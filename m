From: Julia Lawall <julia@diku.dk>
Date: Thu, 27 May 2010 12:32:45 +0000
Subject: [PATCH 3/11] arch/sparc/kernel: Eliminate what looks like a NULL
Message-Id: <Pine.LNX.4.64.1005271432250.5422@ask.diku.dk>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>, Grant Likely <grant.likely@secretlab.ca>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree-discuss@lists.ozlabs.orgkern

From: Julia Lawall <julia@diku.dk>

At the point of the test, action cannot be NULL, as it has been dereferenced
in the code just above.

A simplified version of the semantic match that finds this problem is as
follows: (http://coccinelle.lip6.fr/)

// <smpl>
@r exists@
expression E,E1;
identifier f;
statement S1,S2,S3;
@@

if ((E = NULL && ...) || ...)
{
  ... when != if (...) S1 else S2
      when != E = E1
* E->f
  ... when any
}
else S3
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>

---
 arch/sparc/kernel/sun4d_irq.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/kernel/sun4d_irq.c b/arch/sparc/kernel/sun4d_irq.c
index ab036a7..e11b461 100644
--- a/arch/sparc/kernel/sun4d_irq.c
+++ b/arch/sparc/kernel/sun4d_irq.c
@@ -183,7 +183,7 @@ void sun4d_free_irq(unsigned int irq, void *dev_id)
 		goto out_unlock;
 	}
 	
-	if (action && tmp)
+	if (tmp)
 		tmp->next = action->next;
 	else
 		*actionp = action->next;
