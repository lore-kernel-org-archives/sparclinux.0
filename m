From: Denys Vlasenko <vda.linux@googlemail.com>
Date: Wed, 25 Jun 2008 20:37:58 +0000
Subject: Re: [3/10 PATCH] inline wake_up_bit
Message-Id: <200806252237.58046.vda.linux@googlemail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.0806240136200.27784@engineering.redhat.com> <200806251724.57689.vda.linux@googlemail.com> <Pine.LNX.4.64.0806251148550.20484@engineering.redhat.com>
In-Reply-To: <Pine.LNX.4.64.0806251148550.20484@engineering.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, davem@davemloft.net

On Wednesday 25 June 2008 18:01, Mikulas Patocka wrote:
> > Ingo's suggestion to talk to gcc people to remedy
> > insane call convention sounds as a more workable solution.
> >
> > BTW, i386 uses regparm call convention, is similar trick
> > possible for sparc64?
> 
> Sparc64 has register windows: it passes arguments in registers, but it 
> must allocate space for that registers. If the call stack is too deep (8 
> levels), the CPU runs out of registers and starts spilling the registers 
> of the function 8-levels-deep to the stack.
> 
> The stack usage could be reduced to 176 bytes with little work from gcc 
> developers and to 128 bytes with more work (ABI change). If you wanted to 

Wow, it's nearly x2 reduction.

ABI change in not a problem for kernel, since it is a "freestanding
application". Exactly like i386 switched to regparm, which is a different ABI.

> go below 128 bytes, you could use one register to indicate number of used 
> registers and modify the spill/fill handlers to load only that number of 
> registers and reduce the stack usage even more --- that would be a big 
> code change in both gcc and linux.
--
vda
