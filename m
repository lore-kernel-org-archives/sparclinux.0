From: Alexander Beregalov <a.beregalov@gmail.com>
Date: Sun, 20 Dec 2009 12:16:36 +0000
Subject: [PATCH 2/2] sparc: us2e_cpufreq.c: fix warnings/errors
Message-Id: <1261311396-609-2-git-send-email-a.beregalov@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Fix warnings which become build errors since -Werror is used.
arch/sparc/kernel/us2e_cpufreq.c:180: error: control reaches end of non-void function
arch/sparc/kernel/us2e_cpufreq.c:203: error: control reaches end of non-void function

Signed-off-by: Alexander Beregalov <a.beregalov@gmail.com>
---
 arch/sparc/kernel/us2e_cpufreq.c |   28 ++++++++++++++++++----------
 1 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/arch/sparc/kernel/us2e_cpufreq.c b/arch/sparc/kernel/us2e_cpufreq.c
index 791c151..d505233 100644
--- a/arch/sparc/kernel/us2e_cpufreq.c
+++ b/arch/sparc/kernel/us2e_cpufreq.c
@@ -158,48 +158,56 @@ static void us2e_transition(unsigned long estar, unsigned long new_bits,
 
 static unsigned long index_to_estar_mode(unsigned int index)
 {
+	unsigned long ret = 0;
+
 	switch (index) {
 	case 0:
-		return ESTAR_MODE_DIV_1;
+		ret = ESTAR_MODE_DIV_1;
 
 	case 1:
-		return ESTAR_MODE_DIV_2;
+		ret = ESTAR_MODE_DIV_2;
 
 	case 2:
-		return ESTAR_MODE_DIV_4;
+		ret = ESTAR_MODE_DIV_4;
 
 	case 3:
-		return ESTAR_MODE_DIV_6;
+		ret = ESTAR_MODE_DIV_6;
 
 	case 4:
-		return ESTAR_MODE_DIV_8;
+		ret = ESTAR_MODE_DIV_8;
 
 	default:
 		BUG();
 	};
+
+	return ret;
 }
 
 static unsigned long index_to_divisor(unsigned int index)
 {
+	unsigned long ret = 0;
+
 	switch (index) {
 	case 0:
-		return 1;
+		ret = 1;
 
 	case 1:
-		return 2;
+		ret = 2;
 
 	case 2:
-		return 4;
+		ret = 4;
 
 	case 3:
-		return 6;
+		ret = 6;
 
 	case 4:
-		return 8;
+		ret = 8;
 
 	default:
 		BUG();
 	};
+
+	return ret;
 }
 
 static unsigned long estar_to_divisor(unsigned long estar)
-- 
1.6.6.rc3

