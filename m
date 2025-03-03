Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1893BBD8
	for <sparclinux@vger.kernel.org>; Mon,  3 Mar 2025 12:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741006642; cv=none; b=iGRmUKWM51KQ4QAiDEl6Ce6hT7wiNzdp59vCHWMfKY6/0yhMjvbXAwdDOmFsgWO4f1DbUI0tkkx7UZBsfvl4gc6aZY5IJuonCDrY9iL7/VuRrs4dQoNIlSBOVg8q8UkPDxJ2evbV5afeyla2Qwp04TuzgFTHIy5m/ZdA6zbo36Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741006642; c=relaxed/simple;
	bh=7mCZRSnZn6C0/7YA5z8AqNvMolVAwCvm/RRxyvQ8eTs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n/qO27MSIx+Xo575fWzIZeGPJlf1MbD0cP7T8p9uewWvOsOO8YPhlX8oJGY0fjJ3GKUvb4M8CHv8KiL7UAOrNQ4+pdH+Kmq8EWpLEPgG/7gn9ap5YAiUs441t95bqviauaZx4p4j4Dls+l3XL+bwP8MXPstgmRnaWAqRNaNNHQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O8VUX6/4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O8VUX6/4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741006639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ZbBY5HPs9/ORp5FjR/nRtWeFfyn4LQ+KsSmcov6oEIs=;
	b=O8VUX6/41saOK9i2QbZoS/KjcVl1vYD7QFv6Xc/OBltqy3fLtc83JHAtjDweRXJaa2iSwg
	wPBc5L82YmMpfllNQhKs5Lc6/ysWMz7Vop9zAXI6M145Zv8soYf1zArWptLE58cZaVU3gU
	tYXRjPXnMbznMAuOu05o+uFQZbHD18s=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-bKDvI8JfNJamoghDD7Ltwg-1; Mon, 03 Mar 2025 07:57:17 -0500
X-MC-Unique: bKDvI8JfNJamoghDD7Ltwg-1
X-Mimecast-MFC-AGG-ID: bKDvI8JfNJamoghDD7Ltwg_1741006636
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3911218d81cso384826f8f.1
        for <sparclinux@vger.kernel.org>; Mon, 03 Mar 2025 04:57:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741006636; x=1741611436;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZbBY5HPs9/ORp5FjR/nRtWeFfyn4LQ+KsSmcov6oEIs=;
        b=K9EIXP/oVRWbyU+0aHTXqFvTaDqOFQ/y7Qc072D6Vnx4gJe6bVZ9Znsf/xtAmDStes
         eohI1S+0VbVskp+tk5Ix2vlSbTuetgnRkzufq+WTGp/ONY7qXxTyeka6kh0RDCkvh8re
         ng2D7fvPTjBztoKxwvyJvrzgEDrAAD1eqSeqgiRaSpdt32JJcZMYaRWbkhfqQF06dArG
         qVFx+EvE6yPJX4jWuR8/phaxV7zQQ2z+a7GkA56DMOlIclNH42glrjFv/nTwtEXUKXA6
         cZ5FRwNbcn6RcCwrjrV9hAh7pBhQJZzs2L0sBj3GeHihmDDsypGcnbxbUjjvBoZY0PDk
         IiKA==
X-Forwarded-Encrypted: i=1; AJvYcCU+sNatnZXfg5PFUSC9lwmoIB3ejUU6tDLcmjQr24DGNab7eJPHTCVGges4uEepDuZ/sCvgsCQztJzy@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/57tqWgTuUtiEFvTzKAVQeKALg495i9PcorL1SJHQuhVy2Qqs
	C7w8BwgfQ4HBWG5QRn5ZytAZfEHgvm+hL0Amqt5m5V7beWLnEX/HpNWT2J5SJlJKFPcaf93S4wM
	2e5D03aDGNjM0xCn9nzFmKKuxG+JMa6YBIsspzC5b4EaVbqhrlqlcdqPHroU=
X-Gm-Gg: ASbGncsj1UqeJz7SQ+aig9SgjG9aGYqw3xAaV/JRQeIRQhzwKfhIciskh22TIHGRTQF
	XqVbYIp6Ul81bDp91w/w0iX6Bvgrla8+h5q6vwtMDa3j9Rdltm9JPfhCZ6zlJcpaiTOcaKGzO9m
	Wrn3DWAZHPGjw9MtSofQfyGTOrMF1hxEpFQ18O4PyymJLRJkW81O2ZHk6unCUTsiOINJOXIixLf
	vVYm7vqgmkRnWG3hl3mQUgDeCuSIEK+DZAXJfUdJSOSZWHI2+3xlhyjb3j/Z1Ly9hSWV8r2vlte
	mvDj1dEpF8KmO5irgBZObwZqplUgdX5n5KyVFkprpGVdWqsQ8KL8JFbi6ZAIf3GUaxt2Pc0zmKy
	zF1rAU7+hhsHxhn8q/WXrZTyJ5Db7W+vD8ETIlJdgik8=
X-Received: by 2002:a05:6000:1568:b0:390:f6aa:4e7c with SMTP id ffacd0b85a97d-390f6aa506dmr8548955f8f.28.1741006636476;
        Mon, 03 Mar 2025 04:57:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGt3HqyWX69UNDm73XEavs4Jp5ikaGr7A82bFQLZfzfQ+Yf4WqMH1KFtPhi3+sLuqezP58sLw==
X-Received: by 2002:a05:6000:1568:b0:390:f6aa:4e7c with SMTP id ffacd0b85a97d-390f6aa506dmr8548914f8f.28.1741006636083;
        Mon, 03 Mar 2025 04:57:16 -0800 (PST)
Received: from ?IPV6:2003:cb:c734:9600:af27:4326:a216:2bfb? (p200300cbc7349600af274326a2162bfb.dip0.t-ipconnect.de. [2003:cb:c734:9600:af27:4326:a216:2bfb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba58720esm192864235e9.40.2025.03.03.04.57.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 04:57:15 -0800 (PST)
Message-ID: <1fc8281b-72a2-454f-88dc-288084482cec@redhat.com>
Date: Mon, 3 Mar 2025 13:57:14 +0100
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/4] Revert "x86/xen: allow nesting of same lazy mode"
To: Ryan Roberts <ryan.roberts@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "David S. Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>, Juergen Gross <jgross@suse.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-mm@kvack.org, sparclinux@vger.kernel.org,
 xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
References: <20250302145555.3236789-1-ryan.roberts@arm.com>
 <20250302145555.3236789-5-ryan.roberts@arm.com>
 <75031fe1-50d7-48d0-87bb-9c5c88f3b41c@redhat.com>
 <8b218b95-f0e3-424c-815f-5131e3e54031@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <8b218b95-f0e3-424c-815f-5131e3e54031@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03.03.25 13:33, Ryan Roberts wrote:
> On 03/03/2025 11:52, David Hildenbrand wrote:
>> On 02.03.25 15:55, Ryan Roberts wrote:
>>> Commit 49147beb0ccb ("x86/xen: allow nesting of same lazy mode") was
>>> added as a solution for a core-mm code change where
>>> arch_[enter|leave]_lazy_mmu_mode() started to be called in a nested
>>> manner; see commit bcc6cc832573 ("mm: add default definition of
>>> set_ptes()").
>>>
>>> However, now that we have fixed the API to avoid nesting, we no longer
>>> need this capability in the x86 implementation.
>>>
>>> Additionally, from code review, I don't believe the fix was ever robust
>>> in the case of preemption occurring while in the nested lazy mode. The
>>> implementation usually deals with preemption by calling
>>> arch_leave_lazy_mmu_mode() from xen_start_context_switch() for the
>>> outgoing task if we are in the lazy mmu mode. Then in
>>> xen_end_context_switch(), it restarts the lazy mode by calling
>>> arch_enter_lazy_mmu_mode() for an incoming task that was in the lazy
>>> mode when it was switched out. But arch_leave_lazy_mmu_mode() will only
>>> unwind a single level of nesting. If we are in the double nest, then
>>> it's not fully unwound and per-cpu variables are left in a bad state.
>>>
>>> So the correct solution is to remove the possibility of nesting from the
>>> higher level (which has now been done) and remove this x86-specific
>>> solution.
>>>
>>> Fixes: 49147beb0ccb ("x86/xen: allow nesting of same lazy mode")
>>
>> Does this patch here deserve this tag? IIUC, it's rather a cleanup now that it
>> was properly fixed elsewhere.
> 
> Now that nesting is not possible, yes it is just a cleanup. But when nesting was
> possible, as far as I can tell it was buggy, as per my description.

Right, I understood that part.

> So it's a
> bug bug that won't ever trigger once the other fixes are applied. Happy to
> remove the Fixes and then not include it for stable for v2. That's probably
> simplest.

I was just curious, because it sounded like the actual fix was the other 
patch. Whatever you think is best :)

-- 
Cheers,

David / dhildenb

