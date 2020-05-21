From: Al Viro <viro@zeniv.linux.org.uk>
Date: Thu, 21 May 2020 20:23:50 +0000
Subject: Re: [PATCH 0/3] sparc: port to copy_thread_tls() and struct kernel_clone_args
Message-Id: <20200521202350.GI23230@ZenIV.linux.org.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <20200512171527.570109-1-christian.brauner@ubuntu.com>
In-Reply-To: <20200512171527.570109-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, May 21, 2020 at 08:42:34PM +0100, Mark Cave-Ayland wrote:

> > Can you tell me a bit more about the host in terms of CPU and disk to help figure out
> > what's going on?

phenom II X6 1100T (6-way 3.3GHz), 8Gb RAM (4Gb given to guest), WDC WD10EACS-00D
disk (hdparm -tT gives
 Timing cached reads:   6988 MB in  2.00 seconds = 3494.96 MB/sec
 Timing buffered disk reads: 280 MB in  3.02 seconds =  92.75 MB/sec
)

> One other thought I had is that somehow the IVEC IRQs are managing to be overwritten
> on a faster host before being read by the guest. Does the following patch display the
> FATAL message at the point where things hang?

> diff --git a/hw/pci-host/sabre.c b/hw/pci-host/sabre.c
> index fae20ee97c..618ebd1300 100644
> --- a/hw/pci-host/sabre.c
> +++ b/hw/pci-host/sabre.c
> @@ -63,6 +63,9 @@
>  static inline void sabre_set_request(SabreState *s, unsigned int irq_num)
>  {
>      trace_sabre_set_request(irq_num);
> +    if (s->irq_request != 0 && s->irq_request != NO_IRQ_REQUEST) {
> +        fprintf(stderr, "FATAL: still waiting for IRQ %x, now %x\n", s->irq_request,
> irq_num);
> +    }
>      s->irq_request = irq_num;
>      qemu_set_irq(s->ivec_irqs[irq_num], 1);
>  }

I have to go AFK right now, will test when I get back (should be about an
hour or two)
