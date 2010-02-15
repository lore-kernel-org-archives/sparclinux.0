From: Kristoffer Glembo <kristoffer@gaisler.com>
Date: Mon, 15 Feb 2010 15:10:28 +0000
Subject: [PATCH] sparc: Fix incorrect comparison in of_bus_ambapp_match()
Message-Id: <1266246628-860-1-git-send-email-kristoffer@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Use type instead of name in comparison.

Signed-off-by: Kristoffer Glembo <kristoffer@gaisler.com>
---
 arch/sparc/kernel/of_device_32.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/sparc/kernel/of_device_32.c b/arch/sparc/kernel/of_device_32.c
index 4c26eb5..53a58b3 100644
--- a/arch/sparc/kernel/of_device_32.c
+++ b/arch/sparc/kernel/of_device_32.c
@@ -105,7 +105,7 @@ static unsigned long of_bus_sbus_get_flags(const u32 *addr, unsigned long flags)
 
 static int of_bus_ambapp_match(struct device_node *np)
 {
-	return !strcmp(np->name, "ambapp");
+	return !strcmp(np->type, "ambapp");
 }
 
 static void of_bus_ambapp_count_cells(struct device_node *child,
-- 
1.6.4.1

