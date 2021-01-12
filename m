From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Tue, 12 Jan 2021 14:44:44 +0000
Subject: Re: Old platforms: bring out your dead
Message-Id: <cb5a2e11-d423-96ec-3d43-3568a109e37f@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
References: <ef1dc21f-694b-2433-e1c6-aa121320173e@physik.fu-berlin.de>
 <f48bcf43-9dcc-e48b-d29d-f75f3814398b@gmx.net>
In-Reply-To: <f48bcf43-9dcc-e48b-d29d-f75f3814398b@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Gerhard Pircher <gerhard_pircher@gmx.net>, Arnd Bergmann <arnd@arndb.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, Sparc kernel list <sparclinux@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

Hello Gerhard!

On 1/11/21 4:04 PM, Gerhard Pircher wrote:
>>> * powerpc/cell: I'm the maintainer and I promised to send a patch to remove it.
>>>    it's in my backlog but I will get to it. This is separate from PS3,
>>>    which is actively maintained and used; spufs will move to ps3
>>> * powerpc/chrp (32-bit rs6000, pegasos2): last updated in 2009
>>
>> I'm still using this. Please keep it.
>
> I can also confirm that Pegasos2 users in the Amiga scene are running Linux
> (Debian) on these machines.

Thanks for raising your voice. It's nice and reliable hardware after all and
still fast enough to run a recent version of Debian unstable with a lean
desktop such as XFCE or MATE.
 
>>> * powerpc/amigaone: last updated in 2009
>
> I still have 2 of the 3 types of the first generation AmigaOne machines (not
> to be confused with the newer AmigaOne X1000 and X5000 machines based on
> PASemi and P5020 CPUs) working here. A third machine needs a repair of the
> G4 CPU module (replacement parts already available).

Cool.

> I have to admit however that I yet have to setup an environment that allows
> me to regularly test new Linux kernel versions on these machines. Especially
> because there are not many Linux users for these machines - which is likely
> due to the fact that no distribution officially supports these machines out
> of the box (the Pegasos2 platform had more luck here). Inputs on how to
> automate tests would therefore be very welcome!

Are you on the debian-powerpc mailing list? If not, please subscribe and post
your issues there:

> https://lists.debian.org/debian-powerpc/

> Given however that the Debian PowerPC port has a proper maintainer again
> (kudos to Adrian!) and there is also another new PowerPC distro (Void Linux),
> I would like to ask for a period of grace. After all this is just a hobby
> project for me, so keeping up with the pace of the Linux development isn't
> always that easy (and no, work on this did not stop in 2009, but shifted more
> towards distro support since then).

Yeah, I have the same impression that's the strong commercial interest pushes
hobbyist use of the Linux kernel a bit down. A lot of these changes feel like
they're motivated by corporate decisions.

There has to be a healthy balance between hobbyist and commercial use. I understand
that from a commercial point of view, it doesn't make much sense to run Linux
on a 30-year-old computer. But it's a hobbyist project for many people and hacking
Linux stuff for these old machines has a very entertaining and educational factor.

Plus, as Thomas Bogendoerfer already mentioned in this thread, most of the old ports
run just fine. I have an Alpha XP-1000 building Debian packages for the Debian
Alpha port and it runs 24/7 without a hick and is regularly kept up-to-date with
dist-upgrades.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
