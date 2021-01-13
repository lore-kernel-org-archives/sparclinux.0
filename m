From: Rob Landley <rob@landley.net>
Date: Wed, 13 Jan 2021 07:57:44 +0000
Subject: Re: Old platforms: bring out your dead
Message-Id: <b8eb1c83-d2f8-1c72-ca67-4160b90b3845@landley.net>
List-Id: <sparclinux.vger.kernel.org>
References: <ef1dc21f-694b-2433-e1c6-aa121320173e@physik.fu-berlin.de>
 <f48bcf43-9dcc-e48b-d29d-f75f3814398b@gmx.net>
 <cb5a2e11-d423-96ec-3d43-3568a109e37f@physik.fu-berlin.de>
 <CACRpkda4E2NwNw29J7x5gehtqn_m3M_Z2dHpc7xRgvb0b-p22A@mail.gmail.com>
In-Reply-To: <CACRpkda4E2NwNw29J7x5gehtqn_m3M_Z2dHpc7xRgvb0b-p22A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Linus Walleij <linus.walleij@linaro.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Gerhard Pircher <gerhard_pircher@gmx.net>, Arnd Bergmann <arnd@arndb.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, Sparc kernel list <sparclinux@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

On 1/12/21 4:46 PM, Linus Walleij wrote:
> On Tue, Jan 12, 2021 at 3:45 PM John Paul Adrian Glaubitz
> <glaubitz@physik.fu-berlin.de> wrote:
>=20
>> Yeah, I have the same impression that's the strong commercial interest p=
ushes
>> hobbyist use of the Linux kernel a bit down. A lot of these changes feel=
 like
>> they're motivated by corporate decisions.
>>
>> There has to be a healthy balance between hobbyist and commercial use. I=
 understand
>> that from a commercial point of view, it doesn't make much sense to run =
Linux
>> on a 30-year-old computer. But it's a hobbyist project for many people a=
nd hacking
>> Linux stuff for these old machines has a very entertaining and education=
al factor.
>=20
> This is actually one of the most interesting things written in this discu=
ssion.
>=20
> I have both revamped and deleted subarchitectures in the ARM tree. We
> never deleted anyone's pet project *unless* they were clearly unwilling to
> work on it (such as simply testning new patches) and agreed that it will
> not go on.

Another fun aspect of old hardware is it serves as prior art for patents. T=
he
j-core hardware implementation schedule has in part been driven by specific
patents expiring, as in "we can't do $FEATURE until $DATE".

It's much easier to nip a patent suit in the bud if you can go "here is
functionally equivalent hardware from the past, dates the specifications we=
re
published, and the specific patents on the technology which have now expire=
d".

We're a little overscheduled and not always _prompt_ about it, but for exam=
ple
the reason we couldn't do full 6-wire sd 1.0 in the first j-core SOC release
(and had to implement a painfully slow mmc bus instead) is the patents hadn=
't
expired yet.

> That said there are a three things that people should really be doing if =
they
> want to keep their pet archs/subarchs around as good community
> members, and they are in essence to:
>=20
> 1. Test and review/ack patches that others make

I'm trying. :)

> 2. Migrate existing drivers to newly appeared and
>     appropriate subsystems (I think there are some hacky heartbeat LED
>     drivers down in arch/* for example) there is also the feature matrix
>     core maintainers like and which appears if you type
>     Documentation/features/list-arch.sh <archname>
>     would be nice if you work on them if you can support them!
>     Or at least take a look.

For 3 years in the 1990's SuperH was the best-selling processor in the worl=
d,
and that's left the architecture with a bunch of legacy boards that aren't
easily available to us. I regression test a current kernel build under qemu
every month or two, and have portable USB-powered boards for the j-core stu=
ff.

When I did an sh4 porting contract in 2018 I got that board updated to a
current-ish kernel (3 versions back from then-current it hit some intermitt=
ent
nor flash filesystem corruption that only occurred intermittently under
sustained load; had to ship so I backed off one version and never tracked it
down). But these days I'm not always on the same continent as my two actual=
 sh4
hardware boards, have never gotten my physical sh2 board to boot, and $DAYJ=
OB is
all j-core stuff not sh4.

Testing that a basic superh system still builds and boots under qemu and j-=
core
I can commit to doing regularly. Testing specific hardware devices on board=
s I
don't regularly use is a lot harder.

> 3. Migrate old systems to use the
>    contemporary hardware descriptions (such as device tree or ACPI)
>    because it makes things so much easier to maintain. Some
>    upfront work, but a great win for everyone. Especially for
>    subsystem maintainers.

We did that one for our SOC. We haven't ported a lot of legacy boards becau=
se we
can't easily test most of them.

> And if your arch uses highmem then please get rid of highmem. I'm
> trying to do this a bit right now for ARM let's see how it goes.

I don't believe it does? (We haven't got any configs using it, anyway...)

> I understand that for some maintainers time is a factor and this list
> feels stressful. I'd say relax, but it'd be nice if you have a TODO that
> you cross items off of.

My todo list runneth over. One of our perpetual todo list items is "collate=
 todo
lists"...

> Just my =E2=82=AC0.01
> Linus Walleij

Rob
