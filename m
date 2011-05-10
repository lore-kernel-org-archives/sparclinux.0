From: Kristoffer Glembo <kristoffer@gaisler.com>
Date: Tue, 10 May 2011 11:26:52 +0000
Subject: Re: [RFC/PATCH] sparc32/LEON: Cache flush during context switch
Message-Id: <4DC920FC.1050808@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <4DC89ECB.6030309@googlemail.com>
In-Reply-To: <4DC89ECB.6030309@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Matthias Rosenfelder wrote:
> Am 10.05.2011 09:19, schrieb Daniel Hellstrom:
>>
>> Have you taken cache aliasing into account? The problem may be that
>> the same physical address may be mapped onto different virtual
>> addresses. This is no problem when there is only one location in
>> the cache multiple virtual addresses with the same page offset can
>> be located at, one virtual address mapped to the same physical
>> address will replace the other. That is why the check is for 4KByte
>> cache of less (less then one page) and only one set.
> 
> In this case cache aliasing is not an issue. It is only a problem if two
> aliases (i.e. two virtual addresses that are mapped to the same
> physical address) can be present in the cache _and_ the cache can
> generate a hit when reading from one of these two after having written
> the other one before. Then the cache hit will return the old data rather
> than then new ones.
> 
> But in the case of context switching the cache does not generate a hit.
> The context number stored alongside every cache line prevents this. You
> never get a cache hit from data that was pulled into the cache in a
> different address space than the current. That's why after _changing_
> the address space the cache will produce a series of misses. It is like
> flushing the cache atomically within one cycle when you write a
> different context number into the SRMMU register.
> 


The cache can generate a hit after a context switch if there exists cache lines
belonging to the newly switched in process. Then the new process can get a hit in 
the cache when another process has updated the value in memory. Just because you write 
the context register it does not mean that the cache is automatically invalidated.

You could avoid this if you always make shared memory regions non-cacheable. I don't know 
enough to say whether this is currently possible.



>> We are well aware of this problem, I think some day Jiri will present a
>> solution.
> 
> Hmm, this is non-standard terminology. How can others understand the
> source code if it doesn't use the generally accepted terms found in
> textbooks about computer architecture?

> I think this might confuse a lot of people (as it did confuse me
> in the past until I found out and understood the error) and should
> therefore not be tolerated to remain in the Linux kernel in the long
> run. The promise of a solution "some day" is way too vague for my taste.
> This should be changed in the near future.


I think Daniel meant a solution to the cache coherency problem. It is possible to
fully avoid aliases in hardware.

What terminology do you have a problem with in the Linux kernel? That it is written
"set size" instead of "way size" in some comments? I don't think "set size" is an uncommon
alias for "way size" ...



> The Leon3 cache configuration is the standard one. If I remember
> correctly there are a 4 kiB direct-mapped and a 8 kiB 2-way associative
> cache but I don't remember which one was for data and instructions.
> 

Try using shared memory to a greater extent.

Best regards,
Kristoffer Glembo
Aeroflex Gaisler



