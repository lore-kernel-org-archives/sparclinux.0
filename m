Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92919234972
	for <sparclinux@vger.kernel.org>; Tue, 18 Feb 2025 10:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739874576; cv=none; b=ce9sfHGXjJZ+19OI3ng12y2ifK7JaD8J8GAmnnBcFYhz9nmykBI+VY9TcWGBgcq9Xh2cz4QLaMZVoMo8PqQq3gqglyq0CX1aY4q6CGIpMh6yPcGbxWrYGdmR1Kwo5ct5//eqlDyiVJ7fYmDQZvteGf85cWZ/YhaXbTo4at5EV+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739874576; c=relaxed/simple;
	bh=OXa24ocgXVEVT9vevFK3a8QfTBQ7Sd9cZSemLgdwzh0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NQ0BZHeiL20GCkVcnTgbA9cQMjO/JHSlQSD4OskAT4zkdohecTCFyhTMgjRrqthtKI78tLdG/T3cQmW1mTa1R3AOw1Qk+kyWKx2ezZAdnQkXkJe4+NvmkMl+11Ih/MemrG3oiWYWkba9tJO9TaoiN6YVDcLm52JYpWENhkIzjbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NkkKIOXf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NkkKIOXf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739874573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=G+HjwJ9mJ5Ava/YF/RbVKXd+QR18qcRDmZfeajdLUu8=;
	b=NkkKIOXfuoC3JDxSWjfTtwCu2FO2cnuh1sXjqzwmws8YZJORZ40dKkoMLRKWU28UGlMfoz
	ewU3s/docihZ+ibEdyfEPZSZXg6wJRTOEv6NqUE/JyRSeQqVIztALYJfAYOqUqC6+Nq4pI
	SmjfGtTTWLicS7LiAEcKRt3HxkHRpE4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-DlFghMFZOiSggZgwi2r0tg-1; Tue, 18 Feb 2025 05:29:31 -0500
X-MC-Unique: DlFghMFZOiSggZgwi2r0tg-1
X-Mimecast-MFC-AGG-ID: DlFghMFZOiSggZgwi2r0tg_1739874570
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-38f4e3e9c70so581932f8f.1
        for <sparclinux@vger.kernel.org>; Tue, 18 Feb 2025 02:29:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739874570; x=1740479370;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=G+HjwJ9mJ5Ava/YF/RbVKXd+QR18qcRDmZfeajdLUu8=;
        b=Pg5az+rLL2A9uEJFF5Eo3IAxTUtxnYJWF+9w9fs+bWftkHzbTyGR93QL3J7BRrBgWk
         rPTNGTBueSRFH/R937cDi1nmDu+ra9jnMmh5h7d012OM9ZluJTC8/L8FYX6fa1MEqaBn
         3cJnDpf3vZEw+NHayII3ockIHuXmspFif9X5PPwwdUoIBytYTsz4pUXCZzgYH4w62dpN
         JuENSdsLLZsq2C3U1Y8r50eDnJDJQrgRuW7ev2zyCXHBET6H07KbRU/6BNNkVAo0yYBq
         N7VuETRsPkd5hc6sicnqe3sqi13u6vP/fxAqHSoKFy/0jUbUm69r0Qprfvujv3JFzU4y
         LYQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzNsD3gXgteUOabl6n7cAqU1SDMsAvn/rqNx1rnJjNWF01jj+4Azux4QG2iDngVcDe8yKAzY1OCxdv@vger.kernel.org
X-Gm-Message-State: AOJu0YyNapIEQs5AmjtbNSBt0hymkGsLyLR0JpoONhJHYRxD5oh9kOR9
	GOQnj7HnV3gcBzG8gUrIrHzQbG6r6j5aFkGhG7WlsAQ8REBX1gHLSgmaIdIm8jRANWUywIHE//m
	ry3LgUf2dOSfbVHO7esxWBZ2b93wsYlG657NNorkWvj2vhpyHvZ+0vOPlR34=
X-Gm-Gg: ASbGncvJl+QvsNne3YcdX4EYznNepZXgqkW+BQDg/3uorHLKsToXWaQNTiaYQ+CvRck
	Jh3hkMtS93DHIwGoYmWalqPGH9XA6/cP32oyf3OvxXgVJFNrzsXlZapSZXmCIRuEzYdQin95i7D
	K8HmjzchKmsy954Sm4ZVTtVn6F7WHi1h5g2Op0dkM+O4FJfJUIeIx+8xG1UG0xdR86J1vr/sGT0
	z8mtmsmdKTWnJ2Q6JAwok1804Ho3EFxlP921R9UjEI/7QO8kfoiqZIkY/xnKIIJjULDl9TTgAcO
	z8WIvXl3E3a/TOWhbAv14/puUzFCXXTL29dqc95M667foZMtiU2bJtEO7h+OwEM1yDAhA5cG/7Q
	gqtuV5etgUOEkkJvd/Do/s5w+zCK3fyO/
X-Received: by 2002:a5d:64aa:0:b0:38f:4f37:7504 with SMTP id ffacd0b85a97d-38f4f377bb4mr3195057f8f.16.1739874570269;
        Tue, 18 Feb 2025 02:29:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFN693UNj3uMUwWwlf2ctNsjDwCDYZ2rQpAw3Q3z51pqfxfutoeEP1sMGNfu8iSj0Dl+e27fA==
X-Received: by 2002:a5d:64aa:0:b0:38f:4f37:7504 with SMTP id ffacd0b85a97d-38f4f377bb4mr3195027f8f.16.1739874569894;
        Tue, 18 Feb 2025 02:29:29 -0800 (PST)
Received: from ?IPV6:2003:cb:c70d:fb00:d3ed:5f44:1b2d:12af? (p200300cbc70dfb00d3ed5f441b2d12af.dip0.t-ipconnect.de. [2003:cb:c70d:fb00:d3ed:5f44:1b2d:12af])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43994f0c10csm12319315e9.26.2025.02.18.02.29.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 02:29:29 -0800 (PST)
Message-ID: <dcc74d17-9e5c-468a-a248-e4cddca2b1dc@redhat.com>
Date: Tue, 18 Feb 2025 11:29:28 +0100
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] Add folio_mk_pte() and simplify mk_pte()
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org
Cc: linux-arch@vger.kernel.org, x86@kernel.org, linux-s390@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-um@lists.infradead.org
References: <20250217190836.435039-1-willy@infradead.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250217190836.435039-1-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17.02.25 20:08, Matthew Wilcox (Oracle) wrote:
> The intent is to add folio_mk_pte() to remove the conversion from folio
> to page necessary to call mk_pte().  Eventually we might end up removing
> mk_pte(), but that's not what's being proposed today.
> 
> I didn't want to add folio_mk_pte() to each architecture, and I didn't
> want to lose any optimisations that architectures have from their own
> implementation of mk_pte().  Fortunately, most architectures have by
> now turned their mk_pte() into a fairly bland variant of pfn_pte(),
> but s390 is different.
> 
> So patch 1 hoists the optimisation of calling pte_mkdirty() from s390
> to generic code.  I'd appreciate some eyes on this from mm people who
> understand this better than I do.  I originally had
> 
> -	if (write)
> +	if (write || folio_test_dirty(folio))
> 		entry = maybe_mkwrite(pte_mkdirty(entry), vma);
> 
> and I think that broke COW under some circumstances that 01.org could
> reproduce and I couldn't.

If it's an anon folio that logic would be broken, yes (anon CoW). We do 
have can_change_pte_writable() that tells you when it is safe to upgrade 
write permissions for a PTE.

Looking at can_change_pte_writable(), I don't know if filesystems with 
writenotify might have a problem when setting the PTE dirty and allowing 
for write access, just because the folio is dirty.

So I assume that it would break fs-level CoW indeed.

-- 
Cheers,

David / dhildenb

