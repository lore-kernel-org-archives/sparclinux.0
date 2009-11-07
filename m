From: Mikulas Patocka <mpatocka@redhat.com>
Date: Sat, 07 Nov 2009 05:36:23 +0000
Subject: Re: kernel BUG at arch/sparc/mm/fault_64.c:270!
Message-Id: <Pine.LNX.4.64.0911070017050.3025@hs20-bc2-1.build.redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.0910211359560.7932@hs20-bc2-1.build.redhat.com>
In-Reply-To: <Pine.LNX.4.64.0910211359560.7932@hs20-bc2-1.build.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org



On Thu, 5 Nov 2009, David Miller wrote:

> From: Mikulas Patocka <mpatocka@redhat.com>
> Date: Wed, 21 Oct 2009 14:24:59 -0400 (EDT)
> 
> > The fault_code variable that triggered is in l2, it's 0xfe, the fault 
> > address is in l3. Do you have any idea how this could (or couldn't) 
> > happen?
> 
> The fault_code on sparc64 is a bitmask which should contain only the
> following bit values (some of which are exclusive):
> 
> #define FAULT_CODE_WRITE	0x01	/* Write access, implies D-TLB	   */
> #define FAULT_CODE_DTLB		0x02	/* Miss happened in D-TLB	   */
> #define FAULT_CODE_ITLB		0x04	/* Miss happened in I-TLB	   */
> #define FAULT_CODE_WINFIXUP	0x08	/* Miss happened during spill/fill */
> #define FAULT_CODE_BLKCOMMIT	0x10	/* Use blk-commit ASI in copy_page */
> 
> 0xfe is an illegal value.
> 
> I suspect that once you hit this IDE bug, the IDE controller is
> spamming garbage via DMA all over memory corrupting things.

There is another thing that contradicts this. This BUG() really happened 
twice for the same "vmstat" program when I ran it consecutively. On the 
same faulting address.

After stopping simultaneous I/O and clearing the cache with "echo 3 
>/proc/sys/vm/drop_caches", the machine ran reliably, including that 
vmstat command (I rebooted it anyway fearing hidden data corruption, but 
there were really no more program failures).

- So, if the controller corrupted kernel code, the machine wouldn't 
recover.
- If the controller corrupted common kernel data, the bug would show on 
all processes or on all "vmstat" processes and it wouldn't go away after 
clearing disk cache.
- If the controller corrupted per-process kernel data, the probability 
that it corrupted two processes in the same way is small.
- Other idea?

Sadly I don't have copy of the corrupted binary, I wasn't at the console 
and I found out about the BUG later :-/

Mikulas
