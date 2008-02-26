From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Date: Tue, 26 Feb 2008 16:32:57 +0000
Subject: [PATCH 1/3] Fix for ext3 from Aurora SRPM
Message-Id: <1204043579-5056-2-git-send-email-vonbrand@inf.utfsm.cl>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Signed-off-by: Horst H. von Brand <vonbrand@inf.utfsm.cl>
---
 second/fs/ext2.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/second/fs/ext2.c b/second/fs/ext2.c
index 028f77e..57f5e9a 100644
--- a/second/fs/ext2.c
+++ b/second/fs/ext2.c
@@ -42,14 +42,14 @@ static void ext2fs_error (int errcode)
     	    return;
     	}
 #endif
-    printf ("Unknown ext2 error");
+    printf ("Unknown ext2 error: %d", errcode);
 }
 
 static int open_ext2 (char *device)
 {
     int retval;
 
-    retval = ext2fs_open (device, EXT2_FLAG_RW, 0, 0, silo_io_manager, &fs);
+    retval = ext2fs_open (device, EXT2_FLAG_DIRTY, 0, 0, silo_io_manager, &fs);
     if (retval = EXT2_ET_BAD_MAGIC)
         return 0;
     if (retval) {
-- 
1.5.4.3.220.g99d8e

