From: "Tom 'spot' Callaway" <tcallawa@redhat.com>
Date: Sun, 07 Mar 2004 16:28:55 +0000
Subject: [PATCH 2.6] Fix parport_sunbpp so it compiles
Message-Id: <1078676935.12295.31.camel@zorak>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-3KYgyq2YFIVkZe+HPLEm"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org


--=-3KYgyq2YFIVkZe+HPLEm
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Given the history of this driver, I doubt this gets it into "working"
state, but it should at least compile now.

~spot
---
Tom "spot" Callaway <tcallawa(a)redhat*com> LCA, RHCE 
Red Hat Sales Engineer || Aurora SPARC Linux Project Leader

"The author's mathematical treatment of the conception of purpose is
novel and highly ingenious, but heretical and, so far as the present
social order is concerned, dangerous and potentially subversive. Not 
to be published." -- Aldous Huxley's "Brave New World"

--=-3KYgyq2YFIVkZe+HPLEm
Content-Disposition: attachment; filename=linux-2.6.3-parport_sunbpp_fix.patch
Content-Type: text/x-diff; name=linux-2.6.3-parport_sunbpp_fix.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- linux-2.6.3/drivers/parport/parport_sunbpp.c.OLD	2004-03-07 11:23:12.000000000 -0500
+++ linux-2.6.3/drivers/parport/parport_sunbpp.c	2004-03-07 11:25:24.000000000 -0500
@@ -384,7 +384,7 @@
 
 static void __exit parport_sunbpp_exit(void)
 {
-	while (!list_empty(port_list)) {
+	while (!list_empty(&port_list)) {
 		Node *node = list_entry(port_list.next, Node, list);
 		struct parport *p = node->port;
 		struct parport_operations *ops = p->ops;

--=-3KYgyq2YFIVkZe+HPLEm--

