From: "David S. Miller" <davem@redhat.com>
Date: Tue, 30 Mar 2004 22:24:45 +0000
Subject: Re: atyfb module, unknown symbol prom_palette
Message-Id: <20040330142445.54accc08.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <002b01c416a1$556dee30$fa0da8c0@juba>
In-Reply-To: <002b01c416a1$556dee30$fa0da8c0@juba>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Congratulations, you are the first person to try and build any
of these things as a module :-)

This should fix it:

=== arch/sparc64/kernel/sparc64_ksyms.c 1.65 vs edited ==--- 1.65/arch/sparc64/kernel/sparc64_ksyms.c	Fri Mar 19 13:59:48 2004
+++ edited/arch/sparc64/kernel/sparc64_ksyms.c	Tue Mar 30 14:22:58 2004
@@ -91,6 +91,7 @@
 extern int (*handle_mathemu)(struct pt_regs *, struct fpustate *);
 extern long sparc32_open(const char * filename, int flags, int mode);
 extern int io_remap_page_range(struct vm_area_struct *vma, unsigned long from, unsigned long offset, unsigned long size, pgprot_t prot, int space);
+extern void (*prom_palette)(int);
 
 extern int __ashrdi3(int, int);
 
@@ -388,3 +389,5 @@
 EXPORT_SYMBOL(xor_vis_3);
 EXPORT_SYMBOL(xor_vis_4);
 EXPORT_SYMBOL(xor_vis_5);
+
+EXPORT_SYMBOL(prom_palette);
