From: Frans Pop <elendil@planet.nl>
Date: Thu, 16 Jul 2009 18:41:52 +0000
Subject: [PATCH,resend] sparc64: build compressed image (zImage) by default
Message-Id: <200907162041.53181.elendil@planet.nl>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org
Cc: linux-kbuild@vger.kernel.org, Jurij Smakov <jurij@wooyd.org>, David Miller <davem@davemloft.net>

From: Jurij Smakov <jurij@wooyd.org>
Subject: sparc64: build compressed image (zImage) by default

Besides creating the uncompressed vmlinux image for sparc64, also
create a compressed zImage. This is more consistent with other
architectures and required to make the 'deb-pkg' target work.

Signed-off-by: Jurij Smakov <jurij@wooyd.org>
Signed-off-by: Frans Pop <elendil@planet.nl>

---
The patch was taken from the Debian kernel package. It was written by
Jurij. I added his Signed-off-by with his permission.

The patch was tested to work during my recent tests for the cmd64x issue.

diff --git a/arch/sparc/Makefile b/arch/sparc/Makefile
index 2003ded..2adc5ea 100644
--- a/arch/sparc/Makefile
+++ b/arch/sparc/Makefile
@@ -91,6 +91,9 @@ endif
 
 boot := arch/sparc/boot
 
+# Default target
+all: zImage
+
 image zImage tftpboot.img vmlinux.aout: vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
 
diff --git a/arch/sparc/boot/Makefile b/arch/sparc/boot/Makefile
index 1ff0fd9..97e3feb 100644
--- a/arch/sparc/boot/Makefile
+++ b/arch/sparc/boot/Makefile
@@ -79,6 +79,9 @@ $(obj)/image: vmlinux FORCE
 	$(call if_changed,strip)
 	@echo '  kernel: $@ is ready'
 
+$(obj)/zImage: $(obj)/image
+	$(call if_changed,gzip)
+
 $(obj)/tftpboot.img: $(obj)/image $(obj)/piggyback_64 System.map $(ROOT_IMG) FORCE
 	$(call if_changed,elftoaout)
 	$(call if_changed,piggy)
