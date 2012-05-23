From: Daniel Hellstrom <daniel@gaisler.com>
Date: Wed, 23 May 2012 12:27:19 +0000
Subject: Re: Linux on sparc v7
Message-Id: <4FBCD7A7.5080704@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <4FBA4DBC.9070609@gaisler.com>
In-Reply-To: <4FBA4DBC.9070609@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 05/22/2012 08:28 AM, Daniel Hellstrom wrote:
> On 05/21/2012 06:16 PM, Sam Ravnborg wrote:
>> On Mon, May 21, 2012 at 04:14:20PM +0200, Daniel Hellstrom wrote:
>>> Hello Dave,
>>>
>>> I am trying to catch up on what has been happening lately with the sparc
>>> port. Have the latest patches removed support for SPARC V7 CPUs?
>> Yes. The sun4c were the only users of v7 so today we tell gcc to generate v8
>> code. This imply support for muldiv&  friends.
>>
>> > From the sparc Makefile:
>>
>>      KBUILD_CFLAGS  += -mcpu=v8
>
> Does this mean that if we change it to mcpu=v7 or mcpu=cypress (or removing mcpu=v8) the kernel can still be run on a V7 CPU? Or have software routines for making V8 mul/div operations on a V7 CPU 
> been removed so that V7 CPUs can't run Linux regardless of compiler option?
>
>> As a side-note - we require support for the "flush" instruction now.
>> I assume LEON support this.
> Yes, flush invalidates all of the instruction cache.

Note that it will also flush the LEON data cache. Flushing on a LEON is normally done:
  * I-cache, write anywhere using ASI=0x15
  * D-cache, write anywhere using ASI=0x16

Daniel

>
>>> The LEON VHDL model supports both V7 and V8 CPUs,
>>> FPU and non-FPU in any combination.
>> I do not have any overview on the FPU side of things.
> Thanks,
> Daniel
> -- 
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>

