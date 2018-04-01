From: Rob Gardner <rob.gardner@oracle.com>
Date: Sun, 01 Apr 2018 04:53:01 +0000
Subject: [PATCH] sparc64: Properly range check DAX completion index
Message-Id: <1522558381-31281-1-git-send-email-rob.gardner@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Each Oracle DAX CCB has a corresponding completion area, and the required
number of areas must fit within a previously allocated array of completion
areas beginning at the requested index.  Since the completion area index
is specified by a file offset, a user can pass arbitrary values, including
negative numbers. So the index must be thoroughly range checked to prevent
access to addresses outside the bounds of the allocated completion
area array.  The index cannot be negative, and it cannot exceed the
total array size, less the number of CCBs requested. The old code did
not check for negative values and was off by one on the upper bound.

Signed-off-by: Rob Gardner <rob.gardner@oracle.com>
Signed-off-by: Jonathan Helman <jonathan.helman@oracle.com>
Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 drivers/sbus/char/oradax.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/sbus/char/oradax.c b/drivers/sbus/char/oradax.c
index d8597d5..96b4ad7 100644
--- a/drivers/sbus/char/oradax.c
+++ b/drivers/sbus/char/oradax.c
@@ -880,7 +880,7 @@ static int dax_ccb_exec(struct dax_ctx *ctx, const char __user *buf,
 	dax_dbg("args: ccb_buf_len=%ld, idx=%d", count, idx);
 
 	/* for given index and length, verify ca_buf range exists */
-	if (idx + nccbs >= DAX_CA_ELEMS) {
+	if (idx < 0 || idx > (DAX_CA_ELEMS - nccbs)) {
 		ctx->result.exec.status = DAX_SUBMIT_ERR_NO_CA_AVAIL;
 		return 0;
 	}
-- 
1.7.1

