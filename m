From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 09 Jul 2020 19:30:16 +0000
Subject: [PATCH] drm/drm_fb_helper: fix fbdev with sparc64
Message-Id: <20200709193016.291267-1-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Gerd Hoffmann <kraxel@redhat.com>, Thomas Zimmermann <tzimmermann@suse.de>, sparclinux@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>, "David S. Miller" <davem@davemloft.net>

Mark reported that sparc64 would panic while booting using qemu.
Mark bisected this to a patch that introduced generic fbdev emulation to
the bochs DRM driver.
Mark pointed out that a similar bug was fixed before where
the sys helpers was replaced by cfb helpers.

The culprint here is that the framebuffer reside in IO memory which
requires SPARC ASI_PHYS (physical) loads and stores.

The current bohcs DRM driver uses a shadow buffer.
So all copying to the framebuffer happens in
drm_fb_helper_dirty_blit_real().

The fix is to replace the memcpy with memcpy_toio() from io.h.

memcpy_toio() uses writeb() where the original fbdev code
used sbus_memcpy_toio(). The latter uses sbus_writeb().

The difference between writeb() and sbus_memcpy_toio() is
that writeb() writes bytes in little-endian, where sbus_writeb() writes
bytes in big-endian. As endian does not matter for byte writes they are
the same. So we can safely use memcpy_toio() here.

For many architectures memcpy_toio() is a simple memcpy().
One sideeffect that is unknow is if this has any impact on other
architectures.
So far the analysis tells that this change is OK for other arch's.
but testing would be good.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Reported-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
---
 drivers/gpu/drm/drm_fb_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index 5609e164805f..4d05b0ab1592 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -399,7 +399,7 @@ static void drm_fb_helper_dirty_blit_real(struct drm_fb_helper *fb_helper,
 	unsigned int y;
 
 	for (y = clip->y1; y < clip->y2; y++) {
-		memcpy(dst, src, len);
+		memcpy_toio(dst, src, len);
 		src += fb->pitches[0];
 		dst += fb->pitches[0];
 	}
-- 
2.25.1
