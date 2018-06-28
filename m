From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Date: Thu, 28 Jun 2018 09:16:23 +0000
Subject: Re: due to kconfig changes kernel config file is no longer sufficient for configuring the kernel
Message-Id: <20180628111623.3807fe9b@naga.suse.cz>
List-Id: <sparclinux.vger.kernel.org>
References: <20180627143705.5a1fed1c@kitsune.suse.cz>
        <CAK7LNARVPNx_uC5xTrS_p9T4nMRTC79BO51T4Lytv2eU1c-ynw@mail.gmail.com>
In-Reply-To: <CAK7LNARVPNx_uC5xTrS_p9T4nMRTC79BO51T4Lytv2eU1c-ynw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.de>, Andreas Schwab <schwab@suse.de>, Michal Kubecek <mkubecek@suse.cz>, Michal Marek <michal.lkml@markovi.net>, Jonathan Corbet <corbet@lwn.net>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>, Kees Cook <keescook@chromium.org>, Philippe Ombredanne <pombredanne@nexb.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ulf Magnusson <ulfalizer@gmail.com>, Jeff Mahoney <jeffm@suse.com>, "Peter Zijlstra," <peterz@infradead.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Frederic Weisbecker <frederic@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Dominik Brodowski <linux@dominikbrodowski.net>, Nicholas Piggin <npiggin@gmail.com>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, sparclinux <sparclinux@vger.kernel.org>, linux-um@lists.infradead.org

On Wed, 27 Jun 2018 23:07:21 +0900
Masahiro Yamada <yamada.masahiro@socionext.com> wrote:

> Hi.
>=20
>=20
> 2018-06-27 21:37 GMT+09:00 Michal Such=C3=A1nek <msuchanek@suse.de>:
> > Hello,
> >
> > in the x86 Kconfig we have this:
> >
> > # Select 32 or 64 bit
> > config 64BIT
> >         bool "64-bit kernel" if "$(ARCH)" =3D "x86"
> >         default "$(ARCH)" !=3D "i386"
> >         ---help---
> >           Say yes to build a 64-bit kernel - formerly known as
> > x86_64 Say no to build a 32-bit kernel - formerly known as i386
> >
> > Since commit 104daea149c4 ("kconfig: reference environment variables
> > directly and remove 'option env=3D'") the value of ARCH is not saved
> > in the kernel config. =20
>=20
> I think this commit is unrelated.  It was just a syntax change.

This does not look like syntax only change to me:

diff --git a/init/Kconfig b/init/Kconfig
index 15aae32e0719..1217fc62ca61 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1,20 +1,12 @@
-config ARCH
-       string
-       option env=3D"ARCH"
-
-config KERNELVERSION
-       string
-       option env=3D"KERNELVERSION"
-

>=20
> Unless I am missing something,
> we have never saved ARCH in the .config in the past.

There was a config symbol defined for it before the commit removed it.

>=20
>=20
> > Since commit f467c5640c29 ("kconfig: only write '#
> > CONFIG_FOO is not set' for visible symbols") the value of 64BIT is
> > not saved if the ARCH is set i386 or x86_64 because the symbol is
> > not visible. =20
>=20
> This is correct.
>=20
> It was discussed a few weeks ago.
>=20
> https://lkml.org/lkml/2018/6/5/847
>=20
>=20
> > There is a number of ways to hack this particular case to work.
> >
> > However, there is a more general problem with this. Some config
> > options may depend on the environment, may not be saved, and the
> > environment is not saved either. =20
>=20
> Which environment variables in particular are in your mind?

Any that is used in Kconfig.

>=20
> As for ARCH, you need to pass the same ARCH as you used for building
> the kernel. (For native building, you do not have to pass ARCH
> explicitly, though.)

Except if you do pass it to make config you may need to pass it to to
make later as well.

>=20
> As for CC, HOSTCC, etc.
> yes, these are new 'unsaved' environments.
>=20
> CONFIG options now depend on the compiler.
> This is the concept suggested by Linus Torvalds.
>=20
>=20
> > So in the end all the infrastructure with symlinks
> > from module directory pointing to the kernel source and object
> > directory is useless. To interpret the config stored there you need
> > the environment and that is not saved anywhere. So if you try to
> > build out-of-tree module it might end up reconfiguring your kernel
> > and producing useless modules. =20
>=20
> No. out-of-tree module building never ever re-configures the kernel.

It does implicitly because the config values depend on environment that
is not saved and the values themselves are not saved either. If that
happens to expose a new variable it is even explicitly reconfigured.

>=20
> out-of-tree modules are built with exactly the same configuration
> as used for the kernel.

It is not true. And that is the problem. You need the config file and
dump of the environment passed to the make command at configuration
time to get the exact same configuration. The environment is not saved
anywhere, though.

Thanks

Michal
