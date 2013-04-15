From: Federico Vaga <federico.vaga@gmail.com>
Date: Mon, 15 Apr 2013 14:42:52 +0000
Subject: [RFC PATCH] sparc/kernel/vio.c: add put_device() after device_find_child()
Message-Id: <1366036972-9240-1-git-send-email-federico.vaga@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Federico Vaga <federico.vaga@gmail.com>

The vio_remove() function uses device_find_child() but it does not drop
the reference of the retrieved child.

Signed-off-by: Federico Vaga <federico.vaga@gmail.com>
---

I do not have a SPARC system (and I do not know it), so I cannot test this
patch. Please test it.
If I'm right, the device_unregister() does not work properly because,
device_find_child() did get_device() on dev. In essence, the release method
associated to the device will never be invoked because there is a reference
to the device that is not dropped.

 arch/sparc/kernel/vio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sparc/kernel/vio.c b/arch/sparc/kernel/vio.c
index 3e244f3..8647fcc 100644
--- a/arch/sparc/kernel/vio.c
+++ b/arch/sparc/kernel/vio.c
@@ -342,6 +342,7 @@ static void vio_remove(struct mdesc_handle *hp, u64 node)
 		printk(KERN_INFO "VIO: Removing device %s\n", dev_name(dev));
 
 		device_unregister(dev);
+		put_device(dev);
 	}
 }
 
-- 
1.8.1.4

