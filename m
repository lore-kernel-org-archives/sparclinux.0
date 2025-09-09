Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4DC285061
	for <sparclinux@vger.kernel.org>; Tue,  9 Sep 2025 09:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757409723; cv=none; b=uYNZpJnxUN9UtBuyYZeI734hejq3Gjwxx85e/v77FbDUP/SlzTPHY/duaHWTdtOEBcKVrItZlTDCaDW4+Z0LbvmUt4Ycjq6tcQiLxbmO7MKGKDzZ0H+te6qJQvIiZE8/ZIe0oSe6nbyIgZmWsiKCEoF4uGwOTyV0qIIS6WbJkYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757409723; c=relaxed/simple;
	bh=5PhNtLrl7k0wajDmS7bukrWOcz0jfuXrNVxvCTRExcA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YGp/xCsUfLpiYUbG4rHOZzcGy2TLrAMwYpd0Vsd+ekpGilrX7v4YwneRwZFnnf61WzHHYd6mB/pl0jcXoQClN5wIwWxnKrb58GmuPw1R3v18/RfYfmq90oGKVX0157nFOpBucoselFo4Fbqto/dwXRy/IzFxOS6y/xjmhcIloT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eSPQdM1V; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eSPQdM1V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757409720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=yZ7mpSu7Vyx7D7KzsRAEX4kah9GPWTLG09gnV5krCYA=;
	b=eSPQdM1Vv90+jyLGYGKQBidvEXu5T7MOWgA1GT2RCf4E/33n7gCl0HggWTxwbIE37S/4Ah
	igJi6X2+REFVkpHBgXMp5YnkXuE8oNtVQ5bWoF4dyrbhFPLe0wbGJX+SAA2zr5z8p/eUzZ
	HOwJN9V1ezpyywaKCLGQukI66Ty6QaM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-u9M_JCZjP7O49IwkIeTyrQ-1; Tue, 09 Sep 2025 05:21:58 -0400
X-MC-Unique: u9M_JCZjP7O49IwkIeTyrQ-1
X-Mimecast-MFC-AGG-ID: u9M_JCZjP7O49IwkIeTyrQ_1757409718
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3df07c967e9so3327342f8f.2
        for <sparclinux@vger.kernel.org>; Tue, 09 Sep 2025 02:21:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757409717; x=1758014517;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yZ7mpSu7Vyx7D7KzsRAEX4kah9GPWTLG09gnV5krCYA=;
        b=HEaRsitmdsNRBH6fpd2zk0A28RH7ZOckx8QbpsYNnQpJ6Ku/ta9sYoxrV7llaMUUHR
         KH5ZrnLXeWEoqzzXW/1Yyxm3uc96+lzsBzM4ldPcif2923xaZ3kJdjiIuM+C+SnpaZAY
         1XQu+zdTNCYD0vs7oAO4dJ1Z08Bs0OQRAN721eRh0xbu5N+Y8s+zUiTD46GLs3nczR8d
         x2Lp1wbbqlrjexOEmavFmD7E9GQX/8TeVydM5Z7H0yPCQeLf4ElwFyRGk28nB2CmXgbm
         kJsqCvLK9RD27u/6S5V29NurguX3pzbw9NJh8XDs0TkO/AFe+w8o4wFn8Zut2kzurqi5
         355Q==
X-Forwarded-Encrypted: i=1; AJvYcCW+U1KBqRUpinDyYozobIB+z9z2PR4iFMrjAKK13DI5rvDJof69jQruFNlCm/WbWLjPa0MUFB4W5T4E@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6xGg0sT8eE4J3f14akqeHuiai0EwsGVRtSbD0L0gYEO/O2Qpr
	GMDYsHcd/VFJ9pit4c4lwSJAhi33mCxqrpubaHdehBJgBNXKfjLu9rFLx34/3qs4wBsH5Qs09EV
	cO9aEvlNNWHjF1SVAUupWCdny1XuYioTiNcj5ekzNdPJlZQtug1hOg1dkg7vORB4=
X-Gm-Gg: ASbGncs8xD1hA0O6yWl7Gs+8u2XHelBL6VMVi7uIK4mZEQ6c/2ynScAR5oNNy/DGr9W
	ttEJem7Bx4yaEhjq2KDlOh7eVEqwGFe/ZzQGVLcGDhi58vRHJxantbLD8M0fe5VE8J/yUUXyux7
	I2URcI7/o8IsYH76wF6/yilP8aOZi47Ng0s6WdWEplYLBiqNdOb5jbK65EalIUtmsFlr7lrHmvB
	+hV4886zZuZFUSS8PhJ3uvyFQ0pSow8pxq+B3gdtBPKK6dZmgHqPxT3DFugVP8xG/gCHqp4MymL
	WOv+sZR6rx5vDfaT8+co5ftsS5XeHGnWEUXNJ50IMoyzmVQldgAKTba9we2nSymBYl80VJ70gZx
	FJ4Nx5Lsb5Mcjkb5VkakM5587FYpRk7uSotV4rknXFkS6kQDiTVMqFH768EXe3QxEEBM=
X-Received: by 2002:a05:6000:d0e:b0:3e7:4fb7:4e9 with SMTP id ffacd0b85a97d-3e74fb7050cmr2433460f8f.47.1757409717595;
        Tue, 09 Sep 2025 02:21:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHaiuV2XNAb2KzSftztUT7DW61EOo5r3IILYTR3cBriEgdDR9uMZbXOjouMq5dEBDNTmzUKg==
X-Received: by 2002:a05:6000:d0e:b0:3e7:4fb7:4e9 with SMTP id ffacd0b85a97d-3e74fb7050cmr2433419f8f.47.1757409717177;
        Tue, 09 Sep 2025 02:21:57 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f23:9c00:d1f6:f7fe:8f14:7e34? (p200300d82f239c00d1f6f7fe8f147e34.dip0.t-ipconnect.de. [2003:d8:2f23:9c00:d1f6:f7fe:8f14:7e34])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b98e77231sm303120095e9.12.2025.09.09.02.21.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 02:21:56 -0700 (PDT)
Message-ID: <d1b4ff2a-052f-4556-91ae-273962edbed0@redhat.com>
Date: Tue, 9 Sep 2025 11:21:54 +0200
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] Nesting support for lazy MMU mode
To: Andrew Morton <akpm@linux-foundation.org>,
 Kevin Brodsky <kevin.brodsky@arm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Andreas Larsson <andreas@gaisler.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, Borislav Petkov
 <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "David S. Miller" <davem@davemloft.net>, "H. Peter Anvin" <hpa@zytor.com>,
 Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
 Juergen Gross <jgross@suse.com>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Michal Hocko <mhocko@suse.com>,
 Mike Rapoport <rppt@kernel.org>, Nicholas Piggin <npiggin@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>, Ryan Roberts <ryan.roberts@arm.com>,
 Suren Baghdasaryan <surenb@google.com>, Thomas Gleixner
 <tglx@linutronix.de>, Vlastimil Babka <vbabka@suse.cz>,
 Will Deacon <will@kernel.org>, Yeoreum Yun <yeoreum.yun@arm.com>,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 sparclinux@vger.kernel.org, xen-devel@lists.xenproject.org
References: <20250908073931.4159362-1-kevin.brodsky@arm.com>
 <20250908191602.61160a7990b9ea418de758c7@linux-foundation.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250908191602.61160a7990b9ea418de758c7@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09.09.25 04:16, Andrew Morton wrote:
> On Mon,  8 Sep 2025 08:39:24 +0100 Kevin Brodsky <kevin.brodsky@arm.com> wrote:
> 
>> The main change enabling nesting is patch 2, following the approach
>> suggested by Catalin Marinas [4]: have enter() return some state and
>> the matching leave() take that state.
> 
> This is so totally the correct way.  Thanks.

Staring at this, I wonder if we could alternatively handle it like 
pagefault_disable()/pagefault_enable(), having something like 
current->lazy_mmu_enabled.

We wouldn't have to worry about preemption in that case I guess (unless 
the arch has special requirements).

Not sure if that was already discussed, just a thought.

-- 
Cheers

David / dhildenb

