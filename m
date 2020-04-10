From: Peter Xu <peterx@redhat.com>
Date: Fri, 10 Apr 2020 19:34:19 +0000
Subject: Re: [PATCH v2 3/4] hugetlbfs: remove hugetlb_add_hstate() warning for existing hstate
Message-Id: <20200410193419.GF3172@xz-x1>
List-Id: <sparclinux.vger.kernel.org>
References: <20200401183819.20647-1-mike.kravetz@oracle.com>
 <20200401183819.20647-4-mike.kravetz@oracle.com>
In-Reply-To: <20200401183819.20647-4-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Kravetz <mike.kravetz@oracle.com>
Cc: linux-doc@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-mm@kvack.org, Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org, Will Deacon <will@kernel.org>, Mina Almasry <almasrymina@google.com>, linux-s390@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Longpeng <longpeng2@huawei.com>, Albert Ou <aou@eecs.berkeley.edu>, Vasily Gorbik <gor@linux.ibm.com>, Paul Walmsley <paul.walmsley@sifive.com>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Christophe Leroy <christophe.leroy@c-s.fr>, linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org, "David S . Miller" <davem@davemloft.net>

On Wed, Apr 01, 2020 at 11:38:18AM -0700, Mike Kravetz wrote:

[...]

> @@ -3255,7 +3254,6 @@ void __init hugetlb_add_hstate(unsigned int order)
>  	unsigned long i;
>  
>  	if (size_to_hstate(PAGE_SIZE << order)) {
> -		pr_warn("hugepagesz= specified twice, ignoring\n");
>  		return;
>  	}

Nitpick: I think the brackets need to be removed to follow linux
coding style.  With that:

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu
