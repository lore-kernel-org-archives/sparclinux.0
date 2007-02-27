From: "Doug Nazar" <nazard@dragoninc.ca>
Date: Tue, 27 Feb 2007 18:52:15 +0000
Subject: RE: Unaligned accesses in ip_rcv and ip_fast_csum
Message-Id: <00d101c75aa0$66420b60$32c62220$@ca>
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

This took me a little longer to track down than it should have. I started
looking at the wrong end of the issue but on the plus side I now have a
better understanding sparcv9 asm and the networking stack.


diff --git a/drivers/net/tulip/tulip_core.c b/drivers/net/tulip/tulip_core.c
index 5a35354..e3774a5 100644
--- a/drivers/net/tulip/tulip_core.c
+++ b/drivers/net/tulip/tulip_core.c
@@ -67,7 +67,7 @@ const char * const medianame[32] = {
 
 /* Set the copy breakpoint for the copy-only-tiny-buffer Rx structure. */
 #if defined(__alpha__) || defined(__arm__) || defined(__hppa__) \
-	|| defined(__sparc_) || defined(__ia64__) \
+	|| defined(__sparc__) || defined(__ia64__) \
 	|| defined(__sh__) || defined(__mips__)
 static int rx_copybreak = 1518;
 #else


