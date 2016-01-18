From: Bryce <philip.copeland@oracle.com>
Date: Mon, 18 Jan 2016 18:17:34 +0000
Subject: Minor tweak to silo regarding GPT labeled drives
Message-Id: <569D2C3E.5060608@oracle.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------010502000008090809030900"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

This is a multi-part message in MIME format.
--------------010502000008090809030900
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

I've been prompted by a couple of folk to pass along this minor patch for silo
Newer sparc firmware, mostly in the T4 and above range, along with sun(vtoc) now
support gpt labelled drives on the system boot drive (and theoretically some can
also support msdos? not tried it)

The problem with sillo is that it actively looks to see if a sun label magic is
written but GPT has no such 'magic' and silo would moan.

Phil
=--=



--------------010502000008090809030900
Content-Type: text/x-patch;
 name="0015-GPT-tweak.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0015-GPT-tweak.patch"

From 5d5994b88513f2e45701460d275a2d29ab89c40b Mon Sep 17 00:00:00 2001
From: Dazed and confused <clueless@somewhere.com>
Date: Thu, 19 Feb 2015 05:58:30 -0800
Subject: [PATCH] GPT tweak
 quietens silo about lack of a MAGIC for the GPT label

---
 include/silo.h  |    1 +
 second/fs/iom.c |    4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/silo.h b/include/silo.h
index 94d6e31..135b79e 100644
--- a/include/silo.h
+++ b/include/silo.h
@@ -46,6 +46,7 @@ typedef struct {
 } sun_partition;
 
 #define SUN_LABEL_MAGIC          0xDABE
+#define GPT_LABEL_MAGIC          0x0000
 
 struct silo_inode {
     unsigned int inolen;
diff --git a/second/fs/iom.c b/second/fs/iom.c
index 28dd4b2..8629d36 100644
--- a/second/fs/iom.c
+++ b/second/fs/iom.c
@@ -37,8 +37,8 @@ static int read_sun_partition (int partno)
         silo_fatal("Cannot read partition");
         return 0;
     }
-    if (sdl.magic != SUN_LABEL_MAGIC)
-        silo_fatal("Wrong disklabel magic");
+    if ((sdl.magic != SUN_LABEL_MAGIC) && (sdl.magic != GPT_LABEL_MAGIC))
+        printf("Wrong disklabel magic [0x%X]\n", (unsigned int) sdl.magic);
     for (csum = 0, ush = ((unsigned short *) ((&sdl) + 1)) - 1; ush >= (unsigned short *) &sdl;)
         csum ^= *ush--;
     if (csum)
-- 
1.7.1


--------------010502000008090809030900--
