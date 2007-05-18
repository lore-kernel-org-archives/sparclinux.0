From: Krzysztof Helt <krzysztof.h1@wp.pl>
Date: Fri, 18 May 2007 21:34:57 +0000
Subject: Re: How to load 2.6.22 kernel (image too large to fit ...)
Message-Id: <464F6FD5.7030605@wp.pl>
List-Id: <sparclinux.vger.kernel.org>
References: <464d3ea78cfe8@wp.pl>
In-Reply-To: <464d3ea78cfe8@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi again,

I overcame the problem with too big kernel with the attached patch, but 
I run into another problem. Now, the silo says:

"Your kernel cannot fit into the memory destination. This
can be resolved by recompiling the kernel with more devices
built as modules, or upgrading your kernel to one that
supports being loaded to higher memory areas (currently
2.6.3+ or 2.4.26+)."

Does it mean, that 2.6.22-rc1 for sparc32 cannot be relocated?

Regards,
Krzysztof

PS. The patch maps 8MB or 4MB of memory for kernel like for the sparc64 
kernel.

------------------------------------------------------------------------

diff -urp silo-1.4.13/second/main.c silo-1.4.13.new/second/main.c
--- silo-1.4.13/second/main.c	2006-06-01 19:24:53.000000000 +0200
+++ silo-1.4.13.new/second/main.c	2007-05-18 23:04:51.000000000 +0200
@@ -1272,6 +1273,7 @@ try_again:
 		       "built as modules, or upgrading your kernel to one that\n"
 		       "supports being loaded to higher memory areas (currently\n"
 		       "2.6.3+ or 2.4.26+).\n");
+		image_memory_release();
 		goto try_again;
 	    }
 
diff -urp silo-1.4.13/second/memory.c silo-1.4.13.new/second/memory.c
--- silo-1.4.13/second/memory.c	2006-06-01 19:24:53.000000000 +0200
+++ silo-1.4.13.new/second/memory.c	2007-05-18 23:02:04.000000000 +0200
@@ -271,6 +271,131 @@ not_found:
     return (char *)0;
 }
 
+static unsigned long long sun4m_image_virt, sun4m_image_len, sun4m_image_phys;
+static unsigned long long sun4m_initrd_virt, sun4m_initrd_len;
+unsigned long long sun4m_initrd_phys;
+
+static char *sun4m_memory_find (unsigned int len, int is_kernel)
+{
+	int n, node, i;
+	unsigned int virt = (is_kernel ? IMAGE_VIRT_ADDR : INITRD_VIRT_ADDR);
+	unsigned long phys = 0, phys_base;
+	unsigned long virt2 = 0;
+	unsigned int iter, num_regs;
+
+	/* Grrr, have to traverse the prom device tree ;( */
+	node = prom_getchild (prom_root_node);
+	node = prom_searchsiblings (node, "memory");
+	num_regs = prom_getproperty (node, "available",
+				     (char *) prom_reg_memlist,
+				     sizeof (prom_reg_memlist));
+	n = (num_regs / sizeof (struct linux_prom_registers));
+
+	phys = 0;
+	phys_base = ~(unsigned long)0;
+	for (iter = 0; iter < num_regs; iter++) {
+	    prom_phys_avail[iter].start_adr +		prom_reg_memlist[iter].phys_addr;
+	    prom_phys_avail[iter].num_bytes +		(unsigned long) prom_reg_memlist[iter].reg_size;
+	    prom_phys_avail[iter].theres_more +		&prom_phys_avail[iter + 1];
+	}
+	for (i = 0; i < n; i++) {
+		if ((unsigned long)prom_phys_avail[i].start_adr < phys_base)
+			phys_base = (unsigned long)prom_phys_avail[i].start_adr;
+	}
+
+	for (i = 0; i < n; i++) {
+		/* Do not mess with first 4 Megs of memory */
+		if ((unsigned long)prom_phys_avail[i].start_adr = phys_base) {
+			if (prom_phys_avail[i].num_bytes <= 0x400000)
+				continue;
+			prom_phys_avail[i].start_adr += 0x400000;
+			prom_phys_avail[i].num_bytes -= 0x400000;
+		}
+
+		/* Make sure initrd doesn't overwrite kernel */
+		if (!is_kernel && (unsigned long)prom_phys_avail[i].start_adr = sun4m_image_phys) {
+			if (prom_phys_avail[i].num_bytes <= sun4m_image_len)
+				continue;
+			prom_phys_avail[i].start_adr += sun4m_image_len;
+			prom_phys_avail[i].num_bytes -= sun4m_image_len;
+		}
+
+		/* Make sure initrd phys isn't greater than 28-bits. We
+		 * can only pass unsigned int to the kernel for this
+		 * location. */
+		if (!is_kernel && (unsigned long)prom_phys_avail[i].start_adr >= 0x01000000UL)
+			continue;
+
+		if (prom_phys_avail[i].num_bytes >= len) {
+			phys = (unsigned long)prom_phys_avail[i].start_adr;
+			break;
+		}
+	}
+
+
+	if (!phys) {
+		printf("Could not find any available memory\n");
+		return (char *)0;
+	}
+
+	virt2 = (unsigned long)(*(romvec->pv_v2devops).v2_dumb_mmap)
+			((char*)virt, 0, phys, len);
+	if (!virt2) {
+		printf("Could not map memory\n");
+		return (char *)0;
+	}
+	if (virt2 != virt) {
+		printf("Could not map memory at requested address\n");
+		(*(romvec->pv_v2devops.v2_dumb_munmap))((char*)virt, len);
+		return (char *)0;
+	}
+
+	if (is_kernel) {
+		sun4m_image_len = len;
+		sun4m_image_virt = virt2;
+		sun4m_image_phys = phys;
+		phys += 0x4000UL;
+		virt += 0x4000;
+	} else {
+		sun4m_initrd_len = len;
+		sun4m_initrd_virt = virt2;
+		initrd_phys = phys;
+		/* Not sure what the old kernel crap is for, but it
+		 * expects the passed initrd physical to be relative to
+		 * the phys memory base. We'll keep compatible with older
+		 * kernels to avoid any problems. */
+		sun4m_initrd_phys = phys - phys_base;
+	}
+	return (char *)virt2;
+}
+
+static void sun4m_memory_release(int is_kernel)
+{
+	unsigned long virt, len;
+
+	if (is_kernel) {
+		virt = sun4m_image_virt;
+		len = sun4m_image_len;
+	} else {
+		virt = sun4m_initrd_virt;
+		len = sun4m_initrd_len;
+	}
+
+	if (!len)
+		return;
+
+
+	(*(romvec->pv_v2devops.v2_dumb_munmap))((char*)virt, len);
+
+	if (is_kernel)
+		sun4m_image_len = 0;
+	else
+		sun4m_initrd_len = 0;
+}
+
 static unsigned long long sun4u_image_virt, sun4u_image_len, sun4u_image_phys;
 static unsigned long long sun4u_initrd_virt, sun4u_initrd_len;
 unsigned long long sun4u_initrd_phys;
@@ -393,7 +518,9 @@ static void sun4u_memory_release(int is_
 
 char *image_memory_find (unsigned int len)
 {
-	/* This only works for sparc64 */
+	if (architecture = sun4m || architecture = sun4d)
+		return sun4m_memory_find(len, 1);
+
 	if (architecture != sun4u)
 		return (char *)0;
 
@@ -402,6 +529,9 @@ char *image_memory_find (unsigned int le
 
 void image_memory_release(void)
 {
+	if (architecture = sun4m || architecture = sun4d)
+		sun4m_memory_release(1);
+
 	if (architecture != sun4u)
 		return;
 

