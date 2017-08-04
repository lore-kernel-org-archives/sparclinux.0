From: Pasha Tatashin <pasha.tatashin@oracle.com>
Date: Fri, 04 Aug 2017 14:01:15 +0000
Subject: Re: [v5 11/15] arm64/kasan: explicitly zero kasan shadow memory
Message-Id: <85cce150-74b7-c89b-678c-8fdd0be6c066@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1501795433-982645-1-git-send-email-pasha.tatashin@oracle.com>
 <1501795433-982645-12-git-send-email-pasha.tatashin@oracle.com>
 <CAKv+Gu_V_T56qPS=c3kq73TLFwqpP4YHtggCrjGRmgW1itq3pQ@mail.gmail.com>
In-Reply-To: <CAKv+Gu_V_T56qPS=c3kq73TLFwqpP4YHtggCrjGRmgW1itq3pQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Ard,

Thank you very much for reviewing this. I will fix the bug you found in 
the next iteration.
>> +zero_vemmap_populated_memory(void)
> 
> Typo here: vemmap -> vmemmap

Yeap, will rename here, and in Intel variant.

> 
>> +{
>> +       struct memblock_region *reg;
>> +       u64 start, end;
>> +
>> +       for_each_memblock(memory, reg) {
>> +               start = __phys_to_virt(reg->base);
>> +               end = __phys_to_virt(reg->base + reg->size);
>> +
>> +               if (start >= end)
> How would this ever be true? And why is it a stop condition?

Yes this is a stop condition. Also look at the way kasan allocates its 
shadow memory in this file kasan_init():

187  	for_each_memblock(memory, reg) {
188  		void *start = (void *)__phys_to_virt(reg->base);
189  		void *end = (void *)__phys_to_virt(reg->base + reg->size);
190
191  		if (start >= end)
192  			break;
...
200  		vmemmap_populate(...)

>> +
> 
> Are you missing a couple of kasan_mem_to_shadow() calls here? I can't
> believe your intention is to wipe all of DRAM.

True. Thank you for catching this bug. I have not really tested on arm, 
only compiled for sanity checking. Need to figure out how to configure 
qemu to run most generic arm code. I tested on x86 and sparc both real 
and qemu hardware.

> 
> KASAN uses vmemmap_populate as a convenience: kasan has nothing to do
> with vmemmap, but the function already existed and happened to do what
> KASAN requires.
> 
> Given that that will no longer be the case, it would be far better to
> stop using vmemmap_populate altogether, and clone it into a KASAN
> specific version (with an appropriate name) with the zeroing folded
> into it.

I agree, but this would be outside of the scope of this project.

Pasha
