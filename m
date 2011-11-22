From: Axel Lin <axel.lin@gmail.com>
Date: Tue, 22 Nov 2011 07:42:20 +0000
Subject: [PATCH] bbc_i2c: Remove unneeded err variable
Message-Id: <1321947740.2476.0.camel@phoenix>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 drivers/sbus/char/bbc_i2c.c |   14 ++++----------
 1 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/sbus/char/bbc_i2c.c b/drivers/sbus/char/bbc_i2c.c
index 5f94d22..a0d1399 100644
--- a/drivers/sbus/char/bbc_i2c.c
+++ b/drivers/sbus/char/bbc_i2c.c
@@ -233,13 +233,9 @@ int bbc_i2c_write_buf(struct bbc_i2c_client *client,
 	int ret = 0;
 
 	while (len > 0) {
-		int err = bbc_i2c_writeb(client, *buf, off);
-
-		if (err < 0) {
-			ret = err;
+		ret = bbc_i2c_writeb(client, *buf, off);
+		if (ret < 0)
 			break;
-		}
-
 		len--;
 		buf++;
 		off++;
@@ -253,11 +249,9 @@ int bbc_i2c_read_buf(struct bbc_i2c_client *client,
 	int ret = 0;
 
 	while (len > 0) {
-		int err = bbc_i2c_readb(client, buf, off);
-		if (err < 0) {
-			ret = err;
+		ret = bbc_i2c_readb(client, buf, off);
+		if (ret < 0)
 			break;
-		}
 		len--;
 		buf++;
 		off++;
-- 
1.7.5.4



