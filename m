Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7002E8B76
	for <sparclinux@vger.kernel.org>; Tue,  2 Sep 2025 08:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756800917; cv=none; b=oJgcyrSgIRNaTIX+c2Cnw2Nu5sgW9bYw1geVevElpcRQ9G8uwOxmUlnMWGGwymHGU/b4XqoflN5xPUBSXGhcr/btVAYoXE1jMlVkKMH93vkiQDMfuDH5xBG0Uwhe5MjJQPTsZvES6YYXLc/q9AghYZtnadEAo4k+Oyvzz8VJUhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756800917; c=relaxed/simple;
	bh=nlvpDZpVsMSgg6ylECp9wiLPXOziu9eL4qa/tmhy99E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XB73MlZE48tJvFKR5uPIVjq7vh37p7VQb2sxZlLMKIeFv6hYJYqZS+uvJKOV5EcxLexkFWRn3xwJkjDm/JQrZlPLcm9c5RSK1ZQiZDH+fmw0dWnLiYE2dZ4DFyeP4QdjQdnL8CJ+bmDWsNmW5Ix2WhzfMGhEo11GlIILgMfh7Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TYA6Y8D3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TYA6Y8D3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756800914;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=RogoUtOEfOYQJN4afGzglkQECVqWaZjyfEy0cHwYDVI=;
	b=TYA6Y8D3bQ/rp9EoDn6MjeozpMj9qmC1y2cmP1tgauJPXoy14QMPzE/vHNe00tbnJIOJgr
	ecseAqZOabjxSLgIiilpgXb4fe9y1S7dGchMMq4DHaPsG0M1GN72l4aibOrFtWHT1aXwa4
	PF+mv5nYOFXEp7XLtohab6UyZl3l8l0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580--iM1TAO4PeaLENULbUWVSw-1; Tue, 02 Sep 2025 04:15:13 -0400
X-MC-Unique: -iM1TAO4PeaLENULbUWVSw-1
X-Mimecast-MFC-AGG-ID: -iM1TAO4PeaLENULbUWVSw_1756800912
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3da4c617a95so374306f8f.0
        for <sparclinux@vger.kernel.org>; Tue, 02 Sep 2025 01:15:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756800912; x=1757405712;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RogoUtOEfOYQJN4afGzglkQECVqWaZjyfEy0cHwYDVI=;
        b=uT0meEbbDIaY2lI5fzOoKyQHjGJyKUb8T+R24I3jmrolgUmo3VL3n+EWzHj86jmVHG
         LYoliyBg9QB5AD3O2nkiEzEgkHRscXyo1yvAPb4NVVn31aOxVsaV1FT+rPB5nB+uk/AK
         TV0DkFkluHVid4oxXkw1p2WHLH5gtO4tR3pT67SLlf9YzfjrG0SNIoulFm1tYkCL8yFj
         tWhmILb5PJhDkI9Cs53hC8Xm/6RCiA1pI5NM5SBwa+OfsKeY8Q7qjyvyizf9ddBfvdiq
         37rNPHec3+qtiBjmvzBmjPHJTNRwNRjw+kIVKsUT8hYD7lOfs8mq60/X8rTJsKMRr8s/
         yusQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWVgkKtOU6UcqW7Nv1ux/0CqXsvx4kr+5AFuxSf+xZcsYX4KmJZRvsxqh22Pwh0+pHah5ZCLIAX2Oh@vger.kernel.org
X-Gm-Message-State: AOJu0YyDSPlIX+Om86GJ8NZNiPpeDWJAInO2WDGIvYiimI/rUFqixtAx
	IFq25Iyq0ggKCI0XuvN+2Kx/Iv3EwwTs9Fz9OIx+e0xDhn3YxBqC/SaXQ7FGVDeNoN3e/m+Qa6N
	ds+90U2CECsH1yqaNEs5MuF8JU9m2sjcu17dgfzb39gHvWsFb5P7fU6azMHWJYFY=
X-Gm-Gg: ASbGncutNSFZXL6sT+RADz2L71FVKKiiWC/PmHUqE2GvDTiaUp+mc2FENh+mWqBfWO8
	CwqATCwgxI8WwXfQF3Ajnw0Oj9z9p5CyFjpaatA0rXIhFTFNKgrdNdXHkXQwwuSAu3/LxIQNO0w
	c7RrxHTBcyIifOKpgNVKPbqfXLe+/2eZ1IRy0fX/hggrkDh+xEqIUlcYbCs/ChyCr5gFzRNDeyZ
	/D3zcLTge6KvIUnVXs3KIST/r1aqoqTfLc1T99g1tmFR46D2WT2J1tv/l8Qfz/ZK89b1wTUlCeG
	F4+iD15Cp79mjrqLBCDERLC7ZdnGgmvEvgcutmNF8Ti3yi5BzpBhYaMhnlYqtGfbO9PfC2WLwPH
	2OEjU27lsIXOub3QMIbhtSen8KCTv3zw0qKySaeoZZBLMSZlLUmg8c4ynnertY+dH66o=
X-Received: by 2002:a05:6000:2889:b0:3d1:61f0:d256 with SMTP id ffacd0b85a97d-3d1e01d549cmr9068718f8f.42.1756800912150;
        Tue, 02 Sep 2025 01:15:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZfeVU3LdB4bHgw3FzcrRO99gHX9zuEWOnoc0/0BZioqs0USiyiN4hqenDT8lLo0/e6yv0pQ==
X-Received: by 2002:a05:6000:2889:b0:3d1:61f0:d256 with SMTP id ffacd0b85a97d-3d1e01d549cmr9068645f8f.42.1756800911636;
        Tue, 02 Sep 2025 01:15:11 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1f:3f00:731a:f5e5:774e:d40c? (p200300d82f1f3f00731af5e5774ed40c.dip0.t-ipconnect.de. [2003:d8:2f1f:3f00:731a:f5e5:774e:d40c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf33fba9fbsm18677434f8f.50.2025.09.02.01.15.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 01:15:11 -0700 (PDT)
Message-ID: <59c1ef6e-fd26-4d95-ae96-1e1f23c789fa@redhat.com>
Date: Tue, 2 Sep 2025 10:15:08 +0200
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/12] mm: establish const-correctness for pointer
 parameters
To: Matthew Wilcox <willy@infradead.org>,
 Max Kellermann <max.kellermann@ionos.com>
Cc: akpm@linux-foundation.org, axelrasmussen@google.com, yuanchu@google.com,
 hughd@google.com, mhocko@suse.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 vbabka@suse.cz, rppt@kernel.org, surenb@google.com, vishal.moola@gmail.com,
 linux@armlinux.org.uk, James.Bottomley@hansenpartnership.com, deller@gmx.de,
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
 <aLZbaHf-euLQ0isT@casper.infradead.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <aLZbaHf-euLQ0isT@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02.09.25 04:50, Matthew Wilcox wrote:
> On Mon, Sep 01, 2025 at 02:30:16PM +0200, Max Kellermann wrote:
>> For improved const-correctness.
> 
> SLOW DOWN.
> 
> This series is unimportant churn.  There's no way it should be up to v5
> already.  Wait a freaking week before you send another version.

... while we have v6 already on the list :D

In this case, it was reasonable to follow up rather sooner than later 
(too much drama and v6 now seems to make people happy, I wouldn't want 
that spanning over multiple weeks).

But yeah, too many revisions on a single day.

-- 
Cheers

David / dhildenb

