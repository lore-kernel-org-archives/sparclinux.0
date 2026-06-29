Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0803F0AB1;
	Mon, 29 Jun 2026 17:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782753738; cv=none; b=ROsk+GlnPituVmPJSEqYY86pDAqxfIBtLEsbZFYqvB/Wy4DGdubDr5ApbjC+YpKtP1bIWjrwr4xZg7aqhGbYN99PJSSDwUOCtYZOziHHRL0WbeVLbXKj6Xso66Q7CKKx/GI5ATdyMVfVrBVLs1q0dulj35R+ox6Bugs44QLSMNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782753738; c=relaxed/simple;
	bh=j1PfHP4HnPwoNeH5tZBhuEu0+2T+JkdlEUy7P8dUAss=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=BxBcVOMxnPVRfpudyg2dT3H8vnFGiS2QX7LL1tRoqAPNI4FeW7U2I41QZMU+RYLX0cPeDb6UeHgsbgkSZF5OqmzSn8I0Y9RRswcOLZaE7Ig8IhNt3/fBcYcy0wENEIVRMr9RFexd5v32r5aWv84A+0BVMakCaWZU4qYhH6TtT2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=uTo5qVX1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="uTo5qVX1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2699C1F000E9;
	Mon, 29 Jun 2026 17:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1782753736;
	bh=juWgsiwKrfmDYFjWzFD07h7xasT5wM0m/CbZLCSQTVE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=uTo5qVX1WCofU7ArQgIge3U5uPhkOafXY7LAqEvLoUorCsTnMWFkxpUZNTf8CHCZr
	 AeASxor7XbYPpI6VrMzqtE0MppRB7PPFVbH5MjKJ2vTBtq/2HgmS2d0vYeRlCftWN8
	 M4yhQnX7V544cg53/WuFnz9XZQ23NxJnaDdSzFfA=
Date: Mon, 29 Jun 2026 10:22:15 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Andreas Larsson
 <andreas@gaisler.com>, Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett"
 <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko
 <mhocko@suse.com>, Jann Horn <jannh@google.com>, Peter Zijlstra
 <peterz@infradead.org>, "Oscar Salvador (SUSE)" <osalvador@kernel.org>,
 sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [PATCH v2 2/3] mm: drop pte_clear_not_present_full()
Message-Id: <20260629102215.09605f0e9ef66c5f58fe0932@linux-foundation.org>
In-Reply-To: <20260629-clear_not_present_full_ptes-v2-2-96089871a1e7@kernel.org>
References: <20260629-clear_not_present_full_ptes-v2-0-96089871a1e7@kernel.org>
	<20260629-clear_not_present_full_ptes-v2-2-96089871a1e7@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Jun 2026 15:49:48 +0200 "David Hildenbrand (Arm)" <david@kernel.org> wrote:

> In general, there is no good reason to do anything special when clearing
> non-present PTEs.
> 
> In theory, HW that does have to invalidate TLBs for non-present PTEs could
> benefit from a "full" parameter, but fortunately
> pte_clear_not_present_full() is not wired up anymore ... and there would
> have to be something very convincing for us to care about that to re-add
> it.
> 
> So, let's just use pte_clear() directly now. To avoid the compiler
> complaining on some configs about unused "addr" parameter, silence that
> here.

Wait, which configs do that?

> @@ -1022,8 +1007,10 @@ static inline void pte_clear_not_present_full(struct mm_struct *mm,
>  static inline void clear_not_present_full_ptes(struct mm_struct *mm,
>  		unsigned long addr, pte_t *ptep, unsigned int nr, int full)
>  {
> +	(void)addr;
> +

We heavily rely on this warning not happening.

eg, one of thousands:

static inline bool page_range_contiguous(const struct page *page,
		unsigned long nr_pages)
{
	return true;
}

So... what's happening here?
