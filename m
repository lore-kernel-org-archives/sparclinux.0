From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Date: Thu, 08 Sep 2005 02:56:16 +0000
Subject: [PATCH] Remove some duplicated sparc32 config items
Message-Id: <20050908025616.GA26897@palantir8>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Remove some duplicated items due to the inclusion of the general
drivers/Kconfig file. These are now taken from drivers/char/Kconfig,
and can be turned off there as well (which is desirable sometimes).

Patch is against stock 2.6.13.

Martin

	Signed-off-by: Martin Habets <errandir_news@mph.eclipse.co.uk>

Index: linux/arch/sparc/Kconfig
=================================--- linux.orig/arch/sparc/Kconfig	2005-09-07 19:14:43.000000000 +0100
+++ linux/arch/sparc/Kconfig	2005-09-08 00:29:49.000000000 +0100
@@ -25,62 +25,6 @@
 
 menu "General machine setup"
 
-config VT
-	bool
-	select INPUT
-	default y
-	---help---
-	  If you say Y here, you will get support for terminal devices with
-	  display and keyboard devices. These are called "virtual" because you
-	  can run several virtual terminals (also called virtual consoles) on
-	  one physical terminal. This is rather useful, for example one
-	  virtual terminal can collect system messages and warnings, another
-	  one can be used for a text-mode user session, and a third could run
-	  an X session, all in parallel. Switching between virtual terminals
-	  is done with certain key combinations, usually Alt-<function key>.
-
-	  The setterm command ("man setterm") can be used to change the
-	  properties (such as colors or beeping) of a virtual terminal. The
-	  man page console_codes(4) ("man console_codes") contains the special
-	  character sequences that can be used to change those properties
-	  directly. The fonts used on virtual terminals can be changed with
-	  the setfont ("man setfont") command and the key bindings are defined
-	  with the loadkeys ("man loadkeys") command.
-
-	  You need at least one virtual terminal device in order to make use
-	  of your keyboard and monitor. Therefore, only people configuring an
-	  embedded system would want to say N here in order to save some
-	  memory; the only way to log into such a system is then via a serial
-	  or network connection.
-
-	  If unsure, say Y, or else you won't be able to do much with your new
-	  shiny Linux system :-)
-
-config VT_CONSOLE
-	bool
-	default y
-	---help---
-	  The system console is the device which receives all kernel messages
-	  and warnings and which allows logins in single user mode. If you
-	  answer Y here, a virtual terminal (the device used to interact with
-	  a physical terminal) can be used as system console. This is the most
-	  common mode of operations, so you should say Y here unless you want
-	  the kernel messages be output only to a serial port (in which case
-	  you should say Y to "Console on serial port", below).
-
-	  If you do say Y here, by default the currently visible virtual
-	  terminal (/dev/tty0) will be used as system console. You can change
-	  that with a kernel command line option such as "console=tty3" which
-	  would use the third virtual terminal as system console. (Try "man
-	  bootparam" or see the documentation of your boot loader (lilo or
-	  loadlin) about how to pass options to the kernel at boot time.)
-
-	  If unsure, say Y.
-
-config HW_CONSOLE
-	bool
-	default y
-
 config SMP
 	bool "Symmetric multi-processing support (does not work on sun4/sun4c)"
 	depends on BROKEN
