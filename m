From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 29 May 2012 18:39:39 +0000
Subject: Re: sparc32: some more testing
Message-Id: <20120529183939.GA8557@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <CACEWtaD1kfFocos0EaaZTWodas=YWcM3L-fFJR48JJApTDj2YA@mail.gmail.com>
In-Reply-To: <CACEWtaD1kfFocos0EaaZTWodas=YWcM3L-fFJR48JJApTDj2YA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, May 28, 2012 at 03:59:26PM +0200, Marcel van Nies wrote:
> Hi,
> 
> I tried today's sparc.git on a number of systems:
> 
> UP kernel:
> IPX : not supported (as expected)
> SS5 with MicroSPARC-II 110MHz : works
> SS5 with TurboSPARC 170MHz : works
> SS20 with SuperSPARC-II 75MHz : boots, but various binaries either
> BUG, give "Illegal instruction", receive signal 4, ...
> SS20 with HyperSPARC 125MHz : boots, INIT segfaults
> 
> SMP kernel:
> SS20 with dual SuperSPARC-II 75MHz :  boots, loading INIT is
> slooooooow ... takes like 1 minute or so ... finally system freezes
> SS20 with quad HyperSPARC 125MHz : boots, INIT segfaults


I really did not know where to go from here. So I fired up my ss20
and this time I managed to fix my network issue.
So I now have a setup with an ss20 that does not boot :-)

With SMP I see following bug:
SRMMU: Using VAC size of 262144 bytes, line size 64 bytes.
127MB HIGHMEM available.
Unable to handle kernel paging request at virtual address f0a00000
tsk->{mm,active_mm}->context = ffffffff
tsk->{mm,active_mm}->pgd = f0008000

	SPARC SMILEY

swapper(0): Oops [#1]
PSR: 1e401fe7 PC: f015a73c NPC: f015a740 Y:00000000   Not tainted
PC: <__bzero+0x38/0x144>
...
...
...
Unable to handle kernel NULL pointer dereference
...

And with UP I see the same bug.
So obviously my box fails booting before your box does....

As it boots Solaris I assume that it is to some degree operational
and should be able to boot Linux.

The above looks like the same kind of bug I was hitting when I looked at memblock
support. So I shall likely find the bug somehow in the mmu handling.
I gues I have some challenging debugging hours waiting - but that
will wait a little...

Thanks for your testing - much appreciated depite the bad results!

	Sam
