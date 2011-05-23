From: daniel@gaisler.com
Date: Mon, 23 May 2011 18:59:49 +0000
Subject: Re: Sun4d boot crash in sun4d_init_timers
Message-Id: <20110523145949.5wogt3xqo8scogow@webmail.bluegenesis.com>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.1105231908050.7984@oizys.tordivel.org>
In-Reply-To: <Pine.LNX.4.64.1105231908050.7984@oizys.tordivel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi Kjetil,

First of all you're right calling will NULL just can't be good. The 
LEON genirq build_device_irq has been split into two separate parts, 
one that takes a platofrm device and one that works with "real_irq" 
just because of this reason. Even though the OpenBoot PROM shuold 
deliver all information, I think we should be able to bypass it when 
needed, like in this case. 

Secondly, the return value from sun4d_build_device_irq() is a real_irq, 
and that is what causes the problem I guess. Try make it return the 
virtual IRQ instead, and give that VIRQ to request_irq instead. 

Daniel

On Mon, 23 May 2011 19:28:11 +0200 (CEST), Kjetil Oftedal  wrote:
Hi,
>
> The current sparc-next-2.6 encounters a zero pointer on sun4d during 
> boot. I have bisected it down to the changes made during the 
> introduction of genirq. The problematic change is in 
> sun4d_init_timers(). sun4d_build_device_irq() is now called from 
> there with NULL as the first parameter, which will for obvious 
> reasons not work. I've tried to change sun4d_build_device_irq() to 
> allow building a device irq for the timer interrupt without any 
> platform device, as it is a cpu local interrupt(?), and just 
> bypassing all the sbus specifics in sun4d_build_device_irq(), down to 
> irq_alloc(). (Setting pil to real_irq and board to 0). 
>
> With such a change request_irq() fails with -90, which is probably 
> -ENOSYS from __setup_irq(). Any suggestions on how this could be 
> fixed ?
>
> -
> Kjetil Oftedal
>
>
>
>
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>


