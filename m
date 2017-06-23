From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Date: Fri, 23 Jun 2017 09:33:35 +0000
Subject: [PATCH] sparc: kernel: apc: make of_device_ids const
Message-Id: <6d8baf5133e6aec69f472850dc54779ceba0c774.1498209603.git.arvind.yadav.cs@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

of_device_ids are not supposed to change at runtime. All functions
working with of_device_ids provided by <linux/of.h> work with const
of_device_ids. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 arch/sparc/kernel/apc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/kernel/apc.c b/arch/sparc/kernel/apc.c
index 9ebc37e..c988e7f 100644
--- a/arch/sparc/kernel/apc.c
+++ b/arch/sparc/kernel/apc.c
@@ -167,7 +167,7 @@ static int apc_probe(struct platform_device *op)
 	return 0;
 }
 
-static struct of_device_id apc_match[] = {
+static const struct of_device_id apc_match[] = {
 	{
 		.name = APC_OBPNAME,
 	},
-- 
1.9.1

