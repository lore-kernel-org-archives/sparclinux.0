Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363FA171C9
	for <sparclinux@vger.kernel.org>; Sat,  8 Nov 2025 02:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762569220; cv=none; b=hj+50Nxb4X8G+84qS1i2pvz5YhNtwkj8SUMqyhOR8BV94Or4XL2VAFFUNU/NZ+gBE87qpxRbCBTXgelcHt0ik5iKwsuYj1RU7BmvQtFbJz3mMzqi35TM+3xqjLlb351UKF2b/e4SPrPsPHe7jOKrJtTW1tcV1/+318PyGT/56tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762569220; c=relaxed/simple;
	bh=Nhs+F1/Ux3/GUaROEHf188icqClLbb94b/l3GRvYQMo=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=lIP90l7Na8Y2GIsABwG2xGDh0LZFt0Fjhe6NCVfaoCLwk9uVpRgIg2KFebE6I5abPo+gPd7ulMV5uSO8FSvrWyTlNmHmKN4YqFeC3U9ARWXouQ8UptlOLesDyNQya56PKSEQhoWt3vNzU6KmqbrYiSf3woCrYenByiIz89ptKZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jLxYjy29; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jLxYjy29"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b8c0c0cdd61so1096571a12.2
        for <sparclinux@vger.kernel.org>; Fri, 07 Nov 2025 18:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762569218; x=1763174018; darn=vger.kernel.org;
        h=mime-version:references:message-id:date:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=8bKq5Kbap+TGIzkU08hwTVasn8Atv2TAiFfbpOuCLu4=;
        b=jLxYjy29ijrB6Qeejutw9pWLNQ0sAShg4X+P9fdCcPoWSNvKSQyt9ba1e/tJKryNJy
         59wVDD7SMeVNgpdDpI7Ve5L3yj3Kjt1SmoTLMziNfLw/0i2UtmCUBukJ8U3z2gFMVjvx
         C1U+yhSw7SEuNrtnx/WdX89bojM8pokn834lejq1hXP5MG+4nbpm9oCmAeP+oatFsQ6l
         bdO+JA2PRxvEc6fmC0P4aM/uzR5bo+yZTnl7VF8I2uuk0tVj1P/PX8CDXmVgbB+euE9f
         J0MRd0jiTh4zerKJoC++jwEd4eikd3bcuMmczUp9E4sbvMbItS2qW3iScbjc/VZbGrGx
         L58g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762569218; x=1763174018;
        h=mime-version:references:message-id:date:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8bKq5Kbap+TGIzkU08hwTVasn8Atv2TAiFfbpOuCLu4=;
        b=C4Z0zaKoTipMK0+3oAdyQWzspO7gxSvNYJj4NGAk5dy6xar+sz9HnuEwNJJf2SSEpI
         jknXcuyB/O6g3AyHiMg0+HXFofiD3TyvbpSB2IjHS2myXzDdb023YxuMu2Ecy3y/hB3I
         +2WUczBFCQ0TYFbd2oxZsF3Ksd99ZqfUrFXbSmAnqaiQFOV3ukj64kvUMg0TjL5w/Usi
         W8XCpAcgK2Un7h6X25rnsycrxkdGIk/ksdtT4wFLBrPEltuC+QPiUxC8qDIQj6ybTc6d
         aLfdTer0oV82oHi/l3cnsjCn15j83NLe60kyo39hjzs7UG5ba94p0gASrmifpDJr+oIU
         cbjg==
X-Forwarded-Encrypted: i=1; AJvYcCVsfwd6NEBuz1n+Y0zHsHNRPpRbw/TyI4ubSi4EeSihavne9d5aIEXvCgeXLcdYFl2Y4FgPQ0++Gcdc@vger.kernel.org
X-Gm-Message-State: AOJu0YzD/Kx7UemWiq54j7Bn7z6SRoMeRorqh5hdtvF129VBRsnv1/th
	MT5za2pb5mPGbDlKroQr4K7pEHrXWtb5Q0d/0FQKGFn4zY3BonZWUrb3
X-Gm-Gg: ASbGncvbMgYC4ijsVZ+fw92xnG79g5Pv+t7nVAm6z1EjlrnTN9bOUyPUWw2fQ4ZK30z
	1RClxfF9q9V3CpUqhO3nnp40kPV/pxMZxO+Ced2GWnlkrHId0GdBmsSItQIpyaLmtMEsk5uKFWg
	yDDEIr6l/i/bzwakGlqPEOQCbyxN3XoOnQRD/W5GLebgkH5cn71AOQU5XC4csHNxjDFwLx0usWU
	IHFFiusKgbvQO6o9VkgZjhCxUWMhycWs4bxURNLO8kQMOI+/bVQuFHiCKBWDGw4ilV+sBuqBsSn
	WYV0+CdHcuNpYo0rLmVVhfJk/uoCub9/PPTDAadOoDvyuqEq2UZ8afojh1APytyGHGfu1sD77IN
	5r/nHNWlfxzglT2swUBjp0Ja9RsVBrMb/ZMjg1H6ZevgpX9oBKWhyuoCsYXVXxj3s3FbwnIHbiT
	UYzDTn
X-Google-Smtp-Source: AGHT+IH/Pe7wf3Ci181tpT0LHXQVq+Kf1iV5vunI2sKT5fx4KiiLBfIeJu3hgL/jAYkDOG6ZWRYxGw==
X-Received: by 2002:a05:6a20:12c5:b0:33f:9581:5d2f with SMTP id adf61e73a8af0-3539f99e63emr1740681637.3.1762569218334;
        Fri, 07 Nov 2025 18:33:38 -0800 (PST)
Received: from dw-tp ([171.76.85.117])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba8f8d7eedcsm6587378a12.2.2025.11.07.18.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 18:33:37 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Kevin Brodsky <kevin.brodsky@arm.com>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Andreas Larsson <andreas@gaisler.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Borislav Petkov <bp@alien8.de>, 
	Catalin Marinas <catalin.marinas@arm.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Dave Hansen <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, David Woodhouse <dwmw2@infradead.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>, 
	Juergen Gross <jgross@suse.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>, 
	Nicholas Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ryan Roberts <ryan.roberts@arm.com>, Suren Baghdasaryan <surenb@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>, 
	Yeoreum Yun <yeoreum.yun@arm.com>, linux-arm-kernel@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org, 
	xen-devel@lists.xenproject.org, x86@kernel.org, 
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: Re: [PATCH v4 01/12] powerpc/64s: Do not re-activate batched TLB flush
In-Reply-To: <b3e4a92f-5b51-4eee-bfb8-c454add0f0d2@arm.com>
Date: Sat, 08 Nov 2025 06:05:17 +0530
Message-ID: <87cy5t4b0a.ritesh.list@gmail.com>
References: <20251029100909.3381140-1-kevin.brodsky@arm.com> <20251029100909.3381140-2-kevin.brodsky@arm.com> <87qzud42n1.ritesh.list@gmail.com> <b3e4a92f-5b51-4eee-bfb8-c454add0f0d2@arm.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kevin Brodsky <kevin.brodsky@arm.com> writes:

> On 05/11/2025 02:46, Ritesh Harjani (IBM) wrote:
>> Kevin Brodsky <kevin.brodsky@arm.com> writes:
>>
>>> From: Alexander Gordeev <agordeev@linux.ibm.com>
>>>
>>> Since commit b9ef323ea168 ("powerpc/64s: Disable preemption in hash
>>> lazy mmu mode") a task can not be preempted while in lazy MMU mode.
>>> Therefore, the batch re-activation code is never called, so remove it.
>>>
>>> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
>>> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
>>> ---
>>>  arch/powerpc/include/asm/thread_info.h |  2 --
>>>  arch/powerpc/kernel/process.c          | 25 -------------------------
>>>  2 files changed, 27 deletions(-)
>>>
>> Since the commit referenced in above disables the preemption in
>> arch_enter_lazy_mmu(), so the expectation is that we will never be
>> context switched while in lazy_mmu, hence the code changes in
>> switch_to() around __flush_tlb_pending() should ideally never be called.
>
> Correct, that's the idea.
>
>> With this analysis - the patch looks good to me. I will give this entire
>> patch series a try on Power HW with Hash mmu too (which uses lazy mmu and
>> let you know the results of that)!
>
> That'd be very appreciated, thanks a lot!
>

I did give this patch series a run on Power10 with Hash MMU. I ran the
following stress-ng tests and didn't observe any issues (kernel warnings) so far.

stress-ng --all 0 -t 60s --perf -v --verify \
--tlb-shootdown 0 \
--fault 0 \
--userfaultfd 0 \
--fork 0 \
--exec 0 \
--memfd 0 \
--numa 0 \
--pkey 0 \
--remap 0 \
--vm 0 \
--rmap 0 \
-x swap,pagemove
(Note not all options shown here will work with --verify)

Let me know what else I can run for validation?
Do you know of any specific tests for validation of lazy mmu feature?

>> For this patch please feel free to add:
>> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>>
>>
>> CC: Venkat who also runs CI on linux Power HW for upstream testing :)
>
> Ack, will Cc you both in the next version.

Sure. Thanks!

-ritesh
