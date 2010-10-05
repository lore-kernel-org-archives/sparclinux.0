From: Kirill Tkhai <tkhai@yandex.ru>
Date: Tue, 05 Oct 2010 19:57:56 +0000
Subject: [PATCH]SPARC v9: __tsb_context_switch - demap old tsb_map_vaddr
Message-Id: <1286308676.11216.4.camel@hp>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

SPARC v9: __tsb_context_switch - demap old tsb_map_vaddr
---
When TSB context switches in the function switch_mm() the following
situation could occur. We have old mapping between physical address
and tsb_map_vaddr in uTLB, and new mapping is written in fDTLB.
Because uDTLB has more priority than fDTLB, all transformations
occur through it, and TSB Pointer in tl0_damiss will be formed with
the wrong physical address. To prevent this, we need to flush old
tsb_map_vaddr (TSB_BASE) in TLB. Kernel version 2.6.35.7.


Signed-off-by: Tkhai Kirill <tkhai@yandex.ru>
---

--- arch/sparc/kernel/tsb.S.orig 2010-10-05 19:46:55.272218523 +0400
+++ arch/sparc/kernel/tsb.S 2010-10-05 19:48:56.136235329 +0400
@@ -396,6 +396,9 @@ __tsb_context_switch:

 2:	ldx	[%o1 + TSB_CONFIG_MAP_VADDR], %o4
 	brz	%o4, 9f
+	or	%o4, 1 << 5, %o5
+	stxa	%g0, [%o5] ASI_DMMU_DEMAP
+	membar	#Sync
 	 ldx	[%o1 + TSB_CONFIG_MAP_PTE], %o5
 
 	sethi	%hi(sparc64_highest_unlocked_tlb_ent), %g2

