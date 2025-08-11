Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00CF2E403
	for <sparclinux@vger.kernel.org>; Mon, 11 Aug 2025 08:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754900418; cv=none; b=rwaMpAcxGy+A7SZDZYtIc7y/iG/9FK6208QXPdQ/VixliI2yDz/tU8gOTOzOSDYRKIegWy+nTGnjDBHqJjUa0VRPlt6OHCKwHTlSYkmzx7+B4dHdQHt/2PCPOy7aC6yq+tJn80zKJp2wIigvnpvbejhRAIjPeJYHfbGR2KfuAIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754900418; c=relaxed/simple;
	bh=ShksK8LFzoYLyrebpTx4xYUWaFAc0Qhb+cPc6re2V4M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CREiP3llHNmV3lvRnTi1+JIiMf6ENGcOdMgLRxFeyTIUJ1STQhq62dB4hQhQp/zYgGsIWI2yAqL2cnQldC+6T730jsUuynjiNK4bkmEM5XPrjUF8KPeI7vavdVkpEHcEf/SEnjgoHEHAWASLApl95VI9Tl4eIgr92LrBKgTbVd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aw+yhrjd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aw+yhrjd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754900415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=MO0GOEnqsUi00/HJp4tcv3myQ4l9wSODIZAoAGm0jMk=;
	b=aw+yhrjdISxg3TR7hseRE3oT6Y6+Ov+Ktrzh/u7EcLwc8bcHUKoJ/D6FPz1dD6JTlOVigP
	eb8iFaTl/+S/TeVhzD6nhM/IIw8M7oZ+QJmXLGo0fMMpYN6WCZnK+Z+zCnxY9hIsTzGxLq
	nP6vz4+XDmiBa9zxLrndTUx/M6yJlNc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-NPv-KHZnMVGbOHNTmCpPCw-1; Mon, 11 Aug 2025 04:20:14 -0400
X-MC-Unique: NPv-KHZnMVGbOHNTmCpPCw-1
X-Mimecast-MFC-AGG-ID: NPv-KHZnMVGbOHNTmCpPCw_1754900413
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-459d5f50a07so23596115e9.3
        for <sparclinux@vger.kernel.org>; Mon, 11 Aug 2025 01:20:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754900413; x=1755505213;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MO0GOEnqsUi00/HJp4tcv3myQ4l9wSODIZAoAGm0jMk=;
        b=DXwLgXZrF2s7S+pDDvghgItA9gEw8zUiJxEACTFTFjvaZU3swIbQFhsj7tMFUv27Bm
         t4mcCeGJhjBOpN8kySCgwv8oYQJVS+RrNUxIfX5c/TA8gVsJvWBU8N3jGHcCMZlKgTut
         LuFXXyyZAkb0zmbruJC510aY54kp1PxOBFiGLd1eatbL/Mq9/V5ZfPkLxWhyED8a0WZT
         thDPn2qGDTlxfaPNjeOrknPA3Eu6xpN0ccsKygFFw/1BEKMElA913fQN8BOeeVt6jQG9
         XfjEr+ojRKkyfOB90kjK5Cg3ZV1/lSP0SR8evtAZ2L/4CKSP+USuf3z3Qa/1K8ctEnMX
         GqhA==
X-Forwarded-Encrypted: i=1; AJvYcCU/0x+//h/O4ouscm6xEuYqi2sFVL5ckmBMRaDJq+EScdp13h2vaf3O2Gs/tR0HvXaqgijrM4qzbTwc@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1eZ7JfjVR9a9EEIb26KAxkzJLiKSlnEMJqAshbDLSjmT4sOtq
	R8O3WVofGmxEfMHrNoSI7pcjU7RtBjp1kZPxZOksbKOFVWtrk4aNW/ZNrJVavzJ4PN1LFAXGaAP
	+898M0uL0vUmaq85OoVgEs9Y+yBrWaDEDrHRJxth64X9soo+MouGjdGjr9oCBFGY=
X-Gm-Gg: ASbGncsnZN9QoLgjpnksv1cMuB7viH1WaMk1Xj3K82gDs7i9rM2xY6L3zpQq3b+AJdx
	ykDl818irumrew6FVeCxH55k6qmmgrNWjafKYsBZz9WZQoFtraSshzRjq/QP3Uyy48KC2XZvg85
	PRgrR6h5Q69yMuV+tEbg1Fui/0sxIht/z/do1uDgIZVh5/4iMtWYpanuQ2NR0T39wmQVk67Lnho
	eDTe9/TIJQNq+fII0F5fkkUl+v8zs0pmQ+IU/8htXrEb0MlKVNp4dGDT2NIRp4EHWlSAuikOW7x
	I7z8Ehf8bRTUUDNYXVinUpAgbtpuyoZb407Nr7SR4p2U577ePvIG0wsbWjwvlrs3s/x11TrTkqG
	z+FyV5nK+/ZlQDczX7YYRQwGqrBiQcwfWCDAGFbhq6VeNkfd7b1wUWl9OfucwdGDdZiI=
X-Received: by 2002:a05:600c:3589:b0:456:24aa:958e with SMTP id 5b1f17b1804b1-459f4e9e4c9mr108728055e9.0.1754900412907;
        Mon, 11 Aug 2025 01:20:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhap84eMeBm3c9wHG7W04/VJ3z05W3bAuXpSTfnt7XXnx2D6Q+1WZFV+rDMQrb7QHIlbcnsg==
X-Received: by 2002:a05:600c:3589:b0:456:24aa:958e with SMTP id 5b1f17b1804b1-459f4e9e4c9mr108727745e9.0.1754900412473;
        Mon, 11 Aug 2025 01:20:12 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f06:a600:a397:de1d:2f8b:b66f? (p200300d82f06a600a397de1d2f8bb66f.dip0.t-ipconnect.de. [2003:d8:2f06:a600:a397:de1d:2f8b:b66f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e5869cccsm266006715e9.17.2025.08.11.01.20.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 01:20:11 -0700 (PDT)
Message-ID: <96992842-f576-4e19-afcb-7455452fe506@redhat.com>
Date: Mon, 11 Aug 2025 10:20:10 +0200
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sparc64: fix hugetlb for sun4u
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Anthony Yznaga <anthony.yznaga@oracle.com>, sparclinux@vger.kernel.org,
 davem@davemloft.net, andreas@gaisler.com
Cc: linux-kernel@vger.kernel.org, agordeev@linux.ibm.com, will@kernel.org,
 ryan.roberts@arm.com, osalvador@suse.de
References: <20250716012446.10357-1-anthony.yznaga@oracle.com>
 <35f5ec4eda8a7dbeeb7df9ec0be5c0b062c509f7.camel@physik.fu-berlin.de>
 <7e1e9aa5-0529-4fb5-84fb-557b5cc1cd50@oracle.com>
 <38f4469f48e6d36fa92b445c8ecef7a440be43e6.camel@physik.fu-berlin.de>
 <b14f55642207e63e907965e209f6323a0df6dcee.camel@physik.fu-berlin.de>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <b14f55642207e63e907965e209f6323a0df6dcee.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09.08.25 08:23, John Paul Adrian Glaubitz wrote:
> Hi Anthony,
> 
> On Sat, 2025-08-09 at 00:37 +0200, John Paul Adrian Glaubitz wrote:
>>> Maybe try enabling CONFIG_DEBUG_VM_IRQSOFF, CONFIG_DEBUG_VM, and perhaps
>>> CONFIG_DEBUG_VM_PGFLAGS. That might help detect a problem closer to the
>>> source. You can also try adding transparent_hugepage=never to the kernel
>>> boot line to see if compiling in THP support but not using it is okay.
>>
>> OK, I will try that. But not today anymore. It's half past midnight now here in Germany
>> and I was debugging this issue almost all day long. I'm glad to have finally been able
>> to track this down to THP support being enabled.
>>
>> Maybe you can try whether you can reproduce this in QEMU as well.
> 
> OK, first data point: Setting CONFIG_TRANSPARENT_HUGEPAGE_NEVER=y causes the backtrace during
> boot to disappear with CONFIG_TRANSPARENT_HUGEPAGE=y. However, it still disappears later when
> running "apt update && apt -y upgrade" again:

Just to give some context: (m)THPs in file systems will get used 
independently of CONFIG_TRANSPARENT_HUGEPAGE_NEVER=y.

So CONFIG_TRANSPARENT_HUGEPAGE_NEVER=y primarily only controls usage of 
(m)THPs for anonymous memory, but not in the pagecache.


> 
> [  170.472743] kernel BUG at fs/ext4/inode.c:1174!
> [  170.532313]               \|/ ____ \|/
>                               "@'/ .. \`@"
>                               /_| \__/ |_\
>                                  \__U_/

Is this the

BUG_ON(to > folio_size(folio));

?

-- 
Cheers,

David / dhildenb

