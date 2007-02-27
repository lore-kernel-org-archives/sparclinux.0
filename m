From: "Doug Nazar" <nazard@dragoninc.ca>
Date: Tue, 27 Feb 2007 19:43:23 +0000
Subject: RE: Unaligned accesses in ip_rcv and ip_fast_csum
Message-Id: <00e801c75aa7$8af0e5b0$a0d2b110$@ca>
List-Id: <sparclinux.vger.kernel.org>
References: <20070225200702.GA4451@droopy.oc.cox.net>
In-Reply-To: <20070225200702.GA4451@droopy.oc.cox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> We have a report (Debian bug #409313 [0]) of the following unaligned
> accesses, occuring every 5-6 seconds on Netra X1 and SunFire v100 with
> kernel 2.6.18 and newer:

A quick grep shows this issue is also in de2104x module in case somebody is
using that.

diff --git a/drivers/net/tulip/de2104x.c b/drivers/net/tulip/de2104x.c
index 9d67f11..dacea4f 100644
--- a/drivers/net/tulip/de2104x.c
+++ b/drivers/net/tulip/de2104x.c
@@ -63,7 +63,7 @@ MODULE_PARM_DESC (debug, "de2104x bitmapped message enable
number");
 
 /* Set the copy breakpoint for the copy-only-tiny-buffer Rx structure. */
 #if defined(__alpha__) || defined(__arm__) || defined(__hppa__) \
-        || defined(__sparc_) || defined(__ia64__) \
+        || defined(__sparc__) || defined(__ia64__) \
         || defined(__sh__) || defined(__mips__)
 static int rx_copybreak = 1518;
 #else

