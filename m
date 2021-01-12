From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 12 Jan 2021 22:46:04 +0000
Subject: Re: Old platforms: bring out your dead
Message-Id: <CACRpkda4E2NwNw29J7x5gehtqn_m3M_Z2dHpc7xRgvb0b-p22A@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <ef1dc21f-694b-2433-e1c6-aa121320173e@physik.fu-berlin.de>
 <f48bcf43-9dcc-e48b-d29d-f75f3814398b@gmx.net> <cb5a2e11-d423-96ec-3d43-3568a109e37f@physik.fu-berlin.de>
In-Reply-To: <cb5a2e11-d423-96ec-3d43-3568a109e37f@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Gerhard Pircher <gerhard_pircher@gmx.net>, Arnd Bergmann <arnd@arndb.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, Sparc kernel list <sparclinux@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

On Tue, Jan 12, 2021 at 3:45 PM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:

> Yeah, I have the same impression that's the strong commercial interest pu=
shes
> hobbyist use of the Linux kernel a bit down. A lot of these changes feel =
like
> they're motivated by corporate decisions.
>
> There has to be a healthy balance between hobbyist and commercial use. I =
understand
> that from a commercial point of view, it doesn't make much sense to run L=
inux
> on a 30-year-old computer. But it's a hobbyist project for many people an=
d hacking
> Linux stuff for these old machines has a very entertaining and educationa=
l factor.

This is actually one of the most interesting things written in this discuss=
ion.

I have both revamped and deleted subarchitectures in the ARM tree. We
never deleted anyone's pet project *unless* they were clearly unwilling to
work on it (such as simply testning new patches) and agreed that it will
not go on.

At multiple occasions I actually found it easier to fix stuff than
delete it, both because it is a nicer thing to do and because it
simply creates less social problems, often to the point that the time
(man hours) spent trying to solve the resulting social problems from
deleting a platform would be longer than the time spent actually acquiring
the physical platform and fixing it.

Corporate entities can be a bit deletionist (using Wikipedia terminology)
and as in this thread there is always a strong inclusionist stance pushing
back to that.

The explanation is in my mind very simply that running Linux
on a 35-yo or so Amiga, Atari or Apollo Workstation is pretty impressive and
fun. And I think that fits Mr. Torvalds own sociological-or-something
explanation in the autobiographical "Just for fun" as to why to write it
in the first place. And we are very protective of that quality of the
kernel. (At least I am.)

That said there are a three things that people should really be doing if th=
ey
want to keep their pet archs/subarchs around as good community
members, and they are in essence to:

1. Test and review/ack patches that others make

2. Migrate existing drivers to newly appeared and
    appropriate subsystems (I think there are some hacky heartbeat LED
    drivers down in arch/* for example) there is also the feature matrix
    core maintainers like and which appears if you type
    Documentation/features/list-arch.sh <archname>
    would be nice if you work on them if you can support them!
    Or at least take a look.

3. Migrate old systems to use the
   contemporary hardware descriptions (such as device tree or ACPI)
   because it makes things so much easier to maintain. Some
   upfront work, but a great win for everyone. Especially for
   subsystem maintainers.

And if your arch uses highmem then please get rid of highmem. I'm
trying to do this a bit right now for ARM let's see how it goes.

I understand that for some maintainers time is a factor and this list
feels stressful. I'd say relax, but it'd be nice if you have a TODO that
you cross items off of.

Just my =E2=82=AC0.01
Linus Walleij
