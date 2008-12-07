From: David Miller <davem@davemloft.net>
Date: Sun, 07 Dec 2008 07:35:59 +0000
Subject: Re: common header file in sparc/kernel/ - kernel.h?
Message-Id: <20081206.233559.141352181.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20081206083416.GA14404@uranus.ravnborg.org>
In-Reply-To: <20081206083416.GA14404@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 6 Dec 2008 23:26:23 +0100

> On Sat, Dec 06, 2008 at 01:53:27PM -0800, David Miller wrote:
> > If it's for 32-bit stuff, maybe give the header file
> > a foo_32.h name?  But otherwise sounds like a good idea.
> > 
> > For these things on the sparc64 side I just added them
> > to the closest appropritate header in asm/*.h, there is
> > a series of commits here and there where I addressed
> > sparse warnings in this way.  Probably "gitk arch/sparc64"
> > would allow you to scan them quickly.
> 
> I already did somthing like this and in this case the symbols
> was added to entry.h despite they came from a .c file.
> (sparc_cpu_type + sparc_fpu_type).

Indeed.  And actually I got the case reversed, the problematic
case is where the implementation is in *.c but all of the
_callers_ are in *.S code.  In this case the sparse warning
is completely silly, because the whole point of the declaration
is to make sure the callers and implementation agree on the
arguments, but no compiler or semantic checker can verify
that for C code called from assembler :-)

> [note: git log --follow arch/sparc/kernel/ is your friend]
> 
> Looking at the sparse output there are addition candidates
> to be added to kernel.h - several being shared with sparc64.
> 
> So what I would suggest is to do the following:
> sparc/kernel/kernel.h for stuff from .c files
> sparc/kernel/entry_{32,64}.h for the assembler stuff
> that are 32/64 bit specific.
> sparc/kernel/entry.h for the common assembler stuff.
> 
> If I get around to do additional sparc unification I will try
> this if you do not beat me or tell me otherwise.

Sounds good to me.
