From: "Timothy Pepper" <timothy.c.pepper@linux.intel.com>
Date: Wed, 25 Sep 2013 17:12:43 +0000
Subject: Re: mm: insure topdown mmap chooses addresses above security minimum
Message-Id: <20130925171243.GA7428@tcpepper-desk.jf.intel.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1380057811-5352-1-git-send-email-timothy.c.pepper@linux.intel.com>
 <20130925073048.GB27960@gmail.com>
In-Reply-To: <20130925073048.GB27960@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed 25 Sep at 09:30:49 +0200 mingo@kernel.org said:
> >  	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
> >  	info.length = len;
> > -	info.low_limit = PAGE_SIZE;
> > +	info.low_limit = max(PAGE_SIZE, PAGE_ALIGN(mmap_min_addr));
> >  	info.high_limit = mm->mmap_base;
> >  	info.align_mask = filp ? get_align_mask() : 0;
> >  	info.align_offset = pgoff << PAGE_SHIFT;
> 
> There appears to be a lot of repetition in these methods - instead of 
> changing 6 places it would be more future-proof to first factor out the 
> common bits and then to apply the fix to the shared implementation.

Besides that existing redundancy in the multiple somewhat similar
arch_get_unmapped_area_topdown() functions, I was expecting people might
question the added redundancy of the six instances of:

	max(PAGE_SIZE, PAGE_ALIGN(mmap_min_addr));

There's also a seventh similar instance if you consider
mm/mmap.c:round_hint_to_min() and its call stack.  I'm inclined to
think mmap_min_addr should be validated/aligned in one place, namely on
initialization and input in security/min_addr.c:update_mmap_min_addr(),
with mmap_min_addr always stored as an aligned value.

In the past commit 40401530 Al Viro arguably moved that checking out
of the security code and toward the mmap code.  Granted at that point
though there was only the round_hint_to_min() insuring the value in
mmap_min_addr was page aligned before use in that call path.  I'm thinking
something like:

diff --git a/security/min_addr.c b/security/min_addr.c
--- a/security/min_addr.c
+++ b/security/min_addr.c
@@ -14,14 +14,16 @@ unsigned long dac_mmap_min_addr = CONFIG_DEFAULT_MMAP_MIN_ADDR;
  */
 static void update_mmap_min_addr(void)
 {
+	unsigned long addr;
 #ifdef CONFIG_LSM_MMAP_MIN_ADDR
 	if (dac_mmap_min_addr > CONFIG_LSM_MMAP_MIN_ADDR)
-		mmap_min_addr = dac_mmap_min_addr;
+		addr = dac_mmap_min_addr;
 	else
-		mmap_min_addr = CONFIG_LSM_MMAP_MIN_ADDR;
+		addr = CONFIG_LSM_MMAP_MIN_ADDR;
 #else
-	mmap_min_addr = dac_mmap_min_addr;
+	addr = dac_mmap_min_addr;
 #endif
+	mmap_min_addr = max(PAGE_SIZE, PAGE_ALIGN(addr));
 }
 
 /*

But this possibly has implications beyond the mmap code.

Al Viro, James Morris: any thoughts on the above?

Michel, Rik: what do you think of common helpers called by
ARM, MIPS, SH, Sparc, x86_64 arch_get_unmapped_area_topdown()
and arch_get_unmapped_area() to handle initialization of struct
vm_unmapped_area_info info fields which are currently mostly common?
Given the nuances of "mostly common" I'm not sure the result would
actually be positive for overall readability / self-documenting-ness of
the per arch files.

-- 
Tim Pepper <timothy.c.pepper@linux.intel.com>
Intel Open Source Technology Center
