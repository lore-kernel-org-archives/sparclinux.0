Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8928279DD4
	for <sparclinux@vger.kernel.org>; Tue, 12 Mar 2024 20:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710273682; cv=none; b=KmK7D9xp4lRrMNZbBetNhG3xcw/eBDj1ILYNspJ8aTEf6LPbwbGr5ee3Rbfew/qf19oDjeq/IXhqDvhOGHeBFFtcml5XJn7WHPaq45z20vI4pgM5Cc+rib5If6yWIIxitQZs46hNW/dpnZuVPTdPzWIFGm753nP2KaU8T1dtcOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710273682; c=relaxed/simple;
	bh=0a8n08WPCW1Zky1uteVZ0stAKm5h/96u1j8Uh3AQSwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ueyg6oOM0/vmfjt7M5+ACRNAF7snfCOoN43wnVYTKrwQqBCx0ePqq5gOn5iNmWSTY2WVSJ0ExvhDd1KzGCPkPbKOfCiHu5ZPFOpKQxeMj1Rcr8voRB8ofxM9UbWKbYwPQzd0SiisAvwtn0T+Dv7GRVRZkUHVRzhf3/7eXFJiin8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZNjZyfxP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZNjZyfxP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710273679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sq8Q7APw4DcVkqWc+oejv1fuFkz+jT1GPn/e6E4W0Yk=;
	b=ZNjZyfxPxXGSe3KC3QhPcaQVEc8F70dFtoaEU/+H9DHhN3nB3FSG3ZRQw2K7loOLEmbwu9
	kLXYDL4DUUlDaVmNzZ/RA6zCyKT5HNdT6yDpdYFk/4aqKrK2T259ou1kx1WCoJqr7xLY0k
	jB4hE/8XPTN4nHjDRLOBT+zRQE0mpU8=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-j1vpuxiiPXu2sB-LjHhdjA-1; Tue, 12 Mar 2024 16:01:18 -0400
X-MC-Unique: j1vpuxiiPXu2sB-LjHhdjA-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-42ed8fb8ce0so5362901cf.1
        for <sparclinux@vger.kernel.org>; Tue, 12 Mar 2024 13:01:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710273677; x=1710878477;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sq8Q7APw4DcVkqWc+oejv1fuFkz+jT1GPn/e6E4W0Yk=;
        b=cptmgTUBgglLQLLHQc84k3VNk80QnDDgKjOL6GNMWDuktsvDBgqklvOZjjx4Ddzlw0
         JIjq482q/Vtef0TDtgx56WSnPLeJWV7UR4clSsqtgm93L2SJIST3UZbWMdR2jS0ygLlh
         fx/Yj0nSoIHKTTboAVLB7qY5HdN/x2EU+8i/s4po6HIgSLeXqe6B1AKGLTMAFGyAzXd+
         FUb71GN1KSAiCzA6pbmr7kmAF/EbIxpxk/4MgzdYdEwodoL6l5wOXxdAUERkM0NV0UBt
         prKAa1utYpDcyA65qwiSf8WpBjXHJ0L1S18xjvsSoD4/IaekaDyadKA0hdhkTJwq601H
         lMLg==
X-Forwarded-Encrypted: i=1; AJvYcCXT4W4RKpm1KW6hnkoW14WkVGALZZY5EgZMkNEslKDi5oHXRN3O68Xr4z+daB7HUcjoQ2zFxJZjTQDlBIL/nzqJcir5tUC1Js/V2A==
X-Gm-Message-State: AOJu0Yy/0ZWr7CeP2BYATC+U2b0+hpuwFdZ1+UtejeBoEfWi3r1HhoDK
	hzwLNB6bn2UGTw4enHzbL3eEIxjGc8iQqdUc3SK6lsepTNQ/ww8qbSkbwpSAjCYE9mSvpUXHmTH
	UksFwvApPWPR3AKoUy4jvrXIgUaFf1ShRDz7tSfDS3THukSy0Q8XCFuqwfZs=
X-Received: by 2002:a05:620a:2715:b0:788:79d3:402e with SMTP id b21-20020a05620a271500b0078879d3402emr3492049qkp.7.1710273677509;
        Tue, 12 Mar 2024 13:01:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFci8LJ7emFKeNaMhqM4be32i5qK2b8ngNE0xIpit/UyC+7KzN+KAk6ieS3wmiUOL3/zXkrQ==
X-Received: by 2002:a05:620a:2715:b0:788:79d3:402e with SMTP id b21-20020a05620a271500b0078879d3402emr3492030qkp.7.1710273677131;
        Tue, 12 Mar 2024 13:01:17 -0700 (PDT)
Received: from x1n (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id f18-20020a05620a12f200b007882915ca34sm3977850qkl.40.2024.03.12.13.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 13:01:16 -0700 (PDT)
Date: Tue, 12 Mar 2024 16:01:14 -0400
From: Peter Xu <peterx@redhat.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Matthew Wilcox <willy@infradead.org>,
	Mike Rapoport <rppt@kernel.org>, "x86@kernel.org" <x86@kernel.org>,
	"sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH RFC 00/13] mm/treewide: Remove pXd_huge() API
Message-ID: <ZfC0ioxUrCK5sX1k@x1n>
References: <20240306104147.193052-1-peterx@redhat.com>
 <f9b786bf-27d9-4e16-b8d2-2a2666d917df@csgroup.eu>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f9b786bf-27d9-4e16-b8d2-2a2666d917df@csgroup.eu>

Hi, Christophe,

On Mon, Mar 11, 2024 at 09:58:47AM +0000, Christophe Leroy wrote:
> Hi Peter, and nice job you are doing in cleaning up things around _huge 
> stuff.

Thanks.  I appreciate your help along the way on Power.

> 
> One thing that might be worth looking at also at some point is the mess 
> around pmd_clear_huge() and pud_clear_huge().
> 
> I tried to clean things up with commit c742199a014d ("mm/pgtable: add 
> stubs for {pmd/pub}_{set/clear}_huge") but it was reverted because of 
> arm64 by commit d8a719059b9d ("Revert "mm/pgtable: add stubs for 
> {pmd/pub}_{set/clear}_huge"")
> 
> So now powerpc/8xx has to implement pmd_clear_huge() and 
> pud_clear_huge() allthough 8xx page hierarchy only has 2 levels.

Those are so far out of my radar, as my focus right now is still more on
hugetlbfs relevant side of things, while kernel mappings are not yet
directly involved in hugetlbfs, even though they're still huge mappings.

It's a pity to know that broke arm and got reverted, as that looks like a
good thing to clean it up if ever possible.  I tend to agree with you that
it seems for 3lvl we should define pgd_huge*() instead of pud_huge*(), so
that it looks like the only way to provide such a treewide clean API is to
properly define those APIs for aarch64, and define different pud helpers
for either 3/4 levels.  But I confess I don't think I fully digested all
the bits.

Thanks,

-- 
Peter Xu

