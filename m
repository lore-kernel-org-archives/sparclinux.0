From: "David S. Miller" <davem@davemloft.net>
Date: Mon, 09 Jan 2006 20:53:01 +0000
Subject: Re: strace broken on SPARC64
Message-Id: <20060109.125301.08889945.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1136767843.9208.15.camel@duncow>
In-Reply-To: <1136767843.9208.15.camel@duncow>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Richard Mortimer" <richm@oldelvet.org.uk>
Date: Mon, 9 Jan 2006 16:03:31 -0000

> A quick look at the code in entry.S shows that %l1 is used for TPC
> values a little later in the code and that would correspond to the "zero"
> PC report in the messages.
> 
>         bne,pn          %icc, linux_syscall_trace2
>          add            %l1, 0x4, %l2                   ! npc = npc+4
>         stx             %l1, [%sp + PTREGS_OFF + PT_V9_TPC]
>         ba,pt           %xcc, rtrap_clr_l6
> 
> I should get more time to look at this and try out different registers
> etc tonight.

Yeah, I have to certainly do the fix differently.  Thanks for
testing :-)

I'll cook up a better fix.
