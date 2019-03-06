From: David Miller <davem@davemloft.net>
Date: Wed, 06 Mar 2019 19:20:23 +0000
Subject: Re: [PATCH v5 4/4] hugetlb: allow to free gigantic pages regardless of the configuration
Message-Id: <20190306.112023.204648705168304981.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20190306190005.7036-1-alex@ghiti.fr>
 <20190306190005.7036-5-alex@ghiti.fr>
In-Reply-To: <20190306190005.7036-5-alex@ghiti.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: alex@ghiti.fr
Cc: dalias@libc.org, linux-sh@vger.kernel.org, peterz@infradead.org, benh@kernel.crashing.org, dave.hansen@linux.intel.com, heiko.carstens@de.ibm.com, linux-mm@kvack.org, paulus@samba.org, hpa@zytor.com, sparclinux@vger.kernel.org, linux-s390@vger.kernel.org, ysato@users.sourceforge.jp, mpe@ellerman.id.au, x86@kernel.org, mingo@redhat.com, vbabka@suse.cz, catalin.marinas@arm.com, will.deacon@arm.com, bp@alien8.de, luto@kernel.org, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com, linuxppc-dev@lists.ozlabs.org, mike.kravetz@oracle.com

From: Alexandre Ghiti <alex@ghiti.fr>
Date: Wed,  6 Mar 2019 14:00:05 -0500

> On systems without CONTIG_ALLOC activated but that support gigantic pages,
> boottime reserved gigantic pages can not be freed at all. This patch
> simply enables the possibility to hand back those pages to memory
> allocator.
> 
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>

For sparc:

Acked-by: David S. Miller <davem@davemloft.net>
