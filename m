From: Jag Raman <jag.raman@oracle.com>
Date: Fri, 23 Jun 2017 18:58:29 +0000
Subject: [PATCH v2 01/12] sparc64: ensure VIO operations are defined while being used
Message-Id: <04c46dac62702f6a64f9cf319173178957915fc1.1498238657.git.jag.raman@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

It's possible that VIO operations are not defined for some VIO
clients. In that case, VIO ops pointer should be checked for
NULL before being used

Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Reviewed-by: Liam Merwick <liam.merwick@oracle.com>
Reviewed-by: Shannon Nelson <shannon.nelson@oracle.com>
---
 arch/sparc/kernel/viohs.c |   17 +++++++++++++----
 1 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/kernel/viohs.c b/arch/sparc/kernel/viohs.c
index b30b30a..ea28cb7 100644
--- a/arch/sparc/kernel/viohs.c
+++ b/arch/sparc/kernel/viohs.c
@@ -223,6 +223,9 @@ static int send_rdx(struct vio_driver_state *vio)
 
 static int send_attr(struct vio_driver_state *vio)
 {
+	if (!vio->ops)
+		return -EINVAL;
+
 	return vio->ops->send_attr(vio);
 }
 
@@ -374,6 +377,9 @@ static int process_attr(struct vio_driver_state *vio, void *pkt)
 	if (!(vio->hs_state & VIO_HS_GOTVERS))
 		return handshake_failure(vio);
 
+	if (!vio->ops)
+		return 0;
+
 	err = vio->ops->handle_attr(vio, pkt);
 	if (err < 0) {
 		return handshake_failure(vio);
@@ -388,6 +394,7 @@ static int process_attr(struct vio_driver_state *vio, void *pkt)
 			vio->hs_state |= VIO_HS_SENT_DREG;
 		}
 	}
+
 	return 0;
 }
 
@@ -647,10 +654,13 @@ int vio_control_pkt_engine(struct vio_driver_state *vio, void *pkt)
 		err = process_unknown(vio, pkt);
 		break;
 	}
+
 	if (!err &&
 	    vio->hs_state != prev_state &&
-	    (vio->hs_state & VIO_HS_COMPLETE))
-		vio->ops->handshake_complete(vio);
+	    (vio->hs_state & VIO_HS_COMPLETE)) {
+		if (vio->ops)
+			vio->ops->handshake_complete(vio);
+	}
 
 	return err;
 }
@@ -805,8 +815,7 @@ int vio_driver_init(struct vio_driver_state *vio, struct vio_dev *vdev,
 		return -EINVAL;
 	}
 
-	if (!ops->send_attr ||
-	    !ops->handle_attr ||
+	if (!ops || !ops->send_attr || !ops->handle_attr ||
 	    !ops->handshake_complete)
 		return -EINVAL;
 
-- 
1.7.1

