Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC2D371D0A;
	Fri, 12 Jun 2026 10:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781260623; cv=none; b=bGJ8Fzm+p51XZy7ugRthI0xmNXuPfek3ZTOGm3oVZU0Cu5yPmFu8f3PugBDpjGWSPIbUAakpAmM1jezpseFLH3VoVmhKcEdr7RE2ONZw9Jf6HSnTbhfYWROIs2Q5xZIof28uQr5e5tmgw9aW6vOLppRh1JKPfxJDt4q/ELavOLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781260623; c=relaxed/simple;
	bh=MIidP7xAaulOQbiexKCmtUfGicTHLyiZkpvadRExhk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dEja0OHrOVdZrOhfzdcgYDduax/qzJ3djGsHQOMPA1UdiBW20jnCWfeMY+jg+zU7umHJm1Uq6sbUmkRHe4b6tkBXIc/+iOfNiD3z7IcdZmwlmtyNX/BjT1XxXEcce69kG1GeSpC9LYTzl/Leu8QIIq6tfqyuHrpnYJBDGDsGOJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PA4IkpSs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PA4IkpSs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A32DB1F000E9;
	Fri, 12 Jun 2026 10:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781260622;
	bh=3f46ToGEV0rWd/D1F2Ouo2ymqlnTMfvv1MJeYenFUX0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PA4IkpSsU7xTumiuZKJOGlx0o0zzR1myfODYEV7YPikgOgSdwOhKX+frfvzGSBjAZ
	 oDndS8zEvEl8kexzDReLLnIUHi4nQTxC/Et948M3vasLcp619cDMY47mq3co9fUrqT
	 lnMG0pTS9cdiaqYpJ91rVkxXzy9bdN4ue6SHtFaO7ldgNlFvZ8rNb2FQOjpkE6muU+
	 chKQFOyiLncoDwKLTprQ+ygBzXefozD4NQ0AdB7DVV9E47OBnF1WiLNJW7TT+eW+YV
	 1WFEdBOC6ZzGnkDjPf76u52FmLDRtl2dmhR/A1MxxxtBU5pcmDX1JQBPWPiPDJ0i69
	 fBL6BlQ2lrMLA==
Date: Fri, 12 Jun 2026 12:36:55 +0200
From: "Oscar Salvador (SUSE)" <osalvador@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>,
	Peter Zijlstra <peterz@infradead.org>, sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 3/3] mm: cleanup clear_not_present_full_ptes() and rename
 to clear_non_present_ptes()
Message-ID: <aivhRywnNOOCjhTD@localhost.localdomain>
References: <20260611-clear_not_present_full_ptes-v1-0-49865fc82629@kernel.org>
 <20260611-clear_not_present_full_ptes-v1-3-49865fc82629@kernel.org>
 <aiq_3rp9fwFHyLwl@localhost.localdomain>
 <e9412b6c-ed3c-4c0c-977f-fc019297d875@kernel.org>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9412b6c-ed3c-4c0c-977f-fc019297d875@kernel.org>

On Thu, Jun 11, 2026 at 06:14:34PM +0200, David Hildenbrand (Arm) wrote:
> Usually, you want to get access and dirty bits, and that requires get_and_clear
> semantics. I suspect there are some more details to the low-level helpers.
> 
> > 
> > I guess that such a renaming would have to first audit that all current
> > users obey that? Othen than that, is there anything else stopping us
> > from doing so?
> 
> When I last skimmed over some users, they were all dealing with non-present
> entries. (mremap.c, rmap.c, mpreotect.c, memory.c, madvise.c)
> 
> But yes, we would have to audit and make sure that's the case.

So, I quickly checked some users.

As you mentioned, users from rmap.c, mremap.c, memory.c and madvise.c
deal with non-present ptes.
Hugetlb via huge_pte_clear does it for uffd markers or explicit !pte_present, so
that is fine as well.
That is wrt. generic code.

Now, moving to arch-specific code, things look a bit funny.

E.g: bpf:

arena_free_pages()-> apply_range_clear_cb()

apply_range_clear_cb() only calls pte_clear for present ptes.

Then, e.g: remove_pagetable() from powerpc and and x86 end up calling pte_clear
(for present ptes), but that is fine because we are just nuking it.
And s390 has the same in modify_pte_table()



-- 
Oscar Salvador
SUSE Labs
