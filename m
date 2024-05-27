Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97E61E4A9
	for <sparclinux@vger.kernel.org>; Mon, 27 May 2024 15:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716824643; cv=none; b=Ec7WfCglAZDaVxacx0u38r8d51NBbEao3YndcOJAFLytyANfDDfCXZRRBi/o5lI38vYBZk9nHfacCJ+HhwbPPfSbGkmFIr2gFp4FE/uJIS+v+Iqkhc1NDt4ne3PJ+mLcMe6I6KG1h2bC942OmdQ+Z0KT9EjQKCSmjkCIPlrqeZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716824643; c=relaxed/simple;
	bh=iFiJRTERvUUOzw9z/0q2wi+diCNAv1X6Y3kSP+r2fa8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g0o2rWLcrAAgOnk46rSNLLl8p+BQ8W/q/h1YZHkjPzs/Kjw4eJb/SljbbW/VKSD0RByCr+EBBjhUB327wBuJSb1vOsqiu6wsOXguZbMlzIwWhS1E0+ci05QlxAYbZfBtWscaT0l2PS+7M5H0PkpiF0UInke9xlLOwOfNd+n6Rlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H8yS4Bb/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H8yS4Bb/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716824640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jYZGz7F2HkN4H4qp3H29TFAfu9PHGhaYKuv4XtGKt7g=;
	b=H8yS4Bb/aNClSWYlVYJE8O199z53chkV2zDWZH8PO6n+MZzKzwH+W3IdPnlX0l5cPkGY8m
	WNHmdMhtGPh498Ab6rXB3o8WgNCSBTUZGA+TJAaRMkBRS6DkEkl4XaXbM8g0RIX2DKVJUr
	P8G+yBEkQpMrx6xb/KgeBeAED8Ni8JM=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-dnkn5OaRPyqJQzSeeGgp3A-1; Mon, 27 May 2024 11:43:59 -0400
X-MC-Unique: dnkn5OaRPyqJQzSeeGgp3A-1
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-24ff6093e72so13953fac.2
        for <sparclinux@vger.kernel.org>; Mon, 27 May 2024 08:43:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716824638; x=1717429438;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jYZGz7F2HkN4H4qp3H29TFAfu9PHGhaYKuv4XtGKt7g=;
        b=hF/av8EUBxU7u4sOtnIHACRBLi4WK4Gk3Vk9s28IoSbu1X6ol3GZNq5wmKxj72OAYh
         X+KxDGL7YwOPcImsJuH5j4lzG6UaT+uVg1Zf6bzfeKSBI33QKPaiqfLOApjLWPAwc/hi
         VfZbZdfEfr9u3P/VRF9DCs6i/XIiTVXpwg/EKyRkQiummkVYQM5cCuRxdu21dsG89XPZ
         vAKjXoR6QXPJszAfLC6TDtYkip3zgMnjJI+mecL0wjwuONqdwTe1nKzxp/9m0p+hhVEe
         TIUyS01uGszLctkhiA5UR3dEyu8oYur4wXsMyue+VNtmS+wbMAlwPycoq8+p84Ttb5hN
         6MmA==
X-Forwarded-Encrypted: i=1; AJvYcCWHXyQh6vA/lbkhNXTWx89g58AANfFAJ6vowuDjnoElWl7vI+LZwf1R+eKdUHrwjYgV6dcAOlg2qeHvyhyl4J4EgwiWZd+LhL4drg==
X-Gm-Message-State: AOJu0YxALnuwQn34FXX4Vw7DgGqK98kOjEJxU1CmpnlXGNpBM7Vt0Ndr
	mO64WVZ0GSpKUfJTZGFjmx81KF2TByLcbglKk30yiluwrISSMLVs4+ydPbdulOndDfsVs3+4ePf
	M6r8DYuwgxsNKjRnz0+irDrDKu1G06IQcDxBr2SnJF715UJW7lmhiJXtVQRk=
X-Received: by 2002:a05:6358:716:b0:192:47fd:8be3 with SMTP id e5c5f4694b2df-197e5671b94mr1114623355d.3.1716824638158;
        Mon, 27 May 2024 08:43:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqu64yXCSH6zIgkGZqg9gyTi88XsJqX1EQqATRLKBAyQwdGY9SZpdiRPG6qy2xlzfZr724FA==
X-Received: by 2002:a05:6358:716:b0:192:47fd:8be3 with SMTP id e5c5f4694b2df-197e5671b94mr1114603355d.3.1716824636813;
        Mon, 27 May 2024 08:43:56 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ac070c2eeasm35518706d6.19.2024.05.27.08.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 08:43:56 -0700 (PDT)
Date: Mon, 27 May 2024 11:43:54 -0400
From: Peter Xu <peterx@redhat.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"x86@kernel.org" <x86@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Mike Rapoport <rppt@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	"sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 12/14] mm/treewide: Remove pXd_huge()
Message-ID: <ZlSqOmvS9jkDwZub@x1n>
References: <20240318200404.448346-1-peterx@redhat.com>
 <20240318200404.448346-13-peterx@redhat.com>
 <60ea6d69-a5f8-4e7b-8c4c-e54488adfadb@csgroup.eu>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <60ea6d69-a5f8-4e7b-8c4c-e54488adfadb@csgroup.eu>

On Mon, May 27, 2024 at 06:03:30AM +0000, Christophe Leroy wrote:
> 
> 
> Le 18/03/2024 à 21:04, peterx@redhat.com a écrit :
> > From: Peter Xu <peterx@redhat.com>
> > 
> > This API is not used anymore, drop it for the whole tree.
> 
> Some documentation remain in v6.10-rc1:
> 
> $ git grep -w p.d_huge
> Documentation/mm/arch_pgtable_helpers.rst:| pmd_huge                  | 
> Tests a HugeTLB mapped PMD                       |
> Documentation/mm/arch_pgtable_helpers.rst:| pud_huge                  | 
> Tests a HugeTLB mapped PUD                       |
> arch/x86/mm/pat/set_memory.c:            * otherwise 
> pmd_present/pmd_huge will return true

True, I'll send a patch, thanks.

-- 
Peter Xu

