From: "Tom 'spot' Callaway" <tcallawa@redhat.com>
Date: Wed, 22 Dec 2004 05:38:51 +0000
Subject: [sparc32] [3/3] sun4d prom_adjust_ranges extern
Message-Id: <1103693931.3913.72.camel@localhost.localdomain>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-n8giNXa8hOJxq3XKv2Fw"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org


--=-n8giNXa8hOJxq3XKv2Fw
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Chris Newport and Thomas Bogendoerfer's sun4d patch adds a
prom_adjust_ranges call to drivers/sbus/sbus.c, but no extern for the
function, so we get this warning:

drivers/sbus/sbus.c: In function `sbus_bus_ranges_init':
drivers/sbus/sbus.c:243: warning: implicit declaration of function
`prom_adjust_ranges'

Adding the extern makes the warning go away.

Signed-off-by: Tom 'spot' Callaway <tcallawa@redhat.com>

~spot
---
Tom "spot" Callaway <tcallawa(a)redhat*com> LCA, RHCE 
Red Hat Sales Engineer || Aurora Linux Project Leader

"If you are going through hell, keep going."
- Sir Winston Churchill

--=-n8giNXa8hOJxq3XKv2Fw
Content-Disposition: attachment; filename=linux-2.6.9-sun4d-prom_adjust_ranges.patch
Content-Type: text/x-patch; name=linux-2.6.9-sun4d-prom_adjust_ranges.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- linux-2.6.9/drivers/sbus/sbus.c.BAD	2004-12-21 23:13:04.166603659 -0500
+++ linux-2.6.9/drivers/sbus/sbus.c	2004-12-21 23:12:57.749579195 -0500
@@ -219,6 +219,9 @@ static void __init sbus_do_child_sibling
  */
 /* added back sun4d patch from Thomas Bogendoerfer - should be OK (crn) */
 
+extern void prom_adjust_ranges(struct linux_prom_ranges *ranges1, int nranges1,
+			       struct linux_prom_ranges *ranges2, int nranges2);
+
 static void __init sbus_bus_ranges_init(int parent_node, struct sbus_bus *sbus)
 {
 	int len;

--=-n8giNXa8hOJxq3XKv2Fw--

