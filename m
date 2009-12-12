From: David Miller <davem@davemloft.net>
Date: Sat, 12 Dec 2009 06:55:23 +0000
Subject: [PATCH 1/10]: sparc: Validate that kprobe address is 4-byte
Message-Id: <20091211.225523.226799586.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Otherwise it isn't a valid instruction address.

This is the sparc equivalent of commit
b46b3d70c9c017d7c4ec49f7f3ffd0af5a622277 (kprobes: Checks probe
address is instruction boudary on x86)

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/kprobes.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/kernel/kprobes.c b/arch/sparc/kernel/kprobes.c
index 3bc6527..6716584 100644
--- a/arch/sparc/kernel/kprobes.c
+++ b/arch/sparc/kernel/kprobes.c
@@ -46,6 +46,9 @@ struct kretprobe_blackpoint kretprobe_blacklist[] = {{NULL, NULL}};
 
 int __kprobes arch_prepare_kprobe(struct kprobe *p)
 {
+	if ((unsigned long) p->addr & 0x3UL)
+		return -EILSEQ;
+
 	p->ainsn.insn[0] = *p->addr;
 	flushi(&p->ainsn.insn[0]);
 
-- 
1.6.5

