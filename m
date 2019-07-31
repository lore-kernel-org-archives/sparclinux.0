From: Randy Dunlap <rdunlap@infradead.org>
Date: Wed, 31 Jul 2019 17:45:24 +0000
Subject: Re: microblaze HAVE_MEMBLOCK_NODE_MAP dependency (was Re: [PATCH v2 0/5] mm: Enable CONFIG_NODES_SPA
Message-Id: <57b08afb-d07e-a24f-4cfe-5a633227ed6b@infradead.org>
List-Id: <sparclinux.vger.kernel.org>
References: <730368c5-1711-89ae-e3ef-65418b17ddc9@os.amperecomputing.com>
 <20190730081415.GN9330@dhcp22.suse.cz> <20190731062420.GC21422@rapoport-lnx>
 <20190731080309.GZ9330@dhcp22.suse.cz> <20190731111422.GA14538@rapoport-lnx>
 <20190731114016.GI9330@dhcp22.suse.cz> <20190731122631.GB14538@rapoport-lnx>
 <20190731130037.GN9330@dhcp22.suse.cz> <20190731142129.GA24998@rapoport-lnx>
 <20190731144114.GY9330@dhcp22.suse.cz> <20190731171510.GB24998@rapoport-lnx>
In-Reply-To: <20190731171510.GB24998@rapoport-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Rapoport <rppt@linux.ibm.com>, Michal Hocko <mhocko@kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>, Paul Mackerras <paulus@samba.org>, "H . Peter Anvin" <hpa@zytor.com>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, Will Deacon <will@kernel.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, "x86@kernel.org" <x86@kernel.org>, "willy@infradead.org" <willy@infradead.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@redhat.com>, Hoan Tran OS <hoan@os.amperecomputing.com>, Catalin Marinas <catalin.marinas@arm.com>, Open Source Submission <patches@amperecomputing.com>, Pavel Tatashin <pavel.tatashin@microsoft.com>, Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will.deacon@arm.com>, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, Vlastimil Babka <vbabka@suse.cz>, Oscar Salvador <osalvador@suse.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Michal Simek <monstr@monstr.eu>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "David S . Miller" <davem@davemloft.net>

On 7/31/19 10:15 AM, Mike Rapoport wrote:
> On Wed, Jul 31, 2019 at 04:41:14PM +0200, Michal Hocko wrote:
>> On Wed 31-07-19 17:21:29, Mike Rapoport wrote:
>>> On Wed, Jul 31, 2019 at 03:00:37PM +0200, Michal Hocko wrote:
>>>>
>>>> I am sorry, but I still do not follow. Who is consuming that node id
>>>> information when NUMA=n. In other words why cannot we simply do
>>>  
>>> We can, I think nobody cared to change it.
>>
>> It would be great if somebody with the actual HW could try it out.
>> I can throw a patch but I do not even have a cross compiler in my
>> toolbox.
> 
> Well, it compiles :)

Adding Michal Simek <monstr@monstr.eu>.

It's not clear that the MICROBLAZE maintainer is still supporting MICROBLAZE.

>>>> diff --git a/arch/microblaze/mm/init.c b/arch/microblaze/mm/init.c
>>>> index a015a951c8b7..3a47e8db8d1c 100644
>>>> --- a/arch/microblaze/mm/init.c
>>>> +++ b/arch/microblaze/mm/init.c
>>>> @@ -175,14 +175,9 @@ void __init setup_memory(void)
>>>>  
>>>>  		start_pfn = memblock_region_memory_base_pfn(reg);
>>>>  		end_pfn = memblock_region_memory_end_pfn(reg);
>>>> -		memblock_set_node(start_pfn << PAGE_SHIFT,
>>>> -				  (end_pfn - start_pfn) << PAGE_SHIFT,
>>>> -				  &memblock.memory, 0);
>>>> +		memory_present(0, start_pfn << PAGE_SHIFT, end_pfn << PAGE_SHIFT);
>>>
>>> memory_present() expects pfns, the shift is not needed.
>>
>> Right.
>>
>> -- 
>> Michal Hocko
>> SUSE Labs


-- 
~Randy
