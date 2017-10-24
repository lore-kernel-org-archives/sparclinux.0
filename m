From: Allen Pais <allen.pais@oracle.com>
Date: Tue, 24 Oct 2017 09:50:13 +0000
Subject: [PATCH] sparc64: Convert timers to user timer_setup()
Message-Id: <1508837893-26652-1-git-send-email-allen.pais@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Switch to using the new timer_setup() and from_timer()
in LDOM Virtual I/O handshake.

Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Allen Pais <allen.pais@oracle.com>
---
 arch/sparc/kernel/viohs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/kernel/viohs.c b/arch/sparc/kernel/viohs.c
index dcd278f..7cb27c2 100644
--- a/arch/sparc/kernel/viohs.c
+++ b/arch/sparc/kernel/viohs.c
@@ -797,9 +797,9 @@ void vio_port_up(struct vio_driver_state *vio)
 }
 EXPORT_SYMBOL(vio_port_up);
 
-static void vio_port_timer(unsigned long _arg)
+static void vio_port_timer(struct timer_list *t)
 {
-	struct vio_driver_state *vio = (struct vio_driver_state *) _arg;
+	struct vio_driver_state *vio = from_timer(vio, t, timer);
 
 	vio_port_up(vio);
 }
@@ -848,7 +848,7 @@ int vio_driver_init(struct vio_driver_state *vio, struct vio_dev *vdev,
 
 	vio->ops = ops;
 
-	setup_timer(&vio->timer, vio_port_timer, (unsigned long) vio);
+	timer_setup(&vio->timer, vio_port_timer, 0);
 
 	return 0;
 }
-- 
1.9.1

