From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Date: Sun, 29 Jul 2007 14:44:14 +0000
Subject: Re: Sparc32 not working:2.6.23-rc1 (git commit
Message-Id: <Pine.LNX.4.61.0707291513190.30117@mtfhpc.demon.co.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0707281903350.27869@mtfhpc.demon.co.uk>
 <20070728.224037.39158363.davem@davemloft.net> <Pine.LNX.4.61.0707290856330.30117@mtfhpc.demon.co.uk>
 <20070729.020554.104645494.davem@davemloft.net>
 <Pine.LNX.4.61.0707291041380.30117@mtfhpc.demon.co.uk>
In-Reply-To: <Pine.LNX.4.61.0707291041380.30117@mtfhpc.demon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linux-mm@kvack.org

Hi David,

I have finally located where my NULL pointer is. The problem is that I 
have not got a clue how it is getting set to NULL.

In arch/sparc/mm/sun4c.c, add_ring_ordered, head->next is getting 
corrupted and is becoming a NULL pointer. This is ment to be a circular 
linked list so it should never be NULL.

The simple explenation, since nothing significant apears to have changed 
in sun4c.c, is that some change in mm/memory.c is wrong/incompatible with 
sun4c mmu. The problem is that all the kernels I tried to build around the 
changes to the mm code don't build on Sparc32 due to the DMA changes. This 
makes it more dificult to be cirtain of the cause of the corruption.

I am going to try to back out the mm/memory.c changes so that I can 
eliminate them as a cause.

Unless someone who understands the memory management code spots an error, 
this is not going to be easy to track down and fix.

Do you have any documentation on the sun4c mmu?

If not, I am going to have to create some diagrams/documentation as 
tralling through the code takes forever and gets very confusing. I am 
struggel to understand what tables have what in them for the sun4c mmu.

Regards
 	Mark Fortescue.

