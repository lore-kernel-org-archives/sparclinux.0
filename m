From: David Miller <davem@davemloft.net>
Date: Fri, 01 Oct 2010 01:13:20 +0000
Subject: Re: sun4v_intr_settarget() return HV_EINVAL
Message-Id: <20100930.181320.137840091.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <201009291530.45792.alexvm12e@mail.ru>
In-Reply-To: <201009291530.45792.alexvm12e@mail.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Alex <alexvm12e@mail.ru>
Date: Wed, 29 Sep 2010 15:30:45 +0400

> I've made jump from Linux 2.6.30.5 to 2.6.35.5 and have the problem: 
> 
> [   20.106850] f026b770: ttyS0 at I/O 0x0 (irq = 1) is a SUN4V HCONS
> [   24.022837] console [ttyHV0] enabled
> [   24.142277] sun4v_intr_settarget(111,0): err(6)
> [   24.181751] sun4v_intr_setstate(111): err(6)
> [   24.219969] sun4v_intr_setenabled(111): err(6) 
> [   24.391342] brd: module loaded
> 
> sun4v_irq_enable() which includes these functions wasn't called  for 2.6.30.5:

They were called, they just didn't get the errors it is getting for you
now.

> [   20.692492] f026b770: ttyS0 at I/O 0x0 (irq = 1) is a SUN4V HCONS
> [   20.693875] console [ttyHV0] enabled
> [   25.752923] brd: module loaded
> 
> obp_prom and .config for linux are the same. So why function sun4v_irq_enable() 
> is called for 2.6.35.5 and isn't called for 2.6.30.5? Can this be cause for 
> Linux hang after
> [   25.945778] VFS: Mounted root (ext3 filesystem) readonly on device 254:0.?

I suspect the interrupt information simply isn't being computed properly.

Please send me the output of "prtconf -pv" from the working 2.6.30.5 system
and I should be able to figure out the problem.

Thanks.
