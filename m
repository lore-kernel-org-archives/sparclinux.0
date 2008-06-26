From: David Miller <davem@davemloft.net>
Date: Thu, 26 Jun 2008 00:28:38 +0000
Subject: Re: [3/10 PATCH] inline wake_up_bit
Message-Id: <20080625.172838.242554644.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200806251724.57689.vda.linux@googlemail.com>
	<Pine.LNX.4.64.0806251148550.20484@engineering.redhat.com>
	<200806252237.58046.vda.linux@googlemail.com>
In-Reply-To: <200806252237.58046.vda.linux@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: vda.linux@googlemail.com
Cc: mpatocka@redhat.com, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: Denys Vlasenko <vda.linux@googlemail.com>
Date: Wed, 25 Jun 2008 22:37:58 +0200

> On Wednesday 25 June 2008 18:01, Mikulas Patocka wrote:
> > > Ingo's suggestion to talk to gcc people to remedy
> > > insane call convention sounds as a more workable solution.
> > >
> > > BTW, i386 uses regparm call convention, is similar trick
> > > possible for sparc64?
> > 
> > Sparc64 has register windows: it passes arguments in registers, but it 
> > must allocate space for that registers. If the call stack is too deep (8 
> > levels), the CPU runs out of registers and starts spilling the registers 
> > of the function 8-levels-deep to the stack.
> > 
> > The stack usage could be reduced to 176 bytes with little work from gcc 
> > developers and to 128 bytes with more work (ABI change). If you wanted to 
> 
> Wow, it's nearly x2 reduction.
> 
> ABI change in not a problem for kernel, since it is a "freestanding
> application". Exactly like i386 switched to regparm, which is a different ABI.

Except that nobody has written this code and therefore being about to
use this unimplemented compiler facility to get correctness is not
tenable.
