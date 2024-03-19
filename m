Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533EE7D3EA
	for <sparclinux@vger.kernel.org>; Tue, 19 Mar 2024 14:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710857079; cv=none; b=KqWi3B5Ohngo0j1PqjAWukqOuLuJPcKwytCCu+kOoaNWOxqgdgVhlys5eDU/1GuMtwP8zuE960XDRvz1TurEU+4Kea96OzGZFRKXCOWDNc9kfaGDLikwu43F9nNKS4Fr3Tb2vSRf8zU5+BdBtAyDqEcVXokgfilqxZVmWCaCKbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710857079; c=relaxed/simple;
	bh=yNVTuH8Tx4LSKyNlUvmV1JciL2tHoqgg0gSm10mQhSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FKIgJwsJbfGpbMRwumIJ/HXPbZ5RUDIxTWTIJ/bbLeM/XsQsXP63c1IW7NrVIH9iTbuoZZh885dRLDsLeqSug2yy76auqZNylxKERzlJjipc+CAKAs4msEnhIvedG3AGPmlql1WNK2CChmIfY48lUbaMqnDl5FI0SkA+5BcXp7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dhdd4sVL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dhdd4sVL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710857077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8w0eeleNwYf+7p/hWMlw61q+s/j0K+e36TEHXQ6sQvU=;
	b=Dhdd4sVLgkgdh3Z5QXzj0spXGyeB/YJRyfoyFFc4U0688tvIzbZJPGqznrAi9SMkPsOI2g
	eHFnZz08bLMeyz5X1zLSKwqkqFSudYV/NjjADz9TV7WbsDGqcXnBaz9eq2hsHPTMq3yC9m
	ufnYuknGtzBTCK0QIwi08uACmtJHqzI=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-2Yr466-NM0aaUugiDEEIxQ-1; Tue, 19 Mar 2024 10:04:33 -0400
X-MC-Unique: 2Yr466-NM0aaUugiDEEIxQ-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7830635331bso155304685a.1
        for <sparclinux@vger.kernel.org>; Tue, 19 Mar 2024 07:04:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710857073; x=1711461873;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8w0eeleNwYf+7p/hWMlw61q+s/j0K+e36TEHXQ6sQvU=;
        b=LN5RlZgIGj/trnGNppEe6vz0l9mKs2AHjdhS1XCMkSJg98Wv0MJOB31WpvSTEINVTb
         RCK4yovPxL7nx2n/2sqBiGN5UndqRHqkoKo/pKCUvAZraY9+HCQIMjhSAMuDX7xFsXE/
         vFS1mKar7emge7DNzIL01zNBxBCRNfyUk1NA/EC0vWefdQNHUirmS/AH16Zi/E/AYVM7
         se7XLHePg+RSQbaD6Cz5sfjsP1VuxundMqb/EKd0SP12O6QxsZiBS9yDV/kMlvecmZin
         dVCFZO7jskAVPO34xR5u1d8MTTzvuMbIFs6F/Jd/b2neaylwj9xEzlmDdZ8jpMX/LDS/
         Na9w==
X-Forwarded-Encrypted: i=1; AJvYcCXGJi/CsdilqEdR4/UnrccWdUzsauulWS6euczPH6PyIA0wqMyw8EI3UrZVvIiV9AJ71QB13ZtaXyj0/xy9Kbn/3QN3S40UsdJCQQ==
X-Gm-Message-State: AOJu0Yynp3WQjZjG6CaGjr0/PgGCLXf0jj6UTih2Lgj/E1/dpIJ3MfcG
	bblyUHvWBG0hBR1na4whzns8mCtH8gj5LOM3NuzeXmiQW9Wqq4hLRY5zi4DTVU1fZqPtEG2q2V2
	MnO5MLEqNrgzz0gh1dgjDsTShxoux7wVFoPcVCsE/crHQ120VujXcFBZ1m3c=
X-Received: by 2002:a05:620a:1911:b0:789:ea58:d3b1 with SMTP id bj17-20020a05620a191100b00789ea58d3b1mr2518348qkb.4.1710857073237;
        Tue, 19 Mar 2024 07:04:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2woW7UEchY2IkBVWYzgRK0KWJ4spUtcTxNI2cDq95Ac2i5H9cK+iTpsS+AG/gM2n1vRK6zQ==
X-Received: by 2002:a05:620a:1911:b0:789:ea58:d3b1 with SMTP id bj17-20020a05620a191100b00789ea58d3b1mr2518292qkb.4.1710857072670;
        Tue, 19 Mar 2024 07:04:32 -0700 (PDT)
Received: from x1n ([99.254.121.117])
        by smtp.gmail.com with ESMTPSA id ye1-20020a05620a3b8100b00789e1874eccsm4708269qkn.41.2024.03.19.07.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 07:04:32 -0700 (PDT)
Date: Tue, 19 Mar 2024 10:04:31 -0400
From: Peter Xu <peterx@redhat.com>
To: Muchun Song <muchun.song@linux.dev>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
	Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org,
	Mike Rapoport <rppt@kernel.org>,
	Matthew Wilcox <willy@infradead.org>, sparclinux@vger.kernel.org,
	Jason Gunthorpe <jgg@nvidia.com>, linuxppc-dev@lists.ozlabs.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-arm-kernel@lists.infradead.org,
	"David S . Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Subject: Re: [PATCH v2 05/14] mm/sparc: Change pXd_huge() behavior to exclude
 swap entries
Message-ID: <Zfmbb82ErXU8WXt3@x1n>
References: <20240318200404.448346-1-peterx@redhat.com>
 <20240318200404.448346-6-peterx@redhat.com>
 <744C19CB-4AE0-472B-ABD8-2064EB04FDA0@linux.dev>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <744C19CB-4AE0-472B-ABD8-2064EB04FDA0@linux.dev>

On Tue, Mar 19, 2024 at 12:25:39PM +0800, Muchun Song wrote:
> > @@ -409,14 +409,12 @@ pte_t huge_ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
> > 
> > int pmd_huge(pmd_t pmd)
> > {
> > - 	return !pmd_none(pmd) &&
> > - 	(pmd_val(pmd) & (_PAGE_VALID|_PAGE_PMD_HUGE)) != _PAGE_VALID;
> > + 	return pmd_leaf(pmd);;
> 
> There is a redundant semicolon in the end.

Will touch it up, thanks.  PS: This will be dropped as a whole in patch 12.

-- 
Peter Xu

