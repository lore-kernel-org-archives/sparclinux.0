From: Meelis Roos <mroos@linux.ee>
Date: Thu, 10 Oct 2013 11:51:36 +0000
Subject: [PATCH] only try to find radeon IGP ROM on X86
Message-Id: <alpine.SOC.1.00.1310101444090.15296@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.1209061032360.371@math.ut.ee> <1346950551.30263.196.camel@thor.local> <20120906.141823.13429356729572330.davem@davemloft.net> <CAPM=9ty87-kP1QJjgJKQUVkJxg8yN6ZQ5qy+pVYRnrDoa_VqBQ@mail.gmail.com> <alpine.SOC.1.00.1309231638330.9952@math.ut.ee>
 <CALMQjD8ys=rGGQ5BVfAVPZuN8urr6_xTtCEWq9sYubP4+0bPjQ@mail.gmail.com>
In-Reply-To: <CALMQjD8ys=rGGQ5BVfAVPZuN8urr6_xTtCEWq9sYubP4+0bPjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dave Airlie <airlied@gmail.com>, Alex Deucher <alexdeucher@gmail.com>
Cc: David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org, dri-devel@lists.freedesktop.org

To prevent hangs on non-PC machines (e.g. sparc64), probe Radeon ROM 
from ATI IGP only on X86. Fixes hang in this place and allows PCI radeon 
detection to move on to next problem.

Signed-off-by: Meelis Roos <mroos@linux.ee>

diff --git a/drivers/gpu/drm/radeon/radeon_bios.c b/drivers/gpu/drm/radeon/radeon_bios.c
index 061b227..48ef97c 100644
--- a/drivers/gpu/drm/radeon/radeon_bios.c
+++ b/drivers/gpu/drm/radeon/radeon_bios.c
@@ -49,6 +49,11 @@ static bool igp_read_bios_from_vram(struct radeon_device *rdev)
 	resource_size_t vram_base;
 	resource_size_t size = 256 * 1024; /* ??? */
 
+#ifndef CONFIG_X86
+	/* IGP only exists on X86 (32- and 64-bit) */
+	return false;
+#endif
+
 	if (!(rdev->flags & RADEON_IS_IGP))
 		if (!radeon_card_posted(rdev))
 			return false;

-- 
Meelis Roos (mroos@linux.ee)
