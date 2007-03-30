From: Robert Reif <reif@earthlink.net>
Date: Fri, 30 Mar 2007 12:32:05 +0000
Subject: [PATCH] fix section mismatch warnings in pci.c and pcic.c
Message-Id: <460D0345.6030208@earthlink.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------050408050103040507080701"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

This is a multi-part message in MIME format.
--------------050408050103040507080701
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Fix section mismatch in arch/sparc/kernel/pcic.c and 
arch/sparc64/kernel/pci.c.

sparc64 part is untested.

Signed-off-by: Robert Reif <reif@earthlink.net>


--------------050408050103040507080701
Content-Type: text/plain;
 name="pci.diff.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pci.diff.txt"

diff --git a/arch/sparc/kernel/pcic.c b/arch/sparc/kernel/pcic.c
index 3fa5f95..1c927c5 100644
--- a/arch/sparc/kernel/pcic.c
+++ b/arch/sparc/kernel/pcic.c
@@ -601,7 +601,7 @@ pcic_fill_irq(struct linux_pcic *pcic, s
 /*
  * Normally called from {do_}pci_scan_bus...
  */
-void __init pcibios_fixup_bus(struct pci_bus *bus)
+void __devinit pcibios_fixup_bus(struct pci_bus *bus)
 {
 	struct pci_dev *dev;
 	int i, has_io, has_mem;
@@ -842,7 +842,7 @@ #endif
 /*
  * Other archs parse arguments here.
  */
-char * __init pcibios_setup(char *str)
+char * __devinit pcibios_setup(char *str)
 {
 	return str;
 }
diff --git a/arch/sparc64/kernel/pci.c b/arch/sparc64/kernel/pci.c
index 196b4b7..1210988 100644
--- a/arch/sparc64/kernel/pci.c
+++ b/arch/sparc64/kernel/pci.c
@@ -327,7 +327,7 @@ static int __init pcibios_init(void)
 
 subsys_initcall(pcibios_init);
 
-void pcibios_fixup_bus(struct pci_bus *pbus)
+void __devinit pcibios_fixup_bus(struct pci_bus *pbus)
 {
 	struct pci_pbm_info *pbm = pbus->sysdata;
 
@@ -405,7 +405,7 @@ void pcibios_bus_to_resource(struct pci_
 }
 EXPORT_SYMBOL(pcibios_bus_to_resource);
 
-char * __init pcibios_setup(char *str)
+char * __devinit pcibios_setup(char *str)
 {
 	return str;
 }

--------------050408050103040507080701--

