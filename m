Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A282C4332F
	for <sparclinux@archiver.kernel.org>; Wed, 16 Nov 2022 11:03:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233713AbiKPLDN (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Wed, 16 Nov 2022 06:03:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239079AbiKPLCG (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Wed, 16 Nov 2022 06:02:06 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7C94730A
        for <sparclinux@vger.kernel.org>; Wed, 16 Nov 2022 02:49:48 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id i21so25954851edj.10
        for <sparclinux@vger.kernel.org>; Wed, 16 Nov 2022 02:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SB0xMxg7mb7arNhoP48cqWafxbk28Z1Lix7iS7Zkf4o=;
        b=G+yH7gGM79Kur0Iop0CPPA+qhziqzAzwIurg983ubYb3WshrhUBjt115nMP15JVtFB
         bCAGjPfacpREtOfp/xR/YX1SymsdQ1bgnCyPvMlgHC3mzRuO7K3B6poJkP/JWiUCmMWF
         GisY2xBmQqATnhhXA26BG81FXfyHx1zsVnNWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SB0xMxg7mb7arNhoP48cqWafxbk28Z1Lix7iS7Zkf4o=;
        b=6p2r9wEXZJNRt52YaSvZZ++7BBhfbN95lDsQrAgtFocgWb2zgSHW1b6p0LotijlmR2
         wTIRXwEGM+eglr+XpDW98kOgjqqm2NUwpXk5FoGIy6uJCyhu+mGetMNjijaGeWMCUHhr
         XuGr3yAflSH0e3yPAFtM9bkq240t7Rq6iEyomHgMrgO+gzU26sPoBnS8ZD0efLfx0a8N
         Seibj5+uRyuATAuNsyciGd9ly21ZiIlaNeJmTS3BZ8eVpIegdGI5oWW+oKha3su1uEVE
         FteNl6qbRSYDs4cDujahdx8ZOEKStrfA94UL2BP/1/liXrp7ID6q0zWWPmsQhkpSEafd
         rGmw==
X-Gm-Message-State: ANoB5pmuuBPl7Rp9IIrWd8673bGYoUUoz5UIx6gySKGa21hN5HXu9lJ8
        xN78pfqxuoHimSW1kZ6LiQT3Zg==
X-Google-Smtp-Source: AA0mqf5eZw0lnDAfrqoVYz8ol539itw9JN3l4qV2Eir0Zt6pEgAkXKur5xarVrPRHlm5su04xf/hGA==
X-Received: by 2002:a05:6402:3458:b0:458:b9f9:9fba with SMTP id l24-20020a056402345800b00458b9f99fbamr19055554edc.305.1668595786519;
        Wed, 16 Nov 2022 02:49:46 -0800 (PST)
Received: from phenom.ffwll.local (212-51-149-33.fiber7.init7.net. [212.51.149.33])
        by smtp.gmail.com with ESMTPSA id kx13-20020a170907774d00b0078ba492db81sm6694451ejc.9.2022.11.16.02.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 02:49:46 -0800 (PST)
Date:   Wed, 16 Nov 2022 11:49:43 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        linux-um@lists.infradead.org, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-samsung-soc@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-media@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-perf-users@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>,
        Peter Xu <peterx@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>, Nadav Amit <namit@vmware.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Shuah Khan <shuah@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christoph Hellwig <hch@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>
Subject: Re: [PATCH mm-unstable v1 14/20] drm/etnaviv: remove FOLL_FORCE usage
Message-ID: <Y3TAR7Ndmat+zYpJ@phenom.ffwll.local>
Mail-Followup-To: David Hildenbrand <david@redhat.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        linux-um@lists.infradead.org, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-samsung-soc@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-media@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-perf-users@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
        Peter Xu <peterx@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>, Nadav Amit <namit@vmware.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Shuah Khan <shuah@kernel.org>, Lucas Stach <l.stach@pengutronix.de>,
        David Airlie <airlied@gmail.com>, Oded Gabbay <ogabbay@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christoph Hellwig <hch@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>
References: <20221116102659.70287-1-david@redhat.com>
 <20221116102659.70287-15-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116102659.70287-15-david@redhat.com>
X-Operating-System: Linux phenom 5.19.0-2-amd64 
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Wed, Nov 16, 2022 at 11:26:53AM +0100, David Hildenbrand wrote:
> GUP now supports reliable R/O long-term pinning in COW mappings, such
> that we break COW early. MAP_SHARED VMAs only use the shared zeropage so
> far in one corner case (DAXFS file with holes), which can be ignored
> because GUP does not support long-term pinning in fsdax (see
> check_vma_flags()).
> 
> commit cd5297b0855f ("drm/etnaviv: Use FOLL_FORCE for userptr")
> documents that FOLL_FORCE | FOLL_WRITE was really only used for reliable
> R/O pinning.
> 
> Consequently, FOLL_FORCE | FOLL_WRITE | FOLL_LONGTERM is no longer required
> for reliable R/O long-term pinning: FOLL_LONGTERM is sufficient. So stop
> using FOLL_FORCE, which is really only for ptrace access.
> 
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Russell King <linux+etnaviv@armlinux.org.uk>
> Cc: Christian Gmeiner <christian.gmeiner@gmail.com>
> Cc: David Airlie <airlied@gmail.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Also ack for merging through whatever tree suits best, since I guess this
should all land together.
-Daniel

> ---
>  drivers/gpu/drm/etnaviv/etnaviv_gem.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem.c b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
> index cc386f8a7116..efe2240945d0 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gem.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
> @@ -638,6 +638,7 @@ static int etnaviv_gem_userptr_get_pages(struct etnaviv_gem_object *etnaviv_obj)
>  	struct page **pvec = NULL;
>  	struct etnaviv_gem_userptr *userptr = &etnaviv_obj->userptr;
>  	int ret, pinned = 0, npages = etnaviv_obj->base.size >> PAGE_SHIFT;
> +	unsigned int gup_flags = FOLL_LONGTERM;
>  
>  	might_lock_read(&current->mm->mmap_lock);
>  
> @@ -648,14 +649,15 @@ static int etnaviv_gem_userptr_get_pages(struct etnaviv_gem_object *etnaviv_obj)
>  	if (!pvec)
>  		return -ENOMEM;
>  
> +	if (!userptr->ro)
> +		gup_flags |= FOLL_WRITE;
> +
>  	do {
>  		unsigned num_pages = npages - pinned;
>  		uint64_t ptr = userptr->ptr + pinned * PAGE_SIZE;
>  		struct page **pages = pvec + pinned;
>  
> -		ret = pin_user_pages_fast(ptr, num_pages,
> -					  FOLL_WRITE | FOLL_FORCE | FOLL_LONGTERM,
> -					  pages);
> +		ret = pin_user_pages_fast(ptr, num_pages, gup_flags, pages);
>  		if (ret < 0) {
>  			unpin_user_pages(pvec, pinned);
>  			kvfree(pvec);
> -- 
> 2.38.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
