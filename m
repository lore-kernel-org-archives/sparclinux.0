Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A5B2690F9
	for <sparclinux@vger.kernel.org>; Tue, 12 May 2026 07:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778571923; cv=none; b=iwDy2pMA7k3JZnMXkImY3KHdQ6MILiubt459XWYJvM4wlxFgUNPdlcCFQAh57Y4/FknhpyqQQoodGYCSgWyR3A8XujiV3Da78DkeZFIQydUEWwqbqygBuJlvzW2oe2BAV06teBWRM9wto9cKu1L6GT2Qkshg4hSqC7z6RFmp6Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778571923; c=relaxed/simple;
	bh=f+yWQMRJhhFmv3gWuRjIuOMLgbpJH+o6i8+Glu9ZEP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l1G9GXqrSUZdPtas8/+olc7sbSTEx76r9vS+nXnVXvGU8W+9qUfRAjzcid7aRVvGb1Hy/2j9H1XZCjBWe0MowRmxYtpaBgbkFW4w0AAqNMMqkycAzUhjWcFpoB1eKyBjSGc9gs9EYTjIaYtqeNvH/wx1JtE+meZjg4DMARl5HeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Xn4hnga/; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Xn4hnga/"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488ba840146so45992475e9.1
        for <sparclinux@vger.kernel.org>; Tue, 12 May 2026 00:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1778571916; x=1779176716; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YuUpqcwRSMeMl5pOLaTVyc6TdYwqJl65snzBr5xo1y0=;
        b=Xn4hnga/P7L9YXCppEJLnBL4DfcInuCK+mZ6VABAT1nof0/wIln8cBcgJKclKcd9YQ
         KfJ3wGhIA8F4oBkcCh7eVsAim2f3gX4XvPyGKr6rfyZk7tkIq5EkAsr071pfXmVgJN1T
         bNPuJ/EWJDz3tKEz6dMWC8g23iS/w+hEFm/rWjoFVzJ7sbmR/lRgZ9ZNWvm7Rhle6o0O
         AwdiOdCzldL/YoefkXrmaGEoDesANSIGAcD0zsc16NC59tnsWKxZmicyE1SkWMrT6Ypw
         7er+j+tt6UcCeTq1nJ+TGczD/rdw0PvxTkLW/abwwArRe8G37EIKYmD1Cl9lRbRvKNSC
         YRaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778571916; x=1779176716;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YuUpqcwRSMeMl5pOLaTVyc6TdYwqJl65snzBr5xo1y0=;
        b=O0+4MzPKnKREQFDTE+VxU9tOX3t3ugEfwTSWyWcSh77mkAIAKcZEwGZD/kj4Al0FXe
         fClfPTi0y/KetHeWp0fAkk1J3gJ1QfoMeYlQ7+lToJMr8Cyakbi7X2gOeWDU91wTn4AP
         7hh6K9JmZ0NXMXdd7eOudkKmJo6cxRmAUA2l6rsYY6l2K6H9++v94MpysWwyZBdxVLDl
         taE5JfyfHykcLrhVauoIgWR0kOCs0mxz4GmLJa0YbpOWsuHEqhusr2kxyn27x+gupEtK
         Wg592+/4/ou4gLmPPY6t7YmOUODCjnWq44b3SsHNgGtpxtXKlKQISfuu2ndXQUdSSLQY
         n51A==
X-Forwarded-Encrypted: i=1; AFNElJ/m/fo32s/L1kw7Accz9aTmptG+vNF4+Hqg/u65nRoNorwJk46HLkQqT9A0L8LY2rv2s59x24uucPdL@vger.kernel.org
X-Gm-Message-State: AOJu0YzHJv1/tWqvwRuyJl9ucUF8POVE3mHX90MN2+29WI1rjb/Ltqpt
	fcBRXnt1d+vv9qMVo4XvihbUYj7L4H5jEjkqCYDRfwdz71MlcZ6ovfCud94QxdpQ4zw=
X-Gm-Gg: Acq92OG1RyAlOXEsJuA0eauk9TGbwLWlCTqFs1AnA2+ZlMKz0OGIf7WLyrzqyNmllEl
	1c5cdfOV0XT5v9MA3lKHFf/vG/2olhQRgyYwclpixIkWnnWKqsRiqgFgqlj5MWk0gyvLxItBKwT
	1r/qQ/L84JQW7qVAno7NTD+FsQH4LBkyEqldW9VWBbVy+1qt6RIMUmu/DgIhvbBzLjzsj4l1YkP
	N7I0B0qPugyCY8ZJbgDBUodfqo39flB4nux/dwNqoH7Vb4vidObNMRuNAeM9afBYLYe3GcXrmhq
	g1qiq0+131mIcw7JkHRLDuhM4bh54WhT2dVU7tHgZthnqBcw/KHexvfv05jWhEL9IWu0D2DYGKo
	fSml60qFrTi/TWEWtSqdkLwn1a+R7UdiMBekpCPnOQHfd/3W+2QD3rKlxM8bLM8u0K9RW7rHUYj
	ymtyZT+78QXVP7aVmDkX4r6srvulNWNZZvTUGw
X-Received: by 2002:a05:600c:c058:b0:489:1aed:1658 with SMTP id 5b1f17b1804b1-48e8fe7b8bemr18623855e9.23.1778571916418;
        Tue, 12 May 2026 00:45:16 -0700 (PDT)
Received: from localhost (109-81-80-123.rct.o2.cz. [109.81.80.123])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e8f63beb7sm13428995e9.35.2026.05.12.00.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 00:45:16 -0700 (PDT)
Date: Tue, 12 May 2026 09:45:15 +0200
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
Subject: Re: [PATCH 5/8] mm/bootmem_info: stop marking the pgdat as NODE_INFO
Message-ID: <agLai5lr0CQRZLBK@tiehlicka>
References: <20260511-bootmem_info_prep-v1-0-3fb0be6fc688@kernel.org>
 <20260511-bootmem_info_prep-v1-5-3fb0be6fc688@kernel.org>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511-bootmem_info_prep-v1-5-3fb0be6fc688@kernel.org>

On Mon 11-05-26 16:05:33, David Hildenbrand wrote:
> We removed the last user of NODE_INFO in commit 119c31caa59e ("mm/sparse:
> remove !CONFIG_SPARSEMEM_VMEMMAP leftovers for CONFIG_MEMORY_HOTPLUG").
> 
> But it really was never used it besides for safety-checks ever since it was
> introduced in commit 04753278769f ("memory hotplug: register section/node
> id to free"), where we had the comment:
> 
> 	5) The node information like pgdat has similar issues. But, this
> 	   will be able to be solved too by this.
> 	   (Not implemented yet, but, remembering node id in the pages.)
> 
> Of course, that never happened, and we are not planning on freeing the
> node data (pgdat/pglist_data), during memory hotunplug.
> 
> So let's just stop marking the pgdat as NODE_INFO.

With the last user, shouldn't we simply drop NODE_INFO?

> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
>  mm/bootmem_info.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/mm/bootmem_info.c b/mm/bootmem_info.c
> index 74c1116626c8..cce1d560f094 100644
> --- a/mm/bootmem_info.c
> +++ b/mm/bootmem_info.c
> @@ -62,15 +62,8 @@ static void __init register_page_bootmem_info_section(unsigned long start_pfn)
>  
>  void __init register_page_bootmem_info_node(struct pglist_data *pgdat)
>  {
> -	unsigned long i, pfn, end_pfn, nr_pages;
> +	unsigned long pfn, end_pfn;
>  	int node = pgdat->node_id;
> -	struct page *page;
> -
> -	nr_pages = PAGE_ALIGN(sizeof(struct pglist_data)) >> PAGE_SHIFT;
> -	page = virt_to_page(pgdat);
> -
> -	for (i = 0; i < nr_pages; i++, page++)
> -		get_page_bootmem(node, page, NODE_INFO);
>  
>  	pfn = pgdat->node_start_pfn;
>  	end_pfn = pgdat_end_pfn(pgdat);
> 
> -- 
> 2.43.0
> 

-- 
Michal Hocko
SUSE Labs
