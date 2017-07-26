From: David Miller <davem@davemloft.net>
Date: Wed, 26 Jul 2017 06:11:33 +0000
Subject: Re: [PATCH v2 3/3] sparc64: Increase max_phys_bits to 51 for M8.
Message-Id: <20170725.231133.421437669502602611.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1500876859-8398-3-git-send-email-allen.pais@oracle.com>
In-Reply-To: <1500876859-8398-3-git-send-email-allen.pais@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Allen <allen.pais@oracle.com>
Date: Mon, 24 Jul 2017 19:33:27 +0530

>> This patch needs to go with sparc-5-Level-paging  patch. I am still
>> working on adding boot time selection option, so please ignore this
>> patch for now. I will post this patch separately with sparc-5-level
>> patch.
> 
>  My bad. David, could you please ignore this patch for the moment.

Wait, why do you need 5 level page tables for this?

The existing 4 level code supports up to 53-bits and you need only 51
for M8.

There is even a check for this limit in asm/pgtable_64.h:

#if (MAX_PHYS_ADDRESS_BITS > PGDIR_SHIFT + PGDIR_BITS)
#error MAX_PHYS_ADDRESS_BITS exceeds what kernel page tables can support
#endif

#if (PGDIR_SHIFT + PGDIR_BITS) != 53
#error Page table parameters do not cover virtual address space properly.
#endif

We've supported up to 53-bits forever, from page_64.h:

#define MAX_PHYS_ADDRESS_BITS	53

