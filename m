From: "Art Haas" <ahaas@airmail.net>
Date: Wed, 31 Mar 2004 01:35:28 +0000
Subject: [PATCH] Add config option for '-mcpu=v8'
Message-Id: <20040331013528.GA6522@artsapartment.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi.

Here are two small patches that allow you to configure your kernel build
so that an '-mcpu=v8' option is passed to the compiler. I've built the
2.6.5-rc3 stuff with this flag in the compile command, and the kernels
both run. I'd hacked the flag in initially; this patch makes it a nice
configuration option. Comments on the Kconfig wording welcomed.

Art Haas

=== arch/sparc/Makefile 1.30 vs edited ==--- 1.30/arch/sparc/Makefile	Sun Mar 21 18:57:30 2004
+++ edited/arch/sparc/Makefile	Tue Mar 30 19:22:58 2004
@@ -18,6 +18,10 @@
 CFLAGS := $(CFLAGS) -m32 -pipe -mno-fpu -fcall-used-g5 -fcall-used-g7
 AFLAGS := $(AFLAGS) -m32
 
+cflags-$(CONFIG_V8) += -mcpu=v8
+
+CFLAGS += $(cflags-y)
+
 #LDFLAGS_vmlinux = -N -Ttext 0xf0004000
 #  Since 2.5.40, the first stage is left not btfix-ed.
 #  Actual linking is done with "make image".
=== arch/sparc/Kconfig 1.28 vs edited ==--- 1.28/arch/sparc/Kconfig	Fri Mar 19 00:04:54 2004
+++ edited/arch/sparc/Kconfig	Tue Mar 30 19:17:43 2004
@@ -228,6 +228,13 @@
 
 if !SUN4
 
+config V8
+	bool "v8/supersparc CPU"
+	help
+	  Select this to compile the kernel for Sparc V8 type processors,
+	  such as the SuperSparc. A kernel compiled with this option will
+	  not run on the V7 version chips
+	  
 config PCI
 	bool "Support for PCI and PS/2 keyboard/mouse"
 	help
-- 
Man once surrendering his reason, has no remaining guard against absurdities
the most monstrous, and like a ship without rudder, is the sport of every wind.

-Thomas Jefferson to James Smith, 1822
