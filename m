From: David Miller <davem@davemloft.net>
Date: Mon, 01 Aug 2016 02:29:38 +0000
Subject: Re: [PATCH] sparc: Don't leak context bits into thread->fault_address
Message-Id: <20160731.192938.1389187225223871270.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20160727.175351.219584019615190125.davem@davemloft.net>
In-Reply-To: <20160727.175351.219584019615190125.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Mikulas Patocka <mpatocka@redhat.com>
Date: Sun, 31 Jul 2016 19:49:10 -0400 (EDT)

> The patch is OK, but I found two other bugs when inspecting the code:
> 
> - some of copy_from_user versions do multiple read operations from 
> userspace before writing the registers to kernel space. If one of those 
> subsequent reads fail, the function compute_size incorrectly assumes that 
> all data up to the faulting address were copied to kernel space.
> 
> - the function copy_in_user_fixup tries to guess if the fault address 
> belongs to the source or destination range. However, the fault address is 
> imprecise (the low 13 bits are always zero), and it may result in 
> incorrect guess.

The low 13 bits are only zero for pre-Niagara systems, and for data
faults only (%tpc is used for instruction faults).

But anyways, we could do something like page align the address and
take the lower of the start of the buffer or the page aligned fault
address to determine how far the copy actually got.

I bet overlapping copies (memmove like situations, etc.) will still
be hard to "guess."

> I've seen a message "BUG: non-zero nr_ptes on freeing mm: 1" twice on 
> sparc64, once on 4.4.13 and once on 4.4.16. I don't know how to reproduce 
> it. Do you have an idea what could be causing this bug?

People have been reporting this off and on for years, and sorry we don't
know what's causing it yet.
