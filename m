From: David Miller <davem@davemloft.net>
Date: Fri, 06 Nov 2009 05:07:51 +0000
Subject: Re: kernel BUG at arch/sparc/mm/fault_64.c:270!
Message-Id: <20091105.210751.131773861.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.0910211359560.7932@hs20-bc2-1.build.redhat.com>
In-Reply-To: <Pine.LNX.4.64.0910211359560.7932@hs20-bc2-1.build.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Mikulas Patocka <mpatocka@redhat.com>
Date: Wed, 21 Oct 2009 14:24:59 -0400 (EDT)

> The fault_code variable that triggered is in l2, it's 0xfe, the fault 
> address is in l3. Do you have any idea how this could (or couldn't) 
> happen?

The fault_code on sparc64 is a bitmask which should contain only the
following bit values (some of which are exclusive):

#define FAULT_CODE_WRITE	0x01	/* Write access, implies D-TLB	   */
#define FAULT_CODE_DTLB		0x02	/* Miss happened in D-TLB	   */
#define FAULT_CODE_ITLB		0x04	/* Miss happened in I-TLB	   */
#define FAULT_CODE_WINFIXUP	0x08	/* Miss happened during spill/fill */
#define FAULT_CODE_BLKCOMMIT	0x10	/* Use blk-commit ASI in copy_page */

0xfe is an illegal value.

I suspect that once you hit this IDE bug, the IDE controller is
spamming garbage via DMA all over memory corrupting things.
