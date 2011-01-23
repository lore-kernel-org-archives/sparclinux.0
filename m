From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 23 Jan 2011 21:41:10 +0000
Subject: [PATCH 7/7] sparc32,sun4d: add comment in empty statement in sun4d_request_irq()
Message-Id: <1295818870-25450-7-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

This looked like a bug to me.
Add a comment so next reader is hopefully less confused.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/kernel/sun4d_irq.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/sparc/kernel/sun4d_irq.c b/arch/sparc/kernel/sun4d_irq.c
index 6db2fba..fbcbada 100644
--- a/arch/sparc/kernel/sun4d_irq.c
+++ b/arch/sparc/kernel/sun4d_irq.c
@@ -307,7 +307,8 @@ int sun4d_request_irq(unsigned int irq,
 
 	if (action) {
 		if ((action->flags & IRQF_SHARED) && (irqflags & IRQF_SHARED)) {
-			for (tmp = action; tmp->next; tmp = tmp->next);
+			for (tmp = action; tmp->next; tmp = tmp->next)
+				/* find last entry - tmp used below */;
 		} else {
 			ret = -EBUSY;
 			goto out_unlock;
-- 
1.6.0.6

