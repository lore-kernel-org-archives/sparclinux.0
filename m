Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43FE3CF058
	for <sparclinux@vger.kernel.org>; Mon, 18 May 2026 07:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779090603; cv=none; b=H729QTdSKckwPoTfYSrC/NGnP4He4NyviRFCoQ/+WNxJfjnKez4G8Z61840rm5XRKYjjzjicbXriLQnuoDnGHZrvPkIz25ZWWT8sTNd78qiq8jzty8EqGNLhO+ttvIuwj/o/D4wSc4V/2cVY6N45WYP0ZXxBkqbaXVeglh8NmLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779090603; c=relaxed/simple;
	bh=dlHK93f7h9wI2wKbxsG36bajUuLGo9Wq/tg0HHtlEMc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BSSOofD1CfWL9cetO2R6zYJfzoxi70sNa3Lg3gecwPISrUHjCTIGhPQ8aX99FZhc1bm6RtlQqNMqZIZQ+NfG0h58kRveERPGavBpWhKyi1aB+fsjK258oVG1sFvPfmnALsf3a8rd/dFUFJuDk02DpxquD0uAYiAw+Kyz6f8FgM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sQA9gAlm; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sQA9gAlm"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779090587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fTTRIuI2xioXcBOay/WhZ57PMiS4AlcVkZHDZZirdOs=;
	b=sQA9gAlmLXajI0q10KUnEdN1uuZqCxucU3NRWLlR3WCTWt4IvAIwwMmL9Yv6cg1ak9LTUk
	GcZJgc51RUZJ7q5loEHLNQ7RZ6YM5RGuq2Q/7SkVZott8sl3sIvYYq4EpVgjv3FmqR41gO
	tjAWCElujIzm29k6iPaM4P/xnC8SWbI=
From: Lance Yang <lance.yang@linux.dev>
To: david@kernel.org
Cc: davem@davemloft.net,
	andreas@gaisler.com,
	rppt@kernel.org,
	akpm@linux-foundation.org,
	agordeev@linux.ibm.com,
	gerald.schaefer@linux.ibm.com,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-s390@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Lance Yang <lance.yang@linux.dev>
Subject: Re: [PATCH 2/8] mm/bootmem_info: drop initialization of page->lru
Date: Mon, 18 May 2026 15:49:31 +0800
Message-Id: <20260518074931.34380-1-lance.yang@linux.dev>
In-Reply-To: <20260511-bootmem_info_prep-v1-2-3fb0be6fc688@kernel.org>
References: <20260511-bootmem_info_prep-v1-2-3fb0be6fc688@kernel.org>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On Mon, May 11, 2026 at 04:05:30PM +0200, David Hildenbrand (Arm) wrote:
>In the past, we used to store the type in page->lru.next, introduced by
>commit 5f24ce5fd34c ("thp: remove PG_buddy"). The location changed over
>the years; ever since commit 0386aaa6e9c8 ("bootmem: stop using
>page->index"), we store it alongside the info in page->private.
>
>Consequently, there is no need to reset page->lru anymore.
>
>Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>---
> mm/bootmem_info.c | 1 -
> 1 file changed, 1 deletion(-)
>
>diff --git a/mm/bootmem_info.c b/mm/bootmem_info.c
>index 3d7675a3ae04..a0a1ecdec8d0 100644
>--- a/mm/bootmem_info.c
>+++ b/mm/bootmem_info.c
>@@ -34,7 +34,6 @@ void put_page_bootmem(struct page *page)
> 	if (page_ref_dec_return(page) == 1) {
> 		ClearPagePrivate(page);
> 		set_page_private(page, 0);
>-		INIT_LIST_HEAD(&page->lru);

Yep, that old INIT_LIST_HEAD() call was dead cleanup. page->lru and
page->buddy_list are in the same union:

			union {
				struct list_head lru;

				/* Or, free page */
				struct list_head buddy_list;
			};

and free_reserved_page() passes the page to the buddy allocator. The
later buddy list insertion will overwrite the values written by
INIT_LIST_HEAD(&page->lru) anyway.

> 		kmemleak_free_part_phys(PFN_PHYS(page_to_pfn(page)), PAGE_SIZE);
> 		free_reserved_page(page);
> 	}

LGTM, feel free to add:
Reviewed-by: Lance Yang <lance.yang@linux.dev>
