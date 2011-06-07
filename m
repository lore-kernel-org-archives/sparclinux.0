From: Jesper Juhl <jj@chaosbits.net>
Date: Tue, 07 Jun 2011 14:38:19 +0000
Subject: [PATCH][RFC] Sparc: Remove trigraph in die_if_kernel() message.
Message-Id: <alpine.LNX.2.00.1106071627260.8844@swampdragon.chaosbits.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, davem@davemloft.net

In arch/sparc/kernel/traps_32.c::do_priv_instruction() we have this:

  die_if_kernel("Penguin instruction from Penguin mode??!?!", regs);

If I'm not mistaken, that "??!" will be taken as a trigraph for "|" by the 
preprocessor, so the final string will end up either as
  "Penguin instruction from Penguin mode|?!"
which I assume is not what we want, or as the correct string but with a 
warning about an ignored trigraph which I assume we don't want either. So, 
in order to elliminate the trigraph but keep the original string intact I 
changed it to

  die_if_kernel("Penguin instruction from Penguin mode?""?!?!", regs);

I've tested with a small test program on my x86-64 host and it behaves as 
I would expect, but I've not tested the actual code in 
arch/sparc/kernel/traps_32.c since I have no way to compile for sparc 
(which is why I submit this as a [RFC] patch).

Please take a look and apply if you agree :-)

Signed-off-by: Jesper Juhl <jj@chaosbits.net>
---
 traps_32.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/kernel/traps_32.c b/arch/sparc/kernel/traps_32.c
index c0490c7..d99ca40 100644
--- a/arch/sparc/kernel/traps_32.c
+++ b/arch/sparc/kernel/traps_32.c
@@ -137,7 +137,7 @@ void do_priv_instruction(struct pt_regs *regs, unsigned long pc, unsigned long n
 	siginfo_t info;
 
 	if(psr & PSR_PS)
-		die_if_kernel("Penguin instruction from Penguin mode??!?!", regs);
+		die_if_kernel("Penguin instruction from Penguin mode?""?!?!", regs);
 	info.si_signo = SIGILL;
 	info.si_errno = 0;
 	info.si_code = ILL_PRVOPC;


-- 
Jesper Juhl <jj@chaosbits.net>       http://www.chaosbits.net/
Don't top-post http://www.catb.org/jargon/html/T/top-post.html
Plain text mails only, please.

