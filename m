From: Christopher Kenna <cjk@cs.unc.edu>
Date: Tue, 01 May 2012 14:00:56 +0000
Subject: Re: OpenSPARC T1 Processor L2 Cache Question
Message-Id: <CACdM24e1B8xBm3QJH2HGmYWuHUGd7Qg8fzfN1RPG11NQUb6rhw@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Greetings,

To anyone who might be interested in the answer to this question, it
looks I was right in that bits [17:8] are used as a cache-set index
directly, without hashing, according to page 10-3 of [1]. I also found
some older hypervisor code that uses these bits in order to maks off
set indices, etc. [2].

Unfortunately, I still don't know why the L2 data cache read miss
performance counter (using [LL][OP_READ][RESULT_MISS] from [3])
registers few if any misses when I intentionally fill a specific cache
set with more cache lines than it has ways by using the
vm_insert_page() kernel function to map specific physical memory pages
into the virtual address space of a process.

Thanks,
Christopher Kenna

[1] OpenSPARC T1 Processor Megacell Specification
http://read.pudn.com/downloads161/ebook/726659/doc/OpenSPARCT1_MegaCell.pdf
[2] hypervisor-opensparc/src/greatlakes/ontario/include/platform/cache.h
http://kenai.com/projects/hypervisor/sources/hypervisor-opensparc/content/src/greatlakes/ontario/include/platform/cache.h?rev)
[3] http://lxr.linux.no/linux+v3.3.4/arch/sparc/kernel/perf_event.c#L293
