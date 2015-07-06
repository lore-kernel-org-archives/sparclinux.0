From: Phil Sutter <phil@nwl.cc>
Date: Mon, 06 Jul 2015 13:51:20 +0000
Subject: [PATCH v2] rhashtable: fix for resize events during table walk
Message-Id: <1436190680-21887-1-git-send-email-phil@nwl.cc>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Graf <tgraf@suug.ch>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, davem@davemloft.net, herbert@gondor.apana.org.au, daniel@iogearbox.net, geert@linux-m68k.org, mroos@linux.ee

If rhashtable_walk_next detects a resize operation in progress, it jumps
to the new table and continues walking that one. But it misses to drop
the reference to it's current item, leading it to continue traversing
the new table's bucket in which the current item is sorted into, and
after reaching that bucket's end continues traversing the new table's
second bucket instead of the first one, thereby potentially missing
items.

This fixes the rhashtable runtime test for me. Bug probably introduced
by Herbert Xu's patch eddee5ba ("rhashtable: Fix walker behaviour during
rehash") although not explicitly tested.

Fixes: eddee5ba ("rhashtable: Fix walker behaviour during rehash")
Signed-off-by: Phil Sutter <phil@nwl.cc>
---
Changes since v1:
- Use simplified solution suggested by Herbert Xu.
---
 lib/rhashtable.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index a60a6d3..cc0c697 100644
--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -610,6 +610,8 @@ next:
 		iter->skip = 0;
 	}
 
+	iter->p = NULL;
+
 	/* Ensure we see any new tables. */
 	smp_rmb();
 
@@ -620,8 +622,6 @@ next:
 		return ERR_PTR(-EAGAIN);
 	}
 
-	iter->p = NULL;
-
 	return NULL;
 }
 EXPORT_SYMBOL_GPL(rhashtable_walk_next);
-- 
2.1.2

