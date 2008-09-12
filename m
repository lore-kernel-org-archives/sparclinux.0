From: David Miller <davem@davemloft.net>
Date: Fri, 12 Sep 2008 21:48:46 +0000
Subject: [PATCH 9/16]: sparc64: Fix sparse warnings in of_device.c
Message-Id: <20080912.144846.195698099.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sparc64: Fix sparse warnings in of_device.c

Passing unsigned int pointer where plain int pointer is
expected.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc64/kernel/of_device.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/sparc64/kernel/of_device.c b/arch/sparc64/kernel/of_device.c
index 5c4fbc2..ef05d14 100644
--- a/arch/sparc64/kernel/of_device.c
+++ b/arch/sparc64/kernel/of_device.c
@@ -401,8 +401,7 @@ static int __init build_one_resource(struct device_node *parent,
 				     int na, int ns, int pna)
 {
 	const u32 *ranges;
-	unsigned int rlen;
-	int rone;
+	int rone, rlen;
 
 	ranges = of_get_property(parent, "ranges", &rlen);
 	if (ranges = NULL || rlen = 0) {
-- 
1.5.6.5.GIT

