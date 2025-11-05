Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241452FB0BC
	for <sparclinux@vger.kernel.org>; Wed,  5 Nov 2025 09:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762336168; cv=none; b=bIt63ysor5Z+0yeRSiVEzMdEdqRkxfqA+7hOpPp0+xQ3vJ/ydess5MB7pnHbyOV9LUOpMMri+0p6tVc/ITHTRn26kIqFeE+osMdL2khfdDwDoLipTBVNeU2pTSlLDxLiLniVWDToc5Lm/MRX/dTpJ0C0JcxJ9JyNTZzjMnZq/3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762336168; c=relaxed/simple;
	bh=NC6ReN0WzQGGaTyVdcbh4RmGorXBkU+fbc8xzhNkKSw=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=fS4nFw+dBZz3cVeRFRYUW1ip2eJeRu4Xx1jVnLxfUsmjWX70mO5J1tuFVtCRl4+baHcDeL9E6qDlRLaCPwUe1SwoOwefIpZV6M0pZGpE+gzalkJdcKuNf60Fgls1L0KgftrsLpktpY/Av5DyIDfawU45ul4eoLZSUsUcPrx7o2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RQWVYUax; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RQWVYUax"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-79af647cef2so5998652b3a.3
        for <sparclinux@vger.kernel.org>; Wed, 05 Nov 2025 01:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762336166; x=1762940966; darn=vger.kernel.org;
        h=mime-version:references:message-id:date:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=KSkImeW26wxHMAXfbe7WvrT7t//6KWteMn9Q9gZQJTU=;
        b=RQWVYUaxEoTzw1PGOUe6ayh6KYlnYA/MLK2sT+N8I7zVI4gX3wo454Lj0dp7cuU68v
         nFkEe5Ld2Uk1l0IoFfMp/Qv7XNRzmnOgBvSr26qvW8mcRRQLfbEhbXpxeaI8fYp9tv4a
         hd4Twyg/cs4rBf4Rt7RNdYLmnU07TDLzW+xMhmStFUy6wh3JdgubgpucisbbLwkhFhPr
         rkFhU7I1DBeCXaXTZF02A8fUxKp+QhUh7iUrL5+gqKnAQmavUnQHG89QvR90qGFAcmjM
         KvKo8Kq7cIqsGRiMTLMA6P7AO3dnQLXxmG7xZpXt8+QG5d45NhqjAL2GSGzEOxxAnNkO
         RizQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762336166; x=1762940966;
        h=mime-version:references:message-id:date:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KSkImeW26wxHMAXfbe7WvrT7t//6KWteMn9Q9gZQJTU=;
        b=Gb/QXVuD83Ms2cKpYu5mapclHKs9Cbil+TuZcnLExbTPX6ehkJgI0KzmPaI1JF+wfs
         27DeqfVG99qQaulEKTr5KzjBrPl/I2tuaLwT8mlnyCZ6P53fhrFGpH4zDqI/gvOuLOL/
         MLyifEiHVrWjHUqeN67Sj63+Dv+cqTdsGoytXaj8f6I6d3bXnmtU9kLP5s9Zz5aM9pX0
         s8/SgqTUAcVLib5kETBo7g5u+/kqhAHdbIMlbncHM9CBmT44fPsSMzR4O6Nk/cNTKqGA
         9wfMOvu3pp6Neep6afR1MWX6l1PkFiWqy+xcNuauuZmWWF6JRGiODtqYy7wewJVOfJTk
         NZ7g==
X-Forwarded-Encrypted: i=1; AJvYcCVbEF+kXAtZWoFojp/Xdv5OeELBEUBrO9PUl/z0DkgQD3H0xG+Bn0Snac34fPwNl3xcCXGpN9TyzDeB@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr2wja9d5tR/kRpqa/Z/ouhzSGsqwUIRGw6j/SDfOXFwaW15zj
	IcFia/LBbV+SpwvuWZAG+8WMlXxAA61TGg8eBDkiFs093jdwX/e65cCV
X-Gm-Gg: ASbGnctonrXHowGr9KJY1rJpdQ+9051/4YZUCEsbZumxI2dJTdpojbhajjAYeEWFMaE
	zXtvmwipMNLg3wWTKiBEbMhmibWu7kcYjlr2bywqKGhFvjc2V+Vu9dTfS9NuB4gAB4359ih1CWn
	wGVkcXgd4GUbThi4BIR1aarbXIXPeMeYJqg0pf2Q1u1mIvklzf+H6A2xgmCyg54rsnhykYn5byR
	d9YiXsewmvtjRHUXQ69xKPeypmsm7p0CWXTsBjVM50NBlE1Ta6P4SCRVhGBhhbNiH45yoBuydx3
	Jr3Gf1HnXRfRprvLhwlZrnBCCoZ8+mwe0lBGDEJoWx+Wm3SoBDep6r2sYmie4Bgq90/5GqHzhhQ
	+ITjiuaOZFqgHqM+XwlfyvhZa/Qlry7Kgh5HO90YauSgaeE5gsPqEElnTB/Btz11qhgDPFQ==
X-Google-Smtp-Source: AGHT+IGvXEix8Ale69u5jY13ojKwbWl3rHLnPywsClHEKGLTCQBX8z03LTjZkKtfW5wInDfRAomLmQ==
X-Received: by 2002:a05:6a20:7283:b0:343:88b4:a722 with SMTP id adf61e73a8af0-34f862ff4a8mr3711914637.52.1762336166397;
        Wed, 05 Nov 2025 01:49:26 -0800 (PST)
Received: from dw-tp ([171.76.85.117])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba1f765f148sm5030694a12.24.2025.11.05.01.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 01:49:25 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Kevin Brodsky <kevin.brodsky@arm.com>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Kevin Brodsky <kevin.brodsky@arm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Andreas Larsson <andreas@gaisler.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
	Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Dave Hansen <dave.hansen@linux.intel.com>, 
	David Hildenbrand <david@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	David Woodhouse <dwmw2@infradead.org>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, 
	Jann Horn <jannh@google.com>, Juergen Gross <jgross@suse.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Michal Hocko <mhocko@suse.com>, 
	Mike Rapoport <rppt@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Suren Baghdasaryan <surenb@google.com>, Thomas Gleixner <tglx@linutronix.de>, Vlastimil Babka <vbabka@suse.cz>, 
	Will Deacon <will@kernel.org>, Yeoreum Yun <yeoreum.yun@arm.com>, 
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
	sparclinux@vger.kernel.org, xen-devel@lists.xenproject.org, x86@kernel.org
Subject: Re: [PATCH v4 09/12] powerpc/mm: replace batch->active with in_lazy_mmu_mode()
In-Reply-To: <20251029100909.3381140-10-kevin.brodsky@arm.com>
Date: Wed, 05 Nov 2025 15:10:20 +0530
Message-ID: <87ldkk4y2j.ritesh.list@gmail.com>
References: <20251029100909.3381140-1-kevin.brodsky@arm.com> <20251029100909.3381140-10-kevin.brodsky@arm.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kevin Brodsky <kevin.brodsky@arm.com> writes:

> A per-CPU batch struct is activated when entering lazy MMU mode; its
> lifetime is the same as the lazy MMU section (it is deactivated when
> leaving the mode). Preemption is disabled in that interval to ensure
> that the per-CPU reference remains valid.
>
> The generic lazy_mmu layer now tracks whether a task is in lazy MMU
> mode. We can therefore use the generic helper in_lazy_mmu_mode()
> to tell whether a batch struct is active instead of tracking it
> explicitly.
>
> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
> ---
>  arch/powerpc/include/asm/book3s/64/tlbflush-hash.h | 9 ---------
>  arch/powerpc/mm/book3s64/hash_tlb.c                | 2 +-
>  2 files changed, 1 insertion(+), 10 deletions(-)
>

This looks good to me.

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
