From: Bob Breuer <breuerr@mc.net>
Date: Wed, 16 Feb 2005 02:37:23 +0000
Subject: Re: prom_getproperty cleanups
Message-Id: <4212B1E3.3020806@mc.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------060706040201010209040806"
List-Id: <sparclinux.vger.kernel.org>
References: <4206F1AB.8080206@mc.net>
In-Reply-To: <4206F1AB.8080206@mc.net>
To: sparclinux@vger.kernel.org

This is a multi-part message in MIME format.
--------------060706040201010209040806
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

David S. Miller wrote:
> Can I ask you to do two things please?
> 
> 1) Add include/linux/compiler.h to oplib.h, that is needed for the
>    __must_check declaration.

Ok, I've added it.  Somehow everything I tested compiled fine without it.

> 2) Please include your patch as an attachment.  Something in your
>    mailer adds spaces to the beginning of lines of your patches
>    so it always rejects when I try to apply.

Sorry about that, I didn't realize it was mangling them.

Updated patch is attached.  The patch only cleans up the 
include/asm-sparc and arch/sparc directories.

If there is anything questionable or if you prefer patches to be done 
differently, just let me know.

Bob

--------------060706040201010209040806
Content-Type: text/plain;
 name="linux-2.6.11-rc4-cleanup-prom_getproperty.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.6.11-rc4-cleanup-prom_getproperty.patch"

diff -X dontdiff -urp linux-2.6.11-rc4-clean/include/asm-sparc/floppy.h linux-2.6.11-rc4/include/asm-sparc/floppy.h
--- linux-2.6.11-rc4-clean/include/asm-sparc/floppy.h	2005-02-13 08:32:05.000000000 -0600
+++ linux-2.6.11-rc4/include/asm-sparc/floppy.h	2005-02-15 19:52:33.000000000 -0600
@@ -312,8 +312,8 @@ static int sun_floppy_init(void)
 	}
 
 	/* The sun4m lets us know if the controller is actually usable. */
-	if(sparc_cpu_model == sun4m) {
-		prom_getproperty(fd_node, "status", state, sizeof(state));
+	if(sparc_cpu_model == sun4m &&
+	   prom_getproperty(fd_node, "status", state, sizeof(state)) != -1) {
 		if(!strcmp(state, "disabled")) {
 			goto no_sun_fdc;
 		}
diff -X dontdiff -urp linux-2.6.11-rc4-clean/include/asm-sparc/oplib.h linux-2.6.11-rc4/include/asm-sparc/oplib.h
--- linux-2.6.11-rc4-clean/include/asm-sparc/oplib.h	2005-02-06 20:43:01.000000000 -0600
+++ linux-2.6.11-rc4/include/asm-sparc/oplib.h	2005-02-15 19:57:54.000000000 -0600
@@ -10,6 +10,7 @@
 
 #include <asm/openprom.h>
 #include <linux/spinlock.h>
+#include <linux/compiler.h>
 
 /* The master romvec pointer... */
 extern struct linux_romvec *romvec;
@@ -244,8 +245,8 @@ extern int prom_getproplen(int thisnode,
 /* Fetch the requested property using the given buffer.  Returns
  * the number of bytes the prom put into your buffer or -1 on error.
  */
-extern int prom_getproperty(int thisnode, char *property,
-			    char *prop_buffer, int propbuf_size);
+int __must_check prom_getproperty(int thisnode, char *property,
+				  char *prop_buffer, int propbuf_size);
 
 /* Acquire an integer property. */
 extern int prom_getint(int node, char *property);
diff -X dontdiff -urp linux-2.6.11-rc4-clean/arch/sparc/kernel/auxio.c linux-2.6.11-rc4/arch/sparc/kernel/auxio.c
--- linux-2.6.11-rc4-clean/arch/sparc/kernel/auxio.c	2005-02-13 08:30:47.000000000 -0600
+++ linux-2.6.11-rc4/arch/sparc/kernel/auxio.c	2005-02-15 19:52:33.000000000 -0600
@@ -53,7 +53,8 @@ void __init auxio_probe(void)
 #endif
 		}
 	}
-	prom_getproperty(auxio_nd, "reg", (char *) auxregs, sizeof(auxregs));
+	if(prom_getproperty(auxio_nd, "reg", (char *) auxregs, sizeof(auxregs)) <= 0)
+		return;
 	prom_apply_obio_ranges(auxregs, 0x1);
 	/* Map the register both read and write */
 	r.flags = auxregs[0].which_io & 0xF;
@@ -121,7 +122,8 @@ void __init auxio_power_probe(void)
 		return;
 
 	/* Map the power control register. */
-	prom_getproperty(node, "reg", (char *)&regs, sizeof(regs));
+	if (prom_getproperty(node, "reg", (char *)&regs, sizeof(regs)) <= 0)
+		return;
 	prom_apply_obio_ranges(&regs, 1);
 	memset(&r, 0, sizeof(r));
 	r.flags = regs.which_io & 0xF;
diff -X dontdiff -urp linux-2.6.11-rc4-clean/arch/sparc/kernel/idprom.c linux-2.6.11-rc4/arch/sparc/kernel/idprom.c
--- linux-2.6.11-rc4-clean/arch/sparc/kernel/idprom.c	2005-02-06 20:43:01.000000000 -0600
+++ linux-2.6.11-rc4/arch/sparc/kernel/idprom.c	2005-02-15 19:52:33.000000000 -0600
@@ -53,13 +53,12 @@ static void __init display_system_type(u
 
 	for (i = 0; i < NUM_SUN_MACHINES; i++) {
 		if(Sun_Machines[i].id_machtype == machtype) {
-			if (machtype != (SM_SUN4M_OBP | 0x00))
+			if (machtype != (SM_SUN4M_OBP | 0x00) ||
+			    prom_getproperty(prom_root_node, "banner-name",
+					     sysname, sizeof(sysname)) <= 0)
 				printk("TYPE: %s\n", Sun_Machines[i].name);
-			else {
-				prom_getproperty(prom_root_node, "banner-name",
-						 sysname, sizeof(sysname));
+			else
 				printk("TYPE: %s\n", sysname);
-			}
 			return;
 		}
 	}
diff -X dontdiff -urp linux-2.6.11-rc4-clean/arch/sparc/kernel/sun4c_irq.c linux-2.6.11-rc4/arch/sparc/kernel/sun4c_irq.c
--- linux-2.6.11-rc4-clean/arch/sparc/kernel/sun4c_irq.c	2005-02-06 20:43:01.000000000 -0600
+++ linux-2.6.11-rc4/arch/sparc/kernel/sun4c_irq.c	2005-02-15 19:52:33.000000000 -0600
@@ -217,13 +217,18 @@ void __init sun4c_init_IRQ(void)
 			panic("Cannot find /interrupt-enable node");
 
 		/* Depending on the "address" property is bad news... */
-		prom_getproperty(ie_node, "reg", (char *) int_regs, sizeof(int_regs));
-		memset(&phyres, 0, sizeof(struct resource));
-		phyres.flags = int_regs[0].which_io;
-		phyres.start = int_regs[0].phys_addr;
-		interrupt_enable = (char *) sbus_ioremap(&phyres, 0,
-		    int_regs[0].reg_size, "sun4c_intr");
+		interrupt_enable = NULL;
+		if (prom_getproperty(ie_node, "reg", (char *) int_regs,
+				     sizeof(int_regs)) != -1) {
+			memset(&phyres, 0, sizeof(struct resource));
+			phyres.flags = int_regs[0].which_io;
+			phyres.start = int_regs[0].phys_addr;
+			interrupt_enable = (char *) sbus_ioremap(&phyres, 0,
+			    int_regs[0].reg_size, "sun4c_intr");
+		}
 	}
+	if (!interrupt_enable)
+		panic("Cannot map interrupt_enable");
 
 	BTFIXUPSET_CALL(sbint_to_irq, sun4c_sbint_to_irq, BTFIXUPCALL_NORM);
 	BTFIXUPSET_CALL(enable_irq, sun4c_enable_irq, BTFIXUPCALL_NORM);
diff -X dontdiff -urp linux-2.6.11-rc4-clean/arch/sparc/mm/iommu.c linux-2.6.11-rc4/arch/sparc/mm/iommu.c
--- linux-2.6.11-rc4-clean/arch/sparc/mm/iommu.c	2005-02-13 08:30:47.000000000 -0600
+++ linux-2.6.11-rc4/arch/sparc/mm/iommu.c	2005-02-15 19:52:33.000000000 -0600
@@ -71,14 +71,16 @@ iommu_init(int iommund, struct sbus_bus 
 		prom_printf("Unable to allocate iommu structure\n");
 		prom_halt();
 	}
-	prom_getproperty(iommund, "reg", (void *) iommu_promregs,
-			 sizeof(iommu_promregs));
-	memset(&r, 0, sizeof(r));
-	r.flags = iommu_promregs[0].which_io;
-	r.start = iommu_promregs[0].phys_addr;
-	iommu->regs = (struct iommu_regs *)
-		sbus_ioremap(&r, 0, PAGE_SIZE * 3, "iommu_regs");
-	if(!iommu->regs) {
+	iommu->regs = NULL;
+	if (prom_getproperty(iommund, "reg", (void *) iommu_promregs,
+			 sizeof(iommu_promregs)) != -1) {
+		memset(&r, 0, sizeof(r));
+		r.flags = iommu_promregs[0].which_io;
+		r.start = iommu_promregs[0].phys_addr;
+		iommu->regs = (struct iommu_regs *)
+			sbus_ioremap(&r, 0, PAGE_SIZE * 3, "iommu_regs");
+	}
+	if (!iommu->regs) {
 		prom_printf("Cannot map IOMMU registers\n");
 		prom_halt();
 	}
diff -X dontdiff -urp linux-2.6.11-rc4-clean/arch/sparc/mm/io-unit.c linux-2.6.11-rc4/arch/sparc/mm/io-unit.c
--- linux-2.6.11-rc4-clean/arch/sparc/mm/io-unit.c	2005-02-13 08:30:47.000000000 -0600
+++ linux-2.6.11-rc4/arch/sparc/mm/io-unit.c	2005-02-15 19:52:33.000000000 -0600
@@ -52,13 +52,15 @@ iounit_init(int sbi_node, int io_node, s
 	iounit->rotor[1] = IOUNIT_BMAP2_START;
 	iounit->rotor[2] = IOUNIT_BMAPM_START;
 
-	prom_getproperty(sbi_node, "reg", (void *) iommu_promregs,
-			 sizeof(iommu_promregs));
-	prom_apply_generic_ranges(io_node, 0, iommu_promregs, 3);
-	memset(&r, 0, sizeof(r));
-	r.flags = iommu_promregs[2].which_io;
-	r.start = iommu_promregs[2].phys_addr;
-	xpt = (iopte_t *) sbus_ioremap(&r, 0, PAGE_SIZE * 16, "XPT");
+	xpt = NULL;
+	if(prom_getproperty(sbi_node, "reg", (void *) iommu_promregs,
+			    sizeof(iommu_promregs)) != -1) {
+		prom_apply_generic_ranges(io_node, 0, iommu_promregs, 3);
+		memset(&r, 0, sizeof(r));
+		r.flags = iommu_promregs[2].which_io;
+		r.start = iommu_promregs[2].phys_addr;
+		xpt = (iopte_t *) sbus_ioremap(&r, 0, PAGE_SIZE * 16, "XPT");
+	}
 	if(!xpt) panic("Cannot map External Page Table.");
 	
 	sbus->iommu = (struct iommu_struct *)iounit;
diff -X dontdiff -urp linux-2.6.11-rc4-clean/arch/sparc/mm/sun4c.c linux-2.6.11-rc4/arch/sparc/mm/sun4c.c
--- linux-2.6.11-rc4-clean/arch/sparc/mm/sun4c.c	2005-02-13 08:30:47.000000000 -0600
+++ linux-2.6.11-rc4/arch/sparc/mm/sun4c.c	2005-02-15 19:52:33.000000000 -0600
@@ -511,7 +511,8 @@ void __init sun4c_probe_memerr_reg(void)
 		node = prom_searchsiblings(prom_root_node, "memory-error");
 		if (!node)
 			return;
-		prom_getproperty(node, "reg", (char *)regs, sizeof(regs));
+		if (prom_getproperty(node, "reg", (char *)regs, sizeof(regs)) <= 0)
+			return;
 		/* hmm I think regs[0].which_io is zero here anyways */
 		sun4c_memerr_reg = ioremap(regs[0].phys_addr, regs[0].reg_size);
 	}
diff -X dontdiff -urp linux-2.6.11-rc4-clean/arch/sparc/prom/console.c linux-2.6.11-rc4/arch/sparc/prom/console.c
--- linux-2.6.11-rc4-clean/arch/sparc/prom/console.c	2005-02-06 20:43:01.000000000 -0600
+++ linux-2.6.11-rc4/arch/sparc/prom/console.c	2005-02-15 19:52:33.000000000 -0600
@@ -111,6 +111,7 @@ prom_query_input_device(void)
 	int st_p;
 	char propb[64];
 	char *p;
+	int propl;
 
 	switch(prom_vers) {
 	case PROM_V0:
@@ -139,14 +140,16 @@ prom_query_input_device(void)
 		if(strncmp(propb, "serial", sizeof("serial")))
 			return PROMDEV_I_UNK;
 		}
-		prom_getproperty(prom_root_node, "stdin-path", propb, sizeof(propb));
-		p = propb;
-		while(*p) p++; p -= 2;
-		if(p[0] == ':') {
-			if(p[1] == 'a')
-				return PROMDEV_ITTYA;
-			else if(p[1] == 'b')
-				return PROMDEV_ITTYB;
+		propl = prom_getproperty(prom_root_node, "stdin-path", propb, sizeof(propb));
+		if(propl > 2) {
+			p = propb;
+			while(*p) p++; p -= 2;
+			if(p[0] == ':') {
+				if(p[1] == 'a')
+					return PROMDEV_ITTYA;
+				else if(p[1] == 'b')
+					return PROMDEV_ITTYB;
+			}
 		}
 		return PROMDEV_I_UNK;
 	}
@@ -179,7 +182,7 @@ prom_query_output_device(void)
 		restore_current();
 		spin_unlock_irqrestore(&prom_lock, flags);
 		propl = prom_getproperty(st_p, "device_type", propb, sizeof(propb));
-		if (propl >= 0 && propl == sizeof("display") &&
+		if (propl == sizeof("display") &&
 			strncmp("display", propb, sizeof("display")) == 0)
 		{
 			return PROMDEV_OSCREEN;
@@ -188,16 +191,20 @@ prom_query_output_device(void)
 			if(propl >= 0 &&
 			    strncmp("serial", propb, sizeof("serial")) != 0)
 				return PROMDEV_O_UNK;
-			prom_getproperty(prom_root_node, "stdout-path", propb, sizeof(propb));
-			if(strncmp(propb, con_name_jmc, CON_SIZE_JMC) == 0)
+			propl = prom_getproperty(prom_root_node, "stdout-path",
+						 propb, sizeof(propb));
+			if(propl == CON_SIZE_JMC &&
+			    strncmp(propb, con_name_jmc, CON_SIZE_JMC) == 0)
 				return PROMDEV_OTTYA;
-			p = propb;
-			while(*p) p++; p -= 2;
-			if(p[0]==':') {
-				if(p[1] == 'a')
-					return PROMDEV_OTTYA;
-				else if(p[1] == 'b')
-					return PROMDEV_OTTYB;
+			if(propl > 2) {
+				p = propb;
+				while(*p) p++; p-= 2;
+				if(p[0]==':') {
+					if(p[1] == 'a')
+						return PROMDEV_OTTYA;
+					else if(p[1] == 'b')
+						return PROMDEV_OTTYB;
+				}
 			}
 		} else {
 			switch(*romvec->pv_stdin) {

--------------060706040201010209040806--
