From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 05 Jan 2009 13:29:16 +0000
Subject: irqnr fallout in gpiolib on sparc32
Message-Id: <20090105132916.GA10545@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ingo Molnar <mingo@elte.hu>, KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>, Yinghai Lu <yinghai@kernel.org>, LKML <linux-kernel@vger.kernel.org>, sparclinux <sparclinux@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>

I hit the following build error on sparc:

drivers/gpio/gpiolib.c: In function `gpiolib_dbg_show':
drivers/gpio/gpiolib.c:1146: error: implicit declaration of function `irq_to_desc'
drivers/gpio/gpiolib.c:1146: warning: initialization makes pointer from integer without a cast


This is with an allmodconfig where I did:

make ARCH=sparc vmlinux

sparc do _not_ have GENERIC_HARDIRQS set to 'y'.

I did a simple:
#include <linux/irqnr.h> but that did not help.

I have not investigated further atm.

It is preproduceable with HEAD equal fe0bdec68b77020281dc814805edfe594ae89e0f
[latest -linus when writing this]

	Sam

