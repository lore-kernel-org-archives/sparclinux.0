From: Krzysztof Helt <krzysztof.h1@wp.pl>
Date: Mon, 14 Feb 2005 19:23:25 +0000
Subject: Makefile improvement for 2.4 kernel
Message-Id: <4210FAAD.3010903@wp.pl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------050001030207000800070607"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

This is a multi-part message in MIME format.
--------------050001030207000800070607
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Here is a atch which forces the arch/sparc/boot directory being built 
after all other arch/sparc/* directories. On my 2-way SS20 it makes 
"make -j3 vmlinux" working in the first pass. Someone can test it on 
machine with more CPUs. I post it here for judgement if it is a correct 
way to force the correct order of kernel build. I am not sure if I can 
use variables from the main makefile int the arch/sparc/Makefile.

If it is useful, please merge it into the kernel tree.

Regards,
Krzysztof

--------------050001030207000800070607
Content-Type: text/x-patch;
 name="smp-makefile.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="smp-makefile.patch"

--- arch/sparc/Makefile.old	2004-12-08 22:26:06.000000000 +0100
+++ arch/sparc/Makefile	2005-02-14 19:13:22.000000000 +0100
@@ -35,7 +35,7 @@
 
 HEAD := arch/sparc/kernel/head.o arch/sparc/kernel/init_task.o
 
-SUBDIRS += arch/sparc/kernel arch/sparc/lib arch/sparc/prom \
+PRE_BT_SUBDIRS := arch/sparc/kernel arch/sparc/lib arch/sparc/prom \
 	arch/sparc/mm arch/sparc/math-emu
 
 CORE_FILES := arch/sparc/kernel/kernel.o arch/sparc/mm/mm.o $(CORE_FILES) \
@@ -45,10 +45,13 @@
 	$(TOPDIR)/arch/sparc/lib/lib.a
 
 # This one has to come last
-SUBDIRS += arch/sparc/boot
+SUBDIRS += $(PRE_BT_SUBDIRS) arch/sparc/boot
 CORE_FILES_NO_BTFIX := $(CORE_FILES)
 CORE_FILES += arch/sparc/boot/btfix.o
 
+# The boot dir should be built as the last one
+$(patsubst %, _dir_%, arch/sparc/boot ): $(patsubst %, _dir_%, $(PRE_BT_SUBDIRS) )
+
 export	CORE_FILES_NO_BTFIX
 
 archclean:

--------------050001030207000800070607--

