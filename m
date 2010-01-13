From: Michael Ellerman <michael@ellerman.id.au>
Date: Wed, 13 Jan 2010 07:25:24 +0000
Subject: [PATCH] lmb: Add lmb_free()
Message-Id: <7fc2de452d4c0a034681dcaca89630882386b4b2.1263367518.git.michael@ellerman.id.au>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linuxppc-dev@ozlabs.org
Cc: sparclinux@vger.kernel.org, microblaze-uclinux@itee.uq.edu.au, linux-sh@vger.kernel.org

We can free memory allocated with lmb_alloc() by removing it from the
list of reserved LMBs. Rework lmb_remove() to allow that possibility
and add lmb_free() which exploits it.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 include/linux/lmb.h |    1 +
 lib/lmb.c           |   13 +++++++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/linux/lmb.h b/include/linux/lmb.h
index ef82b8f..f3d1433 100644
--- a/include/linux/lmb.h
+++ b/include/linux/lmb.h
@@ -42,6 +42,7 @@ extern void __init lmb_init(void);
 extern void __init lmb_analyze(void);
 extern long lmb_add(u64 base, u64 size);
 extern long lmb_remove(u64 base, u64 size);
+extern long __init lmb_free(u64 base, u64 size);
 extern long __init lmb_reserve(u64 base, u64 size);
 extern u64 __init lmb_alloc_nid(u64 size, u64 align, int nid,
 				u64 (*nid_range)(u64, u64, int *));
diff --git a/lib/lmb.c b/lib/lmb.c
index 9cee171..cdeb284 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -205,9 +205,8 @@ long lmb_add(u64 base, u64 size)
 
 }
 
-long lmb_remove(u64 base, u64 size)
+static long __lmb_remove(struct lmb_region *rgn, u64 base, u64 size)
 {
-	struct lmb_region *rgn = &(lmb.memory);
 	u64 rgnbegin, rgnend;
 	u64 end = base + size;
 	int i;
@@ -254,6 +253,16 @@ long lmb_remove(u64 base, u64 size)
 	return lmb_add_region(rgn, end, rgnend - end);
 }
 
+long lmb_remove(u64 base, u64 size)
+{
+	return __lmb_remove(&(lmb.memory), base, size);
+}
+
+long __init lmb_free(u64 base, u64 size)
+{
+	return __lmb_remove(&(lmb.reserved), base, size);
+}
+
 long __init lmb_reserve(u64 base, u64 size)
 {
 	struct lmb_region *_rgn = &lmb.reserved;
-- 
1.6.3.3

