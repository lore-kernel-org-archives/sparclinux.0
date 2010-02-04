From: Chris Torek <chris.torek@windriver.com>
Date: Thu, 04 Feb 2010 11:25:56 +0000
Subject: [PATCH 2/8] niu: increase ring size
Message-Id: <14d7f5a63a7026b4413d4b4efa4ce6ddea0e055b.1265231568.git.chris.torek@windriver.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Hong H. Pham <hong.pham@windriver.com>

Configurable niu parameters made it possible to overrun the rings, which
requires a hardware reset to recover.  Since all RCR and TR entries
must fit within a page (hardware constraint), calculate the maximums.
(Note: this means the TX ring size is actually unchanged on x86, but
doubled on SPARC.)

Signed-off-by: Hong H. Pham <hong.pham@windriver.com>
Signed-off-by: Chris Torek <chris.torek@windriver.com>
---
 drivers/net/niu.h |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/niu.h b/drivers/net/niu.h
index 3bd0b59..0c1d17a 100644
--- a/drivers/net/niu.h
+++ b/drivers/net/niu.h
@@ -2843,7 +2843,7 @@ struct txdma_mailbox {
 	__le64	resv2[2];
 } __attribute__((aligned(64)));
 
-#define MAX_TX_RING_SIZE	256
+#define MAX_TX_RING_SIZE	(PAGE_SIZE / sizeof(u64))
 #define MAX_TX_DESC_LEN		4076
 
 struct tx_ring_info {
@@ -2893,8 +2893,8 @@ struct rxdma_mailbox {
 	__le64	resv2[2];
 } __attribute__((aligned(64)));
 
-#define MAX_RBR_RING_SIZE	128
-#define MAX_RCR_RING_SIZE	(MAX_RBR_RING_SIZE * 2)
+#define MAX_RBR_RING_SIZE	256
+#define MAX_RCR_RING_SIZE	(PAGE_SIZE / sizeof(u64))
 
 #define RBR_REFILL_MIN		16
 
-- 
1.6.0.4.766.g6fc4a

