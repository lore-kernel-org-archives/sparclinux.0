From: Stefan Holst <mail@s-holst.de>
Date: Sun, 21 Mar 2004 21:42:23 +0000
Subject: small make clean fix
Message-Id: <20040321214223.GA17279@spike>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

hi,

yet another small patch from me:
this fixes make clean/mrproper to remove arch/sparc/boot/System.map, too.
it was all along in the way while making patches...

maybe it is a bug in kbuild that clean target is not executed
in arch/sparc/boot/Makefile?

diff -urN a/arch/sparc/boot/Makefile b/arch/sparc/boot/Makefile
--- a/arch/sparc/boot/Makefile	2004-02-29 23:35:40.000000000 +0100
+++ b/arch/sparc/boot/Makefile	2004-03-21 22:16:02.096364040 +0100
@@ -32,6 +32,3 @@
 
 $(obj)/btfix.s: $(obj)/btfixupprep vmlinux FORCE
 	$(call if_changed,btfix)
-
-clean:
-	rm $(obj)/System.map
diff -urN a/arch/sparc/Makefile b/arch/sparc/Makefile
--- a/arch/sparc/Makefile	2004-03-11 11:32:58.000000000 +0100
+++ b/arch/sparc/Makefile	2004-03-21 22:13:17.005461672 +0100
@@ -67,7 +67,8 @@
 	$(call filechk,gen-asm-offsets)
 
 CLEAN_FILES +=	include/asm-$(ARCH)/asm_offsets.h	\
-		arch/$(ARCH)/kernel/asm-offsets.s
+		arch/$(ARCH)/kernel/asm-offsets.s	\
+		arch/$(ARCH)/boot/System.map
 
 # Don't use tabs in echo arguments.
 define archhelp

-- 
RY  Stefan
+-----------------+----------------+
| mail@s-holst.de | www.s-holst.de |
+-----------------+----------------+
