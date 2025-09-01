Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B703376BA
	for <sparclinux@vger.kernel.org>; Mon,  1 Sep 2025 13:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756734625; cv=none; b=HgePsGv1En+mb6S4LaCBYJXVlpOdYc/SQluqpV/2lP/hJqNLX9jnSLBe3q7iwZyGgN3wpHVeXa1swqey2ulh1RnBITFxYoARKZoBK2pilbjQJ4JIGDb+5fPNJrMxRWb8xXLnbxaDi3Tz2nrEMzlLYcFd1Q4Xi37XvRxJaWPX9EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756734625; c=relaxed/simple;
	bh=nwwdnJGRchNdc3AHuNIXC8sh7ymim5jBCCZSvUdu70Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=iLN17//4Kky2wQhplX4AJR1orOCPoAcawNMpGvqv+02Uv9m3dlxkx2cr3EonlO7W0sY5qY3eFjEpnEvapHfs8/afVCA6piZB97TwGwxZUh+xc24iXt8kGRyhGg5zMCngbDeOcVsJ7bHIU1mYkKQTstETngBrLDdBEjdNZmlHkRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dQsFpe3U; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dQsFpe3U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756734622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fVP4Gr2R7pmDK3dhteEbvY18ucQslE6qh9XfZ+Ur7rc=;
	b=dQsFpe3UuD/sZUeBy8IqCnWjZBYcyG9ntisuqd/KY+mSCy18Up1yzEMIKIGjUnOjN10b7f
	hcWSR8WYyqv7VaH8Hu3Grgu21uHAtfYh+vRz/W1VdqWeB/NVgcXYNACzwUjErshLQxzL0e
	8xbboi0D8jIpRNjmWqqHwur3IvdC7Uw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-0nlh7lniN-e4qOhoIgbFag-1; Mon, 01 Sep 2025 09:50:21 -0400
X-MC-Unique: 0nlh7lniN-e4qOhoIgbFag-1
X-Mimecast-MFC-AGG-ID: 0nlh7lniN-e4qOhoIgbFag_1756734620
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3d1114879a4so1347458f8f.0
        for <sparclinux@vger.kernel.org>; Mon, 01 Sep 2025 06:50:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756734620; x=1757339420;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fVP4Gr2R7pmDK3dhteEbvY18ucQslE6qh9XfZ+Ur7rc=;
        b=DM2xXHs38cAzYJyuCvJHVxtpSCU6XJwewsEZqe6BikVqjG/JYvxALRgEcNd93+Mn91
         Si5ArJvSJhls6wPwe7tFFeu/udC+P+RsaF45YF9WsH/ZbDu2tCUJXAsm30VhtGWBKUmf
         ColnmuowMpTm26xh0zDM4cip3VqDxpZ9uGN8X8zZhmVQ/kAOAiySk7QdcKNU7vpXNkYN
         VtMoyCghcrxatX18i+BXeJIzTAPjg9PHLQ5yJoxcNUQLDsXOJQ/gRS9LvB406ybWOtTk
         bxC+Wr6+mUwaWa0lwUPL3OTiTdXz4eS0LGTlEyS58tcuViTpoiKe1Xbn9XG6GmeWxl3C
         waHw==
X-Forwarded-Encrypted: i=1; AJvYcCUFhCgl2Tlr/wGm2yzR8MdCu5rOUFJfQvtr9NMRPf29G2SzSZTaiS+BPa6bFdL01wWTGrQ6odJUqnVY@vger.kernel.org
X-Gm-Message-State: AOJu0YzxbW0GHMheq7832FK6rq7OC/27soQIPVc3zVi7IodgEkkt+CE6
	HQuIVEDIJTVORQASm/rh3OhOh0rkYBnwWVg/Ryw6lX7rE49VX2VReUtiE5WhjA3xKlJIw41XbqQ
	UvJBq9BxVT4svdKsW8IgfOEp4TpH1TjH7ZH7kuqpPX/k95/+4UN+eZzeAupQbIfg=
X-Gm-Gg: ASbGnct3dIXO6r6PucR+j1sSDZxGm1dNaeLUwBC546lP1Imqvh1RBM9fwGhlGjcE+Lv
	ovfMhuv1LsdgvLzwcLp4zfMWADoHO8nBaKreybES6NtLtmplN9XUdfVcjWPMi0i+KE1w1izf4sr
	e13NZKYpGZ8Pxs/hltMaDeAm8hPzP03MQaZwktAfOX89IvYTvp97Z7eytGw9oNsy3URMTJtnX6M
	CjF3beXp/pfGQYYwqmrGFUS79NKtdDm3UAkkBsHsmN2VWuNGPm+TRqUayAr9afZi+4ttBCwxQcG
	kHP+byw1G0owrYml976Zmv5jAlrNJEqJq4Ptg727JqgB1ubTojipCzqW3ec+LyHJE2akI5to9tc
	/LX6Kr1kR3ZG4hwBpekKJ3Er1OwRiCdyHy7N7ynmUKTIJC80Lo5cdiHuR7LzdbhuzcjE=
X-Received: by 2002:a05:6000:290d:b0:3d1:721:31c7 with SMTP id ffacd0b85a97d-3d1e03c6916mr6097702f8f.51.1756734620287;
        Mon, 01 Sep 2025 06:50:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGS5YkCDJoe2KLKpyw9PN16pVvmUFSrYqCth5HMHY9aLGpLdyFPeQoI3wQu+Yy0lNdrjSjEcg==
X-Received: by 2002:a05:6000:290d:b0:3d1:721:31c7 with SMTP id ffacd0b85a97d-3d1e03c6916mr6097638f8f.51.1756734619809;
        Mon, 01 Sep 2025 06:50:19 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f37:2b00:948c:dd9f:29c8:73f4? (p200300d82f372b00948cdd9f29c873f4.dip0.t-ipconnect.de. [2003:d8:2f37:2b00:948c:dd9f:29c8:73f4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b813816desm82205115e9.4.2025.09.01.06.50.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 06:50:19 -0700 (PDT)
Message-ID: <9217a23d-45d3-42f2-ba3c-003982868fee@redhat.com>
Date: Mon, 1 Sep 2025 15:50:16 +0200
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/12] mm: constify zone related test functions for
 improved const-correctness
To: Max Kellermann <max.kellermann@ionos.com>, akpm@linux-foundation.org,
 axelrasmussen@google.com, yuanchu@google.com, willy@infradead.org,
 hughd@google.com, mhocko@suse.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 vbabka@suse.cz, rppt@kernel.org, surenb@google.com, vishal.moola@gmail.com,
 linux@armlinux.org.uk, James.Bottomley@HansenPartnership.com, deller@gmx.de,
 agordeev@linux.ibm.com, gerald.schaefer@linux.ibm.com, hca@linux.ibm.com,
 gor@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
 davem@davemloft.net, andreas@gaisler.com, dave.hansen@linux.intel.com,
 luto@kernel.org, peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, x86@kernel.org, hpa@zytor.com, chris@zankel.net,
 jcmvbkbc@gmail.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
 jack@suse.cz, weixugc@google.com, baolin.wang@linux.alibaba.com,
 rientjes@google.com, shakeel.butt@linux.dev, thuth@redhat.com,
 broonie@kernel.org, osalvador@suse.de, jfalempe@redhat.com,
 mpe@ellerman.id.au, nysal@linux.ibm.com,
 linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <20250901123028.3383461-1-max.kellermann@ionos.com>
 <20250901123028.3383461-4-max.kellermann@ionos.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250901123028.3383461-4-max.kellermann@ionos.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01.09.25 14:30, Max Kellermann wrote:
> We select certain test functions which either invoke each other,
> functions that are already const-ified, or no further functions.
> 
> It is therefore relatively trivial to const-ify them, which
> provides a basis for further const-ification further up the call
> stack.
> 
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> ---

Also some getters hiding in between the test functions.

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb

