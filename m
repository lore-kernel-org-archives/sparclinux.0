From: Masami Hiramatsu <mhiramat@kernel.org>
Date: Mon, 04 Jun 2018 15:59:39 +0000
Subject: [RFC PATCH -tip v5 23/27] sparc64: kprobes: Don't call the ->break_handler() in sparc64 kprobes code
Message-Id: <152812797932.10068.11564914590596665822.stgit@devbox>
List-Id: <sparclinux.vger.kernel.org>
References: <152812730943.10068.5166429445118734697.stgit@devbox>
In-Reply-To: <152812730943.10068.5166429445118734697.stgit@devbox>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>, linux-arch@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org

Don't call the ->break_handler() from the sparc64 kprobes code,
because it was only used by jprobes which got removed.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
---
 arch/sparc/kernel/kprobes.c |   11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/arch/sparc/kernel/kprobes.c b/arch/sparc/kernel/kprobes.c
index f555711da8f1..c684c96ef2e9 100644
--- a/arch/sparc/kernel/kprobes.c
+++ b/arch/sparc/kernel/kprobes.c
@@ -147,18 +147,12 @@ static int __kprobes kprobe_handler(struct pt_regs *regs)
 			kcb->kprobe_status = KPROBE_REENTER;
 			prepare_singlestep(p, regs, kcb);
 			return 1;
-		} else {
-			if (*(u32 *)addr != BREAKPOINT_INSTRUCTION) {
+		} else if (*(u32 *)addr != BREAKPOINT_INSTRUCTION) {
 			/* The breakpoint instruction was removed by
 			 * another cpu right after we hit, no further
 			 * handling of this interrupt is appropriate
 			 */
-				ret = 1;
-				goto no_kprobe;
-			}
-			p = __this_cpu_read(current_kprobe);
-			if (p->break_handler && p->break_handler(p, regs))
-				goto ss_probe;
+			ret = 1;
 		}
 		goto no_kprobe;
 	}
@@ -184,7 +178,6 @@ static int __kprobes kprobe_handler(struct pt_regs *regs)
 	if (p->pre_handler && p->pre_handler(p, regs))
 		return 1;
 
-ss_probe:
 	prepare_singlestep(p, regs, kcb);
 	kcb->kprobe_status = KPROBE_HIT_SS;
 	return 1;

