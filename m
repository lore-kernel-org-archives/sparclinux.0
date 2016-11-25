From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Fri, 25 Nov 2016 11:02:50 +0000
Subject: [patch] sparc: indent an if statement
Message-Id: <20161125110250.GC5938@mwanda>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kernel-janitors@vger.kernel.org

The code works fine, but my static checker complains when we don't
indent our if statements.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/arch/sparc/prom/ranges.c b/arch/sparc/prom/ranges.c
index 6d8dc2a..43f7d99 100644
--- a/arch/sparc/prom/ranges.c
+++ b/arch/sparc/prom/ranges.c
@@ -43,7 +43,7 @@ static void prom_adjust_ranges(struct linux_prom_ranges *ranges1, int nranges1,
 			if (ranges1[rng1c].ot_parent_space = ranges2[rng2c].ot_child_space &&
 			   ranges1[rng1c].ot_parent_base >= ranges2[rng2c].ot_child_base &&
 			   ranges2[rng2c].ot_child_base + ranges2[rng2c].or_size - ranges1[rng1c].ot_parent_base > 0U)
-			break;
+				break;
 		if (rng2c = nranges2) /* oops */
 			prom_printf("adjust_ranges: Could not find matching bus type...\n");
 		else if (ranges1[rng1c].ot_parent_base + ranges1[rng1c].or_size > ranges2[rng2c].ot_child_base + ranges2[rng2c].or_size)
