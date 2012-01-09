From: David Miller <davem@davemloft.net>
Date: Mon, 09 Jan 2012 22:14:52 +0000
Subject: Re: [PATCH]sparc32: forced setting of mode of sun4m per-cpu timers
Message-Id: <20120109.141452.388652017181678757.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1325885691.21461.8.camel@hp>
In-Reply-To: <1325885691.21461.8.camel@hp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Kirill Tkhai <tkhai@yandex.ru>
Date: Sat, 07 Jan 2012 01:34:51 +0400

> SUN4M per-cpu timers have two modes of work. These are timer mode and
> counter mode. Kernel doesn't write anything to the register, which is
> connected with mode choice.
> So, the mode is chosen by bootloader. This patch forces to use timer
> mode from the kernel and to be independent of bootloader.
> 
> I had this problem with OpenBIOS. Timers don't tick and kernel fails on
> QEMU, when it's compiled with SMP support. The patch fixes problem.
> 
> Signed-off-by: Tkhai Kirill <tkhai@yandex.ru>
> Acked-by: Sam Ravnborg <sam@ravnborg.org>

Your email client corrupted your patch.

> @@ -399,6 +399,9 @@ static void __init sun4m_init_timers(irq_handler_t
> counter_fn)

It split up this line into two.

Please, test email the patch to yourself until you can successfully
apply the patch contained in the email.  Then, and only then, resubmit
your patch here.

Thanks.
