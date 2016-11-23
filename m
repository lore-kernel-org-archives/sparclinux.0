From: Geliang Tang <geliangtang@gmail.com>
Date: Wed, 23 Nov 2016 15:06:05 +0000
Subject: [PATCH] sparc: kernel: use builtin_platform_driver
Message-Id: <c694385c83bb1cbe14029016702877962cecb61f.1479913528.git.geliangtang@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: Geliang Tang <geliangtang@gmail.com>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

Use builtin_platform_driver() helper to simplify the code.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 arch/sparc/kernel/power.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/sparc/kernel/power.c b/arch/sparc/kernel/power.c
index 1836cb9..4b60f38 100644
--- a/arch/sparc/kernel/power.c
+++ b/arch/sparc/kernel/power.c
@@ -67,9 +67,4 @@ static struct platform_driver power_driver = {
 	},
 };
 
-static int __init power_init(void)
-{
-	return platform_driver_register(&power_driver);
-}
-
-device_initcall(power_init);
+builtin_platform_driver(power_driver);
-- 
2.9.3

