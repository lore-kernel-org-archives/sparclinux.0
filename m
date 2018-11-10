From: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Date: Sat, 10 Nov 2018 18:58:36 +0000
Subject: [PATCH net-next 6/6] net: remove VLAN_TAG_PRESENT
Message-Id: <c2d068eea7da53242e12b750306af96e74cfae66.1541876179.git.mirq-linux@rere.qmqm.pl>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1541876179.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1541876179.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: netdev@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>, Paul Burton <paul.burton@mips.com>, Paul Mackerras <paulus@samba.org>, Ralf Baechle <ralf@linux-mips.org>, sparclinux@vger.kernel.org

Replace VLAN_TAG_PRESENT with single bit flag and free up
VLAN.CFI overload. Now VLAN.CFI is visible in networking stack
and can be passed around intact.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 arch/mips/net/bpf_jit.c          |  3 ---
 arch/powerpc/net/bpf_jit_comp.c  |  3 ---
 arch/sparc/net/bpf_jit_comp_32.c |  4 ----
 include/linux/if_vlan.h          | 11 ++++++-----
 include/linux/skbuff.h           | 16 +++++++++-------
 lib/test_bpf.c                   | 14 ++++++++------
 net/core/filter.c                |  6 ------
 7 files changed, 23 insertions(+), 34 deletions(-)

diff --git a/arch/mips/net/bpf_jit.c b/arch/mips/net/bpf_jit.c
index de4c6372ad9a..3a0e34f4e615 100644
--- a/arch/mips/net/bpf_jit.c
+++ b/arch/mips/net/bpf_jit.c
@@ -1164,9 +1164,6 @@ static int build_body(struct jit_ctx *ctx)
 						  vlan_tci) != 2);
 			off = offsetof(struct sk_buff, vlan_tci);
 			emit_half_load_unsigned(r_A, r_skb, off, ctx);
-#ifdef VLAN_TAG_PRESENT
-			emit_andi(r_A, r_A, (u16)~VLAN_TAG_PRESENT, ctx);
-#endif
 			break;
 		case BPF_ANC | SKF_AD_VLAN_TAG_PRESENT:
 			ctx->flags |= SEEN_SKB | SEEN_A;
diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index dc4a2f54e829..91d223cf512b 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -383,9 +383,6 @@ static int bpf_jit_build_body(struct bpf_prog *fp, u32 *image,
 
 			PPC_LHZ_OFFS(r_A, r_skb, offsetof(struct sk_buff,
 							  vlan_tci));
-#ifdef VLAN_TAG_PRESENT
-			PPC_ANDI(r_A, r_A, ~VLAN_TAG_PRESENT);
-#endif
 			break;
 		case BPF_ANC | SKF_AD_VLAN_TAG_PRESENT:
 			PPC_LBZ_OFFS(r_A, r_skb, PKT_VLAN_PRESENT_OFFSET());
diff --git a/arch/sparc/net/bpf_jit_comp_32.c b/arch/sparc/net/bpf_jit_comp_32.c
index 48f3c04dd179..84cc8f7f83e9 100644
--- a/arch/sparc/net/bpf_jit_comp_32.c
+++ b/arch/sparc/net/bpf_jit_comp_32.c
@@ -553,10 +553,6 @@ void bpf_jit_compile(struct bpf_prog *fp)
 				break;
 			case BPF_ANC | SKF_AD_VLAN_TAG:
 				emit_skb_load16(vlan_tci, r_A);
-#ifdef VLAN_TAG_PRESENT
-				emit_loadimm(~VLAN_TAG_PRESENT, r_TMP);
-				emit_and(r_A, r_TMP, r_A);
-#endif
 				break;
 			case BPF_ANC | SKF_AD_VLAN_TAG_PRESENT:
 				__emit_skb_load8(__pkt_vlan_present_offset, r_A);
diff --git a/include/linux/if_vlan.h b/include/linux/if_vlan.h
index 1be5230921b5..7a541eadf78e 100644
--- a/include/linux/if_vlan.h
+++ b/include/linux/if_vlan.h
@@ -66,7 +66,6 @@ static inline struct vlan_ethhdr *vlan_eth_hdr(const struct sk_buff *skb)
 #define VLAN_PRIO_MASK		0xe000 /* Priority Code Point */
 #define VLAN_PRIO_SHIFT		13
 #define VLAN_CFI_MASK		0x1000 /* Canonical Format Indicator */
-#define VLAN_TAG_PRESENT	VLAN_CFI_MASK
 #define VLAN_VID_MASK		0x0fff /* VLAN Identifier */
 #define VLAN_N_VID		4096
 
@@ -78,8 +77,8 @@ static inline bool is_vlan_dev(const struct net_device *dev)
         return dev->priv_flags & IFF_802_1Q_VLAN;
 }
 
-#define skb_vlan_tag_present(__skb)	((__skb)->vlan_tci & VLAN_TAG_PRESENT)
-#define skb_vlan_tag_get(__skb)		((__skb)->vlan_tci & ~VLAN_TAG_PRESENT)
+#define skb_vlan_tag_present(__skb)	((__skb)->vlan_present)
+#define skb_vlan_tag_get(__skb)		((__skb)->vlan_tci)
 #define skb_vlan_tag_get_id(__skb)	((__skb)->vlan_tci & VLAN_VID_MASK)
 #define skb_vlan_tag_get_prio(__skb)	(((__skb)->vlan_tci & VLAN_PRIO_MASK) >> VLAN_PRIO_SHIFT)
 
@@ -480,7 +479,7 @@ static inline struct sk_buff *vlan_insert_tag_set_proto(struct sk_buff *skb,
  */
 static inline void __vlan_hwaccel_clear_tag(struct sk_buff *skb)
 {
-	skb->vlan_tci = 0;
+	skb->vlan_present = 0;
 }
 
 /**
@@ -492,6 +491,7 @@ static inline void __vlan_hwaccel_clear_tag(struct sk_buff *skb)
  */
 static inline void __vlan_hwaccel_copy_tag(struct sk_buff *dst, const struct sk_buff *src)
 {
+	dst->vlan_present = src->vlan_present;
 	dst->vlan_proto = src->vlan_proto;
 	dst->vlan_tci = src->vlan_tci;
 }
@@ -526,7 +526,8 @@ static inline void __vlan_hwaccel_put_tag(struct sk_buff *skb,
 					  __be16 vlan_proto, u16 vlan_tci)
 {
 	skb->vlan_proto = vlan_proto;
-	skb->vlan_tci = VLAN_TAG_PRESENT | vlan_tci;
+	skb->vlan_tci = vlan_tci;
+	skb->vlan_present = 1;
 }
 
 /**
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 99f38779332c..b9aa0d1b21cf 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -777,6 +777,14 @@ struct sk_buff {
 	__u8			encap_hdr_csum:1;
 	__u8			csum_valid:1;
 
+#ifdef __BIG_ENDIAN_BITFIELD
+#define PKT_VLAN_PRESENT_BIT	7
+#else
+#define PKT_VLAN_PRESENT_BIT	0
+#endif
+#define PKT_VLAN_PRESENT_OFFSET()	offsetof(struct sk_buff, __pkt_vlan_present_offset)
+	__u8			__pkt_vlan_present_offset[0];
+	__u8			vlan_present:1;
 	__u8			csum_complete_sw:1;
 	__u8			csum_level:2;
 	__u8			csum_not_inet:1;
@@ -784,8 +792,8 @@ struct sk_buff {
 #ifdef CONFIG_IPV6_NDISC_NODETYPE
 	__u8			ndisc_nodetype:2;
 #endif
+
 	__u8			ipvs_property:1;
-
 	__u8			inner_protocol_type:1;
 	__u8			remcsum_offload:1;
 #ifdef CONFIG_NET_SWITCHDEV
@@ -816,12 +824,6 @@ struct sk_buff {
 	__u32			priority;
 	int			skb_iif;
 	__u32			hash;
-#define PKT_VLAN_PRESENT_BIT	4	// CFI (12-th bit) in TCI
-#ifdef __BIG_ENDIAN
-#define PKT_VLAN_PRESENT_OFFSET()	offsetof(struct sk_buff, vlan_tci)
-#else
-#define PKT_VLAN_PRESENT_OFFSET()	(offsetof(struct sk_buff, vlan_tci) + 1)
-#endif
 	__be16			vlan_proto;
 	__u16			vlan_tci;
 #if defined(CONFIG_NET_RX_BUSY_POLL) || defined(CONFIG_XPS)
diff --git a/lib/test_bpf.c b/lib/test_bpf.c
index aa22bcaec1dc..f3e570722a7e 100644
--- a/lib/test_bpf.c
+++ b/lib/test_bpf.c
@@ -39,6 +39,7 @@
 #define SKB_HASH	0x1234aaab
 #define SKB_QUEUE_MAP	123
 #define SKB_VLAN_TCI	0xffff
+#define SKB_VLAN_PRESENT	1
 #define SKB_DEV_IFINDEX	577
 #define SKB_DEV_TYPE	588
 
@@ -725,8 +726,8 @@ static struct bpf_test tests[] = {
 		CLASSIC,
 		{ },
 		{
-			{ 1, SKB_VLAN_TCI & ~VLAN_TAG_PRESENT },
-			{ 10, SKB_VLAN_TCI & ~VLAN_TAG_PRESENT }
+			{ 1, SKB_VLAN_TCI },
+			{ 10, SKB_VLAN_TCI }
 		},
 	},
 	{
@@ -739,8 +740,8 @@ static struct bpf_test tests[] = {
 		CLASSIC,
 		{ },
 		{
-			{ 1, !!(SKB_VLAN_TCI & VLAN_TAG_PRESENT) },
-			{ 10, !!(SKB_VLAN_TCI & VLAN_TAG_PRESENT) }
+			{ 1, SKB_VLAN_PRESENT },
+			{ 10, SKB_VLAN_PRESENT }
 		},
 	},
 	{
@@ -5289,8 +5290,8 @@ static struct bpf_test tests[] = {
 #endif
 		{ },
 		{
-			{  1, !!(SKB_VLAN_TCI & VLAN_TAG_PRESENT) },
-			{ 10, !!(SKB_VLAN_TCI & VLAN_TAG_PRESENT) }
+			{  1, SKB_VLAN_PRESENT },
+			{ 10, SKB_VLAN_PRESENT }
 		},
 		.fill_helper = bpf_fill_maxinsns6,
 		.expected_errcode = -ENOTSUPP,
@@ -6493,6 +6494,7 @@ static struct sk_buff *populate_skb(char *buf, int size)
 	skb->hash = SKB_HASH;
 	skb->queue_mapping = SKB_QUEUE_MAP;
 	skb->vlan_tci = SKB_VLAN_TCI;
+	skb->vlan_present = SKB_VLAN_PRESENT;
 	skb->vlan_proto = htons(ETH_P_IP);
 	dev_net_set(&dev, &init_net);
 	skb->dev = &dev;
diff --git a/net/core/filter.c b/net/core/filter.c
index c151b906df53..10acbc00ff6c 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -301,9 +301,6 @@ static u32 convert_skb_access(int skb_field, int dst_reg, int src_reg,
 		/* dst_reg = *(u16 *) (src_reg + offsetof(vlan_tci)) */
 		*insn++ = BPF_LDX_MEM(BPF_H, dst_reg, src_reg,
 				      offsetof(struct sk_buff, vlan_tci));
-#ifdef VLAN_TAG_PRESENT
-		*insn++ = BPF_ALU32_IMM(BPF_AND, dst_reg, ~VLAN_TAG_PRESENT);
-#endif
 		break;
 	case SKF_AD_VLAN_TAG_PRESENT:
 		*insn++ = BPF_LDX_MEM(BPF_B, dst_reg, src_reg, PKT_VLAN_PRESENT_OFFSET());
@@ -6152,9 +6149,6 @@ static u32 bpf_convert_ctx_access(enum bpf_access_type type,
 		*insn++ = BPF_LDX_MEM(BPF_H, si->dst_reg, si->src_reg,
 				      bpf_target_off(struct sk_buff, vlan_tci, 2,
 						     target_size));
-#ifdef VLAN_TAG_PRESENT
-		*insn++ = BPF_ALU32_IMM(BPF_AND, si->dst_reg, ~VLAN_TAG_PRESENT);
-#endif
 		break;
 
 	case offsetof(struct __sk_buff, cb[0]) ...
-- 
2.19.1
