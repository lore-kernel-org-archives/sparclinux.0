From: David Miller <davem@davemloft.net>
Date: Wed, 07 May 2014 17:52:39 +0000
Subject: Re: [PATCH V2 0/11] sparc64 MM fixes
Message-Id: <20140507.135239.645594139120726248.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20140506.000802.1283819541274253321.davem@davemloft.net>
In-Reply-To: <20140506.000802.1283819541274253321.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Wed, 7 May 2014 01:41:08 +0300 (EEST)

>> > How should I continue debugging it - find the conf differences with 
>> > Debian kernel?
>> > 
>> > Or do you want my .config for U2, X1, V100?
>> 
>> I think the pattern is that the UltraSPARC-III based machines have
>> no problems, whereas the UltraSPARC-I and UltraSPARC-II based ones
>> tend to crash and hang.
> 
> Will try V210/V240/V440/T2000 when I get time.
> 
>> You said they have the same problem with THP disabled too, right?
> 
> U1/U2/E220R/E420R/E250/E450/E3500 were stable with THP off for my 
> dist-upgrade+compile test, Netra X1 and V100 had ocassional trouble. Of 
> these, one might have had THP set to madvise.

I think I found the bug and it's been there forever, please try this patch:

diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
index fde5aba..1a49ffd 100644
--- a/arch/sparc/include/asm/pgtable_64.h
+++ b/arch/sparc/include/asm/pgtable_64.h
@@ -24,7 +24,8 @@
 
 /* The kernel image occupies 0x4000000 to 0x6000000 (4MB --> 96MB).
  * The page copy blockops can use 0x6000000 to 0x8000000.
- * The TSB is mapped in the 0x8000000 to 0xa000000 range.
+ * The 8K TSB is mapped in the 0x8000000 to 0x8400000 range.
+ * The 4M TSB is mapped in the 0x8400000 to 0x8800000 range.
  * The PROM resides in an area spanning 0xf0000000 to 0x100000000.
  * The vmalloc area spans 0x100000000 to 0x200000000.
  * Since modules need to be in the lowest 32-bits of the address space,
@@ -33,7 +34,8 @@
  * 0x400000000.
  */
 #define	TLBTEMP_BASE		_AC(0x0000000006000000,UL)
-#define	TSBMAP_BASE		_AC(0x0000000008000000,UL)
+#define	TSBMAP_8K_BASE		_AC(0x0000000008000000,UL)
+#define	TSBMAP_4M_BASE		_AC(0x0000000008400000,UL)
 #define MODULES_VADDR		_AC(0x0000000010000000,UL)
 #define MODULES_LEN		_AC(0x00000000e0000000,UL)
 #define MODULES_END		_AC(0x00000000f0000000,UL)
diff --git a/arch/sparc/mm/tsb.c b/arch/sparc/mm/tsb.c
index f5d506f..241d47a 100644
--- a/arch/sparc/mm/tsb.c
+++ b/arch/sparc/mm/tsb.c
@@ -133,7 +133,17 @@ static void setup_tsb_params(struct mm_struct *mm, unsigned long tsb_idx, unsign
 	mm->context.tsb_block[tsb_idx].tsb_nentries  		tsb_bytes / sizeof(struct tsb);
 
-	base = TSBMAP_BASE;
+	switch (tsb_idx) {
+	case MM_TSB_BASE:
+		base = TSBMAP_8K_BASE;
+		break;
+	case MM_TSB_HUGE:
+		base = TSBMAP_4M_BASE;
+		break;
+	default:
+		BUG();
+	}
+
 	tte = pgprot_val(PAGE_KERNEL_LOCKED);
 	tsb_paddr = __pa(mm->context.tsb_block[tsb_idx].tsb);
 	BUG_ON(tsb_paddr & (tsb_bytes - 1UL));
