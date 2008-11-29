From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 29 Nov 2008 22:05:50 +0000
Subject: [PATCH 06/10] sparc: clean boot/
Message-Id: <1227996354-11478-6-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Leave all clening to boot/Makefile
and delete zImage too when we do a 'make clean'

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/Makefile      |    2 --
 arch/sparc/boot/Makefile |    3 ++-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/Makefile b/arch/sparc/Makefile
index b8d1c5b..e83ec16 100644
--- a/arch/sparc/Makefile
+++ b/arch/sparc/Makefile
@@ -54,8 +54,6 @@ archclean:
 # This is the image used for packaging
 KBUILD_IMAGE := $(boot)/zImage
 
-CLEAN_FILES += arch/$(ARCH)/boot/System.map
-
 # Don't use tabs in echo arguments.
 define archhelp
   echo  '* image        - kernel image ($(boot)/image)'
diff --git a/arch/sparc/boot/Makefile b/arch/sparc/boot/Makefile
index 014e3d1..74ba65b 100644
--- a/arch/sparc/boot/Makefile
+++ b/arch/sparc/boot/Makefile
@@ -7,7 +7,8 @@ ROOT_IMG	:= /usr/src/root.img
 ELFTOAOUT	:= elftoaout
 
 hostprogs-y	:= piggyback btfixupprep
-targets		:= tftpboot.img btfix.o btfix.S image
+targets		:= tftpboot.img btfix.o btfix.S image zImage
+clean-files	:= System.map
 
 quiet_cmd_elftoaout	= ELFTOAOUT $@
       cmd_elftoaout	= $(ELFTOAOUT) $(obj)/image -o $@
-- 
1.5.6.GIT

