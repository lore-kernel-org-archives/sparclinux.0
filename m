From: "David S. Miller" <davem@davemloft.net>
Date: Sat, 10 Dec 2005 22:35:23 +0000
Subject: Re: Sparc: Kernel 2.6.13 to 2.6.15-rc2 bug when running X11
Message-Id: <20051210.143523.106612727.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.0512072217580.24376@lai.local.lan>
	<20051207.133236.97581111.davem@davemloft.net>
	<Pine.LNX.4.64.0512102314530.4626@lai.local.lan>
In-Reply-To: <Pine.LNX.4.64.0512102314530.4626@lai.local.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: trizt@iname.com
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: "J.O. Aho" <trizt@iname.com>
Date: Sat, 10 Dec 2005 23:25:36 +0100 (CET)

> I have to say I don't have much knowledge about the kernel code, but in 
> arch/sparc64/mm/generic.c it looks for me that no matter what if 
> io_remap_pte_range() is called it will result in a bug output, is this 
> supposed to happen? Looking at arch/sparc/mm/generic.c I can't find any 
> similar functionality.

That's not true.  The bug triggers if the page table mapping
is valid already, which should never occur when we are setting
up new mappings.  We should always find the PTEs we are filling
in as empty at this point in time.  That is what that bug check
is making sure of.

It doesn't trigger for me here with the Xorg server, on an
Ultra60 with CreatorFB.  I do get the cursor in the corner
and a non-functional screen but I can switch around to other
VC's and kill the X server cleanly.  I definitely don't get
those kernel log messages.

Please retest with this debug tracing added:

--- a/arch/sparc64/mm/generic.c.~1~	2005-12-10 14:34:18.000000000 -0800
+++ b/arch/sparc64/mm/generic.c	2005-12-10 14:34:56.000000000 -0800
@@ -137,6 +137,12 @@
 	int space = GET_IOSPACE(pfn);
 	unsigned long offset = GET_PFN(pfn) << PAGE_SHIFT;
 
+#if 1
+	printk("IO[%s:%d]: remap_pfn_range(s[%lx]e[%lx],f[%lx],pfn[%lx],sz[%lx],prot[%lx])\n",
+	       current->comm, current->pid,
+	       vma->vm_start, vma->vm_end,
+	       from, pfn, size, pgprot_val(prot));
+#endif
 	/* See comment in mm/memory.c remap_pfn_range */
 	vma->vm_flags |= VM_IO | VM_RESERVED | VM_PFNMAP;
 
