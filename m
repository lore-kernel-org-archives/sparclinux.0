From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 18 May 2011 19:21:00 +0000
Subject: [PATCH 1/2] of: fix race when matching drivers
Message-Id: <20110518192100.28986.94335.stgit@ponder>
List-Id: <sparclinux.vger.kernel.org>
References: <20110518185751.28986.69446.stgit@ponder>
In-Reply-To: <20110518185751.28986.69446.stgit@ponder>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, gregkh-l3A5Bk7waGM@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Milton Miller <miltonm-ogEGBHC/i9Y@public.gmane.org>, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linus Torvalds <torvalds@linux-foundati>

From: Milton Miller <miltonm@bga.com>

If two drivers are probing devices at the same time, both will write
their match table result to the dev->of_match cache at the same time.

Only write the result if the device matches.

In a thread titled "SBus devices sometimes detected, sometimes not",
Meelis reported his SBus hme was not detected about 50% of the time.
From the debug suggested by Grant it was obvious another driver matched
some devices between the call to match the hme and the hme discovery
failling.

Reported-by: Meelis Roos <mroos@linux.ee>
Signed-off-by: Milton Miller <miltonm@bga.com>
[grant.likely: modified to only call of_match_device() once]
Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---
 include/linux/of_device.h |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/linux/of_device.h b/include/linux/of_device.h
index 8bfe6c1..b33d688 100644
--- a/include/linux/of_device.h
+++ b/include/linux/of_device.h
@@ -21,8 +21,12 @@ extern void of_device_make_bus_id(struct device *dev);
 static inline int of_driver_match_device(struct device *dev,
 					 const struct device_driver *drv)
 {
-	dev->of_match = of_match_device(drv->of_match_table, dev);
-	return dev->of_match != NULL;
+	const struct of_device_id *match;
+
+	match = of_match_device(drv->of_match_table, dev);
+	if (match)
+		dev->of_match = match;
+	return match != NULL;
 }
 
 extern struct platform_device *of_dev_get(struct platform_device *dev);

