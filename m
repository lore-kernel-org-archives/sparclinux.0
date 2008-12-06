From: David Miller <davem@davemloft.net>
Date: Sat, 06 Dec 2008 03:05:19 +0000
Subject: [PATCH 8/14]: sparc: Commonize get_one_property() implementations.
Message-Id: <20081205.190519.205117131.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sparc: Commonize get_one_property() implementations.

Add final len assignment in sparc64's get_one_property() (it's necessary
to avoid unchecked return value warnings on the sparc32 side),
and mark name argument const on sparc32's copy.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/prom_32.c |    2 +-
 arch/sparc/kernel/prom_64.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/kernel/prom_32.c b/arch/sparc/kernel/prom_32.c
index a9859d2..a6809bc 100644
--- a/arch/sparc/kernel/prom_32.c
+++ b/arch/sparc/kernel/prom_32.c
@@ -196,7 +196,7 @@ static char * __init build_full_name(struct device_node *dp)
 	return n;
 }
 
-static char * __init get_one_property(phandle node, char *name)
+static char * __init get_one_property(phandle node, const char *name)
 {
 	char *buf = "<NULL>";
 	int len;
diff --git a/arch/sparc/kernel/prom_64.c b/arch/sparc/kernel/prom_64.c
index e3969db..ce96c1c 100644
--- a/arch/sparc/kernel/prom_64.c
+++ b/arch/sparc/kernel/prom_64.c
@@ -407,7 +407,7 @@ static char * __init get_one_property(phandle node, const char *name)
 	len = prom_getproplen(node, name);
 	if (len > 0) {
 		buf = prom_early_alloc(len);
-		prom_getproperty(node, name, buf, len);
+		len = prom_getproperty(node, name, buf, len);
 	}
 
 	return buf;
-- 
1.5.6.5

