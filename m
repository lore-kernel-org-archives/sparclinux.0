From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Wed, 27 Dec 2017 08:50:29 +0000
Subject: [PATCH v6 4/8] PCI: Add support for relative addressing in quirk tables
Message-Id: <20171227085033.22389-5-ard.biesheuvel@linaro.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20171227085033.22389-1-ard.biesheuvel@linaro.org>
In-Reply-To: <20171227085033.22389-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Allow the PCI quirk tables to be emitted in a way that avoids absolute
references to the hook functions. This reduces the size of the entries,
and, more importantly, makes them invariant under runtime relocation
(e.g., for KASLR)

Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/pci/quirks.c | 13 ++++++++++---
 include/linux/pci.h  | 20 ++++++++++++++++++++
 2 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 10684b17d0bd..b6d51b4d5ce1 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3556,9 +3556,16 @@ static void pci_do_fixups(struct pci_dev *dev, struct pci_fixup *f,
 		     f->vendor = (u16) PCI_ANY_ID) &&
 		    (f->device = dev->device ||
 		     f->device = (u16) PCI_ANY_ID)) {
-			calltime = fixup_debug_start(dev, f->hook);
-			f->hook(dev);
-			fixup_debug_report(dev, calltime, f->hook);
+			void (*hook)(struct pci_dev *dev);
+#ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
+			hook = (void *)((unsigned long)&f->hook_offset +
+					f->hook_offset);
+#else
+			hook = f->hook;
+#endif
+			calltime = fixup_debug_start(dev, hook);
+			hook(dev);
+			fixup_debug_report(dev, calltime, hook);
 		}
 }
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index c170c9250c8b..e8c34afb5d4a 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1792,7 +1792,11 @@ struct pci_fixup {
 	u16 device;		/* You can use PCI_ANY_ID here of course */
 	u32 class;		/* You can use PCI_ANY_ID here too */
 	unsigned int class_shift;	/* should be 0, 8, 16 */
+#ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
+	signed int hook_offset;
+#else
 	void (*hook)(struct pci_dev *dev);
+#endif
 };
 
 enum pci_fixup_pass {
@@ -1806,12 +1810,28 @@ enum pci_fixup_pass {
 	pci_fixup_suspend_late,	/* pci_device_suspend_late() */
 };
 
+#ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
+#define __DECLARE_PCI_FIXUP_SECTION(sec, name, vendor, device, class,	\
+				    class_shift, hook)			\
+	__ADDRESSABLE(hook)						\
+	asm(".section "	#sec ", \"a\"				\n"	\
+	    ".balign	16					\n"	\
+	    ".short "	#vendor ", " #device "			\n"	\
+	    ".long "	#class ", " #class_shift "		\n"	\
+	    ".long "	VMLINUX_SYMBOL_STR(hook) " - .		\n"	\
+	    ".previous						\n");
+#define DECLARE_PCI_FIXUP_SECTION(sec, name, vendor, device, class,	\
+				  class_shift, hook)			\
+	__DECLARE_PCI_FIXUP_SECTION(sec, name, vendor, device, class,	\
+				  class_shift, hook)
+#else
 /* Anonymous variables would be nice... */
 #define DECLARE_PCI_FIXUP_SECTION(section, name, vendor, device, class,	\
 				  class_shift, hook)			\
 	static const struct pci_fixup __PASTE(__pci_fixup_##name,__LINE__) __used	\
 	__attribute__((__section__(#section), aligned((sizeof(void *)))))    \
 		= { vendor, device, class, class_shift, hook };
+#endif
 
 #define DECLARE_PCI_FIXUP_CLASS_EARLY(vendor, device, class,		\
 					 class_shift, hook)		\
-- 
2.11.0

