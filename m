From: "Tom 'spot' Callaway" <tcallawa@redhat.com>
Date: Thu, 06 Oct 2005 13:39:19 +0000
Subject: [PATCH 2.6] Fix prom_getproperty calls
Message-Id: <1128605959.2140.131.camel@localhost.localdomain>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-2OqAQrGlCk6vixF8MwOx"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org


--=-2OqAQrGlCk6vixF8MwOx
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch fixes the remaining prom_getproperty calls in 2.6 to actually
do something with the result.

Signed-off-by: Tom 'spot' Callaway <tcallawa@redhat.com>

~spot
-- 
Tom "spot" Callaway: Red Hat Senior Sales Engineer || GPG ID: 93054260
Fedora Extras Steering Committee Member (RPM Standards and Practices)
Aurora Linux Project Leader: http://auroralinux.org
Lemurs, llamas, and sparcs, oh my!

--=-2OqAQrGlCk6vixF8MwOx
Content-Disposition: attachment; filename=linux-2.6.13-sparc-prom_getproperty-cleanups.patch
Content-Type: text/x-patch; name=linux-2.6.13-sparc-prom_getproperty-cleanups.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- linux-2.6.11/drivers/video/cg14.c.BAD	2005-03-04 02:01:59.732195963 -0500
+++ linux-2.6.11/drivers/video/cg14.c	2005-03-04 02:02:50.616460379 -0500
@@ -532,7 +532,8 @@ static void cg14_init_one(struct sbus_de
 		all->info.screen_base = (char __iomem *)(unsigned long)bases[1];
 	}
 
-	prom_getproperty(node, "reg", (char *) &bases[0], sizeof(bases));
+	if(prom_getproperty(node, "reg", (char *) &bases[0], sizeof(bases)) <= 0)
+		return;
 	is_8mb = (bases[5] == 0x800000);
 
 	if (sizeof(all->par.mmap_map) != sizeof(__cg14_mmap_map)) {
--- linux-2.6.11/drivers/video/ffb.c.BAD	2005-03-04 02:28:58.675079235 -0500
+++ linux-2.6.11/drivers/video/ffb.c	2005-03-04 02:29:49.215395939 -0500
@@ -894,7 +894,9 @@ static int ffb_apply_upa_parent_ranges(i
 	char name[128];
 	int len, i;
 
-	prom_getproperty(parent, "name", name, sizeof(name));
+	if(prom_getproperty(parent, "name", name, sizeof(name)) <= 0)
+		return 1;
+
 	if (strcmp(name, "upa") != 0)
 		return 0;
 
--- linux-2.6.11/drivers/net/tulip/tulip_core.c.BAD	2005-03-04 02:31:57.819845091 -0500
+++ linux-2.6.11/drivers/net/tulip/tulip_core.c	2005-03-04 02:32:47.529288107 -0500
@@ -1566,8 +1566,9 @@ static int __devinit tulip_init_one (str
 #if defined(__sparc__)
 		if ((pcp != NULL) && prom_getproplen(pcp->prom_node,
 			"local-mac-address") == 6) {
-			prom_getproperty(pcp->prom_node, "local-mac-address",
-			    dev->dev_addr, 6);
+			if (prom_getproperty(pcp->prom_node, "local-mac-address",
+			    dev->dev_addr, 6) <= 0)
+				goto err_out_free_ring;
 		}
 #endif
 #if defined(__i386__)		/* Patch up x86 BIOS bug. */
--- linux-2.6.11/drivers/net/sunhme.c.BAD	2005-03-04 02:34:02.507889627 -0500
+++ linux-2.6.11/drivers/net/sunhme.c	2005-03-04 02:35:08.785813851 -0500
@@ -2742,8 +2742,9 @@ static int __init happy_meal_sbus_init(s
 	} else if (qfe_slot != -1 &&
 		   prom_getproplen(sdev->prom_node,
 				   "local-mac-address") == 6) {
-		prom_getproperty(sdev->prom_node, "local-mac-address",
-				 dev->dev_addr, 6);
+		if(prom_getproperty(sdev->prom_node, "local-mac-address",
+				 dev->dev_addr, 6) <= 0)
+			goto err_out;
 	} else {
 		memcpy(dev->dev_addr, idprom->id_ethaddr, 6);
 	}
@@ -3126,8 +3127,9 @@ static int __init happy_meal_pci_init(st
 #ifdef __sparc__
 		if (qfe_slot != -1 &&
 		    prom_getproplen(node, "local-mac-address") == 6) {
-			prom_getproperty(node, "local-mac-address",
-					 dev->dev_addr, 6);
+			if(prom_getproperty(node, "local-mac-address",
+					 dev->dev_addr, 6) <= 0)
+				goto err_out_free_res;
 		} else {
 			memcpy(dev->dev_addr, idprom->id_ethaddr, 6);
 		}
--- linux-2.6.11/drivers/net/sungem.c.BAD	2005-03-04 14:16:55.933554403 -0500
+++ linux-2.6.11/drivers/net/sungem.c	2005-03-04 14:17:29.147505115 -0500
@@ -2756,8 +2756,9 @@ static int __devinit gem_get_device_addr
 	if (pcp != NULL) {
 		node = pcp->prom_node;
 		if (prom_getproplen(node, "local-mac-address") == 6)
-			prom_getproperty(node, "local-mac-address",
-					 dev->dev_addr, 6);
+			if (prom_getproperty(node, "local-mac-address",
+					 dev->dev_addr, 6) <= 0)
+				return -1;
 		else
 			node = -1;
 	}
--- linux-2.6.11/drivers/char/drm/ffb_drv.c.BAD	2005-03-04 14:17:40.937712731 -0500
+++ linux-2.6.11/drivers/char/drm/ffb_drv.c	2005-03-04 14:18:17.668128859 -0500
@@ -93,7 +93,8 @@ static void ffb_apply_upa_parent_ranges(
 	char name[128];
 	int len, i;
 
-	prom_getproperty(parent, "name", name, sizeof(name));
+	if (prom_getproperty(parent, "name", name, sizeof(name)) <= 0)
+		return;
 	if (strcmp(name, "upa") != 0)
 		return;
 
--- linux-2.6.11/drivers/fc4/socal.c.BAD	2005-03-04 14:18:59.442778147 -0500
+++ linux-2.6.11/drivers/fc4/socal.c	2005-03-04 14:19:23.836069803 -0500
@@ -712,9 +712,10 @@ static inline void socal_init(struct sbu
 		case 0:
 		case 1:
 			if (prom_getproplen(node, "port-wwn") == sizeof (fc_wwn))
-				prom_getproperty (node, "port-wwn", 
+				if (prom_getproperty (node, "port-wwn", 
 						  (char *)&s->port[port].fc.wwn_nport,
-						  sizeof (fc_wwn));
+						  sizeof (fc_wwn)) <= 0)
+					return;
 			break;
 		default:
 			break;
--- linux-2.6.11/drivers/atm/fore200e.c.BAD	2005-03-04 14:19:32.611735699 -0500
+++ linux-2.6.11/drivers/atm/fore200e.c	2005-03-04 14:20:44.482809635 -0500
@@ -957,12 +957,16 @@ fore200e_sba_prom_read(struct fore200e* 
     if (len < 0)
 	return -EBUSY;
     
-    prom_getproperty(sbus_dev->prom_node, "serialnumber",
+    len = prom_getproperty(sbus_dev->prom_node, "serialnumber",
 		     (char*)&prom->serial_number, sizeof(prom->serial_number));
+    if (len < 0)
+	return -EBUSY;
     
-    prom_getproperty(sbus_dev->prom_node, "promversion",
+    len = prom_getproperty(sbus_dev->prom_node, "promversion",
 		     (char*)&prom->hw_revision, sizeof(prom->hw_revision));
-    
+    if (len < 0)
+	return -EBUSY;
+
     return 0;
 }
 
--- linux-2.6.11/drivers/sbus/char/openprom.c.BAD	2005-03-04 02:02:59.992035075 -0500
+++ linux-2.6.11/drivers/sbus/char/openprom.c	2005-03-04 02:04:34.229708771 -0500
@@ -391,7 +391,8 @@ static int openprom_bsd_ioctl(struct ino
 			return -ENOMEM;
 		}
 
-		prom_getproperty(op.op_nodeid, str, tmp, len);
+		if (prom_getproperty(op.op_nodeid, str, tmp, len) <= 0)
+			return -EINVAL;
 
 		tmp[len] = '\0';
 
--- linux-2.6.11/drivers/sbus/char/jsflash.c.BAD	2005-03-04 14:20:51.292774363 -0500
+++ linux-2.6.11/drivers/sbus/char/jsflash.c	2005-03-04 14:22:09.888825947 -0500
@@ -486,7 +486,8 @@ static int jsflash_init(void)
 	} else {
 		/* XXX Remove this code once PROLL ID12 got widespread */
 		printk("jsflash: no /flash-memory node, use PROLL >= 12\n");
-		prom_getproperty(prom_root_node, "banner-name", banner, 128);
+		if (prom_getproperty(prom_root_node, "banner-name", banner, 128) <= 0)
+			return -EINVAL;			
 		if (strcmp (banner, "JavaStation-NC") != 0 &&
 		    strcmp (banner, "JavaStation-E") != 0) {
 			return -ENXIO;
--- linux-2.6.11/drivers/sbus/char/cpwatchdog.c.BAD	2005-03-04 14:22:24.603588963 -0500
+++ linux-2.6.11/drivers/sbus/char/cpwatchdog.c	2005-03-04 14:25:40.033879043 -0500
@@ -221,7 +221,8 @@ static inline int wd_isbroken(void)
 	 * ubiquitous on CP1400s
 	 */
 	char val[32];
-	prom_getproperty(prom_root_node, "model", val, sizeof(val));
+	if (prom_getproperty(prom_root_node, "model", val, sizeof(val)) <= 0)
+		return 1;
 	return((!strcmp(val, WD_BADMODEL)) ? 1 : 0);
 }
 		
--- linux-2.6.11/arch/sparc64/kernel/chmc.c.BAD	2005-03-04 02:18:27.155084867 -0500
+++ linux-2.6.11/arch/sparc64/kernel/chmc.c	2005-03-04 02:19:20.511973387 -0500
@@ -360,9 +360,10 @@ static int init_one_mctrl(int node, int 
 		goto fail;
 
 	if (mp->layout_size > 0)
-		prom_getproperty(node, "memory-layout",
+		if(prom_getproperty(node, "memory-layout",
 				 (char *) &mp->layout_prop,
-				 mp->layout_size);
+				 mp->layout_size) <= 0)
+			goto fail;
 
 	t = prom_getproperty(node, "reg",
 			     (char *) &p_reg_prop,
--- linux-2.6.11/arch/sparc64/prom/tree.c.BAD	2005-03-04 02:14:25.563812323 -0500
+++ linux-2.6.11/arch/sparc64/prom/tree.c	2005-03-04 02:17:14.099191051 -0500
@@ -162,8 +162,11 @@ prom_getstring(int node, char *prop, cha
 int
 prom_nodematch(int node, char *name)
 {
+	int error;
+
 	char namebuf[128];
-	prom_getproperty(node, "name", namebuf, sizeof(namebuf));
+	error = prom_getproperty(node, "name", namebuf, sizeof(namebuf));
+	if (error == -1) return 0;
 	if(strcmp(namebuf, name) == 0) return 1;
 	return 0;
 }
--- linux-2.6.11/arch/sparc64/prom/console.c.BAD	2005-03-04 02:24:48.940044731 -0500
+++ linux-2.6.11/arch/sparc64/prom/console.c	2005-03-04 02:26:11.247532091 -0500
@@ -84,13 +84,15 @@ prom_query_input_device(void)
 	st_p = prom_inst2pkg(prom_stdin);
 	if(prom_node_has_property(st_p, "keyboard"))
 		return PROMDEV_IKBD;
-	prom_getproperty(st_p, "device_type", propb, sizeof(propb));
+	if(prom_getproperty(st_p, "device_type", propb, sizeof(propb)) < 0)
+		return PROMDEV_I_UNK;
 	if(strncmp(propb, "serial", 6))
 		return PROMDEV_I_UNK;
 	/* FIXME: Is there any better way how to find out? */	
 	memset(propb, 0, sizeof(propb));
 	st_p = prom_finddevice ("/options");
-	prom_getproperty(st_p, "input-device", propb, sizeof(propb));
+	if(prom_getproperty(st_p, "input-device", propb, sizeof(propb)) < 0)
+		return PROMDEV_I_UNK;
 
 	/*
 	 * If we get here with propb == 'keyboard', we are on ttya, as
@@ -127,7 +129,8 @@ prom_query_output_device(void)
 	/* FIXME: Is there any better way how to find out? */	
 	memset(propb, 0, sizeof(propb));
 	st_p = prom_finddevice ("/options");
-	prom_getproperty(st_p, "output-device", propb, sizeof(propb));
+	if(prom_getproperty(st_p, "output-device", propb, sizeof(propb)) < 0)
+		return PROMDEV_O_UNK;
 
 	/*
 	 * If we get here with propb == 'screen', we are on ttya, as
--- linux-2.6.11/arch/m68k/sun3/prom/console.c.BAD	2005-03-04 02:26:41.904871467 -0500
+++ linux-2.6.11/arch/m68k/sun3/prom/console.c	2005-03-04 02:27:45.737167483 -0500
@@ -91,10 +91,12 @@ prom_query_input_device()
 		local_irq_restore(flags);
 		if(prom_node_has_property(st_p, "keyboard"))
 			return PROMDEV_IKBD;
-		prom_getproperty(st_p, "device_type", propb, sizeof(propb));
+		if(prom_getproperty(st_p, "device_type", propb, sizeof(propb)) < 0)
+			return PROMDEV_I_UNK;
 		if(strncmp(propb, "serial", sizeof("serial")))
 			return PROMDEV_I_UNK;
-		prom_getproperty(prom_root_node, "stdin-path", propb, sizeof(propb));
+		if(prom_getproperty(prom_root_node, "stdin-path", propb, sizeof(propb)) < 0)
+			return PROMDEV_I_UNK;
 		p = propb;
 		while(*p) p++; p -= 2;
 		if(p[0] == ':') {
@@ -148,7 +150,8 @@ prom_query_output_device()
 		if(prom_vers == PROM_V3) {
 			if(strncmp("serial", propb, sizeof("serial")))
 				return PROMDEV_O_UNK;
-			prom_getproperty(prom_root_node, "stdout-path", propb, sizeof(propb));
+			if(prom_getproperty(prom_root_node, "stdout-path", propb, sizeof(propb)) < 0)
+				return PROMDEV_O_UNK;
 			p = propb;
 			while(*p) p++; p -= 2;
 			if(p[0]==':') {
--- linux-2.6.11/include/asm-sparc64/floppy.h.BAD	2005-03-04 02:11:42.220644259 -0500
+++ linux-2.6.11/include/asm-sparc64/floppy.h	2005-03-04 02:12:53.994732939 -0500
@@ -632,8 +632,10 @@ static unsigned long __init sun_floppy_i
 #endif
 		}
 
-		prom_getproperty(edev->prom_node, "status",
-				 state, sizeof(state));
+		if (prom_getproperty(edev->prom_node, "status",
+				 state, sizeof(state)) <= 0)
+			return 0;
+
 		if (!strncmp(state, "disabled", 8))
 			return 0;
 			
--- linux-2.6.13/drivers/net/tg3.c.BAD	2005-09-13 12:25:26.451083489 -0400
+++ linux-2.6.13/drivers/net/tg3.c	2005-09-13 12:26:03.497451585 -0400
@@ -9782,8 +9782,9 @@ static int __devinit tg3_get_macaddr_spa
 		int node = pcp->prom_node;
 
 		if (prom_getproplen(node, "local-mac-address") == 6) {
-			prom_getproperty(node, "local-mac-address",
-					 dev->dev_addr, 6);
+			if (prom_getproperty(node, "local-mac-address",
+					 dev->dev_addr, 6) <= 0)
+				return -ENODEV;
 			memcpy(dev->perm_addr, dev->dev_addr, 6);
 			return 0;
 		}

--=-2OqAQrGlCk6vixF8MwOx--

