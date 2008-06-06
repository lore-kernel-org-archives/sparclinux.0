From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 06 Jun 2008 21:00:33 +0000
Subject: [PATCH 21/21] sparc: add sparc64 files to Kbuild
Message-Id: <1212786033-4227-21-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

To export sparc 32 and 64 bit files use:
make headers_install ARCH=sparc

There is no longer a separate sparc64 export target
and use of ALTARCH are then dropped.

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

