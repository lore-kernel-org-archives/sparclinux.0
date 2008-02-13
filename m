From: Kumar Gala <galak@kernel.crashing.org>
Date: Wed, 13 Feb 2008 13:37:27 +0000
Subject: [PATCH] [POWERPC] Fix initial lmb add region with a non-zero base
Message-Id: <Pine.LNX.4.64.0802130719330.14428@blarg.am.freescale.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linuxppc-dev@ozlabs.org
Cc: sparclinux@vger.kernel.org, davem@davemloft.net, linux-kernel@vger.kernel.org

If we add to an empty lmb region with a non-zero base we will not coalesce
the number of regions done to one.  This causes problems on ppc32 for the
memory region as its assumed to only have one region.

We can fix this be easily specially casing the initial add to just replace
the dummy region.

---

Posting this since Dave's looking a pulling the lmb code out into lib/ and
sharing it between powerpc and sparc.

(this is my git tree git.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git)

- k

 arch/powerpc/mm/lmb.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/mm/lmb.c b/arch/powerpc/mm/lmb.c
index 4ce23bc..1ea8df0 100644
--- a/arch/powerpc/mm/lmb.c
+++ b/arch/powerpc/mm/lmb.c
@@ -141,6 +141,12 @@ static long __init lmb_add_region(struct lmb_region *rgn, unsigned long base,
 	unsigned long coalesced = 0;
 	long adjacent, i;

+	if ((rgn->cnt = 1) && (rgn->region[0].size = 0)) {
+		rgn->region[0].base = base;
+		rgn->region[0].size = size;
+		return 0;
+	}
+
 	/* First try and coalesce this LMB with another. */
 	for (i=0; i < rgn->cnt; i++) {
 		unsigned long rgnbase = rgn->region[i].base;
-- 
1.5.3.8

