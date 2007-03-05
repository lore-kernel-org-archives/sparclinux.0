From: David Miller <davem@davemloft.net>
Date: Mon, 05 Mar 2007 09:11:39 +0000
Subject: [PATCH]: Fix for SB100/SB150 bootup hangs
Message-Id: <20070305.011139.78710584.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Anyone with a SunBlade100 or SunBlade150 trying to use
kernels built with gcc-4.1.x or later and seeing hangs
should try out this patch.

GCC-4.1.x and later optimize away this poorly constructed
delay, so there is no delay, and the chip hangs.

I'll put a proper version of this fix, using a udelay(),
upstream very soon.

Thanks.

diff --git a/drivers/video/aty/mach64_ct.c b/drivers/video/aty/mach64_ct.c
index f3b487b..96e91ee 100644
--- a/drivers/video/aty/mach64_ct.c
+++ b/drivers/video/aty/mach64_ct.c
@@ -614,7 +614,8 @@ static void aty_resume_pll_ct(const struct fb_info *info,
 		 * helps for Rage Mobilities that sometimes crash when
 		 * we switch to sclk. (Daniel Mantione, 13-05-2003)
 		 */
-		for (i=0;i<=0x1ffff;i++);
+		for (i=0;i<=0x1ffff;i++)
+			barrier();
 	}
 
 	aty_st_pll_ct(PLL_REF_DIV, pll->ct.pll_ref_div, par);
