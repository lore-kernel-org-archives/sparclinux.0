From: Michal Kubecek <mkubecek@suse.cz>
Date: Mon, 06 Aug 2018 18:33:29 +0000
Subject: Re: due to kconfig changes kernel config file is no longer sufficient for configuring the kernel
Message-Id: <20180806183329.qditzzemevdafcwb@unicorn.suse.cz>
List-Id: <sparclinux.vger.kernel.org>
References: <20180627143705.5a1fed1c@kitsune.suse.cz>
 <CAK7LNARVPNx_uC5xTrS_p9T4nMRTC79BO51T4Lytv2eU1c-ynw@mail.gmail.com>
 <20180628111623.3807fe9b@naga.suse.cz>
 <CAK7LNARRKU7Mfa8ZBu1qPFYFRr-5k69sjVyERM2bYcnWoBDN8g@mail.gmail.com>
In-Reply-To: <CAK7LNARRKU7Mfa8ZBu1qPFYFRr-5k69sjVyERM2bYcnWoBDN8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.de>, Andreas Schwab <schwab@suse.de>, Michal Marek <michal.lkml@markovi.net>, Jonathan Corbet <corbet@lwn.net>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>, Kees Cook <keescook@chromium.org>, Philippe Ombredanne <pombredanne@nexb.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ulf Magnusson <ulfalizer@gmail.com>, Jeff Mahoney <jeffm@suse.com>, "Peter Zijlstra," <peterz@infradead.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Frederic Weisbecker <frederic@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Dominik Brodowski <linux@dominikbrodowski.net>, Nicholas Piggin <npiggin@gmail.com>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, sparclinux <sparclinux@vger.kernel.org>, linux-um@lists.infradead.org

On Mon, Jul 30, 2018 at 05:02:42PM +0900, Masahiro Yamada wrote:
> 
> For exmaple 'make ARCH=arm config' will create the config suitable
> only for ARM architecture.
> Then, you need to do 'make ARCH=arm' to build the kernel.
> 
> If it is tedious to give 'ARCH=arm' to every make command,
> you can do 'export ARCH=arm' in your shell.
> 
> Again, this is the behavior we have for a long time.

Actually, this no longer works reliably. For example, when I run

  ARCH=powerpc make oldconfig

with our ppc64le config on x86_64 system, I get different result than
when I run it on an actual ppc64le system (or when using a ppc64le cross
compiler on x86_64).

Since .config started to mix user configuration and build environment
capabilities, maintaining distribution configs became real pain. And
it's getting progressively worse.

Michal Kubecek

