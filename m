From: Ralph Mitchell <rmitchell@eds.com>
Date: Thu, 26 Aug 2004 18:05:16 +0000
Subject: Re: [PATCH] SunSAB console problems in 2.6.x
Message-Id: <412E265C.7080004@eds.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20040825233247.237c1fb1.davem@redhat.com>
In-Reply-To: <20040825233247.237c1fb1.davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Ben Collins wrote:

>> * Bringing br0 down... *   Releasing DHCP lease for br0
>>  [ ok ]
>> *   Stopping br0
>>  [ ok ]
>> * Bringing lo down...  [ ok ]
>> * Stopping devfsd...  [ ok ]
>> * Deactivating swap...  [ ok ]
>> * Unmounting filesystems...  [ ok ]
>> * Shutting down the Logical Volume Manager...  [ ok ]
>> * Remounting remaining filesystems readonly...  [ ok ]
>>m:sopn l ddvcs
>>d d wthdt edol oe
>>Rsatn ytm
>>Resetting ... 
>>    
>>
>
>So your serial console works for userspace, but is broken from the
>kernel? That last "Resetting..." is from the OBP I think.
>
>  
>

Ah, yep...  That's exactly how it is.  Sorry, I thought the same was 
happening to other folks as well, or I would have emphasized that oddity.

If it makes any difference, my serial port is:

    ttyS0 at MMIO 0x1fff1400000 (irq = 7969824) is a SAB82532 V3.2

E450, 4x400MHz, kernel 2.6.7.  IIRC this little problem crept in with 
2.6.7.  I have older kernels on the system, but I'm not in a position to 
boot it to check.

I'm supposed to be asleep right now, and I won't be back in front of the 
E450 until about midnight Central Time.  I'll boot 2.6.6 then and post 
the results.  Would it help to try any of the 2.6.7 release candidates?  
It grinds out kernels fairly fast...:)

Oh, BTW, this is absolutely *not* mission-critical for me, so if you 
guys have anything more urgent to deal with, don't let me interrupt.

Thanks,


Ralph Mitchell


