From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Date: Thu, 15 Jun 2017 11:12:20 +0000
Subject: [PATCH] sparc/time: make of_device_ids const
Message-Id: <576039c52d8aebbc40bec5ea2929d6517b9130c4.1497521695.git.arvind.yadav.cs@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net, john.stultz@linaro.org, nicstange@gmail.com
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

of_device_ids are not supposed to change at runtime. All functions
working with of_device_ids provided by <linux/of.h> work with const
of_device_ids. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 arch/sparc/kernel/time_32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/kernel/time_32.c b/arch/sparc/kernel/time_32.c
index 9f575df..2ce2e7b 100644
--- a/arch/sparc/kernel/time_32.c
+++ b/arch/sparc/kernel/time_32.c
@@ -298,7 +298,7 @@ static int clock_probe(struct platform_device *op)
 	return 0;
 }
 
-static struct of_device_id clock_match[] = {
+static const struct of_device_id clock_match[] = {
 	{
 		.name = "eeprom",
 	},
-- 
1.9.1

