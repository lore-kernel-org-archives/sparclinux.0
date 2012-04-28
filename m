From: Christopher Kenna <cjk@cs.unc.edu>
Date: Sat, 28 Apr 2012 02:09:44 +0000
Subject: OpenSPARC T1 Processor L2 Cache Question
Message-Id: <CACdM24fc=0jD+r_43cVO9ChmjqszR9bXSGnSHcFz6cZ285bTyA@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hello,

My question is simple: does the L2 cache in the OpenSPARC T1 (niagara)
processor use index hashing to determine the cache set index for a
cache line? I can only find sources citing that the T2 does this [1]
It seems like this was a new feature in the T2 designed to utilize the
L2 cache more efficiently [2], which *implies* that the T1 does not.
However, I cannot see this when I run experiments using a T1 that I
have. More background information is below.

The OpenSPARC T1 Microarchitecture Specification [3] states that the
L2 cache in the UltraSPARC T1 has total size 3 MB and is divided into
4 banks. Each bank uses a 64 byte line size, is 768 KB in size, and
has 1024 12-way associative sets. Bits [7:6] of the physical address
are used to determine which bank memory maps to. Since there are 1024
sets in a bank, it would make sense to use physical address bits
[17:8] (because these 10 bits are the next-most-significant after the
bits determining the bank). I am hoping that these bits alone
determine a set (without hashing); however, some experiments I ran do
not support this.

Basically, the experiment is to precisely control the virtual to
physical memory mapping of a buffer in a process' address space and
then read it back while using the perf-events subsystem (which uses
the processor's hardware performance counters) to monitor L2 cache
misses. Assuming that index hashing is not used, I compare the results
when the buffer is allocated such that it uses all cache sets equally
and when it is restricted to use only the first 128 cache sets (since
I operate on the granularity of 8 KB pages). I expected the number of
L2 cache misses in the second experiment to be much higher do to
conflict misses (all memory mapping to the same sets), but, actually,
the results are the same in both cases.

To achieve this mapping, I made a miscdevice and set it up so that I
can mmap it and it returns a buffer with the proper virtual to
physical address mapping. I am using vm_insert_page() to insert the
pages into the process' virtual address space. The physical address of
pages are determined with page_to_phys() and then I mask bits [17:13]
to determine which cache sets the page maps into.

Thanks for any comments, referrals, or other help you can provide.

 -- Christopher Kenna

[1] http://www.opensparc.net/offers/OpenSPARC_Internals_Book.pdf
[2] http://www.paume.itb.ac.id/~iidc/opensparc/training%20openSPARC/pdf/06-KG-T2-Solaris-changes-final.pdf
[3] http://users.ece.utexas.edu/~mcdermot/vlsi-2/OpenSPARCT1_Micro_Arch.pdf
