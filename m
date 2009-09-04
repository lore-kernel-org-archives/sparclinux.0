From: Kjetil Oftedal <oftedal@gmail.com>
Date: Fri, 04 Sep 2009 18:29:31 +0000
Subject: Re: [PATCH v2] Fix multiple RTC detections on SUN4D
Message-Id: <Pine.LNX.4.64.0909042024150.13525@oizys.tordivel.org>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.0907220726370.11858@oizys.tordivel.org>
In-Reply-To: <Pine.LNX.4.64.0907220726370.11858@oizys.tordivel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Sorry about the slow response. Had some memory issues with the testbox.

On SUN4D machines there is one RTC-chip located on each systemboard, when
booting all of these will be probed. Registering a second RTC with the
kernel fails, and breaks the rtc:
[    0.212000] kobject (f02625f0): tried to init an initialized object, somethi
[    0.212000] [f0141418 : platform_device_register+0x4/0x18 ] [f01edbc4 : cloc
[    0.216000] ------------[ cut here ]------------
[    0.216000] WARNING: at fs/sysfs/dir.c:487 sysfs_add_one+0x84/0xa4()
[    0.216000] sysfs: cannot create duplicate filename '/devices/platform/rtc-m
[    0.216000] Modules linked in:
[    0.216000] [f00c1988 : sysfs_add_one+0x84/0xa4 ] [f00c1f70 : create_dir+0x4
[    0.216000] ---[ end trace 139ce121c98e96c9 ]---
[    0.220000] kobject_add_internal failed for rtc-m48t59.0 with -EEXIST, don't
[    0.220000] [f013d568 : device_add+0xc8/0x610 ] [f014134c : platform_device_
[    0.220000] Registering RTC device failed

Later on in the boot the following happens:
[   23.116000] drivers/rtc/hctosys.c: unable to open rtc device (rtc0)

The suggested fix searches the supplied RTC node for a address property
which only one RTC per system appears to have and registers only this RTC
with the kernel. (Tested on SS20/SUN4M and SS1000E/SUN4D).

Signed-off-by: Kjetil Oftedal <oftedal@gmail.com>

diff --git a/arch/sparc/kernel/time_32.c b/arch/sparc/kernel/time_32.c
index 614ac7b..a70da0a 100644
--- a/arch/sparc/kernel/time_32.c
+++ b/arch/sparc/kernel/time_32.c
@@ -156,6 +156,10 @@ static int __devinit clock_probe(struct of_device *op, const struct of_device_id
         if (!model)
                 return -ENODEV;

+       /* Only the primary RTC has an address property */
+       if (!of_find_property(dp, "address", NULL))
+               return -ENODEV;
+
         m48t59_rtc.resource = &op->resource[0];
         if (!strcmp(model, "mk48t02")) {
                 /* Map the clock register io area read-only */

