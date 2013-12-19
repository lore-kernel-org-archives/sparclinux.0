From: Levente Kurusa <levex@linux.com>
Date: Thu, 19 Dec 2013 15:03:16 +0000
Subject: [PATCH 05/38] sparc: kernel: add missing put_device call
Message-Id: <1387465429-3568-6-git-send-email-levex@linux.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1387465429-3568-2-git-send-email-levex@linux.com>
In-Reply-To: <1387465429-3568-2-git-send-email-levex@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>
Cc: Levente Kurusa <levex@linux.com>, "David S. Miller" <davem@davemloft.net>, Federico Vaga <federico.vaga@gmail.com>, sparclinux@vger.kernel.org

This is required so that we give up the last reference to the device.
The kfree() has been removed because put_device will set the underlying kref's
reference count to zero and hence vio_dev_release will get called resulting in
kfreeing the structure.

Signed-off-by: Levente Kurusa <levex@linux.com>
---
 arch/sparc/kernel/vio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/kernel/vio.c b/arch/sparc/kernel/vio.c
index 8647fcc..fb0088d 100644
--- a/arch/sparc/kernel/vio.c
+++ b/arch/sparc/kernel/vio.c
@@ -307,7 +307,7 @@ static struct vio_dev *vio_create_one(struct mdesc_handle *hp, u64 mp,
 	if (err) {
 		printk(KERN_ERR "VIO: Could not register device %s, err=%d\n",
 		       dev_name(&vdev->dev), err);
-		kfree(vdev);
+		put_device(&vdev->dev);
 		return NULL;
 	}
 	if (vdev->dp)
-- 
1.8.3.1

