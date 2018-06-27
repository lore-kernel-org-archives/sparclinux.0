From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Wed, 27 Jun 2018 14:07:21 +0000
Subject: Re: due to kconfig changes kernel config file is no longer sufficient for configuring the kernel
Message-Id: <CAK7LNARVPNx_uC5xTrS_p9T4nMRTC79BO51T4Lytv2eU1c-ynw@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20180627143705.5a1fed1c@kitsune.suse.cz>
In-Reply-To: <20180627143705.5a1fed1c@kitsune.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.de>, Andreas Schwab <schwab@suse.de>, Michal Kubecek <mkubecek@suse.cz>, Michal Marek <michal.lkml@markovi.net>, Jonathan Corbet <corbet@lwn.net>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>, Kees Cook <keescook@chromium.org>, Philippe Ombredanne <pombredanne@nexb.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ulf Magnusson <ulfalizer@gmail.com>, Jeff Mahoney <jeffm@suse.com>, "Peter Zijlstra," <peterz@infradead.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Frederic Weisbecker <frederic@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Dominik Brodowski <linux@dominikbrodowski.net>, Nicholas Piggin <npiggin@gmail.com>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, sparclinux <sparclinux@vger.kernel.org>, linux-um@lists.infradead.org

Hi.


2018-06-27 21:37 GMT+09:00 Michal Such=C3=A1nek <msuchanek@suse.de>:
> Hello,
>
> in the x86 Kconfig we have this:
>
> # Select 32 or 64 bit
> config 64BIT
>         bool "64-bit kernel" if "$(ARCH)" =3D "x86"
>         default "$(ARCH)" !=3D "i386"
>         ---help---
>           Say yes to build a 64-bit kernel - formerly known as x86_64
>           Say no to build a 32-bit kernel - formerly known as i386
>
> Since commit 104daea149c4 ("kconfig: reference environment variables
> directly and remove 'option env=3D'") the value of ARCH is not saved in
> the kernel config.

I think this commit is unrelated.  It was just a syntax change.

Unless I am missing something,
we have never saved ARCH in the .config in the past.


> Since commit f467c5640c29 ("kconfig: only write '#
> CONFIG_FOO is not set' for visible symbols") the value of 64BIT is not
> saved if the ARCH is set i386 or x86_64 because the symbol is not
> visible.

This is correct.

It was discussed a few weeks ago.

https://lkml.org/lkml/2018/6/5/847


> There is a number of ways to hack this particular case to work.
>
> However, there is a more general problem with this. Some config options
> may depend on the environment, may not be saved, and the environment is
> not saved either.

Which environment variables in particular are in your mind?

As for ARCH, you need to pass the same ARCH as you used for building the ke=
rnel.
(For native building, you do not have to pass ARCH explicitly, though.)

As for CC, HOSTCC, etc.
yes, these are new 'unsaved' environments.

CONFIG options now depend on the compiler.
This is the concept suggested by Linus Torvalds.


> So in the end all the infrastructure with symlinks
> from module directory pointing to the kernel source and object
> directory is useless. To interpret the config stored there you need the
> environment and that is not saved anywhere. So if you try to build
> out-of-tree module it might end up reconfiguring your kernel and
> producing useless modules.

No. out-of-tree module building never ever re-configures the kernel.

out-of-tree modules are built with exactly the same configuration
as used for the kernel.


There is one more assumption here.

Greg-KH said:
  We don't ever support the system of loading a module built with anything
  other than the _exact_ same compiler than the kernel was.

(https://lkml.org/lkml/2017/10/4/496)



Based on that statement,
CONFIG options depending on 'CC' are valid for out-of-tree modules as well.




> Is there any plan to fix this?
>
> Thanks
>
> Michal
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
Best Regards
Masahiro Yamada
