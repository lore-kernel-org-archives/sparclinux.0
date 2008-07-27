From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 27 Jul 2008 22:14:32 +0000
Subject: [PATCH] sparc: enable headers_export again
Message-Id: <20080727221432.GA26627@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From a1bd021e56fff91cc9354ffb232fd9f0f577099c Mon Sep 17 00:00:00 2001
From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 26 Jul 2008 23:20:48 +0200
Subject: [PATCH] sparc: enable headers_export again

Update include/asm/Kbuild so we export
all relvant headers for sparc.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/include/asm/Kbuild |   46 ++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 45 insertions(+), 1 deletions(-)

diff --git a/arch/sparc/include/asm/Kbuild b/arch/sparc/include/asm/Kbuild
index 6cdaf9d..a5f0ce7 100644
--- a/arch/sparc/include/asm/Kbuild
+++ b/arch/sparc/include/asm/Kbuild
@@ -1 +1,45 @@
-# dummy file to avoid breaking make headers_install
+# User exported sparc header files
+include include/asm-generic/Kbuild.asm
+
+header-y += ipcbuf_32.h
+header-y += ipcbuf_64.h
+header-y += posix_types_32.h
+header-y += posix_types_64.h
+header-y += ptrace_32.h
+header-y += ptrace_64.h
+header-y += sigcontext_32.h
+header-y += sigcontext_64.h
+header-y += siginfo_32.h
+header-y += siginfo_64.h
+header-y += signal_32.h
+header-y += signal_64.h
+header-y += stat_32.h
+header-y += stat_64.h
+header-y += statfs_32.h
+header-y += statfs_64.h
+header-y += unistd_32.h
+header-y += unistd_64.h
+
+header-y += apc.h
+header-y += asi.h
+header-y += bpp.h
+header-y += display7seg.h
+header-y += envctrl.h
+header-y += fbio.h
+header-y += jsflash.h
+header-y += openprom.h
+header-y += openprom_32.h
+header-y += openprom_64.h
+header-y += openpromio.h
+header-y += perfctr.h
+header-y += psrcompat.h
+header-y += psr.h
+header-y += pstate.h
+header-y += reg.h
+header-y += reg_32.h
+header-y += reg_64.h
+header-y += traps.h
+header-y += uctx.h
+header-y += utrap.h
+header-y += vfc_ioctls.h
+header-y += watchdog.h
-- 
1.5.6.1.93.gef98

