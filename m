From: Kjetil Oftedal <oftedal@gmail.com>
Date: Wed, 22 Jul 2009 05:34:22 +0000
Subject: [PATCH v2] Fix multiple RTC detections on SUN4D
Message-Id: <Pine.LNX.4.64.0907220726370.11858@oizys.tordivel.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


David Miller pointed out that the first version was poorly written.
Have rewritten the patch with his suggestions in mind, and the code
became a lot cleaner.


diff --git a/arch/sparc/kernel/time_32.c b/arch/sparc/kernel/time_32.c
index 614ac7b..a70da0a 100644
--- a/arch/sparc/kernel/time_32.c
+++ b/arch/sparc/kernel/time_32.c
@@ -156,6 +156,10 @@ static int __devinit clock_probe(struct of_device *op, const struct of_device_id
  	if (!model)
  		return -ENODEV;

+	/* Only the primary RTC has an address property */
+	if (!of_find_property(dp, "address", NULL))
+		return -ENODEV;
+
  	m48t59_rtc.resource = &op->resource[0];
  	if (!strcmp(model, "mk48t02")) {
  		/* Map the clock register io area read-only */

