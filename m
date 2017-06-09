From: Jag Raman <jag.raman@oracle.com>
Date: Fri, 09 Jun 2017 16:30:51 +0000
Subject: [PATCH v1 02/12] sparc64: specify the device class in VIO version info. packet
Message-Id: <814a2936950840f0bf558b9256f3c16511b750d7.1497024216.git.jag.raman@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Specify the class of VIO device in the version info. packet. The device's
class identifies the type of VIO device, whether it's DISK, CONSOLE,
NETWORK, etc... This packet is used in the handshake between the
client and server for this device.

Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Reviewed-by: Liam Merwick <liam.merwick@oracle.com>
Reviewed-by: Shannon Nelson <shannon.nelson@oracle.com>
---
 arch/sparc/kernel/viohs.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/kernel/viohs.c b/arch/sparc/kernel/viohs.c
index ea28cb7..68e952a 100644
--- a/arch/sparc/kernel/viohs.c
+++ b/arch/sparc/kernel/viohs.c
@@ -286,6 +286,7 @@ static int process_ver_info(struct vio_driver_state *vio,
 			ver.minor = vap->minor;
 		pkt->minor = ver.minor;
 		pkt->tag.stype = VIO_SUBTYPE_ACK;
+		pkt->dev_class = vio->dev_class;
 		viodbg(HS, "SEND VERSION ACK maj[%u] min[%u]\n",
 		       pkt->major, pkt->minor);
 		err = send_ctrl(vio, &pkt->tag, sizeof(*pkt));
-- 
1.7.1

