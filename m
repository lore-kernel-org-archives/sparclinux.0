From: David Miller <davem@davemloft.net>
Date: Fri, 19 Feb 2010 23:20:11 +0000
Subject: Re: Execution possible in non-executable mappings in recent 2.6
Message-Id: <20100219.152011.32519652.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100219225724.GA29861@grsecurity.net>
In-Reply-To: <20100219225724.GA29861@grsecurity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Here's the fix, thanks again for the report:

sparc64: Fix sun4u execute bit check in TSB I-TLB load.

Thanks to testcase and report from Brad Spengler:

--------------------
#include <stdio.h>

typedef int (* _wee)(void);

int main(void)
{
        char buf[8] = { '\x81', '\xc7', '\xe0', '\x08', '\x81', '\xe8',
                        '\x00', '\x00' };
        _wee wee;
        printf("%p\n", &buf);
        wee = (_wee)&buf;
        wee();

        return 0;
}
--------------------

TSB I-tlb load code tries to use andcc to check the _PAGE_EXEC_4U bit,
but that's bit 12 so it gets sign extended all the way up to bit 63
and the test nearly always passes as a result.

Use sethi to fix the bug.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/tsb.S |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/kernel/tsb.S b/arch/sparc/kernel/tsb.S
index 8c91d9b..db15d12 100644
--- a/arch/sparc/kernel/tsb.S
+++ b/arch/sparc/kernel/tsb.S
@@ -191,10 +191,12 @@ tsb_dtlb_load:
 
 tsb_itlb_load:
 	/* Executable bit must be set.  */
-661:	andcc		%g5, _PAGE_EXEC_4U, %g0
-	.section	.sun4v_1insn_patch, "ax"
+661:	sethi		%hi(_PAGE_EXEC_4U), %g4
+	andcc		%g5, %g4, %g0
+	.section	.sun4v_2insn_patch, "ax"
 	.word		661b
 	andcc		%g5, _PAGE_EXEC_4V, %g0
+	nop
 	.previous
 
 	be,pn		%xcc, tsb_do_fault
-- 
1.6.6.1

