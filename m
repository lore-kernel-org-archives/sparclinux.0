From: Mikael Pettersson <mikpe@it.uu.se>
Date: Fri, 28 Jul 2006 10:35:24 +0000
Subject: Re: [BUG sparc64] 2.6.16-git6 broke X11 on Ultra5 with ATI Mach64
Message-Id: <200607281035.k6SAZOJ3015670@harpo.it.uu.se>
List-Id: <sparclinux.vger.kernel.org>
References: <200607031117.k63BHiDa007719@harpo.it.uu.se>
In-Reply-To: <200607031117.k63BHiDa007719@harpo.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net, mikpe@it.uu.se
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

On Thu, 27 Jul 2006 20:38:59 -0700 (PDT), David Miller wrote:
>I just confirmed that this is working properly with a debugging
>patch included below.
>
>Mikael, can you put this debugging patch into a kernel that exhibits
>the problem and post all the "FAULT: " debugging messages that appear
>in your kernel log when the problem happens?
>
>Thanks a lot.
>
>diff --git a/mm/memory.c b/mm/memory.c
>index 109e986..b129ae4 100644
>--- a/mm/memory.c
>+++ b/mm/memory.c
>@@ -2270,6 +2270,12 @@ static inline int handle_pte_fault(struc
> 	spinlock_t *ptl;
> 
> 	old_entry = entry = *pte;
>+#if 1
>+	if (pte_val(old_entry) & _PAGE_E_4U) {
>+		printk("FAULT: write(%d) old_entry[%016lx]\n",
>+		       write_access, pte_val(old_entry));
>+	}
>+#endif
> 	if (!pte_present(entry)) {
> 		if (pte_none(entry)) {
> 			if (!vma->vm_ops || !vma->vm_ops->nopage)
>@@ -2311,6 +2317,12 @@ static inline int handle_pte_fault(struc
> 			flush_tlb_page(vma, address);
> 	}
> unlock:
>+#if 1
>+	if (pte_val(old_entry) & _PAGE_E_4U) {
>+		printk("FAULT: After, entry[%016lx]\n",
>+		       pte_val(entry));
>+	}
>+#endif
> 	pte_unmap_unlock(pte, ptl);
> 	return VM_FAULT_MINOR;
> }

Sure. Here's what 2.6.18-rc2 (vanilla) prints when I start X:

FAULT: write(1) old_entry[800001ffe2000788]
FAULT: After, entry[800001ffe2000f8a]
FAULT: write(1) old_entry[800001ffe2000788]
FAULT: After, entry[800001ffe2000f8a]
FAULT: write(1) old_entry[800001ffe2000788]
FAULT: After, entry[800001ffe2000f8a]
FAULT: write(1) old_entry[800001ffe2000788]
FAULT: After, entry[800001ffe2000f8a]
FAULT: write(1) old_entry[800001ffe2000788]
FAULT: After, entry[800001ffe2000f8a]
FAULT: write(1) old_entry[800001ffe13fe788]
FAULT: After, entry[800001ffe13fef8a]
FAULT: write(1) old_entry[e00001ffe1978788]
FAULT: After, entry[e00001ffe1978f8a]
FAULT: write(1) old_entry[e00001ffe1970788]
FAULT: After, entry[e00001ffe1970f8a]
FAULT: write(1) old_entry[e00001ffe1970f8a]
FAULT: After, entry[e00001ffe1970f8a]
FAULT: write(1) old_entry[e00001ffe1970f8a]
FAULT: After, entry[e00001ffe1970f8a]

The last two lines then repeat semi-infinitely, and they
were generated at an extremely high rate.

/Mikael
