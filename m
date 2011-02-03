From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 03 Feb 2011 16:58:21 +0000
Subject: sparc32 community [Was: sparc32: unaligned memory access (MNA)
Message-Id: <20110203165821.GA14776@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

>
> I really hope that the sparc community can take benefit of the time we  
> invested in this.

Sometimes I have asked myself what is the size of the sparc32 community?
Personally I got more involved in sparc development because I wanted
to simplify the way we handled our headers and a natural step forward
was to get the remaining architectures merged where sparc & sparc64
was one of the outstanding architectures.
A responsive maintainer also helped a lot.

I have looked around for a decent distribution that claim up-to-date
support for sparc. But they all seem to be dropping sparc support.
And here sparc64 is in focus - not sparc32.

And I understand that sparc32 does not work well for many people.
I know that recent kernels only can run on SparcServer 1000 for
a few minutes before it locks hard. And I expect we see similar
problems on sun4m boxes with > 1 CPU.
The bug you have fixed (with great effort) in the unaligned
trap handler further confirm to me that that not many users
are running recent kernels on sparc32 hardware.
I also recall that I broke sparc32 during the unification,
which took months to e detected.

Personally I run sparc only to test my kernel contributions,
as the hw I have available is too noisy / too slow to
be used for anything else.

But IMHO the sparc boxes are quite nice and the sparc32 architecture
code does not deserve to bitrot.
So when Gaisler sponsored me a LEON4 evaluation board I decided to
concentrate my effort on sparc. I have had no benefit of the
evaluation board - yet. The current effort is to bring
the sparc32 stuff up snuff - and this will also benefit the
LEON support.
I expect one day that my contributions rasies above the
janitorial level...

It also looks better on the CV when I can say that I have refactored
the IRQ support on sparc compared to some random kbuild hacking :-)

So Gaislers contributions helps the sparc32 community.
And I expect that the combined effort will allow more people to
use a recent kernel on sparc32 and thus will increase the community.
But how big the community is - is an open question to me.

Note: If someone has - or knows about - a SS1000 that I can use
for Linux testing I am all ears. (I live in Scandinavia / Denmark)
Contact me in private as this in not relevant on the list.

	Sam
