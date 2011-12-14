From: David Miller <davem@davemloft.net>
Date: Wed, 14 Dec 2011 18:18:10 +0000
Subject: Re: Sparc-32 doesn't work in 3.1.
Message-Id: <20111214.131810.916491563666428853.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4EE80891.70604@landley.net>
	<20111214204225.7c8ec86c@sf.home>
	<20111214.125443.973289484729064945.davem@davemloft.net>
In-Reply-To: <20111214.125443.973289484729064945.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: slyich@gmail.com
Cc: rob@landley.net, aboriginal@lists.landley.net, linux-kernel@vger.kernel.org, tytso@mit.edu, sparclinux@vger.kernel.org, jakub@redhat.com

From: David Miller <davem@davemloft.net>
Date: Wed, 14 Dec 2011 12:54:43 -0500 (EST)

> The right fix is to simply teach btfixup to be able to patch
> the 'restore' just as equally as it would patch an 'or'.

Try this:

--------------------
sparc32: Be less strict in matching %lo part of relocation.

The "(insn & 0x01800000) != 0x01800000" test matches 'restore'
but that is a legitimate place to see the %lo() part of a 32-bit
symbol relocation, particularly in tail calls.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/mm/btfixup.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/mm/btfixup.c b/arch/sparc/mm/btfixup.c
index 5175ac2..8a7f817 100644
--- a/arch/sparc/mm/btfixup.c
+++ b/arch/sparc/mm/btfixup.c
@@ -302,8 +302,7 @@ void __init btfixup(void)
 				case 'i':	/* INT */
 					if ((insn & 0xc1c00000) = 0x01000000) /* %HI */
 						set_addr(addr, q[1], fmangled, (insn & 0xffc00000) | (p[1] >> 10));
-					else if ((insn & 0x80002000) = 0x80002000 &&
-					         (insn & 0x01800000) != 0x01800000) /* %LO */
+					else if ((insn & 0x80002000) = 0x80002000) /* %LO */
 						set_addr(addr, q[1], fmangled, (insn & 0xffffe000) | (p[1] & 0x3ff));
 					else {
 						prom_printf(insn_i, p, addr, insn);
-- 
1.7.6.401.g6a319

