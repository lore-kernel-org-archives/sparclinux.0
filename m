From: David Miller <davem@davemloft.net>
Date: Thu, 14 Feb 2008 01:10:35 +0000
Subject: [PATCH 2/4]: [LMB]: Fix bug in __lmb_alloc_base().
Message-Id: <20080213.171035.249149650.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linuxppc-dev@ozlabs.org
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


[LMB]: Fix bug in __lmb_alloc_base().

We need to check lmb_add_region() for errors, it can run out
of regions etc.

Also, the size needs to be padded to the given alignment
or else the lmb.reserved regions don't get expanded and
instead we get tons of holes and eventually run out of
regions prematurely.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 lib/lmb.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/lib/lmb.c b/lib/lmb.c
index 98078b4..6390d63 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -245,6 +245,11 @@ static unsigned long lmb_align_down(unsigned long addr, unsigned long size)
 	return addr & ~(size - 1);
 }
 
+static unsigned long lmb_align_up(unsigned long addr, unsigned long size)
+{
+	return (addr + (size - 1)) & ~(size - 1);
+}
+
 unsigned long __init __lmb_alloc_base(unsigned long size, unsigned long align,
 				    unsigned long max_addr)
 {
@@ -281,7 +286,8 @@ unsigned long __init __lmb_alloc_base(unsigned long size, unsigned long align,
 	if (i < 0)
 		return 0;
 
-	lmb_add_region(&lmb.reserved, base, size);
+	if (lmb_add_region(&lmb.reserved, base, lmb_align_up(size, align)) < 0)
+		return 0;
 
 	return base;
 }
-- 
1.5.4.29.gb828fe

