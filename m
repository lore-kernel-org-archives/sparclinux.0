From: Kumar Gala <galak@kernel.crashing.org>
Date: Wed, 20 Feb 2008 04:27:48 +0000
Subject: [PATCH] [LMB]: Fix lmb_add_region if region should be added at the
Message-Id: <Pine.LNX.4.64.0802192227170.2215@blarg.am.freescale.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net
Cc: sparclinux@vger.kernel.org, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org

We introduced a bug in fixing lmb_add_region to handle an initial
region being non-zero.  Before that fix it was impossible to insert
a region at the head of the list since the first region always started
at zero.

Now that its possible for the first region to be non-zero we need to
check to see if the new region should be added at the head and if so
actually add it.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 lib/lmb.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/lib/lmb.c b/lib/lmb.c
index e3c8dcb..3c43b95 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -184,6 +184,11 @@ static long __init lmb_add_region(struct lmb_region *rgn, u64 base, u64 size)
 			break;
 		}
 	}
+
+	if (base < rgn->region[0].base) {
+		rgn->region[0].base = base;
+		rgn->region[0].size = size;
+	}
 	rgn->cnt++;

 	return 0;
-- 
1.5.3.8

