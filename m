From: David Miller <davem@davemloft.net>
Date: Tue, 11 Jan 2011 23:53:38 +0000
Subject: [PATCH 17/22] arkfb: Don't clobber par->state.vgabase during open
Message-Id: <20110111.155338.77341413.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org


Signed-off-by: David S. Miller <davem@davemloft.net>
---
 drivers/video/arkfb.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/video/arkfb.c b/drivers/video/arkfb.c
index f328c9d..7a648a7 100644
--- a/drivers/video/arkfb.c
+++ b/drivers/video/arkfb.c
@@ -535,7 +535,10 @@ static int arkfb_open(struct fb_info *info, int user)
 
 	mutex_lock(&(par->open_lock));
 	if (par->ref_count = 0) {
+		void __iomem *vgabase = par->state.vgabase;
+
 		memset(&(par->state), 0, sizeof(struct vgastate));
+		par->state.vgabase = vgabase;
 		par->state.flags = VGA_SAVE_MODE | VGA_SAVE_FONTS | VGA_SAVE_CMAP;
 		par->state.num_crtc = 0x60;
 		par->state.num_seq = 0x30;
-- 
1.7.3.4

