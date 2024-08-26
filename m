Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863A71917F9
	for <sparclinux@vger.kernel.org>; Mon, 26 Aug 2024 14:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724682888; cv=none; b=XF+FOrkJ7Y7K+FQqYz1UHW4aFZrPtEEaW2j2Zuz+gn37CXNsz/qiTNiGU41+49AuJIl1caVQ0c6hamt4zZg8ATByemxXu8XIhlTYXNxO38q3T9szwXtpC7sPGwlgtwCjHtQoyDQjy67d/xIxOwxcqzoXoyG4IC8JQd4OyFURxdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724682888; c=relaxed/simple;
	bh=8HhpJlOGt2+/dYbwaoVj3byzmwVR3VEmwanL2/m8idU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cyVUkwYxUcM/IGSZTr5E9V2uOCiPPCPXXkbm5f3r547sT++towXKLolDP6gEgO2VbySPI+bES+JFMlTXrO5vSSfXTuT6cNGywD8kMil1ZyYFXaEl55HH97jZp8HIhCnU4ME9LMjVky1hg+wJuNJyuL+hhmm0hjHImDWyq5YiG3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ASjHTVpI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ASjHTVpI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724682885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VW+HIHEhMAo3/O8qS6yn7a/M9Jq5ewUkNW1oEWQ5L3A=;
	b=ASjHTVpIeCTSeGgid4jlaNZjwZpjL+AIUsYYQe5rFo8Ccg1aVGo926oYYaCdf0NLoixEKc
	7nJW68+t/lfkrJ5qwRyVujGWSaIuHl4rVe2qa18knxDIAmm3VlpJ6JdyDhxFpxtI6sOPAw
	Tk7UNpy+kRTmOh1n7vfE+og5BBon4fE=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-13SaAuVwMaib_4M1s1LZsA-1; Mon, 26 Aug 2024 10:34:44 -0400
X-MC-Unique: 13SaAuVwMaib_4M1s1LZsA-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6c181e15e90so17578306d6.0
        for <sparclinux@vger.kernel.org>; Mon, 26 Aug 2024 07:34:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724682884; x=1725287684;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VW+HIHEhMAo3/O8qS6yn7a/M9Jq5ewUkNW1oEWQ5L3A=;
        b=k7frE8Esim5CkFFZVncFEJbYXWNztRRaoB5Dlb86gZW9nl7dAC+3fH1SM00330b/kA
         ykNX7azMhvkfKbe6l3gd7Vanw21dFnXrmpoATGQPx8OWlfVP6NMdrTpo/Q1y7gjhYv9C
         2Jqe409D20Y8FGtbsU/9P9m9f3k5tESXONxHrObCPEnXK7wPcbnLWgi1lBND0Qa2Wjn0
         eok/zUbTNzDUiMNuJwzJAAYpuvAV6LyT5Ukxa3OAvRVmLWSfzOYWLtAXZ4rnbIdykq/h
         IXEBCRd0ZdUFHHDz0sTauJgvEcNnkxbQRFxgp1cMrwEf+YD9mykpsfwVW+a9ghsYt/1K
         3/LQ==
X-Forwarded-Encrypted: i=1; AJvYcCUi88RmYclEkmmMixxf1Y8Wuu4sfPqCeIQ5gGnr3kpTNSNkX0BqQbFujrptH8xgxzIP8fYcsxstPpk6@vger.kernel.org
X-Gm-Message-State: AOJu0YwWSmq/HW1tjqRW4tji0jUyoht5S7ah+plGQSWzxEheTjAVRSI9
	q5h+1+krzvvtk6jcpi7A7PnFYRoypJzqpn+KN3liENsPVwgrscoQvrRKW52+8PogwRXzq3Zejtr
	mKVSU73HiehbCnpauU3bGJnTAUsAEDLfEu/Aql2pvng7AjnZg5yBX/52XOls=
X-Received: by 2002:a05:6214:4304:b0:6bb:a16d:279f with SMTP id 6a1803df08f44-6c16dcb7b2amr123088956d6.38.1724682883704;
        Mon, 26 Aug 2024 07:34:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJyXhGmqDSVXXp1D+XITrKt9Uq9T5JuT4lUbtmj8ua5Df7FPqa8sCBxKyCSdGvctdo+BxBQQ==
X-Received: by 2002:a05:6214:4304:b0:6bb:a16d:279f with SMTP id 6a1803df08f44-6c16dcb7b2amr123088766d6.38.1724682883376;
        Mon, 26 Aug 2024 07:34:43 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c184ce9034sm10939096d6.73.2024.08.26.07.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 07:34:42 -0700 (PDT)
Date: Mon, 26 Aug 2024 10:34:39 -0400
From: Peter Xu <peterx@redhat.com>
To: LEROY Christophe <christophe.leroy2@cs-soprasteria.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	David Hildenbrand <david@redhat.com>,
	Oscar Salvador <osalvador@suse.de>,
	"linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Michal Hocko <mhocko@kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Jason Gunthorpe <jgg@nvidia.com>, "x86@kernel.org" <x86@kernel.org>,
	Alistair Popple <apopple@nvidia.com>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Hugh Dickins <hughd@google.com>,
	Axel Rasmussen <axelrasmussen@google.com>
Subject: Re: [PATCH RFC 2/6] mm: PGTABLE_HAS_P[MU]D_LEAVES config options
Message-ID: <ZsySf2F9djR5YVOr@x1n>
References: <20240717220219.3743374-1-peterx@redhat.com>
 <20240717220219.3743374-3-peterx@redhat.com>
 <dcdde9fc-7e7c-45a8-8dc7-7f7ed13b81ec@cs-soprasteria.com>
 <ZseOp7M9AmZtW4jw@x1n>
 <d3e4256f-253a-4a61-a83b-93f50ebabed8@cs-soprasteria.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d3e4256f-253a-4a61-a83b-93f50ebabed8@cs-soprasteria.com>

On Fri, Aug 23, 2024 at 06:19:52AM +0000, LEROY Christophe wrote:
> Why is an option needed for that ? If pmd_leaf() returns always false, 
> it means the arch doesn't support pmd mappings and if properly used all 
> related code should fold away without a config option, shouldn't it ?

It's not always easy to leverage an "if" clause there, IIUC.  Take the case
of when a driver wants to inject a pmd pfnmap, we may want something like:

  if (pmd_leaf_supported())
      inject_pmd_leaf(&pmd);

We don't have a pmd entry to reference at the point of pmd_leaf_supported()
when making the decision.

Thanks,

-- 
Peter Xu

