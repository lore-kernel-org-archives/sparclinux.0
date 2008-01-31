From: Jeremy Fitzhardinge <jeremy@goop.org>
Date: Thu, 31 Jan 2008 17:55:41 +0000
Subject: Re: sparc compile error caused by x86 arch updates
Message-Id: <47A20B9D.3090700@goop.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20080130011550.GA31853@elte.hu> <20080131155739.GA19700@cs181133002.pp.htv.fi> <20080131160033.GA11501@elte.hu> <20080131161235.GB19700@cs181133002.pp.htv.fi> <20080131161523.GA12347@elte.hu> <20080131162920.GE19700@cs181133002.pp.htv.fi> <47A1FC6D.6090305@goop.org> <20080131174331.GA11881@elte.hu>
In-Reply-To: <20080131174331.GA11881@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ingo Molnar <mingo@elte.hu>
Cc: Adrian Bunk <bunk@kernel.org>, wli@holomorphy.com, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org

Ingo Molnar wrote:
> * Jeremy Fitzhardinge <jeremy@goop.org> wrote:
>
>   
>> But I guess I overlooked the comment...
>>
>> I guess the fix is to scatter linux/pagemap.h into the appropriate 
>> places where these macros are used (asm-generic/tlb.h, for a start).
>>     
>
> no. The fix is always to undo the damage ASAP, to keep the window of 
> breakage minimized.
>   

Yes, sorry about that.  Uninlining the asm-x86/pgalloc.h functions is 
the right thing to do anyway.

    J
