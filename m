From: Dave Hansen <dave.hansen@intel.com>
Date: Wed, 18 Mar 2020 22:15:43 +0000
Subject: Re: [PATCH 1/4] hugetlbfs: add arch_hugetlb_valid_size
Message-Id: <831a0773-1ba6-4d72-44b9-7472123b8528@intel.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20200318220634.32100-1-mike.kravetz@oracle.com>
 <20200318220634.32100-2-mike.kravetz@oracle.com>
In-Reply-To: <20200318220634.32100-2-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-doc@vger.kernel.org
Cc: Albert Ou <aou@eecs.berkeley.edu>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Andrew Morton <akpm@linux-foundation.org>, Vasily Gorbik <gor@linux.ibm.com>, Jonathan Corbet <corbet@lwn.net>, Catalin Marinas <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Paul Mackerras <paulus@samba.org>, Thomas Gleixner <tglx@linutronix.de>, Longpeng <longpeng2@huawei.com>, Will Deacon <will@kernel.org>, "David S . Miller" <davem@davemloft.net>

Hi Mike,

The series looks like a great idea to me.  One nit on the x86 bits,
though...

> diff --git a/arch/x86/mm/hugetlbpage.c b/arch/x86/mm/hugetlbpage.c
> index 5bfd5aef5378..51e6208fdeec 100644
> --- a/arch/x86/mm/hugetlbpage.c
> +++ b/arch/x86/mm/hugetlbpage.c
> @@ -181,16 +181,25 @@ hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
>  #endif /* CONFIG_HUGETLB_PAGE */
>  
>  #ifdef CONFIG_X86_64
> +bool __init arch_hugetlb_valid_size(unsigned long long size)
> +{
> +	if (size = PMD_SIZE)
> +		return true;
> +	else if (size = PUD_SIZE && boot_cpu_has(X86_FEATURE_GBPAGES))
> +		return true;
> +	else
> +		return false;
> +}

I'm pretty sure it's possible to have a system without 2M/PMD page
support.  We even have a handy-dandy comment about it in
arch/x86/include/asm/required-features.h:

	#ifdef CONFIG_X86_64
	#ifdef CONFIG_PARAVIRT
	/* Paravirtualized systems may not have PSE or PGE available */
	#define NEED_PSE        0
	...

I *think* you need an X86_FEATURE_PSE check here to be totally correct.

	if (size = PMD_SIZE && cpu_feature_enabled(X86_FEATURE_PSE))
		return true;

BTW, I prefer cpu_feature_enabled() to boot_cpu_has() because it
includes disabled-features checking.  I don't think any of it matters
for these specific features, but I generally prefer it on principle.
