From: "Saheed O. Bolarinwa" <refactormyself@gmail.com>
Date: Mon, 13 Jul 2020 12:22:35 +0000
Subject: [RFC PATCH 23/35] sparc/PCI: Change PCIBIOS_SUCCESSFUL to 0
Message-Id: <20200713122247.10985-24-refactormyself@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20200713122247.10985-1-refactormyself@gmail.com>
In-Reply-To: <20200713122247.10985-1-refactormyself@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: helgaas@kernel.org, "David S. Miller" <davem@davemloft.net>
Cc: "Saheed O. Bolarinwa" <refactormyself@gmail.com>, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel-mentees@lists.linuxfoundation.org

In reference to the PCI spec (Chapter 2), PCIBIOS* is an x86 concept.
Their scope should be limited within arch/x86.

Change all PCIBIOS_SUCCESSFUL to 0

Signed-off-by: "Saheed O. Bolarinwa" <refactormyself@gmail.com>
---
 arch/sparc/kernel/pci_common.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/sparc/kernel/pci_common.c b/arch/sparc/kernel/pci_common.c
index 4759ccd542fe..39175f26f401 100644
--- a/arch/sparc/kernel/pci_common.c
+++ b/arch/sparc/kernel/pci_common.c
@@ -59,7 +59,7 @@ static int sun4u_read_pci_cfg_host(struct pci_pbm_info *pbm,
 
 	addr = sun4u_config_mkaddr(pbm, bus, devfn, where);
 	if (!addr)
-		return PCIBIOS_SUCCESSFUL;
+		return 0;
 
 	switch (size) {
 	case 1:
@@ -102,7 +102,7 @@ static int sun4u_read_pci_cfg_host(struct pci_pbm_info *pbm,
 		*value |= tmp32 << 16;
 		break;
 	}
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static int sun4u_read_pci_cfg(struct pci_bus *bus_dev, unsigned int devfn,
@@ -132,7 +132,7 @@ static int sun4u_read_pci_cfg(struct pci_bus *bus_dev, unsigned int devfn,
 
 	addr = sun4u_config_mkaddr(pbm, bus, devfn, where);
 	if (!addr)
-		return PCIBIOS_SUCCESSFUL;
+		return 0;
 
 	switch (size) {
 	case 1:
@@ -144,7 +144,7 @@ static int sun4u_read_pci_cfg(struct pci_bus *bus_dev, unsigned int devfn,
 		if (where & 0x01) {
 			printk("pci_read_config_word: misaligned reg [%x]\n",
 			       where);
-			return PCIBIOS_SUCCESSFUL;
+			return 0;
 		}
 		pci_config_read16((u16 *)addr, &tmp16);
 		*value = (u32) tmp16;
@@ -154,12 +154,12 @@ static int sun4u_read_pci_cfg(struct pci_bus *bus_dev, unsigned int devfn,
 		if (where & 0x03) {
 			printk("pci_read_config_dword: misaligned reg [%x]\n",
 			       where);
-			return PCIBIOS_SUCCESSFUL;
+			return 0;
 		}
 		pci_config_read32(addr, value);
 		break;
 	}
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static int sun4u_write_pci_cfg_host(struct pci_pbm_info *pbm,
@@ -170,7 +170,7 @@ static int sun4u_write_pci_cfg_host(struct pci_pbm_info *pbm,
 
 	addr = sun4u_config_mkaddr(pbm, bus, devfn, where);
 	if (!addr)
-		return PCIBIOS_SUCCESSFUL;
+		return 0;
 
 	switch (size) {
 	case 1:
@@ -206,7 +206,7 @@ static int sun4u_write_pci_cfg_host(struct pci_pbm_info *pbm,
 					 where + 2, 2, value >> 16);
 		break;
 	}
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static int sun4u_write_pci_cfg(struct pci_bus *bus_dev, unsigned int devfn,
@@ -222,7 +222,7 @@ static int sun4u_write_pci_cfg(struct pci_bus *bus_dev, unsigned int devfn,
 
 	addr = sun4u_config_mkaddr(pbm, bus, devfn, where);
 	if (!addr)
-		return PCIBIOS_SUCCESSFUL;
+		return 0;
 
 	switch (size) {
 	case 1:
@@ -233,7 +233,7 @@ static int sun4u_write_pci_cfg(struct pci_bus *bus_dev, unsigned int devfn,
 		if (where & 0x01) {
 			printk("pci_write_config_word: misaligned reg [%x]\n",
 			       where);
-			return PCIBIOS_SUCCESSFUL;
+			return 0;
 		}
 		pci_config_write16((u16 *)addr, value);
 		break;
@@ -242,11 +242,11 @@ static int sun4u_write_pci_cfg(struct pci_bus *bus_dev, unsigned int devfn,
 		if (where & 0x03) {
 			printk("pci_write_config_dword: misaligned reg [%x]\n",
 			       where);
-			return PCIBIOS_SUCCESSFUL;
+			return 0;
 		}
 		pci_config_write32(addr, value);
 	}
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 struct pci_ops sun4u_pci_ops = {
@@ -284,7 +284,7 @@ static int sun4v_read_pci_cfg(struct pci_bus *bus_dev, unsigned int devfn,
 	}
 
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static int sun4v_write_pci_cfg(struct pci_bus *bus_dev, unsigned int devfn,
@@ -307,7 +307,7 @@ static int sun4v_write_pci_cfg(struct pci_bus *bus_dev, unsigned int devfn,
 				     HV_PCI_DEVICE_BUILD(bus, device, func),
 				     where, size, value);
 	}
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 struct pci_ops sun4v_pci_ops = {
-- 
2.18.2
