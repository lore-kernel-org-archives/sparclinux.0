From: David Miller <davem@davemloft.net>
Date: Fri, 14 Jul 2006 23:53:08 +0000
Subject: Re: 2.6.18-rc1 fails to boot on E250
Message-Id: <20060714.165308.83620688.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Marc Zyngier <maz@misterjones.org>
Date: Fri, 14 Jul 2006 12:18:47 +0200

> Quick investigation shows that pbm->name is used a tad too early in
> pbm_register_toplevel_resources. The included patchlet fixes that,
> allowing the boot to go a little further, but not much :

Also, pbm_register_toplevel_resources should not be overwriting
that string as it does currently.  I've added your fix and a fix
for that problem to my tree, thanks a lot.

> Looks like no IRQ can be requested, probably a problem with the new
> IRQ framework.

Please reboot with of_debug=3 and send the logs here.  It's
almost certainly a bug in the psycho bus IRQ translater in
arch/sparc64/kernel/prom.c:psycho_irq_build()/psycho_irq_trans_init().
A good debugging log will give some clues.

Thanks!
