From: "David S. Miller" <davem@redhat.com>
Date: Tue, 06 Jan 2004 00:19:40 +0000
Subject: Re: [PATCH] missing module_init & module_exit (a mystery?)
Message-Id: <20040105161940.72e62791.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1073343430.22653.318.camel@zorak>
In-Reply-To: <1073343430.22653.318.camel@zorak>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, 05 Jan 2004 16:57:11 -0600
"Tom 'spot' Callaway" <tcallawa@redhat.com> wrote:

> When I tried to build drivers/media/dvb/ttusb-dec/ttusb_dec.c in the 2.6
> kernel tree, it failed, because it couldn't find the definitions of
> module_init and module_exit, found in linux/init.h.

Fixed in 2.6.1-rc1 by adding the appropriate linux/init.h include to the
driver.

> ttusb_dec.c includes linux/interrupt.h, which includes asm/hardirq.h. On
> many of the architectures (h8300, i386, ia64, mips, ppc, sh, x86_64),
> hardirq.h includes linux/irq.h, which includes asm/hw_irq.h. On a subset
> of the previously listed architectures (i386, ia64, mips, x86_64),
> asm/hw_irq.h includes linux/profile.h, which includes linux/init.h.

That's right, and there is no reason such an obscure IRQ arch include
should be required to include linux/init.h, it belongs in the drivers that
make use of the facilities in that header file.

