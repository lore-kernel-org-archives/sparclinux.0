From: Jan Engelhardt <jengelh@medozas.de>
Date: Wed, 10 Feb 2010 14:11:04 +0000
Subject: [PATCH] sparc: remove redundant return statements
Message-Id: <1265811065-10467-1-git-send-email-jengelh@medozas.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Signed-off-by: Jan Engelhardt <jengelh@medozas.de>
---
 arch/sparc/kernel/devices.c      |    2 --
 arch/sparc/kernel/pcic.c         |    2 --
 arch/sparc/kernel/setup_32.c     |    2 --
 arch/sparc/kernel/unaligned_64.c |    2 --
 arch/sparc/prom/console_32.c     |    1 -
 arch/sparc/prom/console_64.c     |    1 -
 arch/sparc/prom/devmap.c         |    1 -
 arch/sparc/prom/devops_32.c      |    2 --
 arch/sparc/prom/init_32.c        |    1 -
 arch/sparc/prom/palloc.c         |    1 -
 arch/sparc/prom/ranges.c         |    2 --
 arch/sparc/prom/segment.c        |    1 -
 arch/sparc/prom/tree_32.c        |    1 -
 arch/sparc/prom/tree_64.c        |    1 -
 14 files changed, 0 insertions(+), 20 deletions(-)

diff --git a/arch/sparc/kernel/devices.c b/arch/sparc/kernel/devices.c
index b171ae8..89c22a2 100644
--- a/arch/sparc/kernel/devices.c
+++ b/arch/sparc/kernel/devices.c
@@ -143,6 +143,4 @@ void __init device_scan(void)
 
 	if (ARCH_SUN4C)
 		sun4c_probe_memerr_reg();
-
-	return;
 }
diff --git a/arch/sparc/kernel/pcic.c b/arch/sparc/kernel/pcic.c
index 85e7037..879452d 100644
--- a/arch/sparc/kernel/pcic.c
+++ b/arch/sparc/kernel/pcic.c
@@ -586,8 +586,6 @@ pcic_fill_irq(struct linux_pcic *pcic, struct pci_dev *dev, int node)
 			writew(ivec, pcic->pcic_regs+PCI_INT_SELECT_LO);
 		}
  	}
-
-	return;
 }
 
 /*
diff --git a/arch/sparc/kernel/setup_32.c b/arch/sparc/kernel/setup_32.c
index 9be2af5..b22ce61 100644
--- a/arch/sparc/kernel/setup_32.c
+++ b/arch/sparc/kernel/setup_32.c
@@ -95,8 +95,6 @@ static void prom_sync_me(void)
 			     "nop\n\t"
 			     "nop\n\t" : : "r" (prom_tbr));
 	local_irq_restore(flags);
-
-	return;
 }
 
 static unsigned int boot_flags __initdata = 0;
diff --git a/arch/sparc/kernel/unaligned_64.c b/arch/sparc/kernel/unaligned_64.c
index 378ca82..a9bc6c6 100644
--- a/arch/sparc/kernel/unaligned_64.c
+++ b/arch/sparc/kernel/unaligned_64.c
@@ -636,7 +636,6 @@ daex:
 		return;
 	}
 	advance(regs);
-	return;
 }
 
 void handle_stdfmna(struct pt_regs *regs, unsigned long sfar, unsigned long sfsr)
@@ -685,5 +684,4 @@ daex:
 		return;
 	}
 	advance(regs);
-	return;
 }
diff --git a/arch/sparc/prom/console_32.c b/arch/sparc/prom/console_32.c
index b3075d7..5340264 100644
--- a/arch/sparc/prom/console_32.c
+++ b/arch/sparc/prom/console_32.c
@@ -94,5 +94,4 @@ void
 prom_putchar(char c)
 {
 	while(prom_nbputchar(c) = -1) ;
-	return;
 }
diff --git a/arch/sparc/prom/console_64.c b/arch/sparc/prom/console_64.c
index e1c3fc8..f55d58a 100644
--- a/arch/sparc/prom/console_64.c
+++ b/arch/sparc/prom/console_64.c
@@ -62,7 +62,6 @@ void
 prom_putchar(char c)
 {
 	prom_nbputchar(c);
-	return;
 }
 
 void
diff --git a/arch/sparc/prom/devmap.c b/arch/sparc/prom/devmap.c
index 1e51791..46157d2 100644
--- a/arch/sparc/prom/devmap.c
+++ b/arch/sparc/prom/devmap.c
@@ -50,5 +50,4 @@ prom_unmapio(char *vaddr, unsigned int num_bytes)
 	(*(romvec->pv_v2devops.v2_dumb_munmap))(vaddr, num_bytes);
 	restore_current();
 	spin_unlock_irqrestore(&prom_lock, flags);
-	return;
 }
diff --git a/arch/sparc/prom/devops_32.c b/arch/sparc/prom/devops_32.c
index 9f1a95c..9c5d468 100644
--- a/arch/sparc/prom/devops_32.c
+++ b/arch/sparc/prom/devops_32.c
@@ -84,6 +84,4 @@ prom_seek(int dhandle, unsigned int seekhi, unsigned int seeklo)
 	};
 	restore_current();
 	spin_unlock_irqrestore(&prom_lock, flags);
-
-	return;
 }
diff --git a/arch/sparc/prom/init_32.c b/arch/sparc/prom/init_32.c
index 6193c33..ccb36c7 100644
--- a/arch/sparc/prom/init_32.c
+++ b/arch/sparc/prom/init_32.c
@@ -75,5 +75,4 @@ void __init prom_init(struct linux_romvec *rp)
 	       romvec->pv_romvers, prom_rev);
 
 	/* Initialization successful. */
-	return;
 }
diff --git a/arch/sparc/prom/palloc.c b/arch/sparc/prom/palloc.c
index 20be339..2e2a88b 100644
--- a/arch/sparc/prom/palloc.c
+++ b/arch/sparc/prom/palloc.c
@@ -40,5 +40,4 @@ prom_free(char *vaddr, unsigned int num_bytes)
 {
 	if((prom_vers = PROM_V0) || (num_bytes = 0x0)) return;
 	(*(romvec->pv_v2devops.v2_dumb_mem_free))(vaddr, num_bytes);
-	return;
 }
diff --git a/arch/sparc/prom/ranges.c b/arch/sparc/prom/ranges.c
index cd57908..aeff43e 100644
--- a/arch/sparc/prom/ranges.c
+++ b/arch/sparc/prom/ranges.c
@@ -87,8 +87,6 @@ void __init prom_ranges_init(void)
 
 	if(num_obio_ranges)
 		prom_printf("PROMLIB: obio_ranges %d\n", num_obio_ranges);
-
-	return;
 }
 
 void
diff --git a/arch/sparc/prom/segment.c b/arch/sparc/prom/segment.c
index 04fd03a..86a663f 100644
--- a/arch/sparc/prom/segment.c
+++ b/arch/sparc/prom/segment.c
@@ -25,5 +25,4 @@ prom_putsegment(int ctx, unsigned long vaddr, int segment)
 	(*(romvec->pv_setctxt))(ctx, (char *) vaddr, segment);
 	restore_current();
 	spin_unlock_irqrestore(&prom_lock, flags);
-	return;
 }
diff --git a/arch/sparc/prom/tree_32.c b/arch/sparc/prom/tree_32.c
index 646d244..b21592f 100644
--- a/arch/sparc/prom/tree_32.c
+++ b/arch/sparc/prom/tree_32.c
@@ -173,7 +173,6 @@ void prom_getstring(int node, char *prop, char *user_buf, int ubuf_size)
 	len = prom_getproperty(node, prop, user_buf, ubuf_size);
 	if(len != -1) return;
 	user_buf[0] = 0;
-	return;
 }
 EXPORT_SYMBOL(prom_getstring);
 
diff --git a/arch/sparc/prom/tree_64.c b/arch/sparc/prom/tree_64.c
index 8ea73dd..3c0d2dd 100644
--- a/arch/sparc/prom/tree_64.c
+++ b/arch/sparc/prom/tree_64.c
@@ -154,7 +154,6 @@ void prom_getstring(int node, const char *prop, char *user_buf, int ubuf_size)
 	len = prom_getproperty(node, prop, user_buf, ubuf_size);
 	if(len != -1) return;
 	user_buf[0] = 0;
-	return;
 }
 EXPORT_SYMBOL(prom_getstring);
 
-- 
1.6.6.1

