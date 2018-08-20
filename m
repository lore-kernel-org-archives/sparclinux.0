From: Takashi Iwai <tiwai@suse.de>
Date: Mon, 20 Aug 2018 18:37:12 +0000
Subject: Re: due to kconfig changes kernel config file is no longer sufficient for configuring the kernel
Message-Id: <s5h6004hokn.wl-tiwai@suse.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20180627143705.5a1fed1c@kitsune.suse.cz>
        <CAK7LNARVPNx_uC5xTrS_p9T4nMRTC79BO51T4Lytv2eU1c-ynw@mail.gmail.com>
        <20180628111623.3807fe9b@naga.suse.cz>
        <CAK7LNARRKU7Mfa8ZBu1qPFYFRr-5k69sjVyERM2bYcnWoBDN8g@mail.gmail.com>
        <20180806200725.4efa5d35@kitsune.suse.cz>
        <CAK7LNATCktToMui4NYxoUXV8ZbuDK8F0JCp_CysEWaSBPUP7NQ@mail.gmail.com>
In-Reply-To: <CAK7LNATCktToMui4NYxoUXV8ZbuDK8F0JCp_CysEWaSBPUP7NQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andreas Schwab <schwab@suse.de>, Michal Kubecek <mkubecek@suse.cz>, Michal Marek <michal.lkml@markovi.net>, Jonathan Corbet <corbet@lwn.net>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>, Kees Cook <keescook@chromium.org>, Philippe Ombredanne <pombredanne@nexb.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ulf Magnusson <ulfalizer@gmail.com>, Jeff Mahoney <jeffm@suse.com>, "Peter Zijlstra," <peterz@infradead.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Frederic Weisbecker <frederic@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Dominik Brodowski <linux@dominikbrodowski.net>, Nicholas Piggin <npiggin@gmail.com>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, sparclinux <sparclinux@vger.kernel.org>, linux-um@lists.infradead.org

On Mon, 20 Aug 2018 20:15:12 +0200,
Masahiro Yamada wrote:
> 
> 2018-08-07 3:07 GMT+09:00 Michal Suchánek <msuchanek@suse.de>:
> > On Mon, 30 Jul 2018 17:02:42 +0900
> > Masahiro Yamada <yamada.masahiro@socionext.com> wrote:
> >
> >> 2018-06-28 18:16 GMT+09:00 Michal Suchánek <msuchanek@suse.de>:
> >> > On Wed, 27 Jun 2018 23:07:21 +0900
> >> > Masahiro Yamada <yamada.masahiro@socionext.com> wrote:
> >> >
> >> >> Hi.
> >> >>
> >> >>
> >> >> 2018-06-27 21:37 GMT+09:00 Michal Suchánek <msuchanek@suse.de>:
> >> >> > Hello,
> >> >> >
> >> >> > in the x86 Kconfig we have this:
> >> >> >
> >> >> > # Select 32 or 64 bit
> >> >> > config 64BIT
> >> >> >         bool "64-bit kernel" if "$(ARCH)" = "x86"
> >> >> >         default "$(ARCH)" != "i386"
> >> >> >         ---help---
> >> >> >           Say yes to build a 64-bit kernel - formerly known as
> >> >> > x86_64 Say no to build a 32-bit kernel - formerly known as i386
> >> >> >
> >> >> > Since commit 104daea149c4 ("kconfig: reference environment
> >> >> > variables directly and remove 'option env='") the value of ARCH
> >> >> > is not saved in the kernel config.
> >> >>
> >> >> I think this commit is unrelated.  It was just a syntax change.
> >> >
> >> > This does not look like syntax only change to me:
> >> >
> >> > diff --git a/init/Kconfig b/init/Kconfig
> >> > index 15aae32e0719..1217fc62ca61 100644
> >> > --- a/init/Kconfig
> >> > +++ b/init/Kconfig
> >> > @@ -1,20 +1,12 @@
> >> > -config ARCH
> >> > -       string
> >> > -       option env="ARCH"
> >> > -
> >> > -config KERNELVERSION
> >> > -       string
> >> > -       option env="KERNELVERSION"
> >> > -
> >>
> >> This is just syntax change.
> >>
> >> 'option env=' was used to reference an environment variable.
> >>
> >> Now, $(ARCH), $(KERNELVERSION) are simpler forms.
> >>
> >>
> >> >>
> >> >> Unless I am missing something,
> >> >> we have never saved ARCH in the .config in the past.
> >> >
> >> > There was a config symbol defined for it before the commit removed
> >> > it.
> >>
> >> No.
> >>
> >> CONFIG symbols with'option env='
> >> are not written out to the .config file.
> >>
> >> We have never had CONFIG_ARCH or CONFIG_KERNELVERSION.

Maybe it sounds like a stupid question, but...
if passing ARCH= is almost mandatory for distinguishing the bi-arch or
cross-compile cases, why don't we save it in .config?

The whole "regression" we've seen can be worked around by passing
ARCH at each time.  So, by having it in .config, everything would work
more easily, no?


thanks,

Takashi
