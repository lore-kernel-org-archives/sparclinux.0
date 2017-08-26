From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Date: Sat, 26 Aug 2017 11:40:34 +0000
Subject: [PATCH] sparc: leon: grpci2: constify of_device_id
Message-Id: <cde41ec4bb81718be389f0c47d0469fb2a0d27c1.1503746607.git.arvind.yadav.cs@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

of_device_id are not supposed to change at runtime. All functions
working with of_device_id provided by <linux/of.h> work with const
of_device_ids. So mark the const and __initconst.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 arch/sparc/kernel/leon_pci_grpci2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/kernel/leon_pci_grpci2.c b/arch/sparc/kernel/leon_pci_grpci2.c
index f727c4d..ff0e5c9 100644
--- a/arch/sparc/kernel/leon_pci_grpci2.c
+++ b/arch/sparc/kernel/leon_pci_grpci2.c
@@ -886,7 +886,7 @@ static int grpci2_of_probe(struct platform_device *ofdev)
 	return err;
 }
 
-static struct of_device_id grpci2_of_match[] = {
+static const struct of_device_id grpci2_of_match[] __initconst = {
 	{
 	 .name = "GAISLER_GRPCI2",
 	 },
-- 
2.7.4

