From: Pavel Machek <pavel@suse.cz>
Date: Thu, 26 Jun 2008 18:22:10 +0000
Subject: Re: [3/10 PATCH] inline wake_up_bit
Message-Id: <20080626182209.GA9878@ucw.cz>
List-Id: <sparclinux.vger.kernel.org>
References: <200806251724.57689.vda.linux@googlemail.com> <Pine.LNX.4.64.0806251148550.20484@engineering.redhat.com> <200806252237.58046.vda.linux@googlemail.com> <20080625.172838.242554644.davem@davemloft.net>
In-Reply-To: <20080625.172838.242554644.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: vda.linux@googlemail.com, mpatocka@redhat.com, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

On Wed 2008-06-25 17:28:38, David Miller wrote:
> From: Denys Vlasenko <vda.linux@googlemail.com>
> Date: Wed, 25 Jun 2008 22:37:58 +0200
> 
> > On Wednesday 25 June 2008 18:01, Mikulas Patocka wrote:
> > > > Ingo's suggestion to talk to gcc people to remedy
> > > > insane call convention sounds as a more workable solution.
> > > >
> > > > BTW, i386 uses regparm call convention, is similar trick
> > > > possible for sparc64?
> > > 
> > > Sparc64 has register windows: it passes arguments in registers, but it 
> > > must allocate space for that registers. If the call stack is too deep (8 
> > > levels), the CPU runs out of registers and starts spilling the registers 
> > > of the function 8-levels-deep to the stack.
> > > 
> > > The stack usage could be reduced to 176 bytes with little work from gcc 
> > > developers and to 128 bytes with more work (ABI change). If you wanted to 
> > 
> > Wow, it's nearly x2 reduction.
> > 
> > ABI change in not a problem for kernel, since it is a "freestanding
> > application". Exactly like i386 switched to regparm, which is a different ABI.
> 
> Except that nobody has written this code and therefore being about to
> use this unimplemented compiler facility to get correctness is not
> tenable.

Switch to 32K stack on sparc64, then?

							Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
