From: Kirill Tkhai <tkhai@yandex.ru>
Date: Fri, 02 Aug 2013 15:23:18 +0000
Subject: [PATCH 1/2]sparc64: Fix ITLB handler of null page
Message-Id: <1329021375456998@web27d.yandex.ru>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

1)Use kvmap_itlb_longpath instead of kvmap_dtlb_longpath.

2)Handle page #0 only, don't handle page #1: bleu -> blu

 (KERNBASE is 0x400000, so #1 does not exist too. But everything
  is possible in the future. Fix to not to have problems later.)

3)Remove unused kvmap_itlb_nonlinear.

Signed-off-by: Kirill Tkhai <tkhai@yandex.ru>
CC: David Miller <davem@davemloft.net>
---
 arch/sparc/kernel/ktlb.S |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/kernel/ktlb.S b/arch/sparc/kernel/ktlb.S
index 0746e5e..fde5a41 100644
--- a/arch/sparc/kernel/ktlb.S
+++ b/arch/sparc/kernel/ktlb.S
@@ -25,11 +25,10 @@ kvmap_itlb:
 	 */
 kvmap_itlb_4v:
 
-kvmap_itlb_nonlinear:
 	/* Catch kernel NULL pointer calls.  */
 	sethi		%hi(PAGE_SIZE), %g5
 	cmp		%g4, %g5
-	bleu,pn		%xcc, kvmap_dtlb_longpath
+	blu,pn		%xcc, kvmap_itlb_longpath
 	 nop
 
 	KERN_TSB_LOOKUP_TL1(%g4, %g6, %g5, %g1, %g2, %g3, kvmap_itlb_load)
