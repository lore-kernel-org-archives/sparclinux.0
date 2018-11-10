From: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Date: Sat, 10 Nov 2018 18:58:35 +0000
Subject: [PATCH net-next 4/6] net/bpf_jit: PPC: split VLAN_PRESENT bit handling from VLAN_TCI
Message-Id: <886ae30bd7616e5ecf8b3176648126b1eb19fe67.1541876179.git.mirq-linux@rere.qmqm.pl>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1541876179.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1541876179.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: netdev@vger.kernel.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org, Paul Burton <paul.burton@mips.com>, Ralf Baechle <ralf@linux-mips.org>, sparclinux@vger.kernel.org

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 arch/powerpc/net/bpf_jit_comp.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index d5bfe24bb3b5..dc4a2f54e829 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -379,18 +379,20 @@ static int bpf_jit_build_body(struct bpf_prog *fp, u32 *image,
 							  hash));
 			break;
 		case BPF_ANC | SKF_AD_VLAN_TAG:
-		case BPF_ANC | SKF_AD_VLAN_TAG_PRESENT:
 			BUILD_BUG_ON(FIELD_SIZEOF(struct sk_buff, vlan_tci) != 2);
-			BUILD_BUG_ON(VLAN_TAG_PRESENT != 0x1000);
 
 			PPC_LHZ_OFFS(r_A, r_skb, offsetof(struct sk_buff,
 							  vlan_tci));
-			if (code = (BPF_ANC | SKF_AD_VLAN_TAG)) {
-				PPC_ANDI(r_A, r_A, ~VLAN_TAG_PRESENT);
-			} else {
-				PPC_ANDI(r_A, r_A, VLAN_TAG_PRESENT);
-				PPC_SRWI(r_A, r_A, 12);
-			}
+#ifdef VLAN_TAG_PRESENT
+			PPC_ANDI(r_A, r_A, ~VLAN_TAG_PRESENT);
+#endif
+			break;
+		case BPF_ANC | SKF_AD_VLAN_TAG_PRESENT:
+			PPC_LBZ_OFFS(r_A, r_skb, PKT_VLAN_PRESENT_OFFSET());
+			if (PKT_VLAN_PRESENT_BIT)
+				PPC_SRWI(r_A, r_A, PKT_VLAN_PRESENT_BIT);
+			if (PKT_VLAN_PRESENT_BIT < 7)
+				PPC_ANDI(r_A, r_A, 1);
 			break;
 		case BPF_ANC | SKF_AD_QUEUE:
 			BUILD_BUG_ON(FIELD_SIZEOF(struct sk_buff,
-- 
2.19.1
