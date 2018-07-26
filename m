From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Date: Thu, 26 Jul 2018 08:33:54 +0000
Subject: Re: due to kconfig changes kernel config file is no longer sufficient for configuring the kernel
Message-Id: <20180726103354.111f2d61@naga.suse.cz>
List-Id: <sparclinux.vger.kernel.org>
References: <20180627143705.5a1fed1c@kitsune.suse.cz>
        <CAK7LNARVPNx_uC5xTrS_p9T4nMRTC79BO51T4Lytv2eU1c-ynw@mail.gmail.com>
        <20180628111623.3807fe9b@naga.suse.cz>
In-Reply-To: <20180628111623.3807fe9b@naga.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.de>, Andreas Schwab <schwab@suse.de>, Michal Kubecek <mkubecek@suse.cz>, Michal Marek <michal.lkml@markovi.net>, Jonathan Corbet <corbet@lwn.net>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>, Kees Cook <keescook@chromium.org>, Philippe Ombredanne <pombredanne@nexb.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ulf Magnusson <ulfalizer@gmail.com>, Jeff Mahoney <jeffm@suse.com>, "Peter Zijlstra," <peterz@infradead.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Frederic Weisbecker <frederic@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Dominik Brodowski <linux@dominikbrodowski.net>, Nicholas Piggin <npiggin@gmail.com>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, sparclinux <sparclinux@vger.kernel.org>, linux-um@lists.infradead.org, jslaby@suse.com

On Thu, 28 Jun 2018 11:16:23 +0200
Michal Suchánek <msuchanek@suse.de> wrote:

> On Wed, 27 Jun 2018 23:07:21 +0900
> Masahiro Yamada <yamada.masahiro@socionext.com> wrote:
> 
> > Hi.
> > 
> > 
> > 2018-06-27 21:37 GMT+09:00 Michal Suchánek <msuchanek@suse.de>:  
> > > Hello,
> > >
> > > in the x86 Kconfig we have this:
> > >
> > > # Select 32 or 64 bit
> > > config 64BIT
> > >         bool "64-bit kernel" if "$(ARCH)" = "x86"
> > >         default "$(ARCH)" != "i386"
> > >         ---help---
> > >           Say yes to build a 64-bit kernel - formerly known as
> > > x86_64 Say no to build a 32-bit kernel - formerly known as i386
> > >
> > > Since commit 104daea149c4 ("kconfig: reference environment
> > > variables directly and remove 'option env='") the value of ARCH
> > > is not saved in the kernel config.    
> > 
> > I think this commit is unrelated.  It was just a syntax change.  
> 
> This does not look like syntax only change to me:
> 
> diff --git a/init/Kconfig b/init/Kconfig
> index 15aae32e0719..1217fc62ca61 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1,20 +1,12 @@
> -config ARCH
> -       string
> -       option env="ARCH"
> -
> -config KERNELVERSION
> -       string
> -       option env="KERNELVERSION"
> -
> 
> > 
> > Unless I am missing something,
> > we have never saved ARCH in the .config in the past.  
> 
> There was a config symbol defined for it before the commit removed it.

nonetheless its value was not saved anyway.
> 
> > 
> >   
> > > Since commit f467c5640c29 ("kconfig: only write '#
> > > CONFIG_FOO is not set' for visible symbols") the value of 64BIT is
> > > not saved if the ARCH is set i386 or x86_64 because the symbol is
> > > not visible.    
> > 
> > This is correct.
> > 
> > It was discussed a few weeks ago.
> > 
> > https://lkml.org/lkml/2018/6/5/847

And it went nowhere.

Anyway, the observed issue with CONFIG_64BIT on x86 is the tip of a
larger problem which was unnoticed for ages. The .config simply does
not contain the whole kernel configuration. ie. make oldconfig (and
make syncconfig) is *not* expected to just work. It used to work just by
luck until f467c5640c29 ("kconfig: only write '# CONFIG_FOO is not set'
for visible symbols") finally exposed the problem.

So is .config supposed to contain the kernel configuration or is it
just some byproduct of the kernel build which is meaningless outside of
your build environment (the object tree, shell environment, etc).

Thanks

Michal
