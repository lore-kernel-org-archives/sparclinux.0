From: Daniel Hellstrom <daniel@gaisler.com>
Date: Wed, 27 Apr 2011 13:07:23 +0000
Subject: Re: [PATCH 1/2 v2] sparc32: implement SMP IPIs using the generic
Message-Id: <4DB8150B.9070201@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1296675656-19165-1-git-send-email-daniel@gaisler.com>
In-Reply-To: <1296675656-19165-1-git-send-email-daniel@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller wrote:

>From: Daniel Hellstrom <daniel@gaisler.com>
>Date: Thu, 03 Feb 2011 09:50:05 +0100
>
>  
>
>>David Miller wrote:
>>
>>    
>>
>>>Ok, this looks mostly fine to me.
>>>
>>>Once we have the sun4m/sun4d versions written I can think about
>>>applying this.
>>>
>>>We might want to abstract out the common code of the dispatch and
>>>service stuff you have for LEON, otherwise we'll have 3 copies of
>>>that code that sets and clears the mask state.
>>>
>>>Perhaps something using BTFIXUP or similar.
>>> 
>>>      
>>>
>>I was thinking so too, BTFIXUPs for CPU model specific "IPI
>>operations" to avoid the switch-statement in the arch_ functions.
>>    
>>
>
>Exactly.
>  
>
I have made new IPI patches that uses BTFIXUPs as we discussed above.

 From another discussion we had:


David Miller wrote:

>I think we can make this work on sun4m/sun4c/sun4d, which have several
>software interrupt vectors available.
>
>sun4m has 15 soft interrupts, in the sun4m_irq_percpu->{pending,clear,set}
>registers, these live sequentially starting at bit 16, as per the definition
>of the SUN4M_SOFT_INT() macro.
>
>The only catch is that we'll need to peek at the ->pending register(s) to
>determine if we have a hardware or software interrupt pending at a given
>PIL level (or both).
>  
>
I have made an implementation for sun4m which I think will work, I added 
code to the IRQ traphandler to check for the IPIs as you suggested above 
and clearing the pending register. The previous sun4m code had some IPI 
checks already which I beleive was old unused code that was never 
called, so I removed that.. Do you have any ideas what was going on in 
the old code (smp_reschedule_irq)? Please see patch and commit message.

I don't have the sun4d-SMP hardware so it would be great if someone 
could test the patches?

>I'm not sure how the software interrupt triggering works on sun4c, but that
>doesn't matter since we only need this on SMP.
>  
>
I skip sun4c in this patch.

>The sun4d code has a sun4d_send_ipi() interface from which the necessary
>code can be constructed.
>  
>
I started making a sun4d patch however I don't know the hardware enough 
to make a guess. My problem is that I think I can generate an IPI but 
don't know how to ACK them, detect them, which IRQs to use etc. Is there 
a way to distinguish between soft and hard IRQs on sun4d? If I had a 
piece of document about sun4d it could be possible, but guessing from 
looking at unimplemented code... I hope someone else can take over here, 
probably it is very similar to the sun4m implementation.

Also, this time I added some IPI IRQ statistics to the genirq 
arch_show_interrupts() function, I hope that it may help someone trying 
to implement IPIs on sun4d.

After booting on a LEON4 dualcore board:

# cat /proc/interrupts
           CPU0       CPU1
  2:       2808          0      leon-edge      timer
  3:       2809       2741      leon-per-cpu   ticker
  5:        198          0      leon-edge      apbuart
 13:          0          0      leon-pcilvl    GRPCI2_JUMP
 20:          0          0    grpci2-pcilvl    GRPCI2_ERR
RES:         29          6      IPI rescheduling interrupts
CAL:         35         32      IPI function call interrupts
NMI:          1          1      Non-maskable interrupts


Daniel
