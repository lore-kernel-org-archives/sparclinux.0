From: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Date: Sat, 10 Nov 2018 18:58:35 +0000
Subject: [PATCH net-next 3/6] net/bpf_jit: MIPS: split VLAN_PRESENT bit handling from VLAN_TCI
Message-Id: <cbaaeac4a963f55f86f09eb26be502584c877527.1541876179.git.mirq-linux@rere.qmqm.pl>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1541876179.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1541876179.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: netdev@vger.kernel.org
Cc: Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org, Alexei Starovoitov <ast@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 arch/mips/net/bpf_jit.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/arch/mips/net/bpf_jit.c b/arch/mips/net/bpf_jit.c
index 4d8cb9bb8365..de4c6372ad9a 100644
--- a/arch/mips/net/bpf_jit.c
+++ b/arch/mips/net/bpf_jit.c
@@ -1159,19 +1159,22 @@ static int build_body(struct jit_ctx *ctx)
 			emit_load(r_A, r_skb, off, ctx);
 			break;
 		case BPF_ANC | SKF_AD_VLAN_TAG:
-		case BPF_ANC | SKF_AD_VLAN_TAG_PRESENT:
 			ctx->flags |= SEEN_SKB | SEEN_A;
 			BUILD_BUG_ON(FIELD_SIZEOF(struct sk_buff,
 						  vlan_tci) != 2);
 			off = offsetof(struct sk_buff, vlan_tci);
-			emit_half_load_unsigned(r_s0, r_skb, off, ctx);
-			if (code = (BPF_ANC | SKF_AD_VLAN_TAG)) {
-				emit_andi(r_A, r_s0, (u16)~VLAN_TAG_PRESENT, ctx);
-			} else {
-				emit_andi(r_A, r_s0, VLAN_TAG_PRESENT, ctx);
-				/* return 1 if present */
-				emit_sltu(r_A, r_zero, r_A, ctx);
-			}
+			emit_half_load_unsigned(r_A, r_skb, off, ctx);
+#ifdef VLAN_TAG_PRESENT
+			emit_andi(r_A, r_A, (u16)~VLAN_TAG_PRESENT, ctx);
+#endif
+			break;
+		case BPF_ANC | SKF_AD_VLAN_TAG_PRESENT:
+			ctx->flags |= SEEN_SKB | SEEN_A;
+			emit_load_byte(r_A, r_skb, PKT_VLAN_PRESENT_OFFSET(), ctx);
+			if (PKT_VLAN_PRESENT_BIT)
+				emit_srl(r_A, r_A, PKT_VLAN_PRESENT_BIT, ctx);
+			if (PKT_VLAN_PRESENT_BIT < 7)
+				emit_andi(r_A, r_A, 1, ctx);
 			break;
 		case BPF_ANC | SKF_AD_PKTTYPE:
 			ctx->flags |= SEEN_SKB;
-- 
2.19.1
