Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B801F236A8B
	for <sparclinux@vger.kernel.org>; Tue, 18 Feb 2025 10:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739874820; cv=none; b=jgrMYO+AXbGyboGwgnNCIA2fdL0RPwkiEfk6+Y5lHGGf2mC8PIGbczpklEWeudZw9mzN96tDQ9Nj2kx96os0w9Yn5qpydCrJgdvfNY1SvhUwLiL3fIL18W7dNCgTakDQwnOMsJuVYoo5QWBMuJL7cjOhpHxo4FzYgNAFi4HDQRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739874820; c=relaxed/simple;
	bh=db+mSdmfnMb8TI+b5scWjVaKxjg5A2SjdYzRDQFZkAU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BL/FmDkeNMRmXA7Cb6xRSy3fW5De/HqsUofdM1jIbDJVh3ThEb+9Xojx8G2FPtSTvyIzBqlr+1Ns/jHSkiLF8e+jLOAkl6zQ+Qt7wsG43Q4qPVkj/5ugURZyTDjldRtlsZqsihLWoIizfvxBDreK1q1lC91YC5quvzf44BJFUUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F2+E68Ro; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F2+E68Ro"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739874817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=T1LOQMZfXNCEDy18+82jAtJj33pWYHUPkHE+taTmaK4=;
	b=F2+E68RoWVKTot8Irv//gjhhs4/hUrAHuUB6bijdAmfDFUf9uL09rsJgy7SqKDvDr+YeNk
	cx6TzaIf0vybn0az1wn1QNEmQk3cqO7K+nXGwWuuTpWt9KShbWgwOPp2t40ZlKt1Mf4sfQ
	BpWw4bkfQFOW1+w/Zjem4EnLM8SIu+M=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-7x2rFDnKN_OAGOAS6ml1LQ-1; Tue, 18 Feb 2025 05:33:34 -0500
X-MC-Unique: 7x2rFDnKN_OAGOAS6ml1LQ-1
X-Mimecast-MFC-AGG-ID: 7x2rFDnKN_OAGOAS6ml1LQ_1739874813
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43941ad86d4so31717775e9.2
        for <sparclinux@vger.kernel.org>; Tue, 18 Feb 2025 02:33:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739874813; x=1740479613;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=T1LOQMZfXNCEDy18+82jAtJj33pWYHUPkHE+taTmaK4=;
        b=MNpZsu2WUNRWf5BQaAxsR1o8zNs0lZpNfpZ6AJW7AzHgXrnlW/Ou6lgCZ4GdwSdHrA
         fDVNHHSITOh2oIT85KZj18BWmJv8vYixJWu31wPa+IwIR40RxclRnGAW8v4msXa03nO7
         Y2E7fhHZvoN0DCW3Dj7P9heL6Us/tUxJgPPzvoTJ9tU2y2aZtp075jqgYJkSbFHB502+
         InfUNwAnlwdZ1G0AGwdYSLL58yOBJ3SRKuR64+rQy3tXr9T/Il6dZC7rLU+ZShNW2z1z
         7qciBTABQbP4H3NmHu6V1tZzvsPIGiJiNB3sIFOrM7mY1tD58Df1x0mE9NvJKGA1l8ES
         b/NQ==
X-Forwarded-Encrypted: i=1; AJvYcCXeIri0Q1PK+rfG6NzG7RmwbBhpRF2POxH+C4rsGYkqkcs0Rf1SaXaQDOXhdSvRMjC2xFeX5MGT2s9v@vger.kernel.org
X-Gm-Message-State: AOJu0YxxKOBfZfI1Hv7XzJ7FODZr6Em5tDW66JEPqLZ0K1YEAg6WrYDL
	pCPEBrIq0PsC9OpDafgZLkLwPal1d5JIQWpfnFZxvSrxzfP8xR+jHizkbFaAX+CAKEfwUNQL4yG
	EOApvC+j89dqpRINVtVAdjoMzhN0VjeTDi47YMZHXYX5AYxUP96AMo2zozxo=
X-Gm-Gg: ASbGnctRVD83qnQl9ItFxeMrbvtMo4YYLPk2oBzfY9hwXqvgpfXxdskOJUg2tsCifXi
	0R1f6Rnv1PipQ6MDSnTaaD9H6NG1MjxWu6AcDgMAv0e76YcdeNY9Yw/mtghet92k7S5dBfY3WuA
	GhkXOnAYl87dcqJ7B/poFrhsMt90N+L1adnX1QifvJ0jOy6ILS7ssWlYSAuuFq7+Da8lYgNX2K1
	RupnMN0k1NNg4PGGGrz4sCYrVEgb6+TCHd7MyWAx7JwvyQdQhH906T/Hp0lxBxpeXvt61wUZjh0
	VDz++Wmc+AOpTTCYqEKle5NjROdK95i80O4xIcp8IfgE3LkurX85KZ31P+phHtl48uCae3WIx9T
	6if/XZjTW9g0JGtKDE2bu1lWWnMiMgckf
X-Received: by 2002:a05:600c:354f:b0:439:6b57:c6b with SMTP id 5b1f17b1804b1-4396e700738mr113218015e9.17.1739874813355;
        Tue, 18 Feb 2025 02:33:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG10HbiKwPJC3eaXgh0cFDz3lLRmRUxioOtL7qoeXgGZWfhvAtzEULY5k9Shgn7deaLtJSxFg==
X-Received: by 2002:a05:600c:354f:b0:439:6b57:c6b with SMTP id 5b1f17b1804b1-4396e700738mr113217795e9.17.1739874813029;
        Tue, 18 Feb 2025 02:33:33 -0800 (PST)
Received: from ?IPV6:2003:cb:c70d:fb00:d3ed:5f44:1b2d:12af? (p200300cbc70dfb00d3ed5f441b2d12af.dip0.t-ipconnect.de. [2003:cb:c70d:fb00:d3ed:5f44:1b2d:12af])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43987d1865asm46839995e9.3.2025.02.18.02.33.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 02:33:31 -0800 (PST)
Message-ID: <fcf41c06-ca68-4b26-9462-d96f7cda999c@redhat.com>
Date: Tue, 18 Feb 2025 11:33:30 +0100
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] mm: Add folio_mk_pte()
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org
Cc: linux-arch@vger.kernel.org, x86@kernel.org, linux-s390@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-um@lists.infradead.org
References: <20250217190836.435039-1-willy@infradead.org>
 <20250217190836.435039-8-willy@infradead.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250217190836.435039-8-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17.02.25 20:08, Matthew Wilcox (Oracle) wrote:
> Removes a cast from folio to page in four callers of mk_pte().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---

Yes, that looks good

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

