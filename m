From: Aaro Koskinen <aaro.koskinen@iki.fi>
Date: Thu, 24 Aug 2017 21:16:48 +0000
Subject: [PATCH silo] second/tilo: make all inline functions static
Message-Id: <20170824211648.17281-1-aaro.koskinen@iki.fi>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Make all inline functions static. This will avoid build errors
with GCC 7.2.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 second/cfg.c    | 2 +-
 second/decomp.c | 2 +-
 second/memory.c | 8 ++++----
 tilo/tilo.c     | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/second/cfg.c b/second/cfg.c
index 69de34c..15d2d88 100644
--- a/second/cfg.c
+++ b/second/cfg.c
@@ -127,7 +127,7 @@ void cfg_error (char *msg,...)
     longjmp (env, 1);
 }
 
-inline int my_getc ()
+static inline int my_getc ()
 {
     if (currp = endp)
 	return EOF;
diff --git a/second/decomp.c b/second/decomp.c
index df4786c..32fae92 100644
--- a/second/decomp.c
+++ b/second/decomp.c
@@ -62,7 +62,7 @@ static unsigned outcnt = 0;	/* bytes in output buffer */
 static void flush_window (void);
 static void error (char *);
 #define gzip_mark mark
-inline void gzip_release (void **p)
+static inline void gzip_release (void **p)
 {
     release (*p);
 }
diff --git a/second/memory.c b/second/memory.c
index f642577..4157cdd 100644
--- a/second/memory.c
+++ b/second/memory.c
@@ -158,7 +158,7 @@ void sun4c_unmapio (unsigned long virtual)
     sun4c_map (virtual & ~4095, 0);
 }
 
-inline unsigned long sun4m_get_lev1 (void)
+static inline unsigned long sun4m_get_lev1 (void)
 {
     unsigned long ret;
     
@@ -172,7 +172,7 @@ inline unsigned long sun4m_get_lev1 (void)
     return ret;
 }
 
-inline unsigned long sun4m_probe (unsigned long l)
+static inline unsigned long sun4m_probe (unsigned long l)
 {
     unsigned long ret;
     
@@ -181,7 +181,7 @@ inline unsigned long sun4m_probe (unsigned long l)
     return ret;
 }
 
-inline unsigned long sun4m_get_direct (unsigned long l)
+static inline unsigned long sun4m_get_direct (unsigned long l)
 {
     unsigned long ret;
     __asm__ ("\n\t"
@@ -189,7 +189,7 @@ inline unsigned long sun4m_get_direct (unsigned long l)
     return ret;
 }
 
-inline void sun4m_set_direct (unsigned long l, unsigned long set)
+static inline void sun4m_set_direct (unsigned long l, unsigned long set)
 {
     __asm__ ("\n\t"
 	"sta %0, [%1] 32\n\t" : : "r" (set), "r" (l));
diff --git a/tilo/tilo.c b/tilo/tilo.c
index 9ed4091..0cabe7b 100644
--- a/tilo/tilo.c
+++ b/tilo/tilo.c
@@ -73,7 +73,7 @@ static unsigned outcnt = 0;	/* bytes in output buffer */
 static void flush_window (void);
 static void error (char *);
 #define gzip_mark mark
-inline void gzip_release (void **p)
+static inline void gzip_release (void **p)
 {
     release (*p);
 }
-- 
2.9.2

