From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Date: Tue, 25 Mar 2008 21:24:28 +0000
Subject: [PATCH 2/6] <asm/page.h> is no more
Message-Id: <1206480273-29043-3-git-send-email-vonbrand@inf.utfsm.cl>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Signed-off-by: Horst H. von Brand <vonbrand@inf.utfsm.cl>
---
 second/main.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/second/main.c b/second/main.c
index d5285bb..9644e44 100644
--- a/second/main.c
+++ b/second/main.c
@@ -25,7 +25,6 @@
 /* TODO: This file is a good candidate for rewrite from scratch.  */
 
 #include <silo.h>
-#include <asm/page.h>
 #include <linux/elf.h>
 #include <stringops.h>
 
-- 
1.5.5.rc0.16.g02b00

