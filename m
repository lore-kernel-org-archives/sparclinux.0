From: Matthias Kaehlcke <matthias.kaehlcke@gmail.com>
Date: Sun, 01 Jul 2007 15:16:10 +0000
Subject: [PATCH] Videopix Frame Grabber: Fix unreleased lock in vfc_debug()
Message-Id: <20070701151610.GA3940@traven>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net, wli@holomorphy.com, sparclinux@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org

Videopix Frame Grabber: vfc_debug() doesn't release the device lock
when copy_from_user() fails

Signed-off-by: Matthias Kaehlcke <matthias.kaehlcke@gmail.com>

---

diff --git a/drivers/sbus/char/vfc_dev.c b/drivers/sbus/char/vfc_dev.c
index 6afc7e5..1cbdabd 100644
--- a/drivers/sbus/char/vfc_dev.c
+++ b/drivers/sbus/char/vfc_dev.c
@@ -248,6 +248,7 @@ static int vfc_debug(struct vfc_dev *dev, int cmd, void __user *argp)
 					buffer,inout.len);
 
 		if (copy_to_user(argp,&inout,sizeof(inout))) {
+			vfc_unlock_device(dev);
 			kfree(buffer);
 			return -EFAULT;
 		}
 
-- 
Matthias Kaehlcke
Linux Application Developer
Barcelona


   Usually when people are sad, they don't do anything. They just cry over
     their condition. But when they get angry, they bring about a change
                              (Malcolm X)
                                                                 .''`.
    using free software / Debian GNU/Linux | http://debian.org  : :'  :
                                                                `. `'`
gpg --keyserver pgp.mit.edu --recv-keys 47D8E5D4                  `-
