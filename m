From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 13 Jun 2008 19:57:06 +0000
Subject: [PATCH] sparc: Merge asm-sparc{,64}/poll.h
Message-Id: <1213387042-9711-5-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

$ diff -u include/asm-sparc/poll.h include/asm-sparc64/poll.h
-- include/asm-sparc/poll.h	2008-06-13 06:42:07.000000000 +0200
++ include/asm-sparc64/poll.h	2008-06-13 06:42:07.000000000 +0200
@@ -1,5 +1,5 @@
-#ifndef __SPARC_POLL_H
-#define __SPARC_POLL_H
+#ifndef __SPARC64_POLL_H
+#define __SPARC64_POLL_H

 #define POLLWRNORM	POLLOUT
 #define POLLWRBAND	256

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 include/asm-sparc64/poll.h |   13 +------------
 1 files changed, 1 insertions(+), 12 deletions(-)

diff --git a/include/asm-sparc64/poll.h b/include/asm-sparc64/poll.h
index ebeeb38..8e2f31b 100644
--- a/include/asm-sparc64/poll.h
+++ b/include/asm-sparc64/poll.h
@@ -1,12 +1 @@
-#ifndef __SPARC64_POLL_H
-#define __SPARC64_POLL_H
-
-#define POLLWRNORM	POLLOUT
-#define POLLWRBAND	256
-#define POLLMSG		512
-#define POLLREMOVE	1024
-#define POLLRDHUP       2048
-
-#include <asm-generic/poll.h>
-
-#endif
+#include <asm-sparc/poll.h>
-- 
1.5.4.1.143.ge7e51

