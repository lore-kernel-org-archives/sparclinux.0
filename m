From: David Miller <davem@davemloft.net>
Date: Thu, 01 Jun 2017 02:40:27 +0000
Subject: [PATCH net-next] bpf: Take advantage of stack_depth tracking in sparc64 JIT
Message-Id: <20170531.194027.376921509270354470.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: netdev@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, sparclinux@vger.kernel.org


Signed-off-by: David S. Miller <davem@davemloft.net>
---

Committed to net-next.

 arch/sparc/net/bpf_jit_comp_64.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/net/bpf_jit_comp_64.c b/arch/sparc/net/bpf_jit_comp_64.c
index 4a52d34..098874a 100644
--- a/arch/sparc/net/bpf_jit_comp_64.c
+++ b/arch/sparc/net/bpf_jit_comp_64.c
@@ -802,8 +802,13 @@ static void build_prologue(struct jit_ctx *ctx)
 {
 	s32 stack_needed = BASE_STACKFRAME;
 
-	if (ctx->saw_frame_pointer || ctx->saw_tail_call)
-		stack_needed += MAX_BPF_STACK;
+	if (ctx->saw_frame_pointer || ctx->saw_tail_call) {
+		struct bpf_prog *prog = ctx->prog;
+		u32 stack_depth;
+
+		stack_depth = prog->aux->stack_depth;
+		stack_needed += round_up(stack_depth, 16);
+	}
 
 	if (ctx->saw_tail_call)
 		stack_needed += 8;
-- 
2.1.2.532.g19b5d50

