From: David Miller <davem@davemloft.net>
Date: Wed, 27 Jan 2016 23:17:37 +0000
Subject: Re: [RFC] hugepages on sparc
Message-Id: <20160127.181737.1288749977604132692.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <56A944DD.3060809@oracle.com>
In-Reply-To: <56A944DD.3060809@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Nitin Gupta <nitin.m.gupta@oracle.com>
Date: Wed, 27 Jan 2016 14:29:49 -0800

> I'm not a hugepage expert but as I understand, this change in default
> hugepage size is due to the way transparent hugepage (THP) is
> implemented, which looks at memory in PMD size increments and PMD
> happens to be 8M aligned. Correct?

Correct.  It is 1,000 times easier to implement THP support if the
PMD boundary matches the huge page size.  We can encode the huge PTEs
directly in the PMDs, so it's the best implementation.

> THP code in mm/huge_memory.c also seems to assume an x86 style page
> table (depends on "PMD" size etc.). This seems not ideal for
> architectures like SPARC where any data structure like hash table can
> be used for page tables. So, shouldn't THP code be using some API to
> figure out hugepage backing status of a memory area?

Making APIs easier to use for architecture other than x86 is not a
priority for anyone.

> Do you think it would be worth fixing THP as above (remove constrain
> for hugepage to be PMD aligned) to at least allow enabling hw-backed
> hugepage size as default again?

I don't see what the problem with 8MB huge pages are, they work really
well and the implementation is incredibly straightforward.

You have to demonstrate a performance of behavioral problem to justify
such work.  Then you have to come up with an implementation of the
THP ABI changes, and satisfy the THP and mm maintainers.
