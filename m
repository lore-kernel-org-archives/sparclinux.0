Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C06A1A681B;
	Tue,  2 Jun 2026 04:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780375234; cv=none; b=BojTREViXpdCtockFHjLeOVAySGX3VNImTnXifcG32XSRHx/Q25KVUrG954DAU9wmUzKVZBswufDJmrzpYITb82tOTxvJXK8GnT3IEafcaMqiAeC1avlZzTuKTv6ll+Mfr5OQB44rR+2ZrXd5Ya9eCoBuiSrS/LGiCDASUqhlL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780375234; c=relaxed/simple;
	bh=JeBgjr7N+FIND5KIjD+tMMPmCPq9rkF/prcJ+V/O824=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d9iwfaH+zwSqeE7Xj+oxF3Xev/1w2BMm2JXJ6JgBC2ADP0wJfsrJLzCCH76dtSAmZT6Nxb824/EEcvFUCw6DdBWa5WNbrD4h+4iJqIQQAmfB7QsE+o+3XeSB9ee29DPDvez8H45U31xKI1wNiGgkLx5XiUjKUsm4kvBjoeguUFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AVxln0DQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AVxln0DQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43B6F1F00893;
	Tue,  2 Jun 2026 04:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780375233;
	bh=srXwF/yhg+rbIcHkVtsiegnwql9Xlps6nvacpPywWg4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AVxln0DQCY1PNRUb9aWahhA0PjWLTKukZTz6gcf/R6ukpUVkqFE8CWcIeAncWYn7N
	 9SVxYIW6aEFeLIlpyYOFHeaEHecDbIuH3q+g5YLAKEHaNn6ZRrgsqJihYLcXVkdG1x
	 u8LM5FkmNtBFW2jPuWRqGDHrJbv/cHyD11bDv+X/qQmKmosro2X4Pg0c151+Y8SSAv
	 hQWSIBG7Hk+uobN/a+cvh066m33eGdPyJnddbAG+dmD9IyBZMt1CDCndeajD7bKPSP
	 7X0uyZ4JancSZq6PFTUoH3q4q3QPPvxzUudeqGg4m53tr/brD9qU9izIXKAOHQBjPp
	 P3lcfQWN227kQ==
Date: Tue, 2 Jun 2026 06:40:24 +0200
From: "Oscar Salvador (SUSE)" <osalvador@kernel.org>
To: Muchun Song <muchun.song@linux.dev>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	Muchun Song <songmuchun@bytedance.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <pjw@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
	Andreas Larsson <andreas@gaisler.com>,
	"David S. Miller" <davem@davemloft.net>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, loongarch@lists.linux.dev,
	sparclinux@vger.kernel.org, Alexandre Ghiti <alex@ghiti.fr>,
	Albert Ou <aou@eecs.berkeley.edu>, WANG Xuerui <kernel@xen0n.name>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v3 1/5] mm/sparse-vmemmap: provide generic
 vmemmap_set_pmd() and vmemmap_check_pmd()
Message-ID: <ah5euKU9l3pP_8Ty@localhost.localdomain>
References: <20260601084845.3792171-1-songmuchun@bytedance.com>
 <20260601084845.3792171-2-songmuchun@bytedance.com>
 <db8d440d-c8a1-4f77-b5d9-00bab8737f12@kernel.org>
 <0D4AF42F-37C5-4A76-9703-44ACC6374C48@linux.dev>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0D4AF42F-37C5-4A76-9703-44ACC6374C48@linux.dev>

On Mon, Jun 01, 2026 at 08:37:42PM +0800, Muchun Song wrote:
> 
> 
> > On Jun 1, 2026, at 20:22, David Hildenbrand (Arm) <david@kernel.org> wrote:
> > 
> > On 6/1/26 10:48, Muchun Song wrote:
> >> The two weak functions are currently no-ops on every architecture,
> >> forcing each platform that needs them to duplicate the same handful
> >> of lines.  Provide a generic implementation:
> >> 
> >> - vmemmap_set_pmd() simply sets a huge PMD with PAGE_KERNEL protection.
> >> 
> >> - vmemmap_check_pmd() verifies that the PMD is present and leaf,
> >>  then calls the existing vmemmap_verify() helper.
> >> 
> >> Architectures that need special handling can continue to override the
> >> weak symbols; everyone else gets the standard version for free.
> >> 
> >> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> >> ---
> >> v2->v3:
> >> - Replace BUG_ON() with WARN_ON_ONCE() in vmemmap_set_pmd()
> >> ---
> >> mm/sparse-vmemmap.c | 7 ++++++-
> >> 1 file changed, 6 insertions(+), 1 deletion(-)
> >> 
> >> diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
> >> index 112ccf9c71ca..99e2be39671b 100644
> >> --- a/mm/sparse-vmemmap.c
> >> +++ b/mm/sparse-vmemmap.c
> >> @@ -386,12 +386,17 @@ int __meminit vmemmap_populate_hvo(unsigned long addr, unsigned long end,
> >> void __weak __meminit vmemmap_set_pmd(pmd_t *pmd, void *p, int node,
> >>       unsigned long addr, unsigned long next)
> >> {
> >> + 	WARN_ON_ONCE(!pmd_set_huge(pmd, virt_to_phys(p), PAGE_KERNEL));
> > 
> > 
> > Not sure if a VM_WARN_ON_ONCE() would be appropriate. (then, we have to move the
> > pmd_set_huge() out of the statement).
> 
> I think it might be better to keep WARN_ON_ONCE here. This way, we can still
> monitor for warnings in production while keeping the code simple.

IIRC there was a discussion about this some time ago, given the fact that quite
some people out there tend to have 'panic_on_warn', but then again, if we fail to
set a PMD here it means something pretty nasty happened, so I am ok with that.

 

-- 
Oscar Salvador
SUSE Labs
