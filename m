From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 23 Jan 2011 21:54:38 +0000
Subject: Re: [RFC PATCH 0/7] sparc32: cleanup irq + smp files
Message-Id: <20110123215438.GA28153@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20110123213940.GA15063@merkur.ravnborg.org>
In-Reply-To: <20110123213940.GA15063@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, Jan 23, 2011 at 10:39:40PM +0100, Sam Ravnborg wrote:
> I am slowly working towards the goal of migrating
> sparc32 to genirq.
> PArt of the job is to understand the current code-base.
> While reading the code I was constantly distracted
> by all the minor issues in these.
> 
> So I cooked up a few patches to clean up the files.

The patches survied my SPARCclassic config and defconfig.
But allnoconfig bails out with an error.

This is because asm-generic/tlb.h require linux/pagemap.h.
The include happended implicitly before.


Workaround is simple - see below.
I will try to get it fixed in asm-generic for benefit of all users.

	Sam


diff --git a/arch/sparc/include/asm/tlb_32.h b/arch/sparc/include/asm/tlb_32.h
index 6d02d1c..d29b2ea 100644
--- a/arch/sparc/include/asm/tlb_32.h
+++ b/arch/sparc/include/asm/tlb_32.h
@@ -1,6 +1,8 @@
 #ifndef _SPARC_TLB_H
 #define _SPARC_TLB_H
 
+#include <linux/pagemap.h>
+
 #define tlb_start_vma(tlb, vma) \
 do {								\
 	flush_cache_range(vma, vma->vm_start, vma->vm_end);	\

