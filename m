From: "Hong H. Pham" <hong.pham@windriver.com>
Date: Thu, 04 Dec 2008 14:51:28 +0000
Subject: Re: [PATCH] Fix VIS emulation bugs
Message-Id: <4937EE70.2010307@windriver.com>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.0812040038150.8383@digraph.polyomino.org.uk>
In-Reply-To: <Pine.LNX.4.64.0812040038150.8383@digraph.polyomino.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

>> This patch fixes the bug if single-stepping over the affected
>> instruction in the debugger, but not if the testcase is run
>> standalone.  For that, Wind River has another patch I hope they will
>> send as a followup to this patch submission.
>>
>> Signed-off-by: Joseph Myers <joseph@codesourcery.com>
> 
> Patch applied, thanks!

Here's the follow up patch to Joseph's VIS emulation fix.  The pdist
testcase runs successfully as a standalone with this patch.

Best regards,
Hong


Copy the FPU state to the task's thread_info->fpregs for the VIS emulation
functions to access.

Signed-off-by: Hong H. Pham <hong.pham@windriver.com>
---
  arch/sparc64/kernel/visemul.c |    2 ++
  1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/sparc64/kernel/visemul.c b/arch/sparc64/kernel/visemul.c
index 4e285f9..a4428fd 100644
--- a/arch/sparc64/kernel/visemul.c
+++ b/arch/sparc64/kernel/visemul.c
@@ -802,16 +802,18 @@ int vis_emul(struct pt_regs *regs, unsigned int insn)
  	BUG_ON(regs->tstate & TSTATE_PRIV);

  	if (test_thread_flag(TIF_32BIT))
  		pc = (u32)pc;

  	if (get_user(insn, (u32 __user *) pc))
  		return -EFAULT;

+	save_and_clear_fpu();
+
  	opf = (insn & VIS_OPF_MASK) >> VIS_OPF_SHIFT;
  	switch (opf) {
  	default:
  		return -EINVAL;

  	/* Pixel Formatting Instructions.  */
  	case FPACK16_OPF:
  	case FPACK32_OPF:
-- 
1.5.5.1

