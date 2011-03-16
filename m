From: Daniel Hellstrom <daniel@gaisler.com>
Date: Wed, 16 Mar 2011 15:53:18 +0000
Subject: Re: [PATCH 5/5] sparc32: genirq support
Message-Id: <4D80DCEE.3090302@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1298234400-22378-5-git-send-email-sam@ravnborg.org>
In-Reply-To: <1298234400-22378-5-git-send-email-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller wrote:

>From: Sam Ravnborg <sam@ravnborg.org>
>Date: Tue, 22 Feb 2011 19:22:19 +0100
>
>  
>
>>I will prepare a v4 soon.
>>    
>>
>
>The first 4 patches are in the tree, so you only need to resubmit
>this patch rather than the whole bunch.
>
>I really look forward to applying v4, thanks Sam!
>  
>

I think it is very good as well, it will save us a lot of problems in 
the future! However LEON needs VIRQ to map 1:1 to real IRQs. I figured 
that it does not hurt the SUNs if we map 1:1 as long as it is possible. 
The reason is that LEON drivers must have the possibility to do 
request_irq on IRQ and IRQ+1 and IRQ+2 and so on. Due to how the 
Plug&Play information is designed we can only know the first IRQ of a 
device, a device may have 2 IRQs (always IRQ and IRQ+1 in that case). 
And since VIRQ->REAL_IRQ but not VIRQ+1->REAL_IRQ+1 this will break.

Please see my patches sent to the list (not the APBUART patches), 
perhaps Sam can include the single patch into the PATCH5? The other 
patches for the exteneded IRQ controller and irq_shutdown must be 
applied afterwards.

Thanks,
Daniel

