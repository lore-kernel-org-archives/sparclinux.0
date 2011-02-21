From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 21 Feb 2011 10:02:17 +0000
Subject: Re: [RFC/PATCH 0/5] sparc32 genirq support
Message-Id: <20110221100217.GA23044@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20110220203757.GA12981@merkur.ravnborg.org>
In-Reply-To: <20110220203757.GA12981@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, Feb 21, 2011 at 10:30:55AM +0100, Daniel Hellstrom wrote:
> Sam Ravnborg wrote:
>
>> Convert sparc32 to use genirq.
>>
>> Changes since v2:
>> - avoid moving function in sun4d_irq to make diff more readable (Josip Rodin)
>> - added patch that fixes build with floppy or LEON enabled
>>  I broke that during my cleanup.
>>  This is 1/5 - and should be applied to -next soon.
>> - converted leon to genirq
>>  It was straight forward. I identified some dead code in leon_kernel
>>  but I did not clean it up (stuff that reference eirq).
>>  
>>
> Somehow only parts of the Extended IRQ Controller patch was submitted  
> when LEON was included the first time. We distribute the rest of the  
> patch on our homepage, however since it is not clean and you are  
> cleaning up the IRQ code I have been waiting with it.
>
> The extended IRQ controller is basically one extra level of IRQs, when  
> the EIRQ (1..14) is taken the ISR looks what IRQ actually caused the IRQ  
> (16..31) and calls that handler.

That explains it.
I agree that we shall wait with the eirq bits until we get the genirq stuff in shape.

If you find time I would appreciate a review both of the generic and the
leon specific genirq changes.

	Sam
