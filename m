From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 06 Jun 2008 21:15:32 +0000
Subject: [PATCH 20/21] sparc: copy sparc64 header files to asm-sparc
Message-Id: <20080606211532.GA9063@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1212786033-4227-20-git-send-email-sam@ravnborg.org>
In-Reply-To: <1212786033-4227-20-git-send-email-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Several header files had non-trivial differences between
the 32 and 64 bit version.
To better support further unification create a _32.h
file for the orginal 32 bit version and likewise a _64.h
for the original 64 bit version.
To spot potential unification is now a simple:
$ diff -u file_32.h file_64.h

The follwing script were used to create the copies:

FILES="asi.h openprom.h reg.h ipcbuf.h posix_types.h ptrace.h statfs.h sigcontext.h siginfo.h signal.h stat.h unistd.h"

for FILE in ${FILES}; do
        BASE=`echo $FILE | cut -d '.' -f 1`
        FN32=${BASE}_32.h
        FN64=${BASE}_64.h
        GUARD=_ASM_SPARC_`echo $BASE | tr [:lower:] [:upper:]`_H
        git mv include/asm-sparc/$FILE include/asm-sparc/$FN32
        git mv include/asm-sparc64/$FILE include/asm-sparc/$FN64

        printf "#ifndef %s\n" $GUARD                             > include/asm-sparc/$FILE
        printf "#define %s\n" $GUARD                             >> include/asm-sparc/$FILE
        printf "#if defined(__sparc__) && defined(__arch64__)\n" >> include/asm-sparc/$FILE
        printf "#include <asm-sparc/%s>\n" $FN64                 >> include/asm-sparc/$FILE
        printf "#else\n"                                         >> include/asm-sparc/$FILE
        printf "#include <asm-sparc/%s>\n" $FN32                 >> include/asm-sparc/$FILE
        printf "#endif\n"                                        >> include/asm-sparc/$FILE
        printf "#endif\n"                                        >> include/asm-sparc/$FILE
        git add include/asm-sparc/$FILE
        printf "#include <asm-sparc/%s>\n" $FILE                 > include/asm-sparc64/$FILE
        git add include/asm-sparc64/$FILE
done

It was checked that none of the *_32.h *_64.h files
contains a guard named "_ASM_SPARC_*".

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 include/asm-sparc/Kbuild   |   10 ++++++++++
 include/asm-sparc64/Kbuild |   23 -----------------------
 2 files changed, 10 insertions(+), 23 deletions(-)
 delete mode 100644 include/asm-sparc64/Kbuild

diff --git a/include/asm-sparc/Kbuild b/include/asm-sparc/Kbuild
index 6712237..33eb52f 100644
--- a/include/asm-sparc/Kbuild
+++ b/include/asm-sparc/Kbuild
@@ -1,13 +1,23 @@
 include include/asm-generic/Kbuild.asm
 
+header-y += apb.h
 header-y += apc.h
 header-y += asi.h
+header-y += bbc.h
 header-y += bpp.h
+header-y += display7seg.h
+header-y += envctrl.h
 header-y += jsflash.h
+header-y += openprom.h
 header-y += openpromio.h
+header-y += psrcompat.h
+header-y += pstate.h
 header-y += reg.h
 header-y += traps.h
+header-y += uctx.h
+header-y += utrap.h
 header-y += vfc_ioctls.h
+header-y += watchdog.h
 
 unifdef-y += fbio.h
 unifdef-y += perfctr.h
diff --git a/include/asm-sparc64/Kbuild b/include/asm-sparc64/Kbuild
deleted file mode 100644
index dce1cf9..0000000
--- a/include/asm-sparc64/Kbuild
+++ /dev/null
@@ -1,23 +0,0 @@
-include include/asm-generic/Kbuild.asm
-
-ALTARCH := sparc
-ARCHDEF := defined __sparc__ && defined __arch64__
-ALTARCHDEF := defined __sparc__ && !defined __arch64__
-
-header-y += apb.h
-header-y += asi.h
-header-y += bbc.h
-header-y += bpp.h
-header-y += display7seg.h
-header-y += envctrl.h
-header-y += openprom.h
-header-y += openpromio.h
-header-y += psrcompat.h
-header-y += pstate.h
-header-y += reg.h
-header-y += uctx.h
-header-y += utrap.h
-header-y += watchdog.h
-
-unifdef-y += fbio.h
-unifdef-y += perfctr.h
-- 
1.5.4.1.143.ge7e51

