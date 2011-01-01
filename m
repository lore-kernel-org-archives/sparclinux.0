From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 01 Jan 2011 21:00:32 +0000
Subject: [PATCH 9/9] sparc: unify strip command in boot/Makefile
Message-Id: <1293915632-4596-9-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Include an additional "Kernel is ready" print for zImage

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/boot/Makefile |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/sparc/boot/Makefile b/arch/sparc/boot/Makefile
index f9d3bf9..a2c5898 100644
--- a/arch/sparc/boot/Makefile
+++ b/arch/sparc/boot/Makefile
@@ -14,6 +14,8 @@ quiet_cmd_elftoaout	= ELFTOAOUT $@
       cmd_elftoaout	= $(ELFTOAOUT) $(obj)/image -o $@
 quiet_cmd_piggy		= PIGGY   $@
       cmd_piggy		= $(obj)/piggyback $(BITS) $@ System.map $(ROOT_IMG)
+quiet_cmd_strip		= STRIP   $@
+      cmd_strip		= $(STRIP) -R .comment -R .note -K sun4u_init -K _end -K _start $< -o $@
 
 ifeq ($(CONFIG_SPARC32),y)
 quiet_cmd_btfix		= BTFIX   $@
@@ -22,9 +24,6 @@ quiet_cmd_sysmap        = SYSMAP  $(obj)/System.map
       cmd_sysmap        = $(CONFIG_SHELL) $(srctree)/scripts/mksysmap
 quiet_cmd_image = LD      $@
       cmd_image = $(LD) $(LDFLAGS) $(EXTRA_LDFLAGS) $(LDFLAGS_$(@F)) -o $@
-quiet_cmd_strip = STRIP   $@
-      cmd_strip = $(STRIP) -R .comment -R .note -K sun4u_init -K _end -K _start $(obj)/image -o $@
-
 
 define rule_image
 	$(if $($(quiet)cmd_image),               \
@@ -57,6 +56,7 @@ $(obj)/image: $(obj)/btfix.o FORCE
 
 $(obj)/zImage: $(obj)/image
 	$(call if_changed,strip)
+	@echo '  kernel: $@ is ready'
 
 $(obj)/btfix.S: $(obj)/btfixupprep vmlinux FORCE
 	$(call if_changed,btfix)
@@ -64,9 +64,6 @@ $(obj)/btfix.S: $(obj)/btfixupprep vmlinux FORCE
 endif
 
 ifeq ($(CONFIG_SPARC64),y)
-quiet_cmd_strip     = STRIP   $@
-      cmd_strip     = $(STRIP) -R .comment -R .note -K sun4u_init -K _end -K _start vmlinux -o $@
-
 
 # Actual linking
 $(obj)/image: vmlinux FORCE
@@ -75,6 +72,7 @@ $(obj)/image: vmlinux FORCE
 
 $(obj)/zImage: $(obj)/image
 	$(call if_changed,gzip)
+	@echo '  kernel: $@ is ready'
 
 $(obj)/vmlinux.aout: vmlinux FORCE
 	$(call if_changed,elftoaout)
-- 
1.6.0.6

