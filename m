From: Piet Delaney <piet.delaney@tensilica.com>
Date: Thu, 28 Aug 2008 09:29:44 +0000
Subject: HyperSPARC RT625 Cache Controler,  Ross CY7C605 Cache Controler,
Message-Id: <48B67008.3010007@tensilica.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi Dave, Andrew, Sparc Linux Folks:

I'm wondering about the support in Linux for systems with caches that 
require that
the kernel prevent cache aliases from getting dirty at the same time.

I get the impression that Sun's convention at the time was that the 
kernel prevented
cache aliases from occurring. Interesting the hardware for Ross CY7C605 
appears to have
both virtual and physical cache tags and cache controller appears to 
update the virtual
cache tags in the event that a snoop detects a cache alias.  The 605 seemed
to have an additional advantage of being able to process snoops in parallel
with the normal cache request from the processor. I thought it seemed like
a reasonable thing to do and it would prevent the kernel from having to deal
with cache aliases.

Looks like the later HyperSPARC, the RT625, dropped the virtual cache
tags and relied on the kernel to prevent cache aliases. It was a later 
design
and wonder what the cache aliasing correction support was removed.

We have a non-SMP chip that doesn't handle cache aliases in the hardware
and are coming out with a SMP processor soon. I was wondering if adding the
605 features of detecting aliases during while snooping and correcting them
would be a worthwhile effort and the consequences in the Linux kernel to
having to deal with this; especially and new SMP issues.

I noticed that some of the sparc MMU code had support for coloring in a mm
hyperSPARC file, but it seemed to be related to DMA. In our current code 
we do
cache flushes in the user copy code for copies that would cause dirty 
aliases cache
lines and have additional code like pte_alloc_one_kernel() in 
arch/xtensa/mm/pgtable.c
which keeps allocating pages until it gets one with a compatible color.
I haven't seen anything odd like this in the SPARC mm code yet.
How does the Linux SPARC code deal with cache coloring support for Sun4m?

Since it appears that at least the HyperSPARC 605 shared this
dependency on the kernel I thought I might find some insight
into the cost and mechanisms used to support this in an SMP
environment. I thought you, Andrew, or others on the sparc mailing list
 might have some thoughts and recommendations that you wouldn't mind
sharing when it's convenient.

-piet
