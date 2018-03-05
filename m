From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Mon, 05 Mar 2018 19:22:08 +0000
Subject: Re: [PATCH v12 10/11] sparc64: Add support for ADI (Application Data Integrity)
Message-Id: <a59ece97-ba1f-dfb1-bfc8-b44ffd8edbca@linux.intel.com>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1519227112.git.khalid.aziz@oracle.com>
 <d8602e35e65c8bf6df1a85166bf181536a6f3664.1519227112.git.khalid.aziz@oracle.com>
In-Reply-To: <d8602e35e65c8bf6df1a85166bf181536a6f3664.1519227112.git.khalid.aziz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Khalid Aziz <khalid.aziz@oracle.com>, davem@davemloft.net, akpm@linux-foundation.org
Cc: corbet@lwn.net, bob.picco@oracle.com, steven.sistare@oracle.com, pasha.tatashin@oracle.com, mike.kravetz@oracle.com, rob.gardner@oracle.com, mingo@kernel.org, nitin.m.gupta@oracle.com, anthony.yznaga@oracle.com, kirill.shutemov@linux.intel.com, tom.hromatka@oracle.com, allen.pais@oracle.com, tklauser@distanz.ch, shannon.nelson@oracle.com, vijay.ac.kumar@oracle.com, mhocko@suse.com, jack@suse.cz, punit.agrawal@arm.com, hughd@google.com, thomas.tai@oracle.com, ross.zwisler@linux.intel.com, dave.jiang@intel.com, willy@infradead.org, minchan@kernel.org, imbrenda@linux.vnet.ibm.com, aarcange@redhat.com, kstewart@linuxfoundation.org, pombredanne@nexb.com, tglx@linutronix.de, gregkh@linuxfoundation.org, nagarathnam.muthusamy@oracle.com, linux@roeck-us.net, jane.chu@oracle.com, dan.j.williams@intel.com, jglisse@redhat.com, ktkhai@virtuozzo.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, sparclinux@vger.kernel.org, Khalid Aziz <khalid@gonehiking.org>

On 02/21/2018 09:15 AM, Khalid Aziz wrote:
> +#define arch_validate_prot(prot, addr) sparc_validate_prot(prot, addr)
> +static inline int sparc_validate_prot(unsigned long prot, unsigned long addr)
> +{
> +	if (prot & ~(PROT_READ | PROT_WRITE | PROT_EXEC | PROT_SEM | PROT_ADI))
> +		return 0;
> +	if (prot & PROT_ADI) {
> +		if (!adi_capable())
> +			return 0;
> +
> +		if (addr) {
> +			struct vm_area_struct *vma;
> +
> +			vma = find_vma(current->mm, addr);
> +			if (vma) {
> +				/* ADI can not be enabled on PFN
> +				 * mapped pages
> +				 */
> +				if (vma->vm_flags & (VM_PFNMAP | VM_MIXEDMAP))
> +					return 0;

You don't hold mmap_sem here.  How can this work?
