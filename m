From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed, 16 May 2012 14:58:26 +0000
Subject: Re: [RFC PATCH] sparc32,leon: always include leon code in build
Message-Id: <20120516145826.GA1005@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20120514202951.GA4439@merkur.ravnborg.org>
In-Reply-To: <20120514202951.GA4439@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi Jiri.

> 
> > Konrad / Daniel - any inputs on why LEON uses a different ASI?
> > As we uses this in head_32.S this is really annoying...
> 
> It is not difficult to change the MMU reg ASI from 0x19 to 0x4
> (as defined in the SRMMU spec). However, all available LEON2/3/4
> chips in production uses 0x19 due to a decision take about 10
> years ago.
Then I consider that cast in stone :-(
We have leon boards out that uses ASI = 0x19.

What we really need is an implementation of head_32.S that transparently
handle the existing sun4m + sun4d boxes + the leon based boards.

If there is a way we reliably early on can decide if we run
one of the leon chips then we can always use a separate track in
head_32.S for the leon stuff.

Not that I like to do so - but this is better than the current
situation where we magically redefine ASI and thus are not
compatible with all paltforms in the same code.

I am having something in mind where we from head_32.S call

    void sparc32_start_kernel(int cpu_model)

Then we can do the final preparations here before we call
start_kernel().

Today we transfer the cpu_model in the global variable
cputypval - and we may continue to do so too.

The point is that we should try to come up with
a head_32.S that handle but leon and non-leon
cpu's in the same file.
Then we can always handle the remaining issues using
instruction patching or ops structures etc.

If someone a Gaisler can look into head_32.S then
I would be happy to help with the rest.

	Sam
