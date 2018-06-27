From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Date: Wed, 27 Jun 2018 12:37:05 +0000
Subject: due to kconfig changes kernel config file is no longer sufficient for configuring the kernel
Message-Id: <20180627143705.5a1fed1c@kitsune.suse.cz>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>, Andreas Schwab <schwab@suse.de>, Michal Kubecek <mkubecek@suse.cz>, Masahiro Yamada <yamada.masahiro@socionext.com>, Michal Marek <michal.lkml@markovi.net>, Jonathan Corbet <corbet@lwn.net>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Kees Cook <keescook@chromium.org>, Philippe Ombredanne <pombredanne@nexb.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ulf Magnusson <ulfalizer@gmail.com>, Jeff Mahoney <jeffm@suse.com>, "Peter Zijlstra," <peterz@infradead.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Frederic Weisbecker <frederic@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Dominik Brodowski <linux@dominikbrodowski.net>, Nicholas Piggin <npiggin@gmail.com>, linux-kbuild@vger.kernel.org, linux-doc@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>

Hello,

in the x86 Kconfig we have this:

# Select 32 or 64 bit
config 64BIT
        bool "64-bit kernel" if "$(ARCH)" = "x86"
        default "$(ARCH)" != "i386"
        ---help---
          Say yes to build a 64-bit kernel - formerly known as x86_64
          Say no to build a 32-bit kernel - formerly known as i386

Since commit 104daea149c4 ("kconfig: reference environment variables
directly and remove 'option env='") the value of ARCH is not saved in
the kernel config. Since commit f467c5640c29 ("kconfig: only write '#
CONFIG_FOO is not set' for visible symbols") the value of 64BIT is not
saved if the ARCH is set i386 or x86_64 because the symbol is not
visible.

There is a number of ways to hack this particular case to work.

However, there is a more general problem with this. Some config options
may depend on the environment, may not be saved, and the environment is
not saved either. So in the end all the infrastructure with symlinks
from module directory pointing to the kernel source and object
directory is useless. To interpret the config stored there you need the
environment and that is not saved anywhere. So if you try to build
out-of-tree module it might end up reconfiguring your kernel and
producing useless modules.

Is there any plan to fix this?

Thanks

Michal
