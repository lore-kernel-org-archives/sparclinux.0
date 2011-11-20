From: Jurij Smakov <jurij@wooyd.org>
Date: Sun, 20 Nov 2011 22:33:41 +0000
Subject: Re: Kprobes on sparc
Message-Id: <20111120223341.GA26472@wooyd.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20111119134057.GA6273@wooyd.org>
In-Reply-To: <20111119134057.GA6273@wooyd.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, Nov 20, 2011 at 04:49:50PM -0500, David Miller wrote:
> From: Jurij Smakov <jurij@wooyd.org>
> Date: Sat, 19 Nov 2011 13:40:57 +0000
> 
> > I'm debugging a problem for which kprobes may potentially provide 
> > useful information, in particular I would like to examine local 
> > registers at some point in the kernel code. Unfortunately, while 
> > trying to accomplish that I ran into an issue I can't quite explain: 
> > whenever I try to access %fp register (a.k.a. %i6) from kprobe using 
> > regs->u_regs[UREG_FP], I get an unaligned value, which makes me think 
> > that it's incorrect somehow.
> 
> On 64-bit sparc, the stack is "biased" by 2047 bytes.
> 
> This is so that more of the stack frame is reachable relative to %fp
> using 13-bit signed immediate offsets, which are usable with the address
> of load and store instructions.
> 
> Grep for "STACK_BIAS" under arch/sparc

Thanks for the explanation.
-- 
Jurij Smakov                                           jurij@wooyd.org
Key: http://www.wooyd.org/pgpkey/                      KeyID: C99E03CC
