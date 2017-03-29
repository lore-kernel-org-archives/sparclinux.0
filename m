From: Jag Raman <jag.raman@oracle.com>
Date: Wed, 29 Mar 2017 21:51:45 +0000
Subject: [PATCH 4/5] sparc64: skip control packet while processing LDC RX queue
Message-Id: <6a6c93cb9676b785dcfce86098ea5111b179c9d6.1490823535.git.jag.raman@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Skip the control-only packet while processing the RX queue, for LDC
channels in UNRELIABLE mode.

Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Reviewed-by: Aaron Young <aaron.young@oracle.com>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Reviewed-by: Bijan Mottahedeh <bijan.mottahedeh@oracle.com>
Reviewed-by: Liam Merwick <liam.merwick@oracle.com>
---
 arch/sparc/kernel/ldc.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/sparc/kernel/ldc.c b/arch/sparc/kernel/ldc.c
index 04996cc..3dc8467 100644
--- a/arch/sparc/kernel/ldc.c
+++ b/arch/sparc/kernel/ldc.c
@@ -1815,9 +1815,14 @@ static int read_nonraw(struct ldc_channel *lp, void *buf, unsigned int size)
 
 		lp->rcv_nxt = p->seqid;
 
+		/*
+		 * If this is a control-only packet, there is nothing
+		 * else to do but advance the rx queue since the packet
+		 * was already processed above.
+		 */
 		if (!(p->type & LDC_DATA)) {
 			new = rx_advance(lp, new);
-			goto no_data;
+			break;
 		}
 		if (p->stype & (LDC_ACK | LDC_NACK)) {
 			err = data_ack_nack(lp, p);
-- 
1.7.1

