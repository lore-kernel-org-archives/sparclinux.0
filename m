From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Mon, 11 Jan 2021 08:05:17 +0000
Subject: Re: Old platforms: bring out your dead
Message-Id: <df42946e-5b1f-c433-fc6b-a2950f3d8dab@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
References: <CAK8P3a2VW8T+yYUG1pn1yR-5eU4jJXe1+M_ot6DAvfr2KyXCzQ@mail.gmail.com>
 <ef1dc21f-694b-2433-e1c6-aa121320173e@physik.fu-berlin.de>
 <20210110214653.GA1693373@ravnborg.org>
In-Reply-To: <20210110214653.GA1693373@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, Sparc kernel list <sparclinux@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

Hello!

On 1/10/21 10:46 PM, Sam Ravnborg wrote:
>> I don't think this has reached any agreement yet. Multiple people want it to stay.
> 
> None of the people that replied have any real use of the sun4m port,
> they only wanted it to stay because they had some machines or such.
> In other words - people will be sad if we sunset sun4m, but it will not
> hurt anyone as there are no users left.
> 
> I will include the above summary when I post v2 of the patch to sunset
> sun4m and sun4d. Then we will see what we conclude in the end.

I'm not sure I understand the reasoning for doing this. The SPARC architecture
isn't going to see any new hardware developments in the future after Oracle
let go of most of the SPARC developers. So it's not that we need to make room
for new hardware.

And I also disagree with Arnd's stance that a port seems broken because it
doesn't see frequent or recent changes. As pointed out by Thomas Bogendoerfer
in this thread [1], missing updates don't necessarily mean that something
is broken but it can also just mean the hardware is fully supported and
working, so why fix something that isn't broken?

On the other hand, there are really serious bugs in the kernel that easily
allow crashing the whole machine (here on POWER [2] or here on SPARC [3])
that never get addressed.

We have a $10k IBM POWER server in Debian Ports which hosts a big-endian
PowerKVM build server instance and regularly hard-crashes because of the
bug in [2]. This bug has remained unfixed for almost a year now.

On top of that, some of the tree-wide conversions like [4] have completely
broken the Linux kernel on certain machines so that any larger ia64 servers
are stuck on the 4.14 kernel with no fix in sight. Before that, the kernel
worked perfectly fine on these machines.

I understand that cleaning up code and modernizing things is important, but
I think that the top priority should be to deliver something that is stable
and usable by the enduser.

But kernel development shouldn't be about scratching an itch which I sometimes
have the impression is the main driver behind some changes in the kernel.

I have personally invested a lot of time and effort in the past years to get
Debian into shape on exotic and older architectures and I feel all this effort
goes to waste when upstream projects just decide to kill of a certain platform
in the kernel or toolchain like it already happened with PowerPCSPE in GCC.

Adrian

> [1] https://lore.kernel.org/lkml/20210108234430.GA17487@alpha.franken.de/
> [2] https://bugzilla.kernel.org/show_bug.cgi?id 6669
> [3] https://marc.info/?l=linux-sparc&m0967865029609&w=2
> [4] https://marc.info/?l=linux-ia64&m6144480821712&w=2

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
