From: David Miller <davem@davemloft.net>
Date: Wed, 03 Oct 2012 00:53:18 +0000
Subject: Re: [PATCH 0/8] THP support for Sparc64
Message-Id: <20121002.205318.1484512119234167322.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20121002.182601.845433592794197720.davem@davemloft.net>
	<20121002155544.2c67b1e8.akpm@linux-foundation.org>
In-Reply-To: <20121002155544.2c67b1e8.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, aarcange@redhat.com, hannes@cmpxchg.org, gerald.schaefer@de.ibm.com

From: Andrew Morton <akpm@linux-foundation.org>
Date: Tue, 2 Oct 2012 15:55:44 -0700

> I had a shot at integrating all this onto the pending stuff in linux-next. 
> "mm: Add and use update_mmu_cache_pmd() in transparent huge page code."
> needed minor massaging in huge_memory.c.  But as Andrea mentioned, we
> ran aground on Gerald's
> http://ozlabs.org/~akpm/mmotm/broken-out/thp-remove-assumptions-on-pgtable_t-type.patch,
> part of the thp-for-s390 work.

I'll rebase my work against that stuff, looks fine to me.
