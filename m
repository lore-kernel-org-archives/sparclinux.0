From: Christophe Leroy <christophe.leroy@csgroup.eu>
Date: Tue, 08 Sep 2020 05:19:38 +0000
Subject: Re: [RFC PATCH v2 3/3] mm: make generic pXd_addr_end() macros inline functions
Message-Id: <4c101685-5b29-dace-9dd2-b6f0ae193a9c@csgroup.eu>
List-Id: <sparclinux.vger.kernel.org>
References: <20200907180058.64880-1-gerald.schaefer@linux.ibm.com>
 <20200907180058.64880-4-gerald.schaefer@linux.ibm.com>
In-Reply-To: <20200907180058.64880-4-gerald.schaefer@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@linux.intel.com>, linux-mm <linux-mm@kvack.org>, Paul Mackerras <paulus@samba.org>, linux-sparc <sparclinux@vger.kernel.org>, Alexander Gordeev <agordeev@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Will Deacon <will@kernel.org>, linux-arch <linux-arch@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Vasily Gorbik <gor@linux.ibm.com>, Richard Weinberger <richard@nod.at>, linux-x86 <x86@kernel.org>, Russell King <linux@armlinux.org.uk>, Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Heiko Carstens <hca@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Jeff Dike <jdike@addtoit.com>, linux-um <linux-um@lists.infradead.org>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm <linux-arm-kernel@lists.infradead.org>, linux-power <linuxppc-dev@lists.ozlabs.org>, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>



Le 07/09/2020 à 20:00, Gerald Schaefer a écrit :
> From: Alexander Gordeev <agordeev@linux.ibm.com>
> 
> Since pXd_addr_end() macros take pXd page-table entry as a
> parameter it makes sense to check the entry type on compile.
> Even though most archs do not make use of page-table entries
> in pXd_addr_end() calls, checking the type in traversal code
> paths could help to avoid subtle bugs.
> 
> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
> Signed-off-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
> ---
>   include/linux/pgtable.h | 36 ++++++++++++++++++++----------------
>   1 file changed, 20 insertions(+), 16 deletions(-)
> 
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index 67ebc22cf83d..d9e7d16c2263 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -656,31 +656,35 @@ static inline int arch_unmap_one(struct mm_struct *mm,
>    */
>   
>   #ifndef pgd_addr_end
> -#define pgd_addr_end(pgd, addr, end)					\
> -({	unsigned long __boundary = ((addr) + PGDIR_SIZE) & PGDIR_MASK;	\
> -	(__boundary - 1 < (end) - 1)? __boundary: (end);		\
> -})
> +#define pgd_addr_end pgd_addr_end

I think that #define is pointless, usually there is no such #define for 
the default case.

> +static inline unsigned long pgd_addr_end(pgd_t pgd, unsigned long addr, unsigned long end)
> +{	unsigned long __boundary = (addr + PGDIR_SIZE) & PGDIR_MASK;
> +	return (__boundary - 1 < end - 1) ? __boundary : end;
> +}

Please use the standard layout, ie entry { and exit } alone on their 
line, and space between local vars declaration and the rest.

Also remove the leading __ in front of var names as it's not needed once 
it is not macros anymore.

f_name()
{
	some_local_var;

	do_something();
}

>   #endif
>   
>   #ifndef p4d_addr_end
> -#define p4d_addr_end(p4d, addr, end)					\
> -({	unsigned long __boundary = ((addr) + P4D_SIZE) & P4D_MASK;	\
> -	(__boundary - 1 < (end) - 1)? __boundary: (end);		\
> -})
> +#define p4d_addr_end p4d_addr_end
> +static inline unsigned long p4d_addr_end(p4d_t p4d, unsigned long addr, unsigned long end)
> +{	unsigned long __boundary = (addr + P4D_SIZE) & P4D_MASK;
> +	return (__boundary - 1 < end - 1) ? __boundary : end;
> +}
>   #endif
>   
>   #ifndef pud_addr_end
> -#define pud_addr_end(pud, addr, end)					\
> -({	unsigned long __boundary = ((addr) + PUD_SIZE) & PUD_MASK;	\
> -	(__boundary - 1 < (end) - 1)? __boundary: (end);		\
> -})
> +#define pud_addr_end pud_addr_end
> +static inline unsigned long pud_addr_end(pud_t pud, unsigned long addr, unsigned long end)
> +{	unsigned long __boundary = (addr + PUD_SIZE) & PUD_MASK;
> +	return (__boundary - 1 < end - 1) ? __boundary : end;
> +}
>   #endif
>   
>   #ifndef pmd_addr_end
> -#define pmd_addr_end(pmd, addr, end)					\
> -({	unsigned long __boundary = ((addr) + PMD_SIZE) & PMD_MASK;	\
> -	(__boundary - 1 < (end) - 1)? __boundary: (end);		\
> -})
> +#define pmd_addr_end pmd_addr_end
> +static inline unsigned long pmd_addr_end(pmd_t pmd, unsigned long addr, unsigned long end)
> +{	unsigned long __boundary = (addr + PMD_SIZE) & PMD_MASK;
> +	return (__boundary - 1 < end - 1) ? __boundary : end;
> +}
>   #endif
>   
>   /*
> 
