Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BF52C3757;
	Thu, 11 Jun 2026 14:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781186534; cv=none; b=FX1RkC0yPSBmH96k9PE1fRCR5y9HLFeXoaRCOsjDP1Kki113MKJrx75z4kvQinJHMpFfK0lmP4HMbeiLMfgWKbP6tX/Xo5r4MGUEj+zM4sKa9W7luesxwliHRinRpt9XE7rbHp1zQBvGtia715VVq51X2+9epbAk73J0Il97bGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781186534; c=relaxed/simple;
	bh=u5l2AxbIRB2wMoNTMU44ADkzEd9Kec6nPZZzHflUIMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aTMIuAknwbA26k/veqPy0Xvz86YxLpXQvhl+FFFqJYGBzzmd0DToDuzxgWMWTdoTQpt7RyHnhtn6s0UJ6V2zni9au4n8GTxTEWwUb/TdImLQVessRh9kb2Ht2Jn5oRm/CSmVYVtP/GzsVe+wacf59ZoMjBIjizqRboKbhJV4LDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kLFrWxBs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kLFrWxBs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 857AB1F00893;
	Thu, 11 Jun 2026 14:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781186533;
	bh=TGx263XN3d4QK7OHcwdkEuuULCXh8jD+R0LCjmF4YNE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kLFrWxBsFlBrI6vfhEMMxjaZZXc+1g4bsxZ8G+G+yDP/93GCUruzLJyFRNYzs1LZ8
	 26OquQsl8XSVmbfD37l+a6HG4oqJz8rU7XfNfBFZpkObBxiw5RlnWq8vq4V0uq7ZLv
	 2wvqO5INdyP6rbh8df+Hqdb/0wxsoa1kqNRVbpcsAUNm/D73SfkIcSUZGszwKhCOx3
	 vZIAfaBVUNMGvobJMK39Ob0jNf/rOofkeN6f3FxzmWA4DefcuC3gd76G60C6TdKFhY
	 7vB38WLYHDWLg1+8+EAROgw1JQKZ72fkHesso7wkGkN7rQVt7RKEVYncCQTGOyVen8
	 tBANP7uoOD8sw==
Date: Thu, 11 Jun 2026 16:02:06 +0200
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
Message-ID: <aiq_3rp9fwFHyLwl@localhost.localdomain>
References: <20260611-clear_not_present_full_ptes-v1-0-49865fc82629@kernel.org>
 <20260611-clear_not_present_full_ptes-v1-3-49865fc82629@kernel.org>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611-clear_not_present_full_ptes-v1-3-49865fc82629@kernel.org>

On Thu, Jun 11, 2026 at 01:50:49PM +0200, David Hildenbrand (Arm) wrote:
> Let's clean it up a bit:
> 
> (1) There is no need to pass "full" anymore.
> 
> (2) No architecture overwrites it, and there isn't really a good reason
>     to do so when dealing with non-resent PTEs.
> 
> (3) While at it, call it "non-present", similar to copy_nonpresent_pte()
>     and zap_nonpresent_ptes().
> 
> It's a shame that we have clear_non_present_ptes() correspond to
> pte_clear() and clear_ptes() correspond to ptep_get_and_clear*().
> 
> Likely we should rename pte_clear() to pte_clear_nonpresent() or sth.
> like that, to make it clearer that it is usually the wrong interface
> for dealing with present PTEs.

Is that always the case, that pte_clear() is only used on non-present
entries? Or there maybe users that do not care about the current value
and just want it to nuke?

I guess that such a renaming would have to first audit that all current
users obey that? Othen than that, is there anything else stopping us
from doing so?

> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Oscar Salvador (SUSE) <osalvador@kernel.org>

 

-- 
Oscar Salvador
SUSE Labs
