From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Date: Tue, 27 Jun 2017 09:21:58 +0000
Subject: [PATCH] sparc: kernel: pmc: make of_device_ids const.
Message-Id: <a582a2096ae42e6d2411ce1323e25b7c55181517.1498551384.git.arvind.yadav.cs@gmail.com>
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
 arch/sparc/kernel/pmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/kernel/pmc.c b/arch/sparc/kernel/pmc.c
index f12b23f..3b26cf6 100644
--- a/arch/sparc/kernel/pmc.c
+++ b/arch/sparc/kernel/pmc.c
@@ -71,7 +71,7 @@ static int pmc_probe(struct platform_device *op)
 	return 0;
 }
 
-static struct of_device_id pmc_match[] = {
+static const struct of_device_id pmc_match[] = {
 	{
 		.name = PMC_OBPNAME,
 	},
-- 
1.9.1

