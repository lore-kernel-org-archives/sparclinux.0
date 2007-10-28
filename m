From: =?ISO-8859-1?Q?S=E9bastien_Bernard?= <seb@frankengul.org>
Date: Sun, 28 Oct 2007 13:38:57 +0000
Subject: Re: unkillable dpkg-query processes
Message-Id: <47249E82.4070301@frankengul.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20071024223332.GA24557@keid.carnet.hr>
In-Reply-To: <20071024223332.GA24557@keid.carnet.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Bernd Zeimetz a =E9crit :
> Hi,
>=20
> please note that the futex bug also happens on US II machines,
> it is jsut almost impossible to reproduce it - it'll just hang
> after random days of building.
>=20
>> Everyone who sees these UltraSPARC-III problems please send me PRECISE
>> and FULL description of how to install from scratch a machine and run
>> something that will trigger these errors.
>=20
> Can you please check if the Kernel config I've attached to one of my
> last mails is fine for you? The normal Debian installer doesn't
> boot on the US III machines which use two CPUs in one board as the
> installer's Kernel is a non-SMP Kernel, and the result is that the
> machine throws a CPU exception and needs to be power-cycled....
>=20
> I've started to investigate there with the help of a contact from
> Sun, but we both didn't have the time to finish this.
> http://bugs.debian.org/cgi-bin/bugreport.cgi?bugD0720 if you want
> to have a look, please ignore those troll postings from chealer
> in between...
>=20
> So to give you a recipe to install Debian on such a box, I need to
> build an installer with a SMP Kernel for you. If the config is fine
> for your needs, I could just use use it.
>=20
>=20
> The other option is to use debootstrap, if you have some system
> on the machine already - so if you want to use that instead of
> messing with a network installer, please let me know.
> Debootstrap should run on most systems, as long as they have
> ar/tar/gunzip and a bash (probably sh is enough...).
> Would be faster to use that, and faster to write a recipe for
> that.
>=20
> I'll mark all Qlogic firmware related points, so the recipe should
> work on machines with (v440, v880, probably the Enterprise models,
> too) and without FC (I guess the Blade 1000 and 2000).
>=20
>=20
> If you don't have access to an US-III machine, I can find a way
> to give you access to the RSC and serial console of our machine.
>=20
>=20
> Cheers,
>=20
> Bernd
>=20
Well, I got bitten twice with this bug.

First is on U60, unstable debian.
Since mono team decided that the mono is broken on Sparc (and despite
the fix provided by David Miller), I had to rebuild after enabling the sparc
arch in the source.

The hangs happens always at the end of the buid when invoking dh_shgenlibs =
in the build.

This is not 100% reproducable even in my env.

Second was sun blade 2000 SMP with Ubuntu gutsy, I wasn't able to update th=
e xemacs21 package.
The machine hanged with invoking the post installation script.

This is not really reproducable now that I upgraded the packages.

The mono build is, in my humble opinion, the most interesting track to catc=
h the bug.

	Seb
