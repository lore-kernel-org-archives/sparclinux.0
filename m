From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 21 Jul 2010 23:39:54 +0000
Subject: [PATCH 1/5] drivercore/of: Add OF style matching to platform bus
Message-Id: <20100721233954.7782.81154.stgit@angua>
List-Id: <sparclinux.vger.kernel.org>
References: <20100721232817.7782.23410.stgit@angua>
In-Reply-To: <20100721232817.7782.23410.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stephen Rothwell <sfr@canb.auug.org.au>, Michal Simek <monstr@monstr.eu>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, microblaze-uclinux@itee.uq.edu.au, sparclinux@vger.kernel.org, David Miller <davem@davemloft.net>

As part of the merge between platform bus and of_platform bus, add the
ability to do of-style matching to the platform bus.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
CC: Greg Kroah-Hartman <gregkh@suse.de>
CC: Michal Simek <monstr@monstr.eu>
CC: Grant Likely <grant.likely@secretlab.ca>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Stephen Rothwell <sfr@canb.auug.org.au>
CC: linux-kernel@vger.kernel.org
CC: microblaze-uclinux@itee.uq.edu.au
CC: linuxppc-dev@ozlabs.org
CC: devicetree-discuss@lists.ozlabs.org
---
 drivers/base/platform.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 4d99c8b..6a9b3dd 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -12,6 +12,7 @@
 
 #include <linux/string.h>
 #include <linux/platform_device.h>
+#include <linux/of_device.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/dma-mapping.h>
@@ -673,6 +674,10 @@ static int platform_match(struct device *dev, struct device_driver *drv)
 	struct platform_device *pdev = to_platform_device(dev);
 	struct platform_driver *pdrv = to_platform_driver(drv);
 
+	/* Attempt an OF style match first */
+	if (of_driver_match_device(dev, drv))
+		return 1;
+
 	/* match against the id table first */
 	if (pdrv->id_table)
 		return platform_match_id(pdrv->id_table, pdev) != NULL;

