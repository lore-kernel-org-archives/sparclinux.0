From: Michal Hocko <mhocko@kernel.org>
Date: Wed, 11 Apr 2018 08:49:36 +0000
Subject: Re: [PATCH v3 2/2] mm: remove odd HAVE_PTE_SPECIAL
Message-Id: <20180411084936.GC23400@dhcp22.suse.cz>
List-Id: <sparclinux.vger.kernel.org>
References: <1523433816-14460-1-git-send-email-ldufour@linux.vnet.ibm.com>
 <1523433816-14460-3-git-send-email-ldufour@linux.vnet.ibm.com>
 <20180411083315.GA23400@dhcp22.suse.cz>
 <5bd1bb46-8f71-e6db-7fb7-43d023a37f58@linux.vnet.ibm.com>
In-Reply-To: <5bd1bb46-8f71-e6db-7fb7-43d023a37f58@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed 11-04-18 10:41:23, Laurent Dufour wrote:
> On 11/04/2018 10:33, Michal Hocko wrote:
> > On Wed 11-04-18 10:03:36, Laurent Dufour wrote:
> >> @@ -881,7 +876,8 @@ struct page *_vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
> >>  
> >>  	if (is_zero_pfn(pfn))
> >>  		return NULL;
> >> -check_pfn:
> >> +
> >> +check_pfn: __maybe_unused
> >>  	if (unlikely(pfn > highest_memmap_pfn)) {
> >>  		print_bad_pte(vma, addr, pte, NULL);
> >>  		return NULL;
> >> @@ -891,7 +887,7 @@ struct page *_vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
> >>  	 * NOTE! We still have PageReserved() pages in the page tables.
> >>  	 * eg. VDSO mappings can cause them to exist.
> >>  	 */
> >> -out:
> >> +out: __maybe_unused
> >>  	return pfn_to_page(pfn);
> > 
> > Why do we need this ugliness all of the sudden?
> Indeed the compiler doesn't complaint but in theory it should since these
> labels are not used depending on CONFIG_ARCH_HAS_PTE_SPECIAL.

Well, such a warning would be quite pointless so I would rather not make
the code ugly. The value of unused label is quite questionable to start
with...

-- 
Michal Hocko
SUSE Labs
