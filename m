From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Date: Mon, 06 Aug 2018 18:07:25 +0000
Subject: Re: due to kconfig changes kernel config file is no longer sufficient for configuring the kernel
Message-Id: <20180806200725.4efa5d35@kitsune.suse.cz>
List-Id: <sparclinux.vger.kernel.org>
References: <20180627143705.5a1fed1c@kitsune.suse.cz>
        <CAK7LNARVPNx_uC5xTrS_p9T4nMRTC79BO51T4Lytv2eU1c-ynw@mail.gmail.com>
        <20180628111623.3807fe9b@naga.suse.cz>
        <CAK7LNARRKU7Mfa8ZBu1qPFYFRr-5k69sjVyERM2bYcnWoBDN8g@mail.gmail.com>
In-Reply-To: <CAK7LNARRKU7Mfa8ZBu1qPFYFRr-5k69sjVyERM2bYcnWoBDN8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.de>, Andreas Schwab <schwab@suse.de>, Michal Kubecek <mkubecek@suse.cz>, Michal Marek <michal.lkml@markovi.net>, Jonathan Corbet <corbet@lwn.net>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>, Kees Cook <keescook@chromium.org>, Philippe Ombredanne <pombredanne@nexb.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ulf Magnusson <ulfalizer@gmail.com>, Jeff Mahoney <jeffm@suse.com>, "Peter Zijlstra," <peterz@infradead.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Frederic Weisbecker <frederic@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Dominik Brodowski <linux@dominikbrodowski.net>, Nicholas Piggin <npiggin@gmail.com>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, sparclinux <sparclinux@vger.kernel.org>, linux-um@lists.infradead.org

On Mon, 30 Jul 2018 17:02:42 +0900
Masahiro Yamada <yamada.masahiro@socionext.com> wrote:

> 2018-06-28 18:16 GMT+09:00 Michal Suchánek <msuchanek@suse.de>:
> > On Wed, 27 Jun 2018 23:07:21 +0900
> > Masahiro Yamada <yamada.masahiro@socionext.com> wrote:
> >  
> >> Hi.
> >>
> >>
> >> 2018-06-27 21:37 GMT+09:00 Michal Suchánek <msuchanek@suse.de>:  
> >> > Hello,
> >> >
> >> > in the x86 Kconfig we have this:
> >> >
> >> > # Select 32 or 64 bit
> >> > config 64BIT
> >> >         bool "64-bit kernel" if "$(ARCH)" = "x86"
> >> >         default "$(ARCH)" != "i386"
> >> >         ---help---
> >> >           Say yes to build a 64-bit kernel - formerly known as
> >> > x86_64 Say no to build a 32-bit kernel - formerly known as i386
> >> >
> >> > Since commit 104daea149c4 ("kconfig: reference environment
> >> > variables directly and remove 'option env='") the value of ARCH
> >> > is not saved in the kernel config.  
> >>
> >> I think this commit is unrelated.  It was just a syntax change.  
> >
> > This does not look like syntax only change to me:
> >
> > diff --git a/init/Kconfig b/init/Kconfig
> > index 15aae32e0719..1217fc62ca61 100644
> > --- a/init/Kconfig
> > +++ b/init/Kconfig
> > @@ -1,20 +1,12 @@
> > -config ARCH
> > -       string
> > -       option env="ARCH"
> > -
> > -config KERNELVERSION
> > -       string
> > -       option env="KERNELVERSION"
> > -  
> 
> This is just syntax change.
> 
> 'option env=' was used to reference an environment variable.
> 
> Now, $(ARCH), $(KERNELVERSION) are simpler forms.
> 
> 
> >>
> >> Unless I am missing something,
> >> we have never saved ARCH in the .config in the past.  
> >
> > There was a config symbol defined for it before the commit removed
> > it.  
> 
> No.
> 
> CONFIG symbols with'option env='
> are not written out to the .config file.
> 
> We have never had CONFIG_ARCH or CONFIG_KERNELVERSION.
> 
> 
> 
> 
> >>
> >>  
> >> > Since commit f467c5640c29 ("kconfig: only write '#
> >> > CONFIG_FOO is not set' for visible symbols") the value of 64BIT
> >> > is not saved if the ARCH is set i386 or x86_64 because the
> >> > symbol is not visible.  
> >>
> >> This is correct.
> >>
> >> It was discussed a few weeks ago.
> >>
> >> https://lkml.org/lkml/2018/6/5/847
> >>
> >>  
> >> > There is a number of ways to hack this particular case to work.
> >> >
> >> > However, there is a more general problem with this. Some config
> >> > options may depend on the environment, may not be saved, and the
> >> > environment is not saved either.  
> >>
> >> Which environment variables in particular are in your mind?  
> >
> > Any that is used in Kconfig.  
> 
> They are provided from outside of Kconfig.
> This is the behavior we keep since a long time ago.
> 
> ARCH is given by the environment variable or the command line.
> KERNELVERSION is supplied by the top Makefile.
> 
> >>
> >> As for ARCH, you need to pass the same ARCH as you used for
> >> building the kernel. (For native building, you do not have to pass
> >> ARCH explicitly, though.)  
> >
> > Except if you do pass it to make config you may need to pass it to
> > to make later as well.  
> 
> Right.
> 
> For exmaple 'make ARCH=arm config' will create the config suitable
> only for ARM architecture.
> Then, you need to do 'make ARCH=arm' to build the kernel.
> 
> If it is tedious to give 'ARCH=arm' to every make command,
> you can do 'export ARCH=arm' in your shell.
> 
> Again, this is the behavior we have for a long time.

No, that's not what we had. The kernel build would fail instead of
reconfiguring the kernel for the current arch. At least it used to work
that way at some point.

> 
> 
> 
> >>
> >> As for CC, HOSTCC, etc.
> >> yes, these are new 'unsaved' environments.
> >>
> >> CONFIG options now depend on the compiler.
> >> This is the concept suggested by Linus Torvalds.
> >>
> >>  
> >> > So in the end all the infrastructure with symlinks
> >> > from module directory pointing to the kernel source and object
> >> > directory is useless. To interpret the config stored there you
> >> > need the environment and that is not saved anywhere. So if you
> >> > try to build out-of-tree module it might end up reconfiguring
> >> > your kernel and producing useless modules.  
> >>
> >> No. out-of-tree module building never ever re-configures the
> >> kernel.  
> >
> > It does implicitly because the config values depend on environment
> > that is not saved and the values themselves are not saved either.
> > If that happens to expose a new variable it is even explicitly
> > reconfigured.  
> 
> 
> You should have a built kernel tree
> before building external modules.
> 
> The .config is already there.
> 
> The .config works for external modules, given that
> 
>   - ARCH is the same
>   - the compiler is the same

 - the compiler additional plugins and/or external libraries used to
   implement advanced features are the same

> 
> 
> 
> >>
> >> out-of-tree modules are built with exactly the same configuration
> >> as used for the kernel.  
> >
> > It is not true. And that is the problem. You need the config file
> > and dump of the environment passed to the make command at
> > configuration time to get the exact same configuration. The
> > environment is not saved anywhere, though.  
> 
> 
> Why dump of the environment?
> 
> 
> If you are building external modules natively
> your distribution provides /lib/modules/$(uname -r)/build,
> which contains files enough for building external modules.
> 
> You can pass the directory path to M=... parameter.  That's it.

No, that's not it. Since passing ARCH=i386 is the de-facto standard to
configure a 32bit kernel and the result of passing that was not saved
you need to pass it to make as well. And you need to patch a number of
3rd party build scripts that build a kernel module as part of a bigger
project.

> 
> 
> 
> If you are cross-building external modules,
> you also need to
> 
>  - pass ARCH>  - use the same compiler with CROSS_COMPILE> 
> You should know both
> because you have built the kernel by your self.

No, I am not cross-compiling. I am building 32bit modules and because
the kconfig system did not save the information that the kernel is
32bit I get 64bit modules instead.

> 
> You do not need any other information, do you?

I need the information what ARCH was passed to the x86 kernel at
configuration time when building on x86. This is new.

To avoid this and similar surprises in the future I suggest to flag any
option that depends on something dynamic (compiler option, environment
variable) so that kconfig saves it even if it would not be saved
otherwise.

Then kconfig can do whatever seems sensible for oldconfig but
syncconfig should not change any options based on dynamic input. It
should verify that the option matches (ie compiler can accept -foobar
if the option is on and defaults to cc-option -foobar) and fail if it
does not.


> 
> > And it went nowhere.
> >
> > Anyway, the observed issue with CONFIG_64BIT on x86 is the tip of a
> > larger problem which was unnoticed for ages. The .config simply does
> > not contain the whole kernel configuration. ie. make oldconfig (and
> > make syncconfig) is *not* expected to just work. It used to work
> > just by luck until f467c5640c29 ("kconfig: only write '# CONFIG_FOO
> > is not set' for visible symbols") finally exposed the problem.  
> 
> If you want to build the kernel for an architecture
> other than the host machine architecture, you need to pass ARCH=.
> 
> Building the i386 kernel on a x86_64 machine, it is a _kind_ of
> cross-compiling. So, passing ARCH=i386 is not so weird.
> 
> 
> > So is .config supposed to contain the kernel configuration or is it
> > just some byproduct of the kernel build which is meaningless
> > outside of your build environment (the object tree, shell
> > environment, etc).  
> 
> The .config is supposed to contain the kernel configuration,
> 'ARCH' and the compiler are exceptions.
> 
> 'ARCH' must be passed separately.
> 
> The .config now depends on the compiler.  So, if you pass your .config
> to somebody else, some symbols that depend on the compiler support
> might be configured differently.
> 
> 'make syncconfig' will notice the compiler difference,
> and show prompts for user input as needed.

It should not prompt. I want to build the kernel non-interactively. I
do not want kernel rpm build to wait for user input or silently
change the kernel ABI just because I installed a new gcc plugin. 

Thanks

Michal
