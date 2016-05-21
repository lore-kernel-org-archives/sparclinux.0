From: Andrea Gelmini <andrea.gelmini@gelma.net>
Date: Sat, 21 May 2016 12:10:29 +0000
Subject: [PATCH 0259/1529] Fix typo
Message-Id: <20160521121029.13602-1-andrea.gelmini@gelma.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/sparc/kernel/vio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/kernel/vio.c b/arch/sparc/kernel/vio.c
index f6bb857..b542524 100644
--- a/arch/sparc/kernel/vio.c
+++ b/arch/sparc/kernel/vio.c
@@ -383,7 +383,7 @@ static struct mdesc_notifier_client vio_device_notifier = {
 
 /* We are only interested in domain service ports under the
  * "domain-services" node.  On control nodes there is another port
- * under "openboot" that we should not mess with as aparently that is
+ * under "openboot" that we should not mess with as apparently that is
  * reserved exclusively for OBP use.
  */
 static void vio_add_ds(struct mdesc_handle *hp, u64 node)
-- 
2.8.2.534.g1f66975

