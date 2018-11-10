From: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Date: Sat, 10 Nov 2018 18:58:36 +0000
Subject: [PATCH net-next 5/6] net/bpf_jit: SPARC: split VLAN_PRESENT bit handling from VLAN_TCI
Message-Id: <4508dbca71009d191036155ec1a187455605577e.1541876179.git.mirq-linux@rere.qmqm.pl>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1541876179.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1541876179.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Daniel Borkmann <daniel@iogearbox.net>, James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>, Paul Burton <paul.burton@mips.com>, Paul Mackerras <paulus@samba.org>, Ralf Baechle <ralf@linux-mips.org>

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 arch/sparc/net/bpf_jit_comp_32.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/sparc/net/bpf_jit_comp_32.c b/arch/sparc/net/bpf_jit_comp_32.c
index a5ff88643d5c..48f3c04dd179 100644
--- a/arch/sparc/net/bpf_jit_comp_32.c
+++ b/arch/sparc/net/bpf_jit_comp_32.c
@@ -552,15 +552,18 @@ void bpf_jit_compile(struct bpf_prog *fp)
 				emit_skb_load32(hash, r_A);
 				break;
 			case BPF_ANC | SKF_AD_VLAN_TAG:
-			case BPF_ANC | SKF_AD_VLAN_TAG_PRESENT:
 				emit_skb_load16(vlan_tci, r_A);
-				if (code != (BPF_ANC | SKF_AD_VLAN_TAG)) {
-					emit_alu_K(SRL, 12);
+#ifdef VLAN_TAG_PRESENT
+				emit_loadimm(~VLAN_TAG_PRESENT, r_TMP);
+				emit_and(r_A, r_TMP, r_A);
+#endif
+				break;
+			case BPF_ANC | SKF_AD_VLAN_TAG_PRESENT:
+				__emit_skb_load8(__pkt_vlan_present_offset, r_A);
+				if (PKT_VLAN_PRESENT_BIT)
+					emit_alu_K(SRL, PKT_VLAN_PRESENT_BIT);
+				if (PKT_VLAN_PRESENT_BIT < 7)
 					emit_andi(r_A, 1, r_A);
-				} else {
-					emit_loadimm(~VLAN_TAG_PRESENT, r_TMP);
-					emit_and(r_A, r_TMP, r_A);
-				}
 				break;
 			case BPF_LD | BPF_W | BPF_LEN:
 				emit_skb_load32(len, r_A);
-- 
2.19.1
