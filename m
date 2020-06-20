From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Date: Sat, 20 Jun 2020 01:14:06 +0000
Subject: [PATCH][next] sparc64: viohs: Use struct_size() helper
Message-Id: <20200620011406.GA3260@embeddedor>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>

Make use of the struct_size() helper instead of an open-coded version
in order to avoid any potential type mistakes. Also, remove unnecessary
variable _len_.

This code was detected with the help of Coccinelle and, audited and
fixed manually.

Addresses-KSPP-ID: https://github.com/KSPP/linux/issues/83
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 arch/sparc/kernel/viohs.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/kernel/viohs.c b/arch/sparc/kernel/viohs.c
index 7db5aabe9708..e27afd233bf5 100644
--- a/arch/sparc/kernel/viohs.c
+++ b/arch/sparc/kernel/viohs.c
@@ -428,7 +428,7 @@ static int process_dreg_info(struct vio_driver_state *vio,
 			     struct vio_dring_register *pkt)
 {
 	struct vio_dring_state *dr;
-	int i, len;
+	int i;
 
 	viodbg(HS, "GOT DRING_REG INFO ident[%llx] "
 	       "ndesc[%u] dsz[%u] opt[0x%x] ncookies[%u]\n",
@@ -482,9 +482,7 @@ static int process_dreg_info(struct vio_driver_state *vio,
 	       pkt->num_descr, pkt->descr_size, pkt->options,
 	       pkt->num_cookies);
 
-	len = (sizeof(*pkt) +
-	       (dr->ncookies * sizeof(struct ldc_trans_cookie)));
-	if (send_ctrl(vio, &pkt->tag, len) < 0)
+	if (send_ctrl(vio, &pkt->tag, struct_size(pkt, cookies, dr->ncookies)) < 0)
 		goto send_nack;
 
 	vio->dr_state |= VIO_DR_STATE_RXREG;
-- 
2.27.0
