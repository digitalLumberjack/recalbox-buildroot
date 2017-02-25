#! /usr/bin/env python2
import argparse
import os
import sys
from distutils.dir_util import copy_tree


class EmPack:
    def __init__(self, system, extensions, emcoredef, fullname=None, platform=None, theme=None):
        # Set member variablers
        """

        :type emcoredef: list
        """
        self._System = system.lower()
        self._Extensions = extensions
        self._EmulatoreCoreDefinitions = emcoredef
        self._FullName = fullname if fullname is not None else self._System.title()
        self._Platform = platform if platform is not None else self._System
        self._Theme = theme if theme is not None else self._System

        self._SingleMode = False
        self._SingleEmulatorBRPackage = ""
        self._MultiEmulatorBRPackage = dict()
        self._BRVarsList = list()

        if not isinstance(emcoredef, list):
            raise

        if len(emcoredef) == 1 and emcoredef[0].count(':') == 0:
            self._SingleMode = True
            self._SingleEmulatorBRPackage = emcoredef[0]
            self._BRVarsList = [emcoredef[0]]
        else:
            self._SingleMode = False
            self._BRVarsList = self.initmultiem(emcoredef)

        self._CommandLine = self.setcmdline(system, extensions, emcoredef, fullname, platform, theme)
        self._SystemUpper = self._System.upper()
        self._PackageName = "recalbox-romfs-{}".format(self._System)
        self._PackageDir = "package/recalbox-romfs/{}".format(self._PackageName)
        self._RomsDir = "{}/{}/{}".format(self._PackageDir, 'roms', self._System)
        self._Makefile = '{}/{}.mk'.format(self._PackageDir, self._PackageName)

    def __str__(self):
        return """
                system: {}
                extensions: {}
                fullname: {}
                platform: {}
                theme: {}
                singleMode: {}
                single emulator package: {}
                multi emulator packages: {}
                ------
                list of BR package variables: {}
                """.format(self._System, self._Extensions, self._FullName, self._Platform, self._Theme, self._SingleMode, self._SingleEmulatorBRPackage, self._MultiEmulatorBRPackage, self._BRVarsList)

    def setcmdline(self, system, extensions, emcoredef, fullname=None, platform=None, theme=None):
        cmdline = "{} ".format(sys.argv[0])
        cmdline += "--system {} ".format(system)
        cmdline += "--extension '{}' ".format(extensions)
        cmdline += "--fullname '{}' ".format(fullname) if fullname is not None else ""
        cmdline += "--platform {} ".format(platform) if platform is not None else ""
        cmdline += "--theme {} ".format(theme) if theme is not None else ""
        cmdline += " ".join(emcoredef)
        return cmdline

    def initmultiem(self, emcorelist):
        """
        Returns the list of BR2_PACKAGE from the command line into a single list
        :type emcorelist: list
        :rtype: list
        """
        superpackage = list()
        for item in emcorelist:
            if item.count(':') != 2:
                print >> sys.stderr, "{} must be follow the pattern emulator:core:BR2_PACKAGE_NAME".format(item)
                exit(1)
            try:
                # split emulator:core:BR_VAR into dicts
                emulator, core, brvar = item.split(':')
                # print "{} splitted to {} {} {}".format(arg, emulator, core, brVar)
                if emulator not in self._MultiEmulatorBRPackage:
                    self._MultiEmulatorBRPackage[emulator] = dict()

                self._MultiEmulatorBRPackage[emulator][core] = brvar
                if brvar not in superpackage:
                    superpackage.append(brvar)
            except:
                raise
        return superpackage

    def listpackages(self):
        """ Appends buildroot package variables to be processed by a ifeq/ifneq command
        :returns: a concatenation of $(VAR1)$(VAR2) etc ... ex: '$(BR2_PACKAGE_LIBRETRO_MAME2003)$(BR2_PACKAGE_LIBRETRO_IMAME)'
        :rtype: string
        """
        cond = '$('
        cond += ')$('.join(self._BRVarsList)
        cond += ')'
        return cond

    def generatedefinename(self, typeCmd, emulator='', core=''):
        """ Generate a define name for .mk files
        The return string looks like CONFIGURE_system_emulator_core_typeCmd , depending on provided arguments
        :param typeCmd: they type of command
        :type typeCmd: string must be START, END or DEF
        :param emulator: optionnal, the emulator name (ex: libretro)
        :type emulator: string
        :param core: optional, the core name (ex: mame078)
        :type core: string
        :returns: the define name
        :rtype: string
        """
        if typeCmd not in ('START', 'END', 'DEF'):
            sys.stderr.write("generateDefineName : typeCmd must be START END or DEF\n")
            sys.exit(1)

        if core and not emulator:
            sys.stderr.write("generateDefineName : you must define emulator if you set core\n")
            sys.exit(1)

        defStr = "CONFIGURE_{}".format(self._SystemUpper)

        if emulator:
            emulatorUp = emulator.upper()
            defStr += "_{}".format(emulatorUp)
            if core:
                coreUp = core.upper()
                defStr += "_{}".format(coreUp)

        defStr += "_{}".format(typeCmd)
        return defStr

    def addemulator(self, emulator):
        """ Returns the starting makefile block of a new emulator section in the es_settings.cfg
        the returned string looks like :
        
        ifneq(brVars,)
        define YYY
            echo -e '\t\t<emulator name="{emulator}">\n' > $(SYSTEM_XML_{})
            
        endef

        :returns: a multiline and indented string
        :rtype: string
        """
        emulatorUp = emulator.upper()
        emulatorLo = emulator.lower()
        defineName = self.generatedefinename('START', emulator)
        returnStr = "define {}\n".format(defineName)
        cond = self.listpackages()
        
        returnStr = "ifneq ({},)\n".format(cond)
        returnStr += "define {}\n".format(defineName)
        returnStr += "\techo -e '\\t\\t<emulator name=\"{}\">' >> $(SYSTEM_XML_{})\n".format(emulatorLo, self._SystemUpper)
        returnStr += "\techo -e '\\t\\t\\t<cores>' >> $(SYSTEM_XML_{})\n\n".format(self._SystemUpper)
        returnStr += "endef\n"
        returnStr += "RECALBOX_ROMFS_{}_CONFIGURE_CMDS += $({})\n\n".format(self._SystemUpper, defineName)
        
        return returnStr

    def addcore(self, emulator, core, brVar):
        """ Returns the starting makefile block of a new emulator section in the es_settings.cfg
        The returned string looks like:

        ifeq(brVar,y)
        define XXX
            echo -e '\t\t\t<core>core</core>' >> $(SYSTEM_XML_system)

        endef
        RECALBOX_ROMFS_system_CONFIGURE_CMDS += $(XXX)

        :param emulator: optionnal, the emulator name (ex: libretro)
        :type emulator: string
        :param core: the core name
        :type core: string
        :param brVar: a BR2_PACKAGE_ like name
        :type brVar: string
        :returns: a multiline and indented string
        :rtype: string
        """
        emulatorUp = emulator.upper()
        emulatorLo = emulator.lower()
        coreUp = core.upper()
        coreLo = core.lower()
        defineName = self.generatedefinename('DEF', emulator, core)

        returnStr = "ifeq ($({}),y)\n".format(brVar)
        returnStr += "define {}\n".format(defineName)
        returnStr += "\techo -e '\\t\\t\\t\\t<core>{}</core>' >> $(SYSTEM_XML_{})\n\n".format(coreLo, self._SystemUpper)
        returnStr += "endef\n"
        returnStr += "RECALBOX_ROMFS_{}_CONFIGURE_CMDS += $({})\n".format(self._SystemUpper, defineName)
        returnStr += "endif\n\n"

        return returnStr

    def endemulator(self, emulator):
        """ Returns the ending makefile block of a new emulator section in the es_settings.cfg
        the returned string looks like :

        define XXX
            echo -e '\t\t</emulator>\n' >> $(SYSTEM_XML_MAME)

        endef
        RECALBOX_ROMFS_system_CONFIGURE_CMDS += $(XXX)

        :param emulator: optionnal, the emulator name (ex: libretro)
        :type emulator: string
        :returns: a multiline and indented string
        :rtype: string
        """
        emulatorUp = emulator.upper()
        defineName = self.generatedefinename('END', emulator)

        returnStr = "define {}\n".format(defineName)
        returnStr += "\techo -e '\\t\\t\\t</cores>' >> $(SYSTEM_XML_{})\n\n".format(self._SystemUpper)
        returnStr += "\techo -e '\\t\\t</emulator>' >> $(SYSTEM_XML_{})\n\n".format(self._SystemUpper)
        returnStr += "endef\n"
        returnStr += "RECALBOX_ROMFS_{}_CONFIGURE_CMDS += $({})\n".format(self._SystemUpper, defineName)
        returnStr += "endif\n\n"

        return returnStr

    def writemakefile(self):
        print "== Creating new package dir structure:",
        if not os.path.exists(self._RomsDir):
            try:
                os.makedirs(self._RomsDir)
                print "OK !"
            except:
                print "Failed ... Could not make dir {}".format(self._RomsDir)
                raise
        else:
            print "{} already exists ... Are you sure of what you're doing ? Exiting ...".format(self._RomsDir)
            sys.exit(1)

        if self._SingleMode:
            skeletonFile = 'package/recalbox-romfs/recalbox-romfs_single_emulator.skeleton'
        else:
            skeletonFile = 'package/recalbox-romfs/recalbox-romfs_multicores.skeleton'

        prtCmdLine = " ".join(sys.argv[:]) # Ugly, sadly ... Should be improved to reflect quotes

        #
        # Replace known patterns
        #
        mkFile = open(skeletonFile, 'r').read()
        #mkFile = mkFile.replace('%COMMAND_LINE%', prtCmdLine)
        mkFile = mkFile.replace('%COMMAND_LINE%', self._CommandLine)
        mkFile = mkFile.replace('%SYSTEM_EXTENSIONS%', self._Extensions)
        mkFile = mkFile.replace('%SYSTEM_UPPER%', self._SystemUpper)
        mkFile = mkFile.replace('%SYSTEM_LOWER%', self._System)
        mkFile = mkFile.replace('%FULLNAME%', self._FullName)
        mkFile = mkFile.replace('%PLATFORM%', self._Platform)
        mkFile = mkFile.replace('%THEME%', self._Theme)

        #
        # patterns : additionnal actions for multicore systems
        #
        if not self._SingleMode:
            superString = ""
            for emulator, cores in self._MultiEmulatorBRPackage.iteritems():
                print "Adding emulator {} {}".format(self._System, emulator)
                superString += self.addemulator(emulator)
                for core, brVar in cores.iteritems():
                    superString += self.addcore(emulator, core, brVar)

                superString += self.endemulator(emulator)

            mkFile = mkFile.replace('%SUPER_PACKAGE%', self.listpackages())
            mkFile = mkFile.replace('%EMULATORS_AND_CORES%', superString)
        else:
            mkFile = mkFile.replace('%BR2_PACKAGE_NAME%', self._SingleEmulatorBRPackage)

        print "== Writing {} :".format(self._Makefile),
        with open(self._Makefile, "w") as f:
            try:
                f.write(mkFile)
                print "OK !"
            except:
                print "Failed ... Couldn't write to {}. Aborting ...".format(outputFile)
                raise

    def writeconfigin(self):
        # Time to write the Config.in
        dependsOn = " \\\n\t  || ".join(self._BRVarsList)
        print "== Writing the Config.in: ",
        configIn = "config BR2_PACKAGE_RECALBOX_ROMFS_{}\n".format(self._SystemUpper)
        configIn += "\tbool \"recalbox-romfs-{}\"\n".format(self._System)
        #~ configIn += "\tdefault y\n"
        configIn += "\tselect BR2_PACKAGE_RECALBOX_ROMS\n"
        configIn += "\tdepends on {}\n".format(dependsOn)
        configIn += "\thelp\n"
        configIn += "\t  share_init/roms and xml for {}\n".format(self._System)

        fileConfigIn = "{}/Config.in".format(self._PackageDir)
        try:
            with open(fileConfigIn, "w") as f:
                f.write(configIn)
            print "OK!"
        except:
            print "KO!"
            print "Couldn't write the {}".format(fileConfigIn)
            raise

    def copyoverlaydir(self):
        # Copy the previous fsoverlay if it exists
        overlaydir = "board/recalbox/fsoverlay/recalbox/share_init/roms/{}".format(self._System)
        print "== Copy the previous fsoverlay of this system if it exists:",
        if os.path.exists(overlaydir):
            try:
                copy_tree(overlaydir, self._RomsDir)
                # Need to remove the .keep
                print "OK !"
            except:
                print "Failed ... Couldn't copy {} to {}. Aborting ...".format(overlaydir, self._PackageDir)
                raise
        else:
            print "No overlay, creating default files instead:",
            LISEZ_MOI = "{}/_lisezmoi.txt".format(self._RomsDir)
            READ_ME = "{}/_readme.txt".format(self._RomsDir)
            try:
                with open(LISEZ_MOI, "w") as f:
                    f.write("Remplir ce fichier")
                with open(READ_ME, "w") as f:
                    f.write("Please fill the file")
                print "OK !"
            except:
                print "Failed ... couldn't create {} or {}".format(LISEZ_MOI, READ_ME)
                raise

    def finalword(self):
        # Ask the user to add himself to recalbox-rom.mk the following lines:
        print "\nNow you will have to edit :\n"
        # print "  * package/recalbox-romfs/recalbox-romfs/Config.in and add :"
        # print "\tdepends on BR2_PACKAGE_RECALBOX_ROMFS_{}\n\n".format(SYSTEM_UPPER)
        print "  * package/recalbox-romfs/recalbox-romfs/recalbox-romfs.mk :"
        print "    Mind the tabulation. The shell may have added spaces instead\n"
        defLine = "# System: {}\n".format(self._System)
        if not self._SingleMode:
            defLine += "ifneq ({},)\n".format(self.listpackages())
        else:
            defLine += "ifeq ($({}),y)\n".format(self._SingleEmulatorBRPackage)
        defLine += "\tRECALBOX_ROMFS_DEPENDENCIES += {}\n".format(self._PackageName)
        defLine += "endif"
        print defLine
        print "\n  * Add a source to package/recalbox-romfs/Config.in :"
        print " source {}/Config.in".format(self._PackageDir)
        print "\n  * Add dependencies to package/recalbox-romfs/recalbox-romfs/Config.in :"
        print "\n\t  || BR2_PACKAGE_RECALBOX_ROMFS_{}".format(self._SystemUpper)
        print "\n  * Add to the emulators/cores Config.in:\n"
        print "\tselect BR2_PACKAGE_RECALBOX_ROMFS_{}".format(self._SystemUpper)


if __name__ == '__main__':
    # Parse command line
    parser = argparse.ArgumentParser(description='Emulator Packager helper')
    parser.add_argument("-s", "--system", help="Sets the system name ex: snes", type=str, required=True)
    parser.add_argument("-e", "--extensions", help="File extensions ES should display. Must be a single string between (double) quotes ex: '.bin .BIN .zip.ZIP'", type=str, required=True)
    parser.add_argument("-f", "--fullname", help="Sets the nice full name of the system. Defaults to the system name with a first upper case. ex: 'SEGA Master System'", type=str, required=False)
    parser.add_argument("-p", "--platform", help="Sets the system platform. Defaults to the system name. ex: pc", type=str, required=False)
    parser.add_argument("-t", "--theme", help="Sets the theme name. Defaults to the system name. ex: nes", type=str, required=False)
    parser.add_argument("packageDetails", nargs='+', help="Either specify a BR2_PACKAGE_XXXXX for a standalone emulator (like reicast, ppsspp etc ...)\nOr write it like libretro:mame078:BR2_PACKAGE_LIBRETRO_MAME2003 libretro:imame4all:BR2_PACKAGE_LIBRETRO_IMAME advancemame:advancemame:BR2_PACKAGE_ADVANCEMAME for a multiple emulators/cores system. The syntax in that case is emulator:core:BUILDROOT_CORE_PACKAGE", type=str)

    args = parser.parse_args()

    ConfigEm = EmPack(args.system, args.extensions, args.packageDetails, fullname = args.fullname, platform = args.platform, theme = args.theme)
    print ConfigEm
    ConfigEm.writemakefile()
    ConfigEm.writeconfigin()
    ConfigEm.copyoverlaydir()
    ConfigEm.finalword()
