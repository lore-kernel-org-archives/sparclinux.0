From: David Miller <davem@davemloft.net>
Date: Tue, 30 Sep 2014 21:36:05 +0000
Subject: [PATCH] sparc: VIO protocol version 1.6
Message-Id: <20140930.173605.1143879098343097114.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


From: David L Stevens <david.stevens@oracle.com>

Add VIO protocol version 1.6 interfaces.

Signed-off-by: David L Stevens <david.stevens@oracle.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
---

This is extracted from David Stevens's sunvnet jumbogram support
patch set that just went into net-next.  I'm applying it to the
sparc tree to avoid merge mis-haps wrt. the sunvdc patches which
I'm reviewing next.

 arch/sparc/include/asm/vio.h | 44 ++++++++++++++++++++++++++++++++++++++++++--
 arch/sparc/kernel/viohs.c    | 14 ++++++++++++--
 2 files changed, 54 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/include/asm/vio.h b/arch/sparc/include/asm/vio.h
index e0f6c39..6b135a8 100644
--- a/arch/sparc/include/asm/vio.h
+++ b/arch/sparc/include/asm/vio.h
@@ -65,6 +65,7 @@ struct vio_dring_register {
 	u16			options;
 #define VIO_TX_DRING		0x0001
 #define VIO_RX_DRING		0x0002
+#define VIO_RX_DRING_DATA	0x0004
 	u16			resv;
 	u32			num_cookies;
 	struct ldc_trans_cookie	cookies[0];
@@ -80,6 +81,8 @@ struct vio_dring_unregister {
 #define VIO_PKT_MODE		0x01 /* Packet based transfer	*/
 #define VIO_DESC_MODE		0x02 /* In-band descriptors	*/
 #define VIO_DRING_MODE		0x03 /* Descriptor rings	*/
+/* in vers >= 1.2, VIO_DRING_MODE is 0x04 and transfer mode is a bitmask */
+#define VIO_NEW_DRING_MODE	0x04
 
 struct vio_dring_data {
 	struct vio_msg_tag	tag;
@@ -205,10 +208,20 @@ struct vio_net_attr_info {
 	u8			addr_type;
 #define VNET_ADDR_ETHERMAC	0x01
 	u16			ack_freq;
-	u32			resv1;
+	u8			plnk_updt;
+#define PHYSLINK_UPDATE_NONE		0x00
+#define PHYSLINK_UPDATE_STATE		0x01
+#define PHYSLINK_UPDATE_STATE_ACK	0x02
+#define PHYSLINK_UPDATE_STATE_NACK	0x03
+	u8			options;
+	u16			resv1;
 	u64			addr;
 	u64			mtu;
-	u64			resv2[3];
+	u16			cflags;
+#define VNET_LSO_IPV4_CAPAB		0x0001
+	u16			ipv4_lso_maxlen;
+	u32			resv2;
+	u64			resv3[2];
 };
 
 #define VNET_NUM_MCAST		7
@@ -366,6 +379,33 @@ struct vio_driver_state {
 	struct vio_driver_ops	*ops;
 };
 
+static inline bool vio_version_before(struct vio_driver_state *vio,
+				      u16 major, u16 minor)
+{
+	u32 have = (u32)vio->ver.major << 16 | vio->ver.minor;
+	u32 want = (u32)major << 16 | minor;
+
+	return have < want;
+}
+
+static inline bool vio_version_after(struct vio_driver_state *vio,
+				      u16 major, u16 minor)
+{
+	u32 have = (u32)vio->ver.major << 16 | vio->ver.minor;
+	u32 want = (u32)major << 16 | minor;
+
+	return have > want;
+}
+
+static inline bool vio_version_after_eq(struct vio_driver_state *vio,
+					u16 major, u16 minor)
+{
+	u32 have = (u32)vio->ver.major << 16 | vio->ver.minor;
+	u32 want = (u32)major << 16 | minor;
+
+	return have >= want;
+}
+
 #define viodbg(TYPE, f, a...) \
 do {	if (vio->debug & VIO_DEBUG_##TYPE) \
 		printk(KERN_INFO "vio: ID[%lu] " f, \
diff --git a/arch/sparc/kernel/viohs.c b/arch/sparc/kernel/viohs.c
index 9c5fbd0..526fcb5 100644
--- a/arch/sparc/kernel/viohs.c
+++ b/arch/sparc/kernel/viohs.c
@@ -426,6 +426,13 @@ static int process_dreg_info(struct vio_driver_state *vio,
 	if (vio->dr_state & VIO_DR_STATE_RXREG)
 		goto send_nack;
 
+	/* v1.6 and higher, ACK with desired, supported mode, or NACK */
+	if (vio_version_after_eq(vio, 1, 6)) {
+		if (!(pkt->options & VIO_TX_DRING))
+			goto send_nack;
+		pkt->options = VIO_TX_DRING;
+	}
+
 	BUG_ON(vio->desc_buf);
 
 	vio->desc_buf = kzalloc(pkt->descr_size, GFP_ATOMIC);
@@ -453,8 +460,11 @@ static int process_dreg_info(struct vio_driver_state *vio,
 	pkt->tag.stype = VIO_SUBTYPE_ACK;
 	pkt->dring_ident = ++dr->ident;
 
-	viodbg(HS, "SEND DRING_REG ACK ident[%llx]\n",
-	       (unsigned long long) pkt->dring_ident);
+	viodbg(HS, "SEND DRING_REG ACK ident[%llx] "
+	       "ndesc[%u] dsz[%u] opt[0x%x] ncookies[%u]\n",
+	       (unsigned long long) pkt->dring_ident,
+	       pkt->num_descr, pkt->descr_size, pkt->options,
+	       pkt->num_cookies);
 
 	len = (sizeof(*pkt) +
 	       (dr->ncookies * sizeof(struct ldc_trans_cookie)));
-- 
1.8.1.2

