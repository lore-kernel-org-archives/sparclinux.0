From: Daniel Hellstrom <daniel@gaisler.com>
Date: Thu, 03 Feb 2011 08:50:05 +0000
Subject: Re: [PATCH 1/2 v2] sparc32: implement SMP IPIs using the generic
Message-Id: <4D4A6C3D.8070608@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1296675656-19165-1-git-send-email-daniel@gaisler.com>
In-Reply-To: <1296675656-19165-1-git-send-email-daniel@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller wrote:

>From: Daniel Hellstrom <daniel@gaisler.com>
>Date: Wed,  2 Feb 2011 20:40:55 +0100
>
>  
>
>>The current sparc32 SMP IPI generation is implemented the
>>cross call function. The cross call function uses IRQ15 the
>>NMI, this is has the effect that IPIs will interrupt IRQ
>>critical areas and hang the system. Typically on/after
>>spin_lock_irqsave calls can be aborted.
>>
>>The cross call functionality must still exist to flush
>>cache/TLBS.
>>
>>This patch provides CPU models a custom way to implement
>>generation of IPIs on the generic code's request. The
>>typical approach is to generate an IRQ for each IPI case.
>>
>>After this patch each sparc32 SMP CPU model needs to
>>implement IPIs in order to function properly.
>>
>>Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
>>    
>>
>
>Ok, this looks mostly fine to me.
>
>Once we have the sun4m/sun4d versions written I can think about
>applying this.
>
>We might want to abstract out the common code of the dispatch and
>service stuff you have for LEON, otherwise we'll have 3 copies of
>that code that sets and clears the mask state.
>
>Perhaps something using BTFIXUP or similar.
>  
>
I was thinking so too, BTFIXUPs for CPU model specific "IPI operations" 
to avoid the switch-statement in the arch_ functions.

Daniel

