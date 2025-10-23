Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39D22C236D
	for <sparclinux@vger.kernel.org>; Thu, 23 Oct 2025 20:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761249794; cv=none; b=cIGveGLvSXlcaO4DRHDd+dAUz/KBXGONbmwoH07gGZPW8eOvkkggEH2p69shmQLJ2T6TJb3ZTx8W9uJPClOVaW0WUxXIwrcI7plFO2D86MuApWeRdVil/xakkP67LrBPXMtIOYtyQwyvzh2GvepdpPLFo4pVi8YvvYj3nBBP2AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761249794; c=relaxed/simple;
	bh=9/7NDMtrcv1hrgzsT5A33Nv1CBPMZGfW5nwi/FU45Ek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vtpcc7yUSA4wDNZvivjdvdFmG75MGYcbsn1ym4vfotgIP6My7I3m4vj5MjUgt69DDlJL39UQlkhslrUJsqHZRKtdkXgKyYEsPa5BCyG1y+7AcfxCZwbuUIrGIg2Nqpfe28yjupMr/9i/T61iSpFDnan/Qj1O7HgMLRyYg7HD4IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y1q1VHhU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y1q1VHhU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761249790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=QPUi1jKCUzNIqjtqTEITsV04BJ5RU7P6py+r44ygz4A=;
	b=Y1q1VHhUnUtbAfsLtetVtzpxjabLV1NTsI4fNMxCML9j6ZN1Un2/vK5KOp7SKSEklK+Czx
	DyO80aqMXpClMQhHVgHJ7ZqC2anbauKAnhqchE15JCQhNnaFkLuItd06kx1GDdyWpQBOjG
	CqChN+k32fMElHxmy8kacz88TWjjcC0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-bQV_ntdFNBmfk5SZCJkfXA-1; Thu, 23 Oct 2025 16:03:09 -0400
X-MC-Unique: bQV_ntdFNBmfk5SZCJkfXA-1
X-Mimecast-MFC-AGG-ID: bQV_ntdFNBmfk5SZCJkfXA_1761249788
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-429893e2905so889501f8f.3
        for <sparclinux@vger.kernel.org>; Thu, 23 Oct 2025 13:03:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761249788; x=1761854588;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QPUi1jKCUzNIqjtqTEITsV04BJ5RU7P6py+r44ygz4A=;
        b=rXF4PMJCaKzNBWrM4aUZotM4CNI+j/VIu30qsRHi3HOHvu339uwg+FFFehu6YOq4WP
         i3CeSGEkwC9akr1qQIgdGWzpjrBAaE3FWMmoXi3Ie3luMkJWYPm+NEIpehYunkxBIwK2
         muggfeanRJlPPBcmaz3GY57OPVEWrIRptQMlmJ8RIlOveh4fiaCa/kYm0C1pY6R/BHXu
         aW7YP3fiSGZa9nX4aQbPQOf2DJUbtiRc5WJmuKBOzkenvQd0blktx/AF5uzb6ytG6VIQ
         dkLVE/HkISWDhYg18K1vGopYoQymeTZpMA4J+aAOeUkCgGTljWPqQE3Z0YC+qUiVePBX
         ALFg==
X-Forwarded-Encrypted: i=1; AJvYcCUU8C/Gf7Yzw0VFkyEY4jNkvndmoWBb81N6qIjhMfmw41eKBWAOKtBOgRh7g//gMuljgpNfWvFNZg0o@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh0SFmLsQ3ZBsmiwRMyNZHZSOF59ukdbpmdn4+dGsEos5dT0yj
	XkKgqjsU2XUDuAwvBNFGMr9XPQtgVKw30dcgMS5efASLCPJN3OG8ZaJMEfSp84Fnc44K4yMdQVb
	EwRIoIbPfWj5shLH7LUS2vAHeV66igzyQhhNvfzgWnfMHYNlsbquJqYyKjzUpHlE=
X-Gm-Gg: ASbGncuUJC96c7f4dTwywmiufwYsA3+8tKHk0KYLYINRmYq8u4+ePk5/dVp82kdlip1
	NNbeOjXVpS8zp5Wy9FnLOHerrJ6I+EzPD1xY0iACOFZ4XhRc/omNXHJYnKuUovRHvbjN+i5U0Pw
	l4sJ9djtOwOShRfCVQtOj4ct/nGoLiskCkuZbioLFSmK1gEuoyVns7FbN1BL/L3LUGc/ow6Y1E9
	qGZK7nr4pRbrackMsW3wXeGpUwLE8uQL+Whl+UxDaaeyjjA3Zr6SYzMJYoKFnXJv0E5I8+GcYni
	Hv0acQjxGET/NfnB+o3yBXlSeiTBUQvXE4sooVPZk1eOSjnUInA2HCCWSzWhhmUtnRXvdjTveiC
	PI7v2dbGA3PgHOdXTChJ5d/L2Lcb1Orm7FkkoUEh0XTBEMFpCelOSOrnYmHzovopyqnLmvDUZXW
	931aeKJNhHOnAl5pvw+h5VJw1LVIc=
X-Received: by 2002:a5d:5f54:0:b0:428:3e62:3220 with SMTP id ffacd0b85a97d-4283e6236ebmr11705624f8f.30.1761249787955;
        Thu, 23 Oct 2025 13:03:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVpW2WfIyt9mGiyfA1hGoENq2TIdXWY1dpXbpJHoGGtaDtHStMqMHIOiYdTKz+oFfHpZxtMw==
X-Received: by 2002:a5d:5f54:0:b0:428:3e62:3220 with SMTP id ffacd0b85a97d-4283e6236ebmr11705579f8f.30.1761249787533;
        Thu, 23 Oct 2025 13:03:07 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3? (p200300d82f4e3200c99da38b3f3ad4b3.dip0.t-ipconnect.de. [2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429897f57d9sm5671794f8f.20.2025.10.23.13.03.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 13:03:07 -0700 (PDT)
Message-ID: <e8d31a8d-ad4b-4365-951a-dff0bc9535a5@redhat.com>
Date: Thu, 23 Oct 2025 22:03:04 +0200
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/13] sparc/mm: replace batch->active with
 in_lazy_mmu_mode()
To: Kevin Brodsky <kevin.brodsky@arm.com>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
 Andreas Larsson <andreas@gaisler.com>,
 Andrew Morton <akpm@linux-foundation.org>,
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
 sparclinux@vger.kernel.org, xen-devel@lists.xenproject.org, x86@kernel.org
References: <20251015082727.2395128-1-kevin.brodsky@arm.com>
 <20251015082727.2395128-11-kevin.brodsky@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251015082727.2395128-11-kevin.brodsky@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15.10.25 10:27, Kevin Brodsky wrote:
> The generic lazy_mmu layer now tracks whether a task is in lazy MMU
> mode. As a result we no longer need to track whether the per-CPU TLB
> batch struct is active - we know it is if in_lazy_mmu_mode() returns
> true.

Same here, document the dependency on disabled preemption.

-- 
Cheers

David / dhildenb

