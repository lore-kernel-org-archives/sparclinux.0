From: David Miller <davem@davemloft.net>
Date: Tue, 11 Jan 2011 23:53:53 +0000
Subject: [PATCH 18/22] s3fb: Don't clobber par->state.vgabase during open
Message-Id: <20110111.155353.123417336.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org


Signed-off-by: David S. Miller <davem@davemloft.net>
---
 drivers/video/s3fb.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/video/s3fb.c b/drivers/video/s3fb.c
index 2d436ec..45e1d43 100644
--- a/drivers/video/s3fb.c
+++ b/drivers/video/s3fb.c
@@ -379,7 +379,10 @@ static int s3fb_open(struct fb_info *info, int user)
 
 	mutex_lock(&(par->open_lock));
 	if (par->ref_count = 0) {
+		void __iomem *vgabase = par->state.vgabase;
+
 		memset(&(par->state), 0, sizeof(struct vgastate));
+		par->state.vgabase = vgabase;
 		par->state.flags = VGA_SAVE_MODE | VGA_SAVE_FONTS | VGA_SAVE_CMAP;
 		par->state.num_crtc = 0x70;
 		par->state.num_seq = 0x20;
-- 
1.7.3.4

