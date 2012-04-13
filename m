From: David Miller <davem@davemloft.net>
Date: Fri, 13 Apr 2012 19:01:26 +0000
Subject: [PATCH] sparc64: Fix bootup crash on sun4v.
Message-Id: <20120413.150126.895680397991364654.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


The DS driver registers as a subsys_initcall() but this can be too
early, in particular this risks registering before we've had a chance
to allocate and setup module_kset in kernel/params.c which is
performed also as a subsyts_initcall().

Register DS using device_initcall() insteal.

Signed-off-by: David S. Miller <davem@davemloft.net>
Cc: stable@vger.kernel.org
---
 arch/sparc/kernel/ds.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/kernel/ds.c b/arch/sparc/kernel/ds.c
index fea13c7..b93c2c9 100644
--- a/arch/sparc/kernel/ds.c
+++ b/arch/sparc/kernel/ds.c
@@ -1264,4 +1264,4 @@ static int __init ds_init(void)
 	return vio_register_driver(&ds_driver);
 }
 
-subsys_initcall(ds_init);
+fs_initcall(ds_init);
-- 
1.7.9.5

