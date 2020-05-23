From: Matt Turner <mattst88@gmail.com>
Date: Sat, 23 May 2020 20:22:33 +0000
Subject: [PATCH 5/5] second/util: Remove unused shadowed variables
Message-Id: <20200523202233.3063074-5-mattst88@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 second/util.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/second/util.c b/second/util.c
index 3346823..3469c34 100644
--- a/second/util.c
+++ b/second/util.c
@@ -120,8 +120,6 @@ int main(int argc, char **argv)
     int end, rodata_start, rodata_end;
     int net = 0;
     int i = 1;
-    char sym[256];
-    unsigned int addr;
 
     if (!strcmp (argv[i], "-a")) {
 	net = 1;
-- 
2.26.2
