From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Date: Sat, 26 Aug 2017 11:40:48 +0000
Subject: [PATCH] sparc: leon: grpci1: constify of_device_id
Message-Id: <47b2967d191cb0b0a525682feb7991742df333e6.1503746607.git.arvind.yadav.cs@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <cde41ec4bb81718be389f0c47d0469fb2a0d27c1.1503746607.git.arvind.yadav.cs@gmail.com>
In-Reply-To: <cde41ec4bb81718be389f0c47d0469fb2a0d27c1.1503746607.git.arvind.yadav.cs@gmail.com>
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
 arch/sparc/kernel/leon_pci_grpci1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/kernel/leon_pci_grpci1.c b/arch/sparc/kernel/leon_pci_grpci1.c
index 1e77128..c5fc762 100644
--- a/arch/sparc/kernel/leon_pci_grpci1.c
+++ b/arch/sparc/kernel/leon_pci_grpci1.c
@@ -695,7 +695,7 @@ static int grpci1_of_probe(struct platform_device *ofdev)
 	return err;
 }
 
-static struct of_device_id grpci1_of_match[] = {
+static const struct of_device_id grpci1_of_match[] __initconst = {
 	{
 	 .name = "GAISLER_PCIFBRG",
 	 },
-- 
2.7.4

