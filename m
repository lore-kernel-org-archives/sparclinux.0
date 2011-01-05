From: Daniel Hellstrom <daniel@gaisler.com>
Date: Wed, 05 Jan 2011 11:19:28 +0000
Subject: Re: LEON SMP
Message-Id: <4D2453C0.3090506@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <4CC714EC.2050001@gaisler.com>
In-Reply-To: <4CC714EC.2050001@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Sam Ravnborg wrote:

>>I have started working on this timer patch again...
>>
>>I tried looking a sun4d and sun4m to get an example of how to implement  
>>this in a better way, however they seem to implement the per-cpu ticker  
>>using hardcoded IRQ number 14 and a custom trap handler for the per-cpu  
>>timer ticker (see bottom of kernel/sun4m_irq.c: sun4m_init_timers()).
>>    
>>
>
>I am slowly looking into introducing generic IRQ support for SPARC.
>If I succeed then we will shift to a more dynamic numbering
>of interrupts - like sparc64 does.
>  
>
That would be great. I have not looked so much into the other SPARC32 
ports or the SPARC64, however the LEON port handles IRQ always on the 
CPU calling request_irq(), since CPU0 initializes everything during 
startup CPU0 will end up doing a lot if IRQ work. I wish there where a 
way of implementing IRQ routing to different CPUs. In best case during 
runtime, however a static configuration is good enough.

>Right now I am in a situation where I try to analyse SPARC, existing
>codebase and genirq in the kernel. So it will take
>a while before I get anywhere with this.
>  
>
I understand, I'm appreciating your efforts.

Daniel

