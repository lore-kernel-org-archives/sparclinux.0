From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 15 Nov 2008 21:34:31 +0000
Subject: [PATCH 4/8] sparc: drop UNIX98_PTYS from arch Kconfig
Message-Id: <1226784875-8829-4-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

We have it in drivers/char/Kconfig
There is no need to ask twice

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/Kconfig |   34 ----------------------------------
 1 files changed, 0 insertions(+), 34 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index c83f6f0..d460fc5 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -260,40 +260,6 @@ source "drivers/Kconfig"
 
 source "drivers/sbus/char/Kconfig"
 
-# This one must be before the filesystem configs. -DaveM
-
-menu "Unix98 PTY support"
-
-config UNIX98_PTYS
-	bool "Unix98 PTY support"
-	---help---
-	  A pseudo terminal (PTY) is a software device consisting of two
-	  halves: a master and a slave. The slave device behaves identical to
-	  a physical terminal; the master device is used by a process to
-	  read data from and write data to the slave, thereby emulating a
-	  terminal. Typical programs for the master side are telnet servers
-	  and xterms.
-
-	  Linux has traditionally used the BSD-like names /dev/ptyxx for
-	  masters and /dev/ttyxx for slaves of pseudo terminals. This scheme
-	  has a number of problems. The GNU C library glibc 2.1 and later,
-	  however, supports the Unix98 naming standard: in order to acquire a
-	  pseudo terminal, a process opens /dev/ptmx; the number of the pseudo
-	  terminal is then made available to the process and the pseudo
-	  terminal slave can be accessed as /dev/pts/<number>. What was
-	  traditionally /dev/ttyp2 will then be /dev/pts/2, for example.
-
-	  The entries in /dev/pts/ are created on the fly by a virtual
-	  file system; therefore, if you say Y here you should say Y to
-	  "/dev/pts file system for Unix98 PTYs" as well.
-
-	  If you want to say Y here, you need to have the C library glibc 2.1
-	  or later (equal to libc-6.1, check with "ls -l /lib/libc.so.*").
-	  Read the instructions in <file:Documentation/Changes> pertaining to
-	  pseudo terminals. It's safe to say N.
-
-endmenu
-
 source "fs/Kconfig"
 
 source "arch/sparc/Kconfig.debug"
-- 
1.5.6.GIT

