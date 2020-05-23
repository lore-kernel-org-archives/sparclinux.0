From: Matt Turner <mattst88@gmail.com>
Date: Sat, 23 May 2020 20:22:31 +0000
Subject: [PATCH 3/5] silo: Fix misleading indentation
Message-Id: <20200523202233.3063074-3-mattst88@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 common/stringops1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/stringops1.c b/common/stringops1.c
index 08ed4be..6edac96 100644
--- a/common/stringops1.c
+++ b/common/stringops1.c
@@ -74,7 +74,7 @@ int strlen(const char *s)
 {
 	const char *sc;
 	for (sc = s; *sc != '\0'; ++sc);
-		return sc - s;
+	return sc - s;
 }
 
 int strncmp(const char *cs, const char *ct, size_t count)
-- 
2.26.2
