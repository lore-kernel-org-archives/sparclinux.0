From: Andrew Morton <akpm@linux-foundation.org>
Date: Tue, 18 Sep 2007 21:05:08 +0000
Subject: Re: 2.6.23-rc6-mm1 sparc build error
Message-Id: <20070918140508.e2c56212.akpm@linux-foundation.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20070918011841.2381bd93.akpm@linux-foundation.org>
	<20070918205403.GA13650@Krystal>
In-Reply-To: <20070918205403.GA13650@Krystal>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Cc: linux-kernel@vger.kernel.org, wli@holomorphy.com, sparclinux@vger.kernel.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Dmitry Torokhov <dtor@mail.ru>

On Tue, 18 Sep 2007 16:54:03 -0400
Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca> wrote:

> I got the following error when building 2.6.23-rc6-mm1 on sparc:
> 
> 
>   /opt/crosstool/gcc-4.1.1-glibc-2.3.6/sparc-unknown-linux-gnu/bin/sparc-unknown-linux-gnu-gcc -Wp,-MD,drivers/serial/.serial_core.o.d  -nostdinc -isystem /opt/crosstool/gcc-4.1.1-glibc-2.3.6/sparc-unknown-linux-gnu/lib/gcc/sparc-unknown-linux-gnu/4.1.1/include -D__KERNEL__ -Iinclude -Iinclude2 -I/home/compudj/git/linux-2.6-lttng/include -include include/linux/autoconf.h  -I/home/compudj/git/linux-2.6-lttng/drivers/serial -Idrivers/serial -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -Werror-implicit-function-declaration -Os -m32 -pipe -mno-fpu -fcall-used-g5 -fcall-used-g7 -fomit-frame-pointer -fno-stack-protector -Wdeclaration-after-statement -Wno-pointer-sign  -D"KBUILD_STR(s)=#s" -D"KBUILD_BASENAME=KBUILD_STR(serial_core)"  -D"KBUILD_MODNAME=KBUILD_STR(serial_core)" -c -o drivers/serial/.tmp_serial_core.o /home/compudj/git/linux-2.6-lttng/drivers/serial/serial_core.c
> /home/compudj/git/linux-2.6-lttng/drivers/serial/serial_core.c: In function 'uart_suspend_port':
> /home/compudj/git/linux-2.6-lttng/drivers/serial/serial_core.c:1980: error: implicit declaration of function 'enable_irq_wake'
> /home/compudj/git/linux-2.6-lttng/drivers/serial/serial_core.c: In function 'uart_resume_port':
> /home/compudj/git/linux-2.6-lttng/drivers/serial/serial_core.c:2035: error: implicit declaration of function 'disable_irq_wake'

hm, I wonder why I didn't hit that.

enable_irq_wake() was added by wake-up-from-a-serial-port.patch

I note that git-input adds a call too, and might have a problem
with !CONFIG_GENERIC_HARDIRQS.

Not sure what the best fix is here.  We could sprinkle ifdefs all
over the code, or just add the suitable empty stubs for enable_irq_wake(),
etc.
