Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D3061FFE;
	Sat,  4 Apr 2026 13:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775310900; cv=none; b=e9ChpKy9H/Tsn8oSBYu1Zb5x73rWVYAWckoFGB+4dmYXJO7p6AmbZck10A0sTKMfXv7tET07xK9vd2hD7M1Y7Yp8w458hYsGUakR0Y9gSXgDyYo1DOvdIy5j+ZQBYA/3Zwd9/prdNhSmtX5KZLuMCKAnWx0RO0vSutW4naR7FiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775310900; c=relaxed/simple;
	bh=dQSzIADc6sP5vJjxkJmrIIMyUJ0eKm79JNtVfcJUQLc=;
	h=From:Date:Message-ID:To:Cc:Subject; b=dn+StjzAqWePim4VEUkaX7wTi+JqhHVxbnANdL0kJehOsR8qF1JVyubEv2xqfhOcFl5IxjJ97X6487Zjky+nCugUpZP+HTTGkGSoP2IeYdib9WSlQ4pa2s0eAywSj/6NbjlI23z4XxvseSOBnfEDV2zTmNDl9in409CWOuSudvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from 0003-sparc-prom.eml (unknown [111.196.245.197])
	by APP-03 (Coremail) with SMTP id rQCowAA3VdwmGNFpyyvfDA--.50966S2;
	Sat, 04 Apr 2026 21:54:46 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
Date: Sat, 4 Apr 2026 17:32:20 +0800
Message-ID: <20260404190003.3-sparc-prom-pengpeng@iscas.ac.cn>
To: "David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, sparclinux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, pengpeng@iscas.ac.cn
Subject: [PATCH] sparc/prom: size path-component buffers to fit node names
X-CM-TRANSID:rQCowAA3VdwmGNFpyyvfDA--.50966S2
X-Coremail-Antispam: 1UD129KBjvAXoWfGr1Dur4rXw18KryUZryfXrb_yoW8Cr17Go
	W3WwnYqw18AF4S9rWkG3Z8trZ8Z3W5Wr93AFn5Ja1DZFy7AF909FyxAa9xXa4qqr4xGasx
	ZFsaq3yDGr97Wr4xn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUYT7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xva
	j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l87I20VAvwVCjjxC26r1F6r13M28lY4IEw2IIxx
	k0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK
	6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4
	vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v
	4I1lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
	0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
	17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
	C0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
	6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
	73UjIFyTuYvjfU5oGQDUUUU
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>

build_path_component() in both sparc PROM variants formats fully-named
path components in a fixed 64-byte local buffer and feeds raw firmware
node names
into a chain of sprintf() helpers.

That leaves two problems in the current tree: malformed or unterminated
name properties are treated as C strings, and long node names can
overflow the fixed local scratch buffer before the formatted path
component is copied into early memory.

Read the node name with of_property_read_string(), size the destination
buffer from the validated name length plus the maximum address suffix, and
use bounded formatting in the helper chain.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 arch/sparc/kernel/prom_32.c |  84 +++++++++---------
 arch/sparc/kernel/prom_64.c | 172 +++++++++++++++++-------------------
 2 files changed, 122 insertions(+), 134 deletions(-)

diff --git a/arch/sparc/kernel/prom_32.c b/arch/sparc/kernel/prom_32.c
index cd94f1e8d644..b2a717a44105 100644
--- a/arch/sparc/kernel/prom_32.c
+++ b/arch/sparc/kernel/prom_32.c
@@ -16,6 +16,7 @@
 #include <linux/string.h>
 #include <linux/mm.h>
 #include <linux/memblock.h>
+#include <linux/of.h>
 
 #include <asm/prom.h>
 #include <asm/oplib.h>
@@ -24,6 +25,8 @@
 
 #include "prom.h"
 
+#define SPARC_PATH_COMPONENT_EXTRA 32
+
 void * __init prom_early_alloc(unsigned long size)
 {
 	void *ret;
@@ -52,9 +55,10 @@ void * __init prom_early_alloc(unsigned long size)
  * we walk up the tree until we discover a "device_type" property
  * we recognize and we go from there.
  */
-static void __init sparc32_path_component(struct device_node *dp, char *tmp_buf)
+static void __init sparc32_path_component(const char *name,
+					  struct device_node *dp,
+					  char *tmp_buf, size_t len)
 {
-	const char *name = of_get_property(dp, "name", NULL);
 	struct linux_prom_registers *regs;
 	struct property *rprop;
 
@@ -63,15 +67,14 @@ static void __init sparc32_path_component(struct device_node *dp, char *tmp_buf)
 		return;
 
 	regs = rprop->value;
-	sprintf(tmp_buf, "%s@%x,%x",
-		name,
-		regs->which_io, regs->phys_addr);
+	scnprintf(tmp_buf, len, "%s@%x,%x",
+		  name, regs->which_io, regs->phys_addr);
 }
 
 /* "name@slot,offset"  */
-static void __init sbus_path_component(struct device_node *dp, char *tmp_buf)
+static void __init sbus_path_component(const char *name, struct device_node *dp,
+				       char *tmp_buf, size_t len)
 {
-	const char *name = of_get_property(dp, "name", NULL);
 	struct linux_prom_registers *regs;
 	struct property *prop;
 
@@ -80,16 +83,14 @@ static void __init sbus_path_component(struct device_node *dp, char *tmp_buf)
 		return;
 
 	regs = prop->value;
-	sprintf(tmp_buf, "%s@%x,%x",
-		name,
-		regs->which_io,
-		regs->phys_addr);
+	scnprintf(tmp_buf, len, "%s@%x,%x",
+		  name, regs->which_io, regs->phys_addr);
 }
 
 /* "name@devnum[,func]" */
-static void __init pci_path_component(struct device_node *dp, char *tmp_buf)
+static void __init pci_path_component(const char *name, struct device_node *dp,
+				      char *tmp_buf, size_t len)
 {
-	const char *name = of_get_property(dp, "name", NULL);
 	struct linux_prom_pci_registers *regs;
 	struct property *prop;
 	unsigned int devfn;
@@ -101,21 +102,17 @@ static void __init pci_path_component(struct device_node *dp, char *tmp_buf)
 	regs = prop->value;
 	devfn = (regs->phys_hi >> 8) & 0xff;
 	if (devfn & 0x07) {
-		sprintf(tmp_buf, "%s@%x,%x",
-			name,
-			devfn >> 3,
-			devfn & 0x07);
+		scnprintf(tmp_buf, len, "%s@%x,%x",
+			  name, devfn >> 3, devfn & 0x07);
 	} else {
-		sprintf(tmp_buf, "%s@%x",
-			name,
-			devfn >> 3);
+		scnprintf(tmp_buf, len, "%s@%x", name, devfn >> 3);
 	}
 }
 
 /* "name@addrhi,addrlo" */
-static void __init ebus_path_component(struct device_node *dp, char *tmp_buf)
+static void __init ebus_path_component(const char *name, struct device_node *dp,
+				       char *tmp_buf, size_t len)
 {
-	const char *name = of_get_property(dp, "name", NULL);
 	struct linux_prom_registers *regs;
 	struct property *prop;
 
@@ -125,15 +122,15 @@ static void __init ebus_path_component(struct device_node *dp, char *tmp_buf)
 
 	regs = prop->value;
 
-	sprintf(tmp_buf, "%s@%x,%x",
-		name,
-		regs->which_io, regs->phys_addr);
+	scnprintf(tmp_buf, len, "%s@%x,%x",
+		  name, regs->which_io, regs->phys_addr);
 }
 
 /* "name@irq,addrlo" */
-static void __init ambapp_path_component(struct device_node *dp, char *tmp_buf)
+static void __init ambapp_path_component(const char *name,
+					 struct device_node *dp,
+					 char *tmp_buf, size_t len)
 {
-	const char *name = of_get_property(dp, "name", NULL);
 	struct amba_prom_registers *regs;
 	unsigned int *intr;
 	unsigned int reg0;
@@ -158,45 +155,46 @@ static void __init ambapp_path_component(struct device_node *dp, char *tmp_buf)
 	else
 		intr = prop->value;
 
-	sprintf(tmp_buf, "%s@%x,%x", name, *intr, reg0);
+	scnprintf(tmp_buf, len, "%s@%x,%x", name, *intr, reg0);
 }
 
-static void __init __build_path_component(struct device_node *dp, char *tmp_buf)
+static void __init __build_path_component(const char *name,
+					  struct device_node *dp,
+					  char *tmp_buf, size_t len)
 {
 	struct device_node *parent = dp->parent;
 
 	if (parent != NULL) {
 		if (of_node_is_type(parent, "pci") ||
 		    of_node_is_type(parent, "pciex"))
-			return pci_path_component(dp, tmp_buf);
+			return pci_path_component(name, dp, tmp_buf, len);
 		if (of_node_is_type(parent, "sbus"))
-			return sbus_path_component(dp, tmp_buf);
+			return sbus_path_component(name, dp, tmp_buf, len);
 		if (of_node_is_type(parent, "ebus"))
-			return ebus_path_component(dp, tmp_buf);
+			return ebus_path_component(name, dp, tmp_buf, len);
 		if (of_node_is_type(parent, "ambapp"))
-			return ambapp_path_component(dp, tmp_buf);
+			return ambapp_path_component(name, dp, tmp_buf, len);
 
 		/* "isa" is handled with platform naming */
 	}
 
 	/* Use platform naming convention.  */
-	return sparc32_path_component(dp, tmp_buf);
+	return sparc32_path_component(name, dp, tmp_buf, len);
 }
 
 char * __init build_path_component(struct device_node *dp)
 {
-	const char *name = of_get_property(dp, "name", NULL);
-	char tmp_buf[64], *n;
+	const char *name = "";
+	char *n;
 	size_t n_sz;
 
-	tmp_buf[0] = '\0';
-	__build_path_component(dp, tmp_buf);
-	if (tmp_buf[0] == '\0')
-		strscpy(tmp_buf, name);
-
-	n_sz = strlen(tmp_buf) + 1;
+	of_property_read_string(dp, "name", &name);
+	n_sz = strlen(name) + SPARC_PATH_COMPONENT_EXTRA;
 	n = prom_early_alloc(n_sz);
-	strscpy(n, tmp_buf, n_sz);
+	n[0] = '\0';
+	__build_path_component(name, dp, n, n_sz);
+	if (n[0] == '\0')
+		strscpy(n, name, n_sz);
 
 	return n;
 }
diff --git a/arch/sparc/kernel/prom_64.c b/arch/sparc/kernel/prom_64.c
index aa4799cbb9c1..e8053cf545ea 100644
--- a/arch/sparc/kernel/prom_64.c
+++ b/arch/sparc/kernel/prom_64.c
@@ -28,6 +28,8 @@
 
 #include "prom.h"
 
+#define SPARC_PATH_COMPONENT_EXTRA 32
+
 void * __init prom_early_alloc(unsigned long size)
 {
 	void *ret = memblock_alloc(size, SMP_CACHE_BYTES);
@@ -63,9 +65,10 @@ void * __init prom_early_alloc(unsigned long size)
  *
  *	/pci@1e,600000/ide@d/disk@0,0:c
  */
-static void __init sun4v_path_component(struct device_node *dp, char *tmp_buf)
+static void __init sun4v_path_component(const char *name,
+					struct device_node *dp,
+					char *tmp_buf, size_t len)
 {
-	const char *name = of_get_property(dp, "name", NULL);
 	struct linux_prom64_registers *regs;
 	struct property *rprop;
 	u32 high_bits, low_bits, type;
@@ -76,10 +79,10 @@ static void __init sun4v_path_component(struct device_node *dp, char *tmp_buf)
 
 	regs = rprop->value;
 	if (!of_node_is_root(dp->parent)) {
-		sprintf(tmp_buf, "%s@%x,%x",
-			name,
-			(unsigned int) (regs->phys_addr >> 32UL),
-			(unsigned int) (regs->phys_addr & 0xffffffffUL));
+		scnprintf(tmp_buf, len, "%s@%x,%x",
+			  name,
+			  (unsigned int)(regs->phys_addr >> 32UL),
+			  (unsigned int)(regs->phys_addr & 0xffffffffUL));
 		return;
 	}
 
@@ -91,23 +94,20 @@ static void __init sun4v_path_component(struct device_node *dp, char *tmp_buf)
 		const char *prefix = (type == 0) ? "m" : "i";
 
 		if (low_bits)
-			sprintf(tmp_buf, "%s@%s%x,%x",
-				name, prefix,
-				high_bits, low_bits);
+			scnprintf(tmp_buf, len, "%s@%s%x,%x",
+				  name, prefix, high_bits, low_bits);
 		else
-			sprintf(tmp_buf, "%s@%s%x",
-				name,
-				prefix,
-				high_bits);
+			scnprintf(tmp_buf, len, "%s@%s%x",
+				  name, prefix, high_bits);
 	} else if (type == 12) {
-		sprintf(tmp_buf, "%s@%x",
-			name, high_bits);
+		scnprintf(tmp_buf, len, "%s@%x", name, high_bits);
 	}
 }
 
-static void __init sun4u_path_component(struct device_node *dp, char *tmp_buf)
+static void __init sun4u_path_component(const char *name,
+					struct device_node *dp,
+					char *tmp_buf, size_t len)
 {
-	const char *name = of_get_property(dp, "name", NULL);
 	struct linux_prom64_registers *regs;
 	struct property *prop;
 
@@ -117,10 +117,10 @@ static void __init sun4u_path_component(struct device_node *dp, char *tmp_buf)
 
 	regs = prop->value;
 	if (!of_node_is_root(dp->parent)) {
-		sprintf(tmp_buf, "%s@%x,%x",
-			name,
-			(unsigned int) (regs->phys_addr >> 32UL),
-			(unsigned int) (regs->phys_addr & 0xffffffffUL));
+		scnprintf(tmp_buf, len, "%s@%x,%x",
+			  name,
+			  (unsigned int)(regs->phys_addr >> 32UL),
+			  (unsigned int)(regs->phys_addr & 0xffffffffUL));
 		return;
 	}
 
@@ -133,17 +133,16 @@ static void __init sun4u_path_component(struct device_node *dp, char *tmp_buf)
 		if (tlb_type >= cheetah)
 			mask = 0x7fffff;
 
-		sprintf(tmp_buf, "%s@%x,%x",
-			name,
-			*(u32 *)prop->value,
-			(unsigned int) (regs->phys_addr & mask));
+		scnprintf(tmp_buf, len, "%s@%x,%x",
+			  name, *(u32 *)prop->value,
+			  (unsigned int)(regs->phys_addr & mask));
 	}
 }
 
 /* "name@slot,offset"  */
-static void __init sbus_path_component(struct device_node *dp, char *tmp_buf)
+static void __init sbus_path_component(const char *name, struct device_node *dp,
+				       char *tmp_buf, size_t len)
 {
-	const char *name = of_get_property(dp, "name", NULL);
 	struct linux_prom_registers *regs;
 	struct property *prop;
 
@@ -152,16 +151,14 @@ static void __init sbus_path_component(struct device_node *dp, char *tmp_buf)
 		return;
 
 	regs = prop->value;
-	sprintf(tmp_buf, "%s@%x,%x",
-		name,
-		regs->which_io,
-		regs->phys_addr);
+	scnprintf(tmp_buf, len, "%s@%x,%x",
+		  name, regs->which_io, regs->phys_addr);
 }
 
 /* "name@devnum[,func]" */
-static void __init pci_path_component(struct device_node *dp, char *tmp_buf)
+static void __init pci_path_component(const char *name, struct device_node *dp,
+				      char *tmp_buf, size_t len)
 {
-	const char *name = of_get_property(dp, "name", NULL);
 	struct linux_prom_pci_registers *regs;
 	struct property *prop;
 	unsigned int devfn;
@@ -173,21 +170,17 @@ static void __init pci_path_component(struct device_node *dp, char *tmp_buf)
 	regs = prop->value;
 	devfn = (regs->phys_hi >> 8) & 0xff;
 	if (devfn & 0x07) {
-		sprintf(tmp_buf, "%s@%x,%x",
-			name,
-			devfn >> 3,
-			devfn & 0x07);
+		scnprintf(tmp_buf, len, "%s@%x,%x",
+			  name, devfn >> 3, devfn & 0x07);
 	} else {
-		sprintf(tmp_buf, "%s@%x",
-			name,
-			devfn >> 3);
+		scnprintf(tmp_buf, len, "%s@%x", name, devfn >> 3);
 	}
 }
 
 /* "name@UPA_PORTID,offset" */
-static void __init upa_path_component(struct device_node *dp, char *tmp_buf)
+static void __init upa_path_component(const char *name, struct device_node *dp,
+				      char *tmp_buf, size_t len)
 {
-	const char *name = of_get_property(dp, "name", NULL);
 	struct linux_prom64_registers *regs;
 	struct property *prop;
 
@@ -201,16 +194,15 @@ static void __init upa_path_component(struct device_node *dp, char *tmp_buf)
 	if (!prop)
 		return;
 
-	sprintf(tmp_buf, "%s@%x,%x",
-		name,
-		*(u32 *) prop->value,
-		(unsigned int) (regs->phys_addr & 0xffffffffUL));
+	scnprintf(tmp_buf, len, "%s@%x,%x",
+		  name, *(u32 *)prop->value,
+		  (unsigned int)(regs->phys_addr & 0xffffffffUL));
 }
 
 /* "name@reg" */
-static void __init vdev_path_component(struct device_node *dp, char *tmp_buf)
+static void __init vdev_path_component(const char *name, struct device_node *dp,
+				       char *tmp_buf, size_t len)
 {
-	const char *name = of_get_property(dp, "name", NULL);
 	struct property *prop;
 	u32 *regs;
 
@@ -220,13 +212,13 @@ static void __init vdev_path_component(struct device_node *dp, char *tmp_buf)
 
 	regs = prop->value;
 
-	sprintf(tmp_buf, "%s@%x", name, *regs);
+	scnprintf(tmp_buf, len, "%s@%x", name, *regs);
 }
 
 /* "name@addrhi,addrlo" */
-static void __init ebus_path_component(struct device_node *dp, char *tmp_buf)
+static void __init ebus_path_component(const char *name, struct device_node *dp,
+				       char *tmp_buf, size_t len)
 {
-	const char *name = of_get_property(dp, "name", NULL);
 	struct linux_prom64_registers *regs;
 	struct property *prop;
 
@@ -236,16 +228,16 @@ static void __init ebus_path_component(struct device_node *dp, char *tmp_buf)
 
 	regs = prop->value;
 
-	sprintf(tmp_buf, "%s@%x,%x",
-		name,
-		(unsigned int) (regs->phys_addr >> 32UL),
-		(unsigned int) (regs->phys_addr & 0xffffffffUL));
+	scnprintf(tmp_buf, len, "%s@%x,%x",
+		  name,
+		  (unsigned int)(regs->phys_addr >> 32UL),
+		  (unsigned int)(regs->phys_addr & 0xffffffffUL));
 }
 
 /* "name@bus,addr" */
-static void __init i2c_path_component(struct device_node *dp, char *tmp_buf)
+static void __init i2c_path_component(const char *name, struct device_node *dp,
+				      char *tmp_buf, size_t len)
 {
-	const char *name = of_get_property(dp, "name", NULL);
 	struct property *prop;
 	u32 *regs;
 
@@ -258,14 +250,13 @@ static void __init i2c_path_component(struct device_node *dp, char *tmp_buf)
 	/* This actually isn't right... should look at the #address-cells
 	 * property of the i2c bus node etc. etc.
 	 */
-	sprintf(tmp_buf, "%s@%x,%x",
-		name, regs[0], regs[1]);
+	scnprintf(tmp_buf, len, "%s@%x,%x", name, regs[0], regs[1]);
 }
 
 /* "name@reg0[,reg1]" */
-static void __init usb_path_component(struct device_node *dp, char *tmp_buf)
+static void __init usb_path_component(const char *name, struct device_node *dp,
+				      char *tmp_buf, size_t len)
 {
-	const char *name = of_get_property(dp, "name", NULL);
 	struct property *prop;
 	u32 *regs;
 
@@ -276,18 +267,17 @@ static void __init usb_path_component(struct device_node *dp, char *tmp_buf)
 	regs = prop->value;
 
 	if (prop->length == sizeof(u32) || regs[1] == 1) {
-		sprintf(tmp_buf, "%s@%x",
-			name, regs[0]);
+		scnprintf(tmp_buf, len, "%s@%x", name, regs[0]);
 	} else {
-		sprintf(tmp_buf, "%s@%x,%x",
-			name, regs[0], regs[1]);
+		scnprintf(tmp_buf, len, "%s@%x,%x", name, regs[0], regs[1]);
 	}
 }
 
 /* "name@reg0reg1[,reg2reg3]" */
-static void __init ieee1394_path_component(struct device_node *dp, char *tmp_buf)
+static void __init ieee1394_path_component(const char *name,
+					   struct device_node *dp,
+					   char *tmp_buf, size_t len)
 {
-	const char *name = of_get_property(dp, "name", NULL);
 	struct property *prop;
 	u32 *regs;
 
@@ -298,51 +288,52 @@ static void __init ieee1394_path_component(struct device_node *dp, char *tmp_buf
 	regs = prop->value;
 
 	if (regs[2] || regs[3]) {
-		sprintf(tmp_buf, "%s@%08x%08x,%04x%08x",
-			name, regs[0], regs[1], regs[2], regs[3]);
+		scnprintf(tmp_buf, len, "%s@%08x%08x,%04x%08x",
+			  name, regs[0], regs[1], regs[2], regs[3]);
 	} else {
-		sprintf(tmp_buf, "%s@%08x%08x",
-			name, regs[0], regs[1]);
+		scnprintf(tmp_buf, len, "%s@%08x%08x", name, regs[0], regs[1]);
 	}
 }
 
-static void __init __build_path_component(struct device_node *dp, char *tmp_buf)
+static void __init __build_path_component(const char *name,
+					  struct device_node *dp,
+					  char *tmp_buf, size_t len)
 {
 	struct device_node *parent = dp->parent;
 
 	if (parent != NULL) {
 		if (of_node_is_type(parent, "pci") ||
 		    of_node_is_type(parent, "pciex")) {
-			pci_path_component(dp, tmp_buf);
+			pci_path_component(name, dp, tmp_buf, len);
 			return;
 		}
 		if (of_node_is_type(parent, "sbus")) {
-			sbus_path_component(dp, tmp_buf);
+			sbus_path_component(name, dp, tmp_buf, len);
 			return;
 		}
 		if (of_node_is_type(parent, "upa")) {
-			upa_path_component(dp, tmp_buf);
+			upa_path_component(name, dp, tmp_buf, len);
 			return;
 		}
 		if (of_node_is_type(parent, "ebus")) {
-			ebus_path_component(dp, tmp_buf);
+			ebus_path_component(name, dp, tmp_buf, len);
 			return;
 		}
 		if (of_node_name_eq(parent, "usb") ||
 		    of_node_name_eq(parent, "hub")) {
-			usb_path_component(dp, tmp_buf);
+			usb_path_component(name, dp, tmp_buf, len);
 			return;
 		}
 		if (of_node_is_type(parent, "i2c")) {
-			i2c_path_component(dp, tmp_buf);
+			i2c_path_component(name, dp, tmp_buf, len);
 			return;
 		}
 		if (of_node_is_type(parent, "firewire")) {
-			ieee1394_path_component(dp, tmp_buf);
+			ieee1394_path_component(name, dp, tmp_buf, len);
 			return;
 		}
 		if (of_node_is_type(parent, "virtual-devices")) {
-			vdev_path_component(dp, tmp_buf);
+			vdev_path_component(name, dp, tmp_buf, len);
 			return;
 		}
 		/* "isa" is handled with platform naming */
@@ -350,27 +341,26 @@ static void __init __build_path_component(struct device_node *dp, char *tmp_buf)
 
 	/* Use platform naming convention.  */
 	if (tlb_type == hypervisor) {
-		sun4v_path_component(dp, tmp_buf);
+		sun4v_path_component(name, dp, tmp_buf, len);
 		return;
 	} else {
-		sun4u_path_component(dp, tmp_buf);
+		sun4u_path_component(name, dp, tmp_buf, len);
 	}
 }
 
 char * __init build_path_component(struct device_node *dp)
 {
-	const char *name = of_get_property(dp, "name", NULL);
-	char tmp_buf[64], *n;
+	const char *name = "";
+	char *n;
 	size_t n_sz;
 
-	tmp_buf[0] = '\0';
-	__build_path_component(dp, tmp_buf);
-	if (tmp_buf[0] == '\0')
-		strscpy(tmp_buf, name);
-
-	n_sz = strlen(tmp_buf) + 1;
+	of_property_read_string(dp, "name", &name);
+	n_sz = strlen(name) + SPARC_PATH_COMPONENT_EXTRA;
 	n = prom_early_alloc(n_sz);
-	strscpy(n, tmp_buf, n_sz);
+	n[0] = '\0';
+	__build_path_component(name, dp, n, n_sz);
+	if (n[0] == '\0')
+		strscpy(n, name, n_sz);
 
 	return n;
 }
-- 
2.50.1 (Apple Git-155)

