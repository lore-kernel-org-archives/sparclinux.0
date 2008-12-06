From: David Miller <davem@davemloft.net>
Date: Sat, 06 Dec 2008 21:53:27 +0000
Subject: Re: common header file in sparc/kernel/ - kernel.h?
Message-Id: <20081206.135327.111460237.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20081206083416.GA14404@uranus.ravnborg.org>
In-Reply-To: <20081206083416.GA14404@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 6 Dec 2008 09:34:16 +0100

> A lot of sparc code uses local extern definitions of
> variabels and local function prototypes.
> sparse is good at reporting this.
> 
> I tried to look for the right place to add these but
> did not really find it.
> For sparc64 we have "entry.h" but that does not look like
> a shareable file at all.

entry.h is for functions and symbols whose definition
exists in assembler code on sparc64.  If we wanted to
do something similar for sparc32 likely we'd initially
move entry.h to entry_64.h and create an entry_32.h

> So I'm considering creating a sparc/kernel/kernel.h
> for all the local definitions for this directory.
 ...
> $ grep extern *32.c | wc -l
> 80

If it's for 32-bit stuff, maybe give the header file
a foo_32.h name?  But otherwise sounds like a good idea.

For these things on the sparc64 side I just added them
to the closest appropritate header in asm/*.h, there is
a series of commits here and there where I addressed
sparse warnings in this way.  Probably "gitk arch/sparc64"
would allow you to scan them quickly.



