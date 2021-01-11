From: chase rayfield <cusbrar1@gmail.com>
Date: Mon, 11 Jan 2021 14:55:13 +0000
Subject: Re: Old platforms: bring out your dead
Message-Id: <CACwypyNS+fVoPVspSr36v8YjFbkrnYb+amcYRqVmA2kD2uD1Wg@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <CAK8P3a2VW8T+yYUG1pn1yR-5eU4jJXe1+M_ot6DAvfr2KyXCzQ@mail.gmail.com>
 <ef1dc21f-694b-2433-e1c6-aa121320173e@physik.fu-berlin.de>
 <20210110214653.GA1693373@ravnborg.org> <df42946e-5b1f-c433-fc6b-a2950f3d8dab@physik.fu-berlin.de>
In-Reply-To: <df42946e-5b1f-c433-fc6b-a2950f3d8dab@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Sam Ravnborg <sam@ravnborg.org>, Arnd Bergmann <arnd@arndb.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, Sparc kernel list <sparclinux@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

On Mon, Jan 11, 2021 at 3:09 AM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:

>
> I'm not sure I understand the reasoning for doing this. The SPARC architecture
> isn't going to see any new hardware developments in the future after Oracle
> let go of most of the SPARC developers. So it's not that we need to make room
> for new hardware.
>
My take is that there *would* be more interest in Sparc sun4m / Sun4d
from enthusiasts at the very least if it was possible to actually boot
the bloat hog that is Linux these days in a fully usable configuration
that probably means some modifications to SILO and Linux required.

The problem is as I understand it, SILO only sets up a 16Mb mapping
(either due to having to assume 4MB minimum dram stick size or due to
mapping limitations not sure, most of these machines have at least
16MB in slot one...these days though that wasn't the case for sun4c),
loads Linux into it and says good Luck. This isn't enough for a modern
kernel with any  hardware support built in. So you might for instance
get a kernel to fit but only if you dropped all of networking support
etc... I'm guessing the fix for this would be to modify silo to map a
larger amount in a way that Linux expects so it can remap it as it
likes, or just have SILO map the full memory as Linux would. Anyway
that is THE main demotivation for these architectures.... otherwise
they have plenty of ram and performance to do basic router/server
tasks sans SSL.

This has been the status quo for since the last of the 2.6 series of
kernels which it was still possible to just barely squeeze a usable
kernel out of... If someone wanted to take a few hours and fix this
issue, and keep these architectures around I'd be happy to "buy them a
round of pizza", though I recognize that many people that work on this
already have nice jobs, and just don't have time.

Also Sparc would probably be a good project for someone to extend/test
Andi Keen's Linux LTO patch set so we could reduce the kernel binary
size that way also even if sun4 architectures are dropped, it would
still be useful for embedded sparc. Also there is a port of Temlib to
the Mister hardware now, 3 cores roughly equivalent to a mid 90s
machine, at least 128MB ram is possible ( more if a way to map the ARM
system memory also 1GB is available there, it would have higher
latency though).

It is perfectly viable to build Sparc v7 or v8 32bit binaries in a
chroot on a fast machine also, and I would recommend this if you wish
to retain sanity rather than attempting cross compiler voodoo, unless
that is your thing.

Anyways it could be that people that want this get around to fixing
SILO eventually and just sit on this last kernel version... *shrugs*

Chase
