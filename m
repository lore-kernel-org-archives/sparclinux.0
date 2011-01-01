From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 01 Jan 2011 21:00:31 +0000
Subject: [PATCH 8/9] sparc: rename piggyback_32 to piggyback
Message-Id: <1293915632-4596-8-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Now that we use the same piggyback for 32 and 64 bit
we can drop the _32 suffix.
Include some trivial unification in the Makefile
now that 32 and 64 bit can share the same piggyback command.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/boot/Makefile                        |   20 ++++++--------------
 arch/sparc/boot/{piggyback_32.c => piggyback.c} |    0
 2 files changed, 6 insertions(+), 14 deletions(-)
 rename arch/sparc/boot/{piggyback_32.c => piggyback.c} (100%)

diff --git a/arch/sparc/boot/Makefile b/arch/sparc/boot/Makefile
index 06a79a2..f9d3bf9 100644
--- a/arch/sparc/boot/Makefile
+++ b/arch/sparc/boot/Makefile
@@ -6,16 +6,16 @@
 ROOT_IMG	:= /usr/src/root.img
 ELFTOAOUT	:= elftoaout
 
-hostprogs-y	:= piggyback_32 btfixupprep
+hostprogs-y	:= piggyback btfixupprep
 targets		:= tftpboot.img btfix.o btfix.S image zImage vmlinux.aout
 clean-files	:= System.map
 
 quiet_cmd_elftoaout	= ELFTOAOUT $@
       cmd_elftoaout	= $(ELFTOAOUT) $(obj)/image -o $@
+quiet_cmd_piggy		= PIGGY   $@
+      cmd_piggy		= $(obj)/piggyback $(BITS) $@ System.map $(ROOT_IMG)
 
 ifeq ($(CONFIG_SPARC32),y)
-quiet_cmd_piggy		= PIGGY   $@
-      cmd_piggy		= $(obj)/piggyback_32 $(BITS) $@ System.map $(ROOT_IMG)
 quiet_cmd_btfix		= BTFIX   $@
       cmd_btfix		= $(OBJDUMP) -x vmlinux | $(obj)/btfixupprep > $@
 quiet_cmd_sysmap        = SYSMAP  $(obj)/System.map
@@ -58,18 +58,12 @@ $(obj)/image: $(obj)/btfix.o FORCE
 $(obj)/zImage: $(obj)/image
 	$(call if_changed,strip)
 
-$(obj)/tftpboot.img: $(obj)/image $(obj)/piggyback_32 System.map $(ROOT_IMG) FORCE
-	$(call if_changed,elftoaout)
-	$(call if_changed,piggy)
-
 $(obj)/btfix.S: $(obj)/btfixupprep vmlinux FORCE
 	$(call if_changed,btfix)
 
 endif
 
 ifeq ($(CONFIG_SPARC64),y)
-quiet_cmd_piggy     = PIGGY   $@
-      cmd_piggy     = $(obj)/piggyback_32 $(BITS) $@ System.map $(ROOT_IMG)
 quiet_cmd_strip     = STRIP   $@
       cmd_strip     = $(STRIP) -R .comment -R .note -K sun4u_init -K _end -K _start vmlinux -o $@
 
@@ -82,13 +76,11 @@ $(obj)/image: vmlinux FORCE
 $(obj)/zImage: $(obj)/image
 	$(call if_changed,gzip)
 
-$(obj)/tftpboot.img: $(obj)/image $(obj)/piggyback_32 System.map $(ROOT_IMG) FORCE
-	$(call if_changed,elftoaout)
-	$(call if_changed,piggy)
-	@echo '  kernel: $@ is ready'
-
 $(obj)/vmlinux.aout: vmlinux FORCE
 	$(call if_changed,elftoaout)
 	@echo '  kernel: $@ is ready'
 endif
 
+$(obj)/tftpboot.img: $(obj)/image $(obj)/piggyback System.map $(ROOT_IMG) FORCE
+	$(call if_changed,elftoaout)
+	$(call if_changed,piggy)
diff --git a/arch/sparc/boot/piggyback_32.c b/arch/sparc/boot/piggyback.c
similarity index 100%
rename from arch/sparc/boot/piggyback_32.c
rename to arch/sparc/boot/piggyback.c
-- 
1.6.0.6

