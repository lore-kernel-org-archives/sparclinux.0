From: Daniel Hellstrom <daniel@gaisler.com>
Date: Wed, 20 Apr 2011 11:23:00 +0000
Subject: Re: [PATCH 0/7] sparc32,leon: additional genirq patches
Message-Id: <4DAEC214.6000502@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <4DADB2F4.6070402@gaisler.com>
In-Reply-To: <4DADB2F4.6070402@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Daniel Hellstrom wrote:

> David Miller wrote:
>
>> From: Daniel Hellstrom <daniel@gaisler.com>
>> Date: Tue, 19 Apr 2011 18:06:12 +0200
>>
>>  
>>
>>> Hello Dave,
>>>
>>> All the changes in this patch set [1..7] must be applied on top
>>> of Sam genirq patch. The are all LEON specific.
>>>
>>> They add:
>>> * mask/unmask spinlock protection
>>> * Support for LEON Extended IRQ controller
>>> * Use new genirq layer for per-cpu Timer ISR (cleanup)
>>> * other cleanups
>>> * add support for CPU affinity
>>>
>>> Daniel Hellstrom
>>>   
>>
>>
>> Hey Daniel, could you please address Sam's feedback on a few patches
>> and then resubmit this?  You can integrate the ACK's he gave for
>> some of the patches when you do that.
>>  
>>
> It became a bit more messy than my intension... I have added Sam's 
> boot_cpu_id patch in front of my patches, and previous patch 6 (now 7) 
> has been swapped with previous patch 7 (now 8). I have added Sam's 
> ACK. The previous patch 6 which I was supposed to drop have now been 
> cleaned up using Sam's boot_cpu_id instead of a LEON specific variable 
> leon3_boot_cpu.


I'm sorry to mess up stuff even more, the patches 1 and 8 in my series 
does not compile on UP since setup.h isn't included. But even worse is 
that the boot_cpu_id is always 0 it seems because it is initialized 
before BSS is cleared, and boot_cpu_id is part of BSS.

Please apply patches [2/8]..[7/8], and drop [1/8] and [8/8]. It is 
better we do it the way you proposed (drop boot_cpu patch). I'm sorry 
that I ever brought up the boot_cpu_id stuff, as that had nothing to do 
with the genirq patches, and I'm sorry for taking your time like this.

Daniel

