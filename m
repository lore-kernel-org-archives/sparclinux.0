From: Bernd Zeimetz <bernd@bzed.de>
Date: Sun, 28 Oct 2007 13:02:33 +0000
Subject: Re: unkillable dpkg-query processes
Message-Id: <47248869.7090608@bzed.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20071024223332.GA24557@keid.carnet.hr>
In-Reply-To: <20071024223332.GA24557@keid.carnet.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

please note that the futex bug also happens on US II machines,
it is jsut almost impossible to reproduce it - it'll just hang
after random days of building.

> Everyone who sees these UltraSPARC-III problems please send me PRECISE
> and FULL description of how to install from scratch a machine and run
> something that will trigger these errors.

Can you please check if the Kernel config I've attached to one of my
last mails is fine for you? The normal Debian installer doesn't
boot on the US III machines which use two CPUs in one board as the
installer's Kernel is a non-SMP Kernel, and the result is that the
machine throws a CPU exception and needs to be power-cycled....

I've started to investigate there with the help of a contact from
Sun, but we both didn't have the time to finish this.
http://bugs.debian.org/cgi-bin/bugreport.cgi?bugD0720 if you want
to have a look, please ignore those troll postings from chealer
in between...

So to give you a recipe to install Debian on such a box, I need to
build an installer with a SMP Kernel for you. If the config is fine
for your needs, I could just use use it.


The other option is to use debootstrap, if you have some system
on the machine already - so if you want to use that instead of
messing with a network installer, please let me know.
Debootstrap should run on most systems, as long as they have
ar/tar/gunzip and a bash (probably sh is enough...).
Would be faster to use that, and faster to write a recipe for
that.

I'll mark all Qlogic firmware related points, so the recipe should
work on machines with (v440, v880, probably the Enterprise models,
too) and without FC (I guess the Blade 1000 and 2000).


If you don't have access to an US-III machine, I can find a way
to give you access to the RSC and serial console of our machine.


Cheers,

Bernd

-- 
Bernd Zeimetz
<bernd@bzed.de>                         <http://bzed.de/>
