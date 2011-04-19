From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 19 Apr 2011 18:19:10 +0000
Subject: [PATCH 2/3] sparc32: cleanup code for pci init
Message-Id: <20110419181910.GA20041@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 17 Apr 2011 13:49:55 +0200
Subject: [PATCH 2/3] sparc32: cleanup code for pci init

Move the ifdeffery to a header file to make the logic more
obvious where we decide between PCI or SBUS init

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---

Fixed so it now builds with or witout PCI enabled.
Included the additional cleanup in time_32 as pointed
out by Daniel.

	Sam

diff --git a/arch/sparc/include/asm/pcic.h b/arch/sparc/include/asm/pcic.h
index f20ef56..7eb5d78 100644
--- a/arch/sparc/include/asm/pcic.h
+++ b/arch/sparc/include/asm/pcic.h
@@ -29,11 +29,17 @@ struct linux_pcic {
 	int			pcic_imdim;
 };
 
-extern int pcic_probe(void);
-/* Erm... MJ redefined pcibios_present() so that it does not work early. */
+#ifdef CONFIG_PCI
 extern int pcic_present(void);
+extern int pcic_probe(void);
+extern void pci_time_init(void);
 extern void sun4m_pci_init_IRQ(void);
-
+#else
+static inline int pcic_present(void) { return 0; }
+static inline int pcic_probe(void) { return 0; }
+static inline void pci_time_init(void) {}
+static inline void sun4m_pci_init_IRQ(void) {}
+#endif
 #endif
 
 /* Size of PCI I/O space which we relocate. */
diff --git a/arch/sparc/kernel/irq_32.c b/arch/sparc/kernel/irq_32.c
index 7c93df4..b2dbb4b 100644
--- a/arch/sparc/kernel/irq_32.c
+++ b/arch/sparc/kernel/irq_32.c
@@ -607,14 +607,11 @@ void __init init_IRQ(void)
 		break;
 
 	case sun4m:
-#ifdef CONFIG_PCI
 		pcic_probe();
-		if (pcic_present()) {
+		if (pcic_present())
 			sun4m_pci_init_IRQ();
-			break;
-		}
-#endif
-		sun4m_init_IRQ();
+		else
+			sun4m_init_IRQ();
 		break;
 
 	case sun4d:
diff --git a/arch/sparc/kernel/time_32.c b/arch/sparc/kernel/time_32.c
index 4e23639..b618403 100644
--- a/arch/sparc/kernel/time_32.c
+++ b/arch/sparc/kernel/time_32.c
@@ -228,14 +228,10 @@ static void __init sbus_time_init(void)
 
 void __init time_init(void)
 {
-#ifdef CONFIG_PCI
-	extern void pci_time_init(void);
-	if (pcic_present()) {
+	if (pcic_present())
 		pci_time_init();
-		return;
-	}
-#endif
-	sbus_time_init();
+	else
+		sbus_time_init();
 }
 
 
