Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC15481A92
	for <sparclinux@vger.kernel.org>; Tue, 12 May 2026 07:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778571979; cv=none; b=cqAOlhcHZhw9hY25yWyF7bAlOWAeqyD/f8mjbaCo9EGISUVxuBPmY5do4TYuWqSDwSnpRoyp2boTJ5sFn2PwjKfP1Jkyd3ElawnxNy8jcgWTdgVRXQCa/+ZR23xGYHpbeJIsd6XgDgDiyWq1mqT9GlnZQdNGJyCxmkdCmAKD4Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778571979; c=relaxed/simple;
	bh=/Z0eDts7hPR158brE6qkne1NNt8xM3IFZWLEr3Ouv4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sejhb0A/PmUL/Lieci6JwMQSIolclXpjplT+55a8a7YQNnhzo5+jmD8rtlf1bECSqT6EhQpAr9jfqtbnxIFjVdDU4ZsWZkGuZDQ0OJkcruMArGStHeCY4BuTGaWrt9oDzIcGRyWfNfApl4G8OQzdko8ea/nx4IARxoEZOhMewZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TmN8fyUc; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TmN8fyUc"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48d102471a4so51098275e9.2
        for <sparclinux@vger.kernel.org>; Tue, 12 May 2026 00:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1778571971; x=1779176771; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MV3zAoldwoclbqs7qOGs2hdICyTLCe/Y0G+BfFOFXqo=;
        b=TmN8fyUcGD3UV4/9o2jXioobwkzO8Rgv78EP0grsZh1d/mSD62zYDLRKmqiGWVBRMl
         9w/zsz0u/MmuQG+m1kE2I4P1UkYAyt6SPYzUqpn9rBuqK0xQ10BffgP+spoDChgcObHf
         dWA9y8gymnJ3QZSkcq7F1tvx1gPOA5U2PanxKoGsy9vRgElDwQLFGAR0D4XGG929L4zs
         3fmNSeBghzd9F3eikTLgnPOLqgwP3JQv6PL0dAj/VU6hooOY/CHsRMMobHlytap4jH0R
         ZwB9ejY3Vhh/yK9AXslQZ9vFVlqyaVsQJ1dZWVkG/jO6KHrHhYNAQX3aHxz3hli8IiDV
         N2CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778571971; x=1779176771;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MV3zAoldwoclbqs7qOGs2hdICyTLCe/Y0G+BfFOFXqo=;
        b=XeX9bDXtWiFNmH/T7NS2xwimk9uRoj9uHON+Sr0sZAKpPd7HgWHjuilqj4LGVsN6mH
         gK+m3E6ozvUjIvszENDRCXTkRAnHIfriQ8Pp24YeLFfJNSOw23akbu0WcY6L2s0u/1e0
         hlGMBwZ6t0IiC6WqcfFrKuauvOVA3WPqa5ITqyqeb9ajd97c/l3jZl+ewxihYE+xIRNf
         JwYSZDFRVPftPG9v2uCKyx+6FgmR2pZlokUJXp7+U7rUmPKeq/QLejav84vomVZVSqgI
         JILLmEgFv3FmIIhdHOu7dgDsA59FFREv80Q7FUblmgHRoH8Yf2MYY4pJUqTQ8rYaHhrS
         SQ6w==
X-Forwarded-Encrypted: i=1; AFNElJ/tf4WzkJNAmhDZ/4dktYztiuOVcavDl8YIDr8iEqCrWdxfbGIIRb1UAMcsdNT0XDvNfwt/arrF0XP8@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7/ARE62+HAAw9f9Vtghc+2+ZOWVMtS++Djra9iLafEoKvlWEk
	xUUkcpljHlMf/kYxCTHi57xJkv+8o78ad8giv7KgVQ3qz5W8MVTXP7PojyOd/dotcXU=
X-Gm-Gg: Acq92OFq+B33/65jt+5uQeExHgArWgay8qV162AFlwWcqv7Y7Wq0oFtRxXEhZnfTDQn
	2xumVmoz+F0xllC07Y5ovDdwShMladNaWhEonWCxqzshIxeNhfTwdWjE+oZ/2fB8za7dnM1veZV
	qztHNXM6mxDwsSEjbze94DqepdFxA13+62D+ukU++X9kkV5+W7Peo9/AH1QoAM14E+tZnXRXbc/
	SY1u/MhIhmlg81HY94a75F5PWOrVBmP6PHRzmM2X2QJEpwI6yVaRa+1QANPuZFfRAQ6jDgKsqEg
	IAV85nHQl6M+aETALckyJX8IBo0mEGUKyemH8NkZvelqWlsLwb1s+/AvSEQz6nVXP+kb7Y4J12G
	Z8XEwUxI0IyerIFpBduUulAN0LPAG0WLiGU6AvE+4sOH9dOxzPFlW9i9RhQ6SOrm+KLY+pcUbHV
	5ABeJZfZaJIc6V8ORmJhlkKB+/nE37tgM766fG
X-Received: by 2002:a05:600c:a02:b0:48a:6798:52e9 with SMTP id 5b1f17b1804b1-48e67244c53mr274594475e9.0.1778571970739;
        Tue, 12 May 2026 00:46:10 -0700 (PDT)
Received: from localhost (109-81-80-123.rct.o2.cz. [109.81.80.123])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e908cb62dsm42830055e9.10.2026.05.12.00.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 00:46:10 -0700 (PDT)
Date: Tue, 12 May 2026 09:46:09 +0200
From: Michal Hocko <mhocko@suse.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>, sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 0/8] mm: remove CONFIG_HAVE_BOOTMEM_INFO_NODE (Part 1)
Message-ID: <agLawTyWlnuC9Rz1@tiehlicka>
References: <20260511-bootmem_info_prep-v1-0-3fb0be6fc688@kernel.org>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511-bootmem_info_prep-v1-0-3fb0be6fc688@kernel.org>

On Mon 11-05-26 16:05:28, David Hildenbrand wrote:
> We want to remove CONFIG_HAVE_BOOTMEM_INFO_NODE. As a first step,
> let's limit the remaining harm to x86 and core code, removing
> sparc, ppc and s390 leftovers, starting the stepwise removal by removing
> and simplifying some code.
> 
> Once a related x86 vmemmap fix [1] is in, we can merge part 2 that will
> remove CONFIG_HAVE_BOOTMEM_INFO_NODE entirely.
> 
> Tested on x86-64 with hugetlb vmemmap optimization in combination with
> KMEMLEAK, making sure that the problem reported in dd0ff4d12dd2 ("bootmem:
> remove the vmemmap pages from kmemleak in put_page_bootmem") does not
> reappear -- hoping I managed to trigger the original problem.
> 
> Heavily cross-compiled, but let's let build bots run on it for a bit.
> 
> [1] https://lore.kernel.org/r/20260429-vmemmap-v2-1-8dfcacffd877@kernel.org 
> 
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
> David Hildenbrand (Arm) (8):
>       sparc/mm: remove register_page_bootmem_info()
>       mm/bootmem_info: drop initialization of page->lru
>       mm/bootmem_info: stop using PG_private
>       mm/bootmem_info: remove call to kmemleak_free_part_phys()
>       mm/bootmem_info: stop marking the pgdat as NODE_INFO
>       mm/bootmem_info: stop marking mem_section_usage as MIX_SECTION_INFO
>       s390/mm: use free_reserved_page() in vmem_free_pages()
>       powerpc/mm: remove CONFIG_HAVE_BOOTMEM_INFO_NODE
> 
>  arch/powerpc/mm/init_64.c    |  8 --------
>  arch/s390/mm/vmem.c          |  3 +--
>  arch/sparc/mm/init_64.c      | 20 --------------------
>  include/linux/bootmem_info.h |  1 -
>  mm/Kconfig                   |  2 +-
>  mm/bootmem_info.c            | 25 ++-----------------------
>  6 files changed, 4 insertions(+), 55 deletions(-)

Good clean up. Feel free to add
Acked-by: Michal Hocko <mhocko@suse.com>
to all patches but kmemleak one which I do not feel qualified to judge.

Thanks!

-- 
Michal Hocko
SUSE Labs
