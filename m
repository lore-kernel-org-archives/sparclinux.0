From: =?iso-2022-jp?B?GyRCP0BFRCEhPjAbKEI=?= <hikanda@zlab.co.jp>
Date: Fri, 17 Jun 2016 00:05:28 +0000
Subject: [PATCH] sparc64: Swap registers for fault code and address in mna trap
Message-Id: <TYXPR01MB058946C0AC6B6523F82004FC99570@TYXPR01MB0589.jpnprd01.prod.outlook.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

From: "Hisashi Kanda" <hikanda at zlab dot co dot jp>

I found a logical bug in SPARC code.
So, I send this patch. Please check it.

This bug may occur in the following.

user_rtt_fill_64bit          <= If mna trap occurred, call do_mna
+-> do_mna                   <= Mistake storing registers for fault code and address
    +-> winfix_mna
        +-> user_rtt_fill_fixup  <= Put fault address into thread_info->flag's TI_FAULT_CODE 
            +-> do_sparc64_fault() <= If fault address has FAULT_CODE_ITLB and FAULT_CODE_DTLB bits, call BUG()
                +-> BUG()

If mna trap occured in user_rtt_fill_64bit, then do_mna is called.
So, fault address is loaded into %g4, and fault code is loaded into %g5 in do_mna.
But, %g4 is stored into thread_info->flag's TI_FAULT_CODE, and
%g5 is stored into thread_info->flag's TI_FAULT_ADDR in user_rtt_fill_fixup.
This is a mistake. If fault address has FAULT_CODE_ITLB and 
FAULT_CODE_DTLB bits, BUG() may occur in do_sparc64_fault().

The patch for this bug is the following.
Kernel version is Linux 4.7-rc3. 

Signed-off-by: Hisashi Kanda <hikanda@zlab.co.jp>

---

diff --git a/arch/sparc/kernel/misctrap.S b/arch/sparc/kernel/misctrap.S
index 34b4933..0cfb367 100644
--- a/arch/sparc/kernel/misctrap.S
+++ b/arch/sparc/kernel/misctrap.S
@@ -35,7 +35,7 @@ do_mna:
 	ldxa		[%g3] ASI_DMMU, %g5
 	stxa		%g0, [%g3] ASI_DMMU	! Clear FaultValid bit
 	membar		#Sync
-	bgu,pn		%icc, winfix_mna
+	bgu,pn		%icc, winfix_mna_swap
 	 rdpr		%tpc, %g3
 
 1:	sethi		%hi(109f), %g7
diff --git a/arch/sparc/kernel/winfixup.S b/arch/sparc/kernel/winfixup.S
index 855019a..8359a1b 100644
--- a/arch/sparc/kernel/winfixup.S
+++ b/arch/sparc/kernel/winfixup.S
@@ -103,6 +103,11 @@ spill_fixup_dax:
 	 add	%sp, PTREGS_OFF, %o0
 	ba,a,pt	%xcc, rtrap
 
+winfix_mna_swap:
+	mov	%g4, %g3	! swapping %g4 and %g5 using %g3
+	mov	%g5, %g4	! %g4=SFSR
+	mov	%g3, %g5	! %g5=SFAR
+	rdpr	%tpc, %g3
 winfix_mna:
 	andn	%g3, 0x7f, %g3
 	add	%g3, 0x78, %g3
