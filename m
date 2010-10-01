From: Alex <alexvm12e@mail.ru>
Date: Fri, 01 Oct 2010 10:18:28 +0000
Subject: Re: sun4v_intr_settarget() return HV_EINVAL
Message-Id: <201010011418.29913.alexvm12e@mail.ru>
List-Id: <sparclinux.vger.kernel.org>
References: <201009291530.45792.alexvm12e@mail.ru>
In-Reply-To: <201009291530.45792.alexvm12e@mail.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hello,

> They were called, they just didn't get the errors it is getting for you
> now.

I've checked this commenting if(err) condition in sun4v_irq_enable(), they 
weren't called for 2.6.30.5 (this is for snet - call only one time):

[   65.137911] sun4v_intr_settarget(13f,0): err(0)
[   65.178501] sun4v_intr_setstate(13f): err(0)
[   65.216755] sun4v_intr_setenabled(13f): err(0)

2.6.35.5:

[   24.142277] sun4v_intr_settarget(111,0): err(6)
[   24.181751] sun4v_intr_setstate(111): err(6)
[   24.219969] sun4v_intr_setenabled(111): err(6)

[   25.383697] sun4v_intr_settarget(13f,0): err(0)
[   25.423583] sun4v_intr_setstate(13f): err(0)
[   25.461799] sun4v_intr_setenabled(13f): err(0)

0x111 and 0x13f are sysino's for /virtual-devices@100/console@1 and /virtual-
devices@100/snet@2 respectively.

Perhaps, any console driver was rewritten for interrupt processing instead 
polling?

> I suspect the interrupt information simply isn't being computed properly.
>
> Please send me the output of "prtconf -pv" from the working 2.6.30.5 system
> and I should be able to figure out the problem.

There isn't command "prtconf -pv" in my clfs Linux. Perhaps, following 
information reading from MD can help (it the same for both kernels):

[   15.655144] /virtual-devices@100/console@1: Apply [/virtual-devices@100:1] 
imap --> [/virtual-devices@100:11]
[   15.781886] /virtual-devices@100/console@1: Apply IRQ trans [/virtual-
devices@100] 1 --> 1
[   15.796655] /virtual-devices@100/disk@0: Apply [/virtual-devices@100:1] 
imap --> [/virtual-devices@100:0]
[   15.921960] /virtual-devices@100/disk@0: Apply IRQ trans [/virtual-
devices@100] 1 --> 2
[   15.925455] /virtual-devices@100/snet@2: Apply [/virtual-devices@100:1] 
imap --> [/virtual-devices@100:3f]
[   16.052093] /virtual-devices@100/snet@2: Apply IRQ trans [/virtual-
devices@100] 1 --> 3

Thanks,
Alex.
