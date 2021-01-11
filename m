From: Gerhard Pircher <gerhard_pircher@gmx.net>
Date: Mon, 11 Jan 2021 15:04:11 +0000
Subject: Re: Old platforms: bring out your dead
Message-Id: <f48bcf43-9dcc-e48b-d29d-f75f3814398b@gmx.net>
List-Id: <sparclinux.vger.kernel.org>
References: <ef1dc21f-694b-2433-e1c6-aa121320173e@physik.fu-berlin.de>
In-Reply-To: <ef1dc21f-694b-2433-e1c6-aa121320173e@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Arnd Bergmann <arnd@arndb.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, Sparc kernel list <sparclinux@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

Am 10.01.21 um 18:35 schrieb John Paul Adrian Glaubitz:
> Hi Arnd!
>
> (Please let's have this cross-posted for more visibility. I only learned about this
>  while reading Phoronix news)
Same for me!

>> I also looked at non-ARM platforms while preparing for my article. Some of
>> these look like they are no longer actively maintained or used, but I'm not
>> doing anything about those unless the maintainers would like me to:
>>
>> * h8300: Steven Rostedt has repeatedly asked about it to be removed
>>    or fixed in 2020 with no reply. This was killed before in 2013, added back
>>    in 2015 but has been mostly stale again since 2016
>
> As far as I know, Yoshinori Sato is actively maintaining H8300 support, see:
>
>> https://osdn.net/projects/uclinux-h8/
>
>> * c6x: Added in 2011, this has seen very few updates since, but
>>     Mark still Acks patches when they come. Like most other DSP platforms,
>>     the model of running Linux on a DSP appears to have been obsoleted
>>     by using Linux on ARM with on-chip DSP cores running bare-metal code.
>> * sparc/sun4m: A patch for removing 32-bit Sun sparc support (not LEON)
>>    is currently under review
>
> I don't think this has reached any agreement yet. Multiple people want it to stay.
>
>> * powerpc/cell: I'm the maintainer and I promised to send a patch to remove it.
>>    it's in my backlog but I will get to it. This is separate from PS3,
>>    which is actively maintained and used; spufs will move to ps3
>> * powerpc/chrp (32-bit rs6000, pegasos2): last updated in 2009
>
> I'm still using this. Please keep it.
I can also confirm that Pegasos2 users in the Amiga scene are running Linux
(Debian) on these machines.

>> * powerpc/amigaone: last updated in 2009
I still have 2 of the 3 types of the first generation AmigaOne machines (not
to be confused with the newer AmigaOne X1000 and X5000 machines based on
PASemi and P5020 CPUs) working here. A third machine needs a repair of the
G4 CPU module (replacement parts already available).
I have to admit however that I yet have to setup an environment that allows
me to regularly test new Linux kernel versions on these machines. Especially
because there are not many Linux users for these machines - which is likely
due to the fact that no distribution officially supports these machines out
of the box (the Pegasos2 platform had more luck here). Inputs on how to
automate tests would therefore be very welcome!
Given however that the Debian PowerPC port has a proper maintainer again
(kudos to Adrian!) and there is also another new PowerPC distro (Void Linux),
I would like to ask for a period of grace. After all this is just a hobby
project for me, so keeping up with the pace of the Linux development isn't
always that easy (and no, work on this did not stop in 2009, but shifted more
towards distro support since then).

>> * powerpc/maple: last updated in 2011
>> * m68k/{apollo,hp300,sun3,q40} these are all presumably dead and have not
>>    seen updates in many years (atari/amiga/mac and coldfire are very much
>>    alive)
>
> Dito. I have both sun3 and hp300 machines.
>
>> * mips/jazz: last updated in 2007
>> * mips/cobalt: last updated in 2010
>>
>> There might be some value in dropping old CPU support on architectures
>> and platforms that are almost exclusively used with more modern CPUs.
>> If there are only few users, those can still keep using v5.10 or v5.4 stable
>> kernels for a few more years. Again, I'm not doing anything about them,
>> except mention them since I did the research.
>> These are the oldest one by architecture, and they may have reached
>> their best-served-by-date:
>>
>> * 80486SX/DX: 80386 CPUs were dropped in 2012, and there are
>>   indications that 486 have no users either on recent kernels.
>>   There is still the Vortex86 family of SoCs, and the oldest of those were
>>   486SX-class, but all the modern ones are 586-class.
>> * Alpha 2106x: First generation that lacks some of the later features.
>>   Since all Alphas are ancient by now, it's hard to tell whether these have
>>   any fewer users.
>
> I don't see the point in crippling Alpha support. Does this achieve anything?
>
>> * IA64 Merced: first generation Itanium (2001) was quickly replaced by
>>   Itanium II in 2002.
>> * MIPS R3000/TX39xx: 32-bit MIPS-II generation, mostly superseded by
>>   64-bit MIPS-III (R4000 and higher) starting in 1991. arch/mips still
>>   supports these in DECstation and Toshiba Txx9, but it appears that most
>>   of those machines are of the 64-bit kind. Later MIPS32 such as 4Kc and
>>   later are rather different and widely used.
>> * PowerPC 601 (from 1992) just got removed, later 60x, 4xx, 8xx etc
>>   are apparently all still used.
>> * SuperH SH-2: We discussed removing SH-2 (not J2 or SH-4)
>>   support in the past, I don't think there were any objections, but
>>   nobody submitted a patch.
>
> Isn't SH-2 basically J-2? I'm not sure what we would gain here.
>
>> * 68000/68328 (Dragonball): these are less capable than the
>>   68020+ or the Coldfire MCF5xxx line and similar to the 68360
>>   that was removed in 2016.
>
> Adrian
>
