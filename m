From: Corentin Labbe <clabbe.montjoie@gmail.com>
Date: Mon, 18 Sep 2017 17:58:21 +0000
Subject: [PATCH] sparc: time: Remove unneeded linux/miscdevice.h include
Message-Id: <20170918175821.20026-1-clabbe.montjoie@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, Corentin Labbe <clabbe.montjoie@gmail.com>

arch/sparc/kernel/time_64.c does not contain any miscdevice so the
inclusion of linux/miscdevice.h is unnecessary.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 arch/sparc/kernel/time_64.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/sparc/kernel/time_64.c b/arch/sparc/kernel/time_64.c
index 564f0e46ffd4..5c8524ff09d9 100644
--- a/arch/sparc/kernel/time_64.c
+++ b/arch/sparc/kernel/time_64.c
@@ -27,7 +27,6 @@
 #include <linux/jiffies.h>
 #include <linux/cpufreq.h>
 #include <linux/percpu.h>
-#include <linux/miscdevice.h>
 #include <linux/rtc/m48t59.h>
 #include <linux/kernel_stat.h>
 #include <linux/clockchips.h>
-- 
2.13.5

