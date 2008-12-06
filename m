From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 06 Dec 2008 22:26:23 +0000
Subject: Re: common header file in sparc/kernel/ - kernel.h?
Message-Id: <20081206222623.GA20288@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20081206083416.GA14404@uranus.ravnborg.org>
In-Reply-To: <20081206083416.GA14404@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sat, Dec 06, 2008 at 01:53:27PM -0800, David Miller wrote:
> From: Sam Ravnborg <sam@ravnborg.org>
> Date: Sat, 6 Dec 2008 09:34:16 +0100
> 
> > A lot of sparc code uses local extern definitions of
> > variabels and local function prototypes.
> > sparse is good at reporting this.
> > 
> > I tried to look for the right place to add these but
> > did not really find it.
> > For sparc64 we have "entry.h" but that does not look like
> > a shareable file at all.
> 
> entry.h is for functions and symbols whose definition
> exists in assembler code on sparc64.  If we wanted to
> do something similar for sparc32 likely we'd initially
> move entry.h to entry_64.h and create an entry_32.h
> 
> > So I'm considering creating a sparc/kernel/kernel.h
> > for all the local definitions for this directory.
>  ...
> > $ grep extern *32.c | wc -l
> > 80
> 
> If it's for 32-bit stuff, maybe give the header file
> a foo_32.h name?  But otherwise sounds like a good idea.
> 
> For these things on the sparc64 side I just added them
> to the closest appropritate header in asm/*.h, there is
> a series of commits here and there where I addressed
> sparse warnings in this way.  Probably "gitk arch/sparc64"
> would allow you to scan them quickly.

I already did somthing like this and in this case the symbols
was added to entry.h despite they came from a .c file.
(sparc_cpu_type + sparc_fpu_type).

[note: git log --follow arch/sparc/kernel/ is your friend]

Looking at the sparse output there are addition candidates
to be added to kernel.h - several being shared with sparc64.

So what I would suggest is to do the following:
sparc/kernel/kernel.h for stuff from .c files
sparc/kernel/entry_{32,64}.h for the assembler stuff
that are 32/64 bit specific.
sparc/kernel/entry.h for the common assembler stuff.

If I get around to do additional sparc unification I will try
this if you do not beat me or tell me otherwise.

	Sam
