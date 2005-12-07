From: "David S. Miller" <davem@davemloft.net>
Date: Wed, 07 Dec 2005 20:49:12 +0000
Subject: Re: Sparc: Kernel 2.6.13 to 2.6.15-rc2 bug when running X11
Message-Id: <20051207.124912.87132033.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20051205.181732.34234732.davem@davemloft.net>
In-Reply-To: <20051205.181732.34234732.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Christopher Zimmermann <madroach@zakweb.de>
Date: Wed, 7 Dec 2005 14:56:27 +0100

> As I said, I tested 2.6.15rc5, too. It performs as badly as rc3.
> The symptoms are the same J.H. Aho described. But in contrast to J.H.
> Aho I can switch back to a vt. By pressing CTRL+c on the vt I started X
> on, I can kill the X server. This is the output I get after pressing
> CTRL+c:

I stand corrected.  This needs some investigation...

I still think J.H. Aho has his Xorg.conf configured to use "fbdev"
for that ATI chip instead of "ati", which is a mistake which on
sparc64 is known to wedge the machine in various ways.

Your case seems different...  in the debugging the vm_flags is
0x184473, which works out to:

	VM_READ | VM_WRITE |
	VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC |
	VM_PFNMAP |
	VM_IO |
	VM_RESERVED |
	VM_ACCOUNT

The important bit is VM_PFNMAP, that "Bad pte" kernel message triggers
usually because VM_PFNMAP is set and vma->vm_pgoff does not match what
is in the PTE, but unfortunately the debugging message does not print
the vma->vm_pgoff value.

Let's get that debugging info, shall we?  :-) Please add the patch
below, and retrigger, then send the full dmesg.

Thanks a lot.

diff --git a/mm/memory.c b/mm/memory.c
index aa8af0e..8b6a62c 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -342,10 +342,10 @@ static inline void add_mm_rss(struct mm_
 void print_bad_pte(struct vm_area_struct *vma, pte_t pte, unsigned long vaddr)
 {
 	printk(KERN_ERR "Bad pte = %08llx, process = %s, "
-			"vm_flags = %lx, vaddr = %lx\n",
-		(long long)pte_val(pte),
-		(vma->vm_mm = current->mm ? current->comm : "???"),
-		vma->vm_flags, vaddr);
+			"vm_flags = %lx, vm_pgoff = %lx, vaddr = %lx\n",
+	       (long long)pte_val(pte),
+	       current->comm,
+	       vma->vm_flags, vma->vm_pgoff, vaddr);
 	dump_stack();
 }
 
