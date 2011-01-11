From: David Miller <davem@davemloft.net>
Date: Tue, 11 Jan 2011 23:54:07 +0000
Subject: [PATCH 19/22] vt8623fb: Don't clobber par->state.vgabase during
Message-Id: <20110111.155407.113717176.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org


Signed-off-by: David S. Miller <davem@davemloft.net>
---
 drivers/video/vt8623fb.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/video/vt8623fb.c b/drivers/video/vt8623fb.c
index b470157..6f6f049 100644
--- a/drivers/video/vt8623fb.c
+++ b/drivers/video/vt8623fb.c
@@ -292,7 +292,10 @@ static int vt8623fb_open(struct fb_info *info, int user)
 
 	mutex_lock(&(par->open_lock));
 	if (par->ref_count = 0) {
+		void __iomem *vgabase = par->state.vgabase;
+
 		memset(&(par->state), 0, sizeof(struct vgastate));
+		par->state.vgabase = vgabase;
 		par->state.flags = VGA_SAVE_MODE | VGA_SAVE_FONTS | VGA_SAVE_CMAP;
 		par->state.num_crtc = 0xA2;
 		par->state.num_seq = 0x50;
-- 
1.7.3.4

