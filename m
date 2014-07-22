From: David Miller <davem@davemloft.net>
Date: Tue, 22 Jul 2014 04:56:38 +0000
Subject: Re: [PATCH 0/6] sparc64 io refactoring
Message-Id: <20140721.215638.540755871844353404.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20140720113501.GA3712@ravnborg.org>
In-Reply-To: <20140720113501.GA3712@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 20 Jul 2014 13:43:13 +0200

> On Sun, Jul 20, 2014 at 01:35:02PM +0200, Sam Ravnborg wrote:
>> The following patchset refactor io_64.h. This was triggered by
>> another patchset by Thierry Reding that updates the the generic
>> io.h such that it may be used by sparc64 and thus make sparc
>> and sparc64 more equal in this area.
>> 
>> Before attempting to introduce the generic version it was
>> necessary to clean up the current state to avoid any mistakes.
>> The updates from Thierry needs to go in before I will attempt
>> introducing the generic io.h.
>> 
>> The sparcspkr used inb()/outb() primitives
>> for of_ioremap() memory. Update this driver to use sbus_ variants.
>> This change was triggered by a number of new warnings that would otherwise
>> have been seen when dropping the macro indirections.
>> Likewise PeeCeeI.c had some warnings that was fixed by
>> using another IO varaint - which simplified the code too.
>> 
>> The patchs has been generated with the --histogram option
>> to make the patch that re-order functions in io_64.h
>> more readable.
>> So to see the same patches locally you need this option too.
>> 
>> I have not yet any working sparc64 HW - so this is not tested.
>> But I brought a SUN NetraX1 that I am working on gettting
>> running. That may allow me to do some minimal tests in the future.
> 
> I checked the size impact on these patches on a defconfig kernel:
> 
> Before:
> $ size  vmlinux
>    text    data     bss     dec     hex filename
> 5838466  478776 6876081 13193323         c9506b vmlinux
> 
> After:
> $size vmlinux
>    text    data     bss     dec     hex filename
> 5837570  478776 6876081 13192427         c94ceb vmlinux
> 
> So in other words a reduction on 896 bytes in text.
> This it not much but my main concern was if the kernel
> grow bigger do to these changes - which was not the case.
> 
> I did not check but I assume the most of the reduction in
> size come from the changes in PeeCeeI.c.

Looks great, applied to sparc-next, thanks Sam!
