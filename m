From: Daniel Hellstrom <daniel@gaisler.com>
Date: Wed, 20 Apr 2011 09:49:12 +0000
Subject: Re: [PATCH 0/7] sparc32,leon: additional genirq patches
Message-Id: <4DAEAC18.6080405@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <4DADB2F4.6070402@gaisler.com>
In-Reply-To: <4DADB2F4.6070402@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller wrote:

>From: Daniel Hellstrom <daniel@gaisler.com>
>Date: Tue, 19 Apr 2011 18:06:12 +0200
>
>  
>
>>Hello Dave,
>>
>>All the changes in this patch set [1..7] must be applied on top
>>of Sam genirq patch. The are all LEON specific.
>>
>>They add:
>>* mask/unmask spinlock protection
>>* Support for LEON Extended IRQ controller
>>* Use new genirq layer for per-cpu Timer ISR (cleanup)
>>* other cleanups
>>* add support for CPU affinity
>>
>>Daniel Hellstrom
>>    
>>
>
>Hey Daniel, could you please address Sam's feedback on a few patches
>and then resubmit this?  You can integrate the ACK's he gave for
>some of the patches when you do that.
>  
>
It became a bit more messy than my intension... I have added Sam's 
boot_cpu_id patch in front of my patches, and previous patch 6 (now 7) 
has been swapped with previous patch 7 (now 8). I have added Sam's ACK. 
The previous patch 6 which I was supposed to drop have now been cleaned 
up using Sam's boot_cpu_id instead of a LEON specific variable 
leon3_boot_cpu.

Thanks,
Daniel
