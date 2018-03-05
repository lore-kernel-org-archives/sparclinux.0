From: Khalid Aziz <khalid.aziz@oracle.com>
Date: Mon, 05 Mar 2018 21:37:24 +0000
Subject: Re: [PATCH v12 10/11] sparc64: Add support for ADI (Application Data Integrity)
Message-Id: <b241c894-7751-bd01-2658-4cb6b89f7454@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1519227112.git.khalid.aziz@oracle.com>
 <d8602e35e65c8bf6df1a85166bf181536a6f3664.1519227112.git.khalid.aziz@oracle.com>
 <08ef65c1-16b3-44e7-5cc3-7b6bde7bd5a4@linux.intel.com>
In-Reply-To: <08ef65c1-16b3-44e7-5cc3-7b6bde7bd5a4@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dave Hansen <dave.hansen@linux.intel.com>, davem@davemloft.net, akpm@linux-foundation.org
Cc: corbet@lwn.net, bob.picco@oracle.com, steven.sistare@oracle.com, pasha.tatashin@oracle.com, mike.kravetz@oracle.com, rob.gardner@oracle.com, mingo@kernel.org, nitin.m.gupta@oracle.com, anthony.yznaga@oracle.com, kirill.shutemov@linux.intel.com, tom.hromatka@oracle.com, allen.pais@oracle.com, tklauser@distanz.ch, shannon.nelson@oracle.com, vijay.ac.kumar@oracle.com, mhocko@suse.com, jack@suse.cz, punit.agrawal@arm.com, hughd@google.com, thomas.tai@oracle.com, ross.zwisler@linux.intel.com, dave.jiang@intel.com, willy@infradead.org, minchan@kernel.org, imbrenda@linux.vnet.ibm.com, aarcange@redhat.com, kstewart@linuxfoundation.org, pombredanne@nexb.com, tglx@linutronix.de, gregkh@linuxfoundation.org, nagarathnam.muthusamy@oracle.com, linux@roeck-us.net, jane.chu@oracle.com, dan.j.williams@intel.com, jglisse@redhat.com, ktkhai@virtuozzo.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, sparclinux@vger.kernel.org, Khalid Aziz <khalid@gonehiking.org>

On 03/05/2018 02:26 PM, Dave Hansen wrote:
> On 02/21/2018 09:15 AM, Khalid Aziz wrote:
>> +tag_storage_desc_t *alloc_tag_store(struct mm_struct *mm,
>> +				    struct vm_area_struct *vma,
>> +				    unsigned long addr)
> ...
>> +	tags = kzalloc(size, GFP_NOWAIT|__GFP_NOWARN);
>> +	if (tags = NULL) {
>> +		tag_desc->tag_users = 0;
>> +		tag_desc = NULL;
>> +		goto out;
>> +	}
>> +	tag_desc->start = addr;
>> +	tag_desc->tags = tags;
>> +	tag_desc->end = end_addr;
>> +
>> +out:
>> +	spin_unlock_irqrestore(&mm->context.tag_lock, flags);
>> +	return tag_desc;
>> +}
> 
> OK, sorry, I missed this.  I do see that you now have per-ADI-block tag
> storage and it is not per-page.
> 
> How big can this storage get, btw?  Superficially it seems like it might
> be able to be gigantic for a large, sparse VMA.
> 

Tags are stored only for the pages being swapped out, not for the pages 
in entire vma. Each tag storage page can hold tags for 128 pages (each 
page has 128 4-bit tags, hence 64 bytes are needed to store tags for an 
entire page allowing each page to store tags for 128 pages). Sparse VMA 
does not cause any problems since holes do not have corresponding pages 
that will be swapped out. Tag storage pages are freed once all the pages 
they store tags for have been swapped back in, except for a small number 
of pages (maximum of 8) marked for emergency tag storage.

--
Khalid
