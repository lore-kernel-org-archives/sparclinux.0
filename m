From: Matthias Rosenfelder <rosenfelder.lkml@googlemail.com>
Date: Tue, 10 May 2011 22:31:03 +0000
Subject: Re: [RFC/PATCH] sparc32/LEON: Cache flush during context switch
Message-Id: <4DC9BCA7.5090709@googlemail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <4DC89ECB.6030309@googlemail.com>
In-Reply-To: <4DC89ECB.6030309@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 10.05.2011 13:26, Kristoffer Glembo wrote:
>
> The cache can generate a hit after a context switch if there exists cache lines
> belonging to the newly switched in process.

Is this really possible? You mean that the cache line has "survived" 
during the execution of the last timeslice of another (i.e. different) 
task AND that the last and the new task have shared a memory region AND 
this shared memory region is susceptible to virtual aliasing in the data 
cache AND the last task has actually written to one of these virtual 
addresses AND the new task actually reads from exactly this virtual 
alias address that the last task wrote to?

This seems very unlikely to me but I must admit that you have a point 
here. It is possible in theory, though very unlikely.

But then what is the context number stored for every cache line for?
Only for the case when you have a tiny cache with the lowest possible 
associativity that you can save a few cycle on a context switch? People 
want _big_ caches with _high_ associativity in order to improve the hit 
rate. Having a bigger cache even if you have to flush it on a context 
switch is much better for performance than having a tiny one without a 
flush. Why do you waste so much hardware on a feature that has so little 
benefit?



> You could avoid this if you always make shared memory regions non-cacheable. I don't know
> enough to say whether this is currently possible.

I don't think this is a good idea. It is propably better to still use 
caches and flush the caches on a context switch than making these 
regions uncacheable at all. This will propably slow down access to these 
regions too much.


>
> I think Daniel meant a solution to the cache coherency problem. It is possible to
> fully avoid aliases in hardware.

Ah yes, of course.

>
> What terminology do you have a problem with in the Linux kernel? That it is written
> "set size" instead of "way size" in some comments? I don't think "set size" is an uncommon
> alias for "way size" ...

But I do. A cache set consists of all cache lines in a cache that can 
store data belonging to addresses that have the same index (i.e. the 
"middle" part of the cache address is the same for all cache lines in a 
cache set). The way size is the sum of all cache lines that belong to a 
certain way, i.e. the n-th possiblity within a cache set to store and 
retrieve a cache line. Way zero is the first possibility in each set; 
Way one is the second and so on...
Cache lines belonging to the same way don't necessarily have any address 
bits in common. Whereas the cache lines belonging to a cache set do...

By the way: If it is correct what you say then why was this changed for 
the Leon4 manual? Leon2 and 3 manuals use the wrong terminology while 
the Leon4 manual uses the correct one. Obviously, there must be at least 
one person at Gaisler who believes that the previous terminology was not 
correct. Leon2 and 3 manual mention "multi-set caches" while 
Leon4-manual mentions "multi-way caches". Look at the GRLIB ipcore 
user's manual.

One thing in addition: Please don't get me wrong. I don't want to blame 
anybody too much. I just would like to see consistent terminology in the 
code so it is easier for everybody to understand. That's all I am aiming 
for.


Thanks,

      Matthias
