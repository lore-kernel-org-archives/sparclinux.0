From: David Miller <davem@davemloft.net>
Date: Thu, 14 Feb 2013 20:12:33 +0000
Subject: [PATCH] sunvdc: Fix off-by-one in generic_request().
Message-Id: <20130214.151233.851123821156758130.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


The 'operations' bitmap corresponds one-for-one with the operation
codes, no adjustment is necessary.

Reported-by: Mark Kettenis <mark.kettenis@xs4all.nl>
Signed-off-by: David S. Miller <davem@davemloft.net>
---
 drivers/block/sunvdc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/sunvdc.c b/drivers/block/sunvdc.c
index 564156a..5814deb 100644
--- a/drivers/block/sunvdc.c
+++ b/drivers/block/sunvdc.c
@@ -461,7 +461,7 @@ static int generic_request(struct vdc_port *port, u8 op, void *buf, int len)
 	int op_len, err;
 	void *req_buf;
 
-	if (!(((u64)1 << ((u64)op - 1)) & port->operations))
+	if (!(((u64)1 << (u64)op) & port->operations))
 		return -EOPNOTSUPP;
 
 	switch (op) {
-- 
1.7.11.7

