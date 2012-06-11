From: Sarah Nadi <snadi@uwaterloo.ca>
Date: Mon, 11 Jun 2012 21:12:31 +0000
Subject: [PATCH]: Remove redundant #ifdef CONFIG_SPARC64 check
Message-Id: <4FD65F3F.3040409@uwaterloo.ca>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sarah Nadi<snadi@uwaterloo.ca>

Summary: Unnecessary #ifdef check in arch/sparc/kernel/jump_label.c

Problem description: The #ifdef CONFIG_SPARC64 is unnecessary since the file is only compiled when CONFIG_SPARC64 is selected. Leaving it in makes the
#ifdef block always selected while the #else block is never selected. Suggested patch to remove unneccesary check below.


Patch:

--- a/arch/sparc/kernel/jump_label.c    2012-06-11 16:51:15.000000000 -0400
+++ b/arch/sparc/kernel/jump_label.c    2012-06-11 16:54:39.000000000 -0400
@@ -17,13 +17,9 @@
      if (type = JUMP_LABEL_ENABLE) {
          s32 off = (s32)entry->target - (s32)entry->code;

-#ifdef CONFIG_SPARC64
          /* ba,pt %xcc, . + (off << 2) */
          val = 0x10680000 | ((u32) off >> 2);
-#else
-        /* ba . + (off << 2) */
-        val = 0x10800000 | ((u32) off >> 2);
-#endif
+
      } else {
          val = 0x01000000;
      }


Signed-off-by: Sarah Nadi <snadi@uwaterloo.ca>

