From: David Miller <davem@davemloft.net>
Date: Fri, 12 Sep 2008 21:48:32 +0000
Subject: [PATCH 8/16]: sparc64: Fix sparse warnings in prom.c
Message-Id: <20080912.144832.241780153.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sparc64: Fix sparse warnings in prom.c

1) Testing null with '0'
2) returning void-valued expression

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc64/kernel/prom.c |   85 ++++++++++++++++++++++++++++---------------
 1 files changed, 55 insertions(+), 30 deletions(-)

diff --git a/arch/sparc64/kernel/prom.c b/arch/sparc64/kernel/prom.c
index 922dd61..5f50e2b 100644
--- a/arch/sparc64/kernel/prom.c
+++ b/arch/sparc64/kernel/prom.c
@@ -38,7 +38,7 @@ struct device_node *of_find_node_by_phandle(phandle handle)
 {
 	struct device_node *np;
 
-	for (np = allnodes; np != 0; np = np->allnext)
+	for (np = allnodes; np; np = np->allnext)
 		if (np->node = handle)
 			break;
 
@@ -1043,22 +1043,30 @@ static void __init irq_trans_init(struct device_node *dp)
 		for (i = 0; i < ARRAY_SIZE(pci_irq_trans_table); i++) {
 			struct irq_trans *t = &pci_irq_trans_table[i];
 
-			if (!strcmp(model, t->name))
-				return t->init(dp);
+			if (!strcmp(model, t->name)) {
+				t->init(dp);
+				return;
+			}
 		}
 	}
 #endif
 #ifdef CONFIG_SBUS
 	if (!strcmp(dp->name, "sbus") ||
-	    !strcmp(dp->name, "sbi"))
-		return sbus_irq_trans_init(dp);
+	    !strcmp(dp->name, "sbi")) {
+		sbus_irq_trans_init(dp);
+		return;
+	}
 #endif
 	if (!strcmp(dp->name, "fhc") &&
-	    !strcmp(dp->parent->name, "central"))
-		return central_irq_trans_init(dp);
+	    !strcmp(dp->parent->name, "central")) {
+		central_irq_trans_init(dp);
+		return;
+	}
 	if (!strcmp(dp->name, "virtual-devices") ||
-	    !strcmp(dp->name, "niu"))
-		return sun4v_vdev_irq_trans_init(dp);
+	    !strcmp(dp->name, "niu")) {
+		sun4v_vdev_irq_trans_init(dp);
+		return;
+	}
 }
 
 static int is_root_node(const struct device_node *dp)
@@ -1329,32 +1337,49 @@ static void __init __build_path_component(struct device_node *dp, char *tmp_buf)
 
 	if (parent != NULL) {
 		if (!strcmp(parent->type, "pci") ||
-		    !strcmp(parent->type, "pciex"))
-			return pci_path_component(dp, tmp_buf);
-		if (!strcmp(parent->type, "sbus"))
-			return sbus_path_component(dp, tmp_buf);
-		if (!strcmp(parent->type, "upa"))
-			return upa_path_component(dp, tmp_buf);
-		if (!strcmp(parent->type, "ebus"))
-			return ebus_path_component(dp, tmp_buf);
+		    !strcmp(parent->type, "pciex")) {
+			pci_path_component(dp, tmp_buf);
+			return;
+		}
+		if (!strcmp(parent->type, "sbus")) {
+			sbus_path_component(dp, tmp_buf);
+			return;
+		}
+		if (!strcmp(parent->type, "upa")) {
+			upa_path_component(dp, tmp_buf);
+			return;
+		}
+		if (!strcmp(parent->type, "ebus")) {
+			ebus_path_component(dp, tmp_buf);
+			return;
+		}
 		if (!strcmp(parent->name, "usb") ||
-		    !strcmp(parent->name, "hub"))
-			return usb_path_component(dp, tmp_buf);
-		if (!strcmp(parent->type, "i2c"))
-			return i2c_path_component(dp, tmp_buf);
-		if (!strcmp(parent->type, "firewire"))
-			return ieee1394_path_component(dp, tmp_buf);
-		if (!strcmp(parent->type, "virtual-devices"))
-			return vdev_path_component(dp, tmp_buf);
-
+		    !strcmp(parent->name, "hub")) {
+			usb_path_component(dp, tmp_buf);
+			return;
+		}
+		if (!strcmp(parent->type, "i2c")) {
+			i2c_path_component(dp, tmp_buf);
+			return;
+		}
+		if (!strcmp(parent->type, "firewire")) {
+			ieee1394_path_component(dp, tmp_buf);
+			return;
+		}
+		if (!strcmp(parent->type, "virtual-devices")) {
+			vdev_path_component(dp, tmp_buf);
+			return;
+		}
 		/* "isa" is handled with platform naming */
 	}
 
 	/* Use platform naming convention.  */
-	if (tlb_type = hypervisor)
-		return sun4v_path_component(dp, tmp_buf);
-	else
-		return sun4u_path_component(dp, tmp_buf);
+	if (tlb_type = hypervisor) {
+		sun4v_path_component(dp, tmp_buf);
+		return;
+	} else {
+		sun4u_path_component(dp, tmp_buf);
+	}
 }
 
 static char * __init build_path_component(struct device_node *dp)
-- 
1.5.6.5.GIT

