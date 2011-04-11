From: Daniel Hellstrom <daniel@gaisler.com>
Date: Mon, 11 Apr 2011 15:30:21 +0000
Subject: Re: [PATCH] sparc32,leon: need VIRQ:IRQ 1:1, don't mask/ack IRQ Controller
Message-Id: <4DA31E8D.40904@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1300290864-20678-1-git-send-email-daniel@gaisler.com>
In-Reply-To: <1300290864-20678-1-git-send-email-daniel@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Daniel Hellstrom wrote:

> David Miller wrote:
>
>> From: Daniel Hellstrom <daniel@gaisler.com>
>> Date: Thu, 31 Mar 2011 17:13:35 +0200
>>
>>  
>>
>>> This is sad, as we have designed all LEON architecture to be Plug&Play
>>> as far as possible, and it will be software that limits it in the
>>> end.
>>>   
>>
>>
>> Never is this the case.
>>
>> For any future device you can provide properly formed firmware
>> device tree nodes, with all IRQ entries included.
>>  
>>
> That is the problem, some cores need tweeking in bootloader or 
> SPARC/LEON low IRQ layers. One can think of it as the LEON has a 
> read-only OpenBoot device tree in hardware, but only provides the 
> first IRQ.
>
>> Stop fighting this, you made a mistake in the past, and the set of
>> broken device nodes that need fixing will not expand if you start
>> creating them properly starting now.
>>
>> You made a mistake, add handlers to cope with that mistake, and
>> take this opportunity to fix things so that future LEON device
>> nodes found in firmware are properly formed and contain multiple
>> IRQ entries when necessary.
>>  
>>
> You are correct. The hardware should be redesigned to contain the full 
> information, and in the meantime we must fix this in software. I will 
> try fixing this in the bootloader at first and see how things goes.


I have updated my genirq patches by relying on the bootloader to create 
correct IRQ numbers. And I have added a PCI layer to LEON which also 
depends on the GENIRQ layer.

Dave, how do you prefer that I continue my work, should I wait for Sam 
to complete his work, or should I post the patches even though you can't 
apply them?

Daniel

