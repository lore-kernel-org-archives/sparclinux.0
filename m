From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Tue, 12 Jan 2021 14:37:32 +0000
Subject: Re: Old platforms: bring out your dead
Message-Id: <4c42f2ce-7702-55cd-a2c0-558d3dd208f2@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
References: <CAK8P3a2VW8T+yYUG1pn1yR-5eU4jJXe1+M_ot6DAvfr2KyXCzQ@mail.gmail.com>
 <ef1dc21f-694b-2433-e1c6-aa121320173e@physik.fu-berlin.de>
 <20210110214653.GA1693373@ravnborg.org>
 <df42946e-5b1f-c433-fc6b-a2950f3d8dab@physik.fu-berlin.de>
 <CACwypyNS+fVoPVspSr36v8YjFbkrnYb+amcYRqVmA2kD2uD1Wg@mail.gmail.com>
In-Reply-To: <CACwypyNS+fVoPVspSr36v8YjFbkrnYb+amcYRqVmA2kD2uD1Wg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: chase rayfield <cusbrar1@gmail.com>
Cc: Sam Ravnborg <sam@ravnborg.org>, Arnd Bergmann <arnd@arndb.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, Sparc kernel list <sparclinux@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

Hello!

On 1/11/21 3:55 PM, chase rayfield wrote:
> My take is that there *would* be more interest in Sparc sun4m / Sun4d
> from enthusiasts at the very least if it was possible to actually boot
> the bloat hog that is Linux these days in a fully usable configuration
> that probably means some modifications to SILO and Linux required.

The Linux kernel is configurable. If you want a small kernel, then just
configure one. No one expects you to boot a fully-fledged distribution
kernel on these machines.

> The problem is as I understand it, SILO only sets up a 16Mb mapping
> (either due to having to assume 4MB minimum dram stick size or due to
> mapping limitations not sure, most of these machines have at least
> 16MB in slot one...these days though that wasn't the case for sun4c),
> loads Linux into it and says good Luck. This isn't enough for a modern
> kernel with any  hardware support built in. So you might for instance
> get a kernel to fit but only if you dropped all of networking support
> etc...

That makes no sense. It worked in the past, why shouldn't it work nowadays?

As I said, you disable everything you don't need. I'm booting my SH-7785LCR
SuperH board with a kernel that is less than 4 MB in size and which includes
everything I need.

> I'm guessing the fix for this would be to modify silo to map a
> larger amount in a way that Linux expects so it can remap it as it
> likes, or just have SILO map the full memory as Linux would. Anyway
> that is THE main demotivation for these architectures.... otherwise
> they have plenty of ram and performance to do basic router/server
> tasks sans SSL.

Or just configure a smaller kernel.

> This has been the status quo for since the last of the 2.6 series of
> kernels which it was still possible to just barely squeeze a usable
> kernel out of... If someone wanted to take a few hours and fix this
> issue, and keep these architectures around I'd be happy to "buy them a
> round of pizza", though I recognize that many people that work on this
> already have nice jobs, and just don't have time.

I haven't gotten around to setup my SPARCstation 5 yet, but I will certainly
going to do that later this year to give it a try.

> Also Sparc would probably be a good project for someone to extend/test
> Andi Keen's Linux LTO patch set so we could reduce the kernel binary
> size that way also even if sun4 architectures are dropped, it would
> still be useful for embedded sparc. Also there is a port of Temlib to
> the Mister hardware now, 3 cores roughly equivalent to a mid 90s
> machine, at least 128MB ram is possible ( more if a way to map the ARM
> system memory also 1GB is available there, it would have higher
> latency though).
> 
> It is perfectly viable to build Sparc v7 or v8 32bit binaries in a
> chroot on a fast machine also, and I would recommend this if you wish
> to retain sanity rather than attempting cross compiler voodoo, unless
> that is your thing.

We build anything SPARC on a SPARC T5 that we have for Debian, no need
for cross-compilation and that machine is actually quite fast.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
