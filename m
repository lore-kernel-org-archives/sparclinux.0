From: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Date: Tue, 03 Jan 2017 20:52:38 +0000
Subject: [PATCH net-next v2 18/27] net/skbuff: add macros for VLAN_PRESENT bit
Message-Id: <719ecd1e2cb20316daf110de4dc865593c7bed9d.1483475202.git.mirq-linux@rere.qmqm.pl>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1483475202.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1483475202.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-arm-kernel@lists.infradead.org

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 include/linux/skbuff.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index b53c0cfd417e..168c3e486bd4 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -768,6 +768,12 @@ struct sk_buff {
 	__u32			priority;
 	int			skb_iif;
 	__u32			hash;
+#define PKT_VLAN_PRESENT_BIT	4	// CFI (12-th bit) in TCI
+#ifdef __BIG_ENDIAN
+#define PKT_VLAN_PRESENT_OFFSET()	offsetof(struct sk_buff, vlan_tci)
+#else
+#define PKT_VLAN_PRESENT_OFFSET()	(offsetof(struct sk_buff, vlan_tci) + 1)
+#endif
 	__be16			vlan_proto;
 	__u16			vlan_tci;
 #if defined(CONFIG_NET_RX_BUSY_POLL) || defined(CONFIG_XPS)
-- 
2.11.0

