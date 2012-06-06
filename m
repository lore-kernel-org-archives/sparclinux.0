From: David Miller <davem@davemloft.net>
Date: Wed, 06 Jun 2012 17:31:17 +0000
Subject: [PATCH] sparc bpf_jit: support BPF_S_ANC_ALU_XOR_X instruction
Message-Id: <20120606.103117.665253083733637529.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: netdev@vger.kernel.org
Cc: sparclinux@vger.kernel.org


Signed-off-by: David S. Miller <davem@davemloft.net>
---

Committed to net-next

 arch/sparc/net/bpf_jit_comp.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/net/bpf_jit_comp.c b/arch/sparc/net/bpf_jit_comp.c
index 1a69244..e9073e9 100644
--- a/arch/sparc/net/bpf_jit_comp.c
+++ b/arch/sparc/net/bpf_jit_comp.c
@@ -96,6 +96,7 @@ static void bpf_flush_icache(void *start_, void *end_)
 #define AND		F3(2, 0x01)
 #define ANDCC		F3(2, 0x11)
 #define OR		F3(2, 0x02)
+#define XOR		F3(2, 0x03)
 #define SUB		F3(2, 0x04)
 #define SUBCC		F3(2, 0x14)
 #define MUL		F3(2, 0x0a)	/* umul */
@@ -462,6 +463,9 @@ void bpf_jit_compile(struct sk_filter *fp)
 			case BPF_S_ALU_OR_K:	/* A |= K */
 				emit_alu_K(OR, K);
 				break;
+			case BPF_S_ANC_ALU_XOR_X: /* A ^= X; */
+				emit_alu_X(XOR);
+				break;
 			case BPF_S_ALU_LSH_X:	/* A <<= X */
 				emit_alu_X(SLL);
 				break;
-- 
1.7.6.5

