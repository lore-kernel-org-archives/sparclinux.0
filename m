From: David Miller <davem@davemloft.net>
Date: Thu, 21 Aug 2008 07:10:25 +0000
Subject: [PATCH 3/3]: of: Add some I2C mod aliases table entries for
Message-Id: <20080821.001025.76289480.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linuxppc-dev@ozlabs.org
Cc: sparclinux@vger.kernel.org, paulus@samba.org


of: Add some I2C mod aliases table entries for sparc64 systems.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 drivers/of/base.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index ad8ac1a..e849f69 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -410,7 +410,9 @@ struct of_modalias_table {
 	char *modalias;
 };
 static struct of_modalias_table of_modalias_table[] = {
-	/* Empty for now; add entries as needed */
+	{ "i2c-adm1031", "adm1031" },
+	{ "i2c-at24c64", "24c64" },
+	{ "i2c-at34c02", "spd" },
 };
 
 /**
-- 
1.5.6.5.GIT

