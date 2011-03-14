From: Daniel Hellstrom <daniel@gaisler.com>
Date: Mon, 14 Mar 2011 11:17:08 +0000
Subject: Re: Status update on sparc32 genirq support
Message-Id: <4D7DF934.6080405@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20110307.230120.226776255.davem@davemloft.net>
In-Reply-To: <20110307.230120.226776255.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Sam Ravnborg wrote:

>Hi Daniel - thanks for looking at this patch.
>
>I was actually planning to send it to David tonight.
>But after your comments I will wait.
>
>  
>
>> I have begun too look at the patches, one thing that strikes me is
>>why handle_level_irq is used and why the ack functions irq_ack and
>>irq_mask_ack are not defined.
>>    
>>
>
>The sun4m at least uses level triggered interrupts.
>And looking at the implmentation the enable() and disable() functions
>in all cases did a simple mask and unmask - also the leon variants.
>  
>
Ok.

mask and unmask is harmless on the LEON, incomming IRQs will be pending 
but not propagated to the CPU until it is unmasked, they will not disapear.

As I understand it the mask/unmask in handler_irq is done in order to 
avoid generating an extra IRQ for level triggered IRQs. When first 
unmasking no more IRQs will be queued for the CPU from this IRQ source, 
the current pending IRQ is cleared by acking the IRQ controller, the 
"real" IRQ source (for example a PCI board) is acked in the ISR, then 
handler_irq unmasks the IRQ again and can safely avoid an extra spurious 
IRQ.

>So based on this observation I decided to go got the handle_level_irq
>flow handler. From the implmentation in kernel/irq/ I could
>also see that handle_level_irq always called irq_mask() / irq_unmask()
>which was a match towoards to earlier implemtnation.
>
>On top of this - this just worked for my sun4m box.
>  
>
Ok

>  
>
>>On the LEON architecture IRQs are
>>normally edge triggered, the exception beeing PCI interrupts that is
>>level triggered. Implementing the ack functions in the current
>>implementation would result in acking edge triggered IRQs which means
>>IRQs may be lost (on the LEON at least)? I thought SUN SPARCs also have
>>edge triggered interrupts and that the CPU acks the IRQ automatically
>>when the trap is taken?
>>  
>> What is the difference between having handle_level_irq without ACKs
>>implemented and having handle_edge_irq doing the interrupt flow
>>handling?
>>    
>>
>
>Thomas? Can you help here? You are much more into these details than I am.
>  
>

Must add one more thing here: I now see that the egde IRQ handler 
(handler_edge_irq) does ack which is also incorrect on the LEON. One 
could argue that irq_ack should be left undefined, however it is needed 
for PCI Level IRQs later. Mixing handler_edge_irq and handler_level_irq 
does not seem to be a good idea on LEON since ack is called both times, 
and edge IRQs must not be acked whereas level IRQs should on the LEON. 
Instead I suggest for the LEON:
1. using handle_fasteoi_irq for "edge" IRQs
2. using handle_level_irq for PCI IRQs in the future, this also requires 
that irq_ack and irq_mask_ack is defined (I have a patch for this)


One other thing is that I can't boot anymore on the LEON with the genirq 
patch, this is because the virtual IRQs is not 1:1 to real IRQs and the 
APBUART serial tty console driver uses the "interrupt" property 
directely, thus VIRQs and real IRQs are mixed and that can not work. 
Perhaps there are other drivers on sparc32 machines that use the 
interrupt propery directely? I will try creating a patch for APBUART 
driver to use VIRQs instead, perhaps that patch can go in before Sam's 
genirq patch...

I really think this is the right way forward for IRQ handling on 
sparc32, this is an improvement for LEON indeed. Thank you all for your 
efforts in this.

Thanks,
Daniel
