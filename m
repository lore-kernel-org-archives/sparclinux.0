From: David Miller <davem@davemloft.net>
Date: Thu, 14 Feb 2008 01:10:50 +0000
Subject: [PATCH 3/4]: [LMB]: Fix initial lmb add region with a non-zero base
Message-Id: <20080213.171050.183740061.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linuxppc-dev@ozlabs.org
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


[LMB]: Fix initial lmb add region with a non-zero base

If we add to an empty lmb region with a non-zero base we will not
coalesce the number of regions down to one.  This causes problems on
ppc32 for the memory region as its assumed to only have one region.

We can fix this be easily specially casing the initial add to just
replace the dummy region.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
---
 lib/lmb.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/lib/lmb.c b/lib/lmb.c
index 6390d63..e34a9e5 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -134,6 +134,12 @@ static long __init lmb_add_region(struct lmb_region *rgn, unsigned long base,
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
1.5.4.29.gb828fe

