From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 11 Mar 2010 18:24:17 +0000
Subject: [PATCH 27/27] of: remove obsolete members from of_platform_driver
Message-Id: <20100311182416.13103.38891.stgit@angua>
List-Id: <sparclinux.vger.kernel.org>
References: <20100311181604.13103.30088.stgit@angua>
In-Reply-To: <20100311181604.13103.30088.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org, gregkh-l3A5Bk7waGM@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org, sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org, jgarzik-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, dwmw2@infrade

.name, .match_table and .owner already exist in struct device_driver.
Remove the duplication from struct of_platform_driver.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 drivers/of/platform.c       |    7 -------
 include/linux/of_platform.h |    4 ----
 2 files changed, 0 insertions(+), 11 deletions(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 9fd7f7d..ba402c6 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -385,13 +385,6 @@ int of_bus_type_init(struct bus_type *bus, const char *name)
 
 int of_register_driver(struct of_platform_driver *drv, struct bus_type *bus)
 {
-	/* initialize common driver fields */
-	if (!drv->driver.name)
-		drv->driver.name = drv->name;
-	if (!drv->driver.owner)
-		drv->driver.owner = drv->owner;
-	if (!drv->driver.of_match_table)
-		drv->driver.of_match_table = drv->match_table;
 	drv->driver.bus = bus;
 
 	/* register with core */
diff --git a/include/linux/of_platform.h b/include/linux/of_platform.h
index ac3ae07..1643d37 100644
--- a/include/linux/of_platform.h
+++ b/include/linux/of_platform.h
@@ -31,10 +31,6 @@ extern struct bus_type of_platform_bus_type;
  */
 struct of_platform_driver
 {
-	const char		*name;
-	const struct of_device_id	*match_table;
-	struct module		*owner;
-
 	int	(*probe)(struct of_device* dev,
 			 const struct of_device_id *match);
 	int	(*remove)(struct of_device* dev);

