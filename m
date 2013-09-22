From: Bob Picco <bpicco@meloft.net>
Date: Sun, 22 Sep 2013 17:15:34 +0000
Subject: Re: [PATCH 1/6] sparc64: Clean up 64-bit mmap exclusion defines.
Message-Id: <20130922171534.GE29427@zareason>
List-Id: <sparclinux.vger.kernel.org>
References: <20130921.011559.2141699869219807525.davem@davemloft.net>
In-Reply-To: <20130921.011559.2141699869219807525.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller wrote:	[Sat Sep 21 2013, 01:15:59AM EDT]
> 
> Older UltraSPARC chips had an address space hole due to the MMU only
> supporting 44-bits of virtual address.
> 
> The top end of this hole also has the same value as the current
> definition of PAGE_OFFSET, so this can be confusing.
> 
> Consolidate the defines for the userspace mmap exclusion range into
> page_64.h and use them in sys_sparc_64.c and hugetlbpage.c
> 
> Signed-off-by: David S. Miller <davem@davemloft.net>

Acked-by: Bob Picco <bob.picco@oracle.com>
