From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Date: Tue, 25 Mar 2008 21:24:30 +0000
Subject: [PATCH 4/6] Handle big kernels
Message-Id: <1206480273-29043-5-git-send-email-vonbrand@inf.utfsm.cl>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Apply silo-big-kernel.patch from Aurora's 1.4.13-8 (from davem)

Signed-off-by: Horst H. von Brand <vonbrand@inf.utfsm.cl>
---
 second/main.c |   16 ++++++++++------
 1 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/second/main.c b/second/main.c
index 9644e44..2042f9d 100644
--- a/second/main.c
+++ b/second/main.c
@@ -1204,12 +1204,16 @@ try_again:
 		unsigned int size;
 		unsigned char *mem;
 
-		size = 0x800000;
-		mem = (unsigned char *)image_memory_find(size);
-
-		if (!mem) {
-		    size = 0x400000;
-		    mem = (unsigned char *)image_memory_find(size);
+ 		/* As of 2.6.25-rc6, an "allyesconfig" kernel is around
+ 		 * ~42MB in size.  So we try to carve out up to 64MB of
+ 		 * memory for the kernel.
+ 		 */
+ 		for (size = 64 * 1024 * 1024;
+ 		     size >= 4 * 1024 * 1024;
+ 		     size -= 4 * 1024 * 1024) {
+ 			mem = (unsigned char *)image_memory_find(size);
+ 			if (mem)
+ 				break;
 		}
 
 		if (mem) {
-- 
1.5.5.rc0.16.g02b00

