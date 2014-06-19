From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Date: Thu, 19 Jun 2014 12:31:52 +0000
Subject: [PATCH] drivers/sbus/char: Micro-optimization in display7seg.c
Message-Id: <1403181112-12018-1-git-send-email-linux@rasmusvillemoes.dk>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>, Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, Rasmus Villemoes <linux@rasmusvillemoes.dk>

Flipping a bit doesn't need four lines of code; and gcc seems to
actually generate two branches.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/sbus/char/display7seg.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/sbus/char/display7seg.c b/drivers/sbus/char/display7seg.c
index 7c71e7b..3221dff 100644
--- a/drivers/sbus/char/display7seg.c
+++ b/drivers/sbus/char/display7seg.c
@@ -143,10 +143,7 @@ static long d7s_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 
 	case D7SIOCTM:
 		/* toggle device mode-- flip display orientation */
-		if (regs & D7S_FLIP)
-			regs &= ~D7S_FLIP;
-		else
-			regs |= D7S_FLIP;
+		regs ^= D7S_FLIP;
 		writeb(regs, p->regs);
 		break;
 	}
-- 
1.9.2

