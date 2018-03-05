From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Mon, 05 Mar 2018 21:50:26 +0000
Subject: Re: [PATCH v12 10/11] sparc64: Add support for ADI (Application Data Integrity)
Message-Id: <6d57c534-5696-e7a2-4b97-5521afcd072a@linux.intel.com>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1519227112.git.khalid.aziz@oracle.com>
 <d8602e35e65c8bf6df1a85166bf181536a6f3664.1519227112.git.khalid.aziz@oracle.com>
 <08ef65c1-16b3-44e7-5cc3-7b6bde7bd5a4@linux.intel.com>
 <b241c894-7751-bd01-2658-4cb6b89f7454@oracle.com>
In-Reply-To: <b241c894-7751-bd01-2658-4cb6b89f7454@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Khalid Aziz <khalid.aziz@oracle.com>, davem@davemloft.net, akpm@linux-foundation.org
Cc: corbet@lwn.net, bob.picco@oracle.com, steven.sistare@oracle.com, pasha.tatashin@oracle.com, mike.kravetz@oracle.com, rob.gardner@oracle.com, mingo@kernel.org, nitin.m.gupta@oracle.com, anthony.yznaga@oracle.com, kirill.shutemov@linux.intel.com, tom.hromatka@oracle.com, allen.pais@oracle.com, tklauser@distanz.ch, shannon.nelson@oracle.com, vijay.ac.kumar@oracle.com, mhocko@suse.com, jack@suse.cz, punit.agrawal@arm.com, hughd@google.com, thomas.tai@oracle.com, ross.zwisler@linux.intel.com, dave.jiang@intel.com, willy@infradead.org, minchan@kernel.org, imbrenda@linux.vnet.ibm.com, aarcange@redhat.com, kstewart@linuxfoundation.org, pombredanne@nexb.com, tglx@linutronix.de, gregkh@linuxfoundation.org, nagarathnam.muthusamy@oracle.com, linux@roeck-us.net, jane.chu@oracle.com, dan.j.williams@intel.com, jglisse@redhat.com, ktkhai@virtuozzo.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, sparclinux@vger.kernel.org, Khalid Aziz <khalid@gonehiking.org>

On 03/05/2018 01:37 PM, Khalid Aziz wrote:
>> How big can this storage get, btw?=C2=A0 Superficially it seems like it =
might
>> be able to be gigantic for a large, sparse VMA.
>>
> Tags are stored only for the pages being swapped out, not for the pages
> in entire vma. Each tag storage page can hold tags for 128 pages (each
> page has 128 4-bit tags, hence 64 bytes are needed to store tags for an
> entire page allowing each page to store tags for 128 pages). Sparse VMA
> does not cause any problems since holes do not have corresponding pages
> that will be swapped out. Tag storage pages are freed once all the pages
> they store tags for have been swapped back in, except for a small number
> of pages (maximum of 8) marked for emergency tag storage.

With a linear scan holding a process-wide spinlock?  If you have a fast
swap device, does this become the bottleneck when swapping ADI-tagged
memory?

FWIW, this tag storage is complex and subtle enough code that it
deserves to be in its own well-documented patch, not buried in a
thousand-line patch.

> +tag_storage_desc_t *find_tag_store(struct mm_struct *mm,
> +				   struct vm_area_struct *vma,
> +				   unsigned long addr)
> +{
> +	tag_storage_desc_t *tag_desc =3D NULL;
> +	unsigned long i, max_desc, flags;
> +
> +	/* Check if this vma already has tag storage descriptor
> +	 * allocated for it.
> +	 */
> +	max_desc =3D PAGE_SIZE/sizeof(tag_storage_desc_t);
> +	if (mm->context.tag_store) {
> +		tag_desc =3D mm->context.tag_store;
> +		spin_lock_irqsave(&mm->context.tag_lock, flags);
> +		for (i =3D 0; i < max_desc; i++) {
> +			if ((addr >=3D tag_desc->start) &&
> +			    ((addr + PAGE_SIZE - 1) <=3D tag_desc->end))
> +				break;
> +			tag_desc++;
> +		}
> +		spin_unlock_irqrestore(&mm->context.tag_lock, flags);

