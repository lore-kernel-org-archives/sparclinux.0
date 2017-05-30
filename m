From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Date: Tue, 30 May 2017 19:45:00 +0000
Subject: [PATCH] sparc/mm/hugepages: Fix setup_hugepagesz for invalid values.
Message-Id: <20170530194500.2015-1-Liam.Howlett@Oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

hugetlb_bad_size needs to be called on invalid values.  Also change the
pr_warn to a pr_err to better align with other platforms.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 arch/sparc/mm/init_64.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 0cda653ae007..7ca1b9dc7d64 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -358,7 +358,8 @@ static int __init setup_hugepagesz(char *string)
 	}
 
 	if ((hv_pgsz_mask & cpu_pgsz_mask) = 0U) {
-		pr_warn("hugepagesz=%llu not supported by MMU.\n",
+		hugetlb_bad_size();
+		pr_err("hugepagesz=%llu not supported by MMU.\n",
 			hugepage_size);
 		goto out;
 	}
-- 
2.13.0.92.gcd65a7235

