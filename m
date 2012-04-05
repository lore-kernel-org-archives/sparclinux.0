From: Thomas Gleixner <tglx@linutronix.de>
Date: Thu, 05 Apr 2012 08:43:12 +0000
Subject: Re: [PATCH] irq: remove obsolete definitions in interrupt.h
Message-Id: <alpine.LFD.2.02.1204051036470.2542@ionos>
List-Id: <sparclinux.vger.kernel.org>
References: <20120404074553.GA14959@merkur.ravnborg.org>
In-Reply-To: <20120404074553.GA14959@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sam Ravnborg <sam@ravnborg.org>
Cc: lkml <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@vger.kernel.org, Greg Ungerer <gerg@uclinux.org>, sparclinux <sparclinux@vger.kernel.org>

On Wed, 4 Apr 2012, Sam Ravnborg wrote:

> interrupt.h contained a small fixlet for the days when
> m68k and sparc32 did not use genirq.
> As they have both entered the modern world this
> fixlet can be dropped.

You forgot that there is still an esoteric architecture which has
CONFIG_GENERIC_HARDIRQS=n.

So at least the exit_irq_thread() needs to stay.

The request_threaded_irq() one should not be used by any S390
driver. If it's used, they have probably a special opcode for it. :)

Thanks,

	tglx

 
