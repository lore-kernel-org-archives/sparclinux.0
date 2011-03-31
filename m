From: Daniel Hellstrom <daniel@gaisler.com>
Date: Thu, 31 Mar 2011 15:13:35 +0000
Subject: Re: [PATCH] sparc32,leon: need VIRQ:IRQ 1:1, don't mask/ack IRQ Controller
Message-Id: <4D949A1F.8020403@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1300290864-20678-1-git-send-email-daniel@gaisler.com>
In-Reply-To: <1300290864-20678-1-git-send-email-daniel@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller wrote:

>From: Daniel Hellstrom <daniel@gaisler.com>
>Date: Wed, 30 Mar 2011 14:41:45 +0200
>
>  
>
>>I see, however that is almost as bad because that would also require
>>one driver per core but in the LEON IRQ layer of Linux.
>>    
>>
>
>This is absolutely unavoidable since the firmware device tree doesn't
>pass along the proper set of IRQs.  You have to fixup your tree,
>because it is broken.
>  
>
This is sad, as we have designed all LEON architecture to be Plug&Play 
as far as possible, and it will be software that limits it in the end. I 
think it is quite uncommon (if not unique) to do plug&play on the most 
low-level stuff such as timers and IRQ Controller etc., I believe that 
part of the idea with the OpenBoot tree is to provide that low-level 
plug&play to Linux and LEON that has true PnP in hardware can not do 
that fully. I'm starting to think virtual IRQ is a bad thing.. :)

I will give it another thought tomorrow before doing anything. A part of 
me thinks that the bootloader should be modified to report the correct 
information, however that requires changes to u-boot as well.

Daniel
