From: Andreas Larsson <andreas@gaisler.com>
Date: Thu, 28 Jan 2021 11:05:28 +0000
Subject: Re: sparc32: boot fails with > 256 MB memory after switch to NO_BOOTMEM
Message-Id: <fd127ef4-7890-8274-7642-c8affcd5b384@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <5adb7c41-ad71-b904-6b73-35aef4dfcafe@gaisler.com>
 <20210128093541.GC299309@linux.ibm.com>
In-Reply-To: <20210128093541.GC299309@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Rapoport <rppt@linux.ibm.com>
Cc: Sparc kernel list <sparclinux@vger.kernel.org>, linux-mm@kvack.org, Mike Rapoport <rppt@linux.vnet.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Sam Ravnborg <sam@ravnborg.org>, Michal Hocko <mhocko@kernel.org>

On 2021-01-28 10:35, Mike Rapoport wrote:
> On Wed, Jan 27, 2021 at 04:03:00PM +0100, Andreas Larsson wrote:
>>
>>
>> Commit cca079ef8ac29a7c02192d2bad2ffe4c0c5ffdd0 makes sparc32 use
>> memblocks instead of the previous bootmem solution. Unfortunately, due
>> to this:
>>
>> #define PAGE_OFFSET  0xf0000000
>> #define __va(x)	     ((void *)((unsigned long) (x) - phys_base +
>> PAGE_OFFSET))
>> #define phys_to_virt __va
>>
>> it makes physical addresses >= 0x10000000 past phys_base wrap around the
>> 32-bit memory space when converted to virtual addresses, e.g. in
>> memblock_alloc_try_nid. Physical memory exactly 0x10000000 past
>> phys_base is returned as an unintended NULL pointer, leading to a panic
>> in my boot when percpu memory allocation fails due to it.
>>
>> Unfortunately I have had 256 MB memory or less in a lot of my testing,
>> so this old one has slipped by me.
>>
>> Does anyone has any ideas or pointers on how to resolve this?
> 
> I think the simplest way to work around this is to limit early allocations
> to 256M with addition of
> 
> 	memblock_set_current_limit(SZ_256M);
>   
> somewhere at setup_arch().
> 
> The page allocator will anyway see the entire memory, so I cannot think of
> any downside here.

That works like a charm! Thank you! I'll submit a patch.

-- 
Andreas Larsson
Cobham Gaisler
