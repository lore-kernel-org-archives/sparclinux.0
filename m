Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A2A1DFF0
	for <sparclinux@vger.kernel.org>; Wed,  5 Nov 2025 04:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762318125; cv=none; b=msU9m5Ux2FkL38mQw924O3fcVB7p5NjskhPutaAgZtFmszUJ+ZWWe9ci633nvm1VruXuboInxN3UmTm2lqe0LdlpaR2BNQm/B0l/VJ7DejRr0GymmjfI7KKUmO7o/Bl6Yc18H1PxA9iEbABxEslOZ4XklT9iQX/LYySngznE24g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762318125; c=relaxed/simple;
	bh=UYkzMdGWP3fFO0+d2KGbO29m16qCMZIP2+cQJMi+cNE=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=ozTZh2gv/e6ivi3G0xBSQmmM1/8Naino6P8pCHBFvTmD0FESRO9BNqwfhboD7q1BRi7mMNlAsJpEF8DuHjJzOTULUmeqNyKh6vQZqqjubkkxgudvO0cj0w4RVJXblfSk70C9QRsRBderUjj/FvIbGz7JbqqBEltsujrEj5G1p+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cNAL3hWR; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cNAL3hWR"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b5579235200so4502075a12.3
        for <sparclinux@vger.kernel.org>; Tue, 04 Nov 2025 20:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762318123; x=1762922923; darn=vger.kernel.org;
        h=mime-version:references:message-id:date:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=YULlj58qL4zgqYnaxIvN0IRxkfnew4hxgBmocTGIAOg=;
        b=cNAL3hWR2NAw0GE15nlqKh3AXTwpmnPu2wwHJglpRmXpRMVv3gkcsFsQCDOLUUn2qo
         Van2Fe8YHDSFipFgL7JgzxTv0GgmQGqdMaXuXfe5+h2pHb1KGdKCYu3F65MpO9PfVHjH
         Df730h35tQt2Ti+uvofPrhaQ6hPudcNr6+zGGWT39/MkNjAy/T3+VQvC3LYBFNX9s3im
         yLG/fyy81iuwu7/2efuCvbR9t86aZMObOtu71AP1HAX97aXc97/gnueE4v9A14fgIvTf
         suk2ZKfN3B//SrlH2TocF3QO66asUNRy7AsqROgZNOSh7q3eCz8jb5bzZvcl2Lt0V9pA
         vysg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762318123; x=1762922923;
        h=mime-version:references:message-id:date:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YULlj58qL4zgqYnaxIvN0IRxkfnew4hxgBmocTGIAOg=;
        b=AYRfqGRse/V8osLVrF/M97bWiq5bINTs0eg8TVpTWACMiibcnU9737WChHhcmnv1/9
         iKzBsc4rdbu/SrLSnk5Lw9hMsSTS4FTc/HQ/FruDvCQIT81Jh9EBBmg6cU8QsFpCIXqU
         iEZuX1XwzPt5L9C7HQfk3OWCPw7mEH+Y0yu+1ywgBT7hzLtyGiiGUeJRKmmWIxj64kS+
         VVQLTD/dAmt4KAj9cWgmC7+sHomdV8d8g+aS1qFVcD1rHw/lsYz8R/rnpwDFjqWXxK1H
         HzF7bMJXw1AdTv+/VOyGJzrlGtDvMrjghOXpdJ3kKGG+blGsNnMnoK59aIVuBBFMNoLf
         E3dA==
X-Forwarded-Encrypted: i=1; AJvYcCUeKcVJOjRy2C38YoRdAN4LvlubSl67FkiPRRg6FmII07XWQLDQK14ThYURcazocGJDMcMv+V8FByhe@vger.kernel.org
X-Gm-Message-State: AOJu0YztVNFTcdO7pCSFigREcPJqlotZNMXQPZK/wAkwbjy6iLyoRduy
	Z6UDyDj0CvxO/JKp/oUYp4CQiQ+YablS/NCC+8RHgjS5hOIjLE9vYWVt
X-Gm-Gg: ASbGncsvNFSRSKYEaeVcmMc9V6bVVSpqy6lHcEBjR8hCdM3sQSELaDs+KuN2+DWizsz
	iuR8Wruw/hG9A/gDg1/Vdi9exvRB7Wcj2yCo3DkiDjQOWa26oVA56vbf4y0DSyzcniCBwQI5snr
	yEs/afiF7rZ+z+ltomygOD6BgJXo9BxjrZiw4H+bul+mcanpY8GPK3hoOhWTzJ3jjLt5o8+YMoF
	W4omfMV5AKDfNNXvLuIrtiSU1G7xq8aCok+Bk2DNz18pmkHl1HDPTR/+QYhHW5M2/tJB8Wlqz2d
	cawIJZcd980LHr69ETAZ8gob65yGJG4w7nz17zviXShkOKbWzotRgQVToOx1Iq/fhelbqTohW/k
	t0EQV0zfgAl+Hmbgr6slu7nn9hKFmkYckLkx3tLHB2GJ/5JE5DYWySYUz3mHnvAoVVYozoA==
X-Google-Smtp-Source: AGHT+IEGT+eOgR9ydzqm23BJtuNpA3RB5HWaj5Ha9KjzqVJ/S6kqSTkQbIaWCHaOF+SdxbuTbYvUtA==
X-Received: by 2002:a05:6a20:7483:b0:34e:63bd:81c1 with SMTP id adf61e73a8af0-34f839f5a57mr2604485637.3.1762318122822;
        Tue, 04 Nov 2025 20:48:42 -0800 (PST)
Received: from dw-tp ([171.76.85.117])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7acd6824811sm4742988b3a.64.2025.11.04.20.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 20:48:42 -0800 (PST)
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
Subject: Re: [PATCH v4 05/12] mm: introduce CONFIG_ARCH_HAS_LAZY_MMU_MODE
In-Reply-To: <20251029100909.3381140-6-kevin.brodsky@arm.com>
Date: Wed, 05 Nov 2025 10:10:33 +0530
Message-ID: <87o6ph3xdq.ritesh.list@gmail.com>
References: <20251029100909.3381140-1-kevin.brodsky@arm.com> <20251029100909.3381140-6-kevin.brodsky@arm.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kevin Brodsky <kevin.brodsky@arm.com> writes:

> Architectures currently opt in for implementing lazy_mmu helpers by
> defining __HAVE_ARCH_ENTER_LAZY_MMU_MODE.
>
> In preparation for introducing a generic lazy_mmu layer that will
> require storage in task_struct, let's switch to a cleaner approach:
> instead of defining a macro, select a CONFIG option.
>
> This patch introduces CONFIG_ARCH_HAS_LAZY_MMU_MODE and has each
> arch select it when it implements lazy_mmu helpers.
> __HAVE_ARCH_ENTER_LAZY_MMU_MODE is removed and <linux/pgtable.h>
> relies on the new CONFIG instead.
>
> On x86, lazy_mmu helpers are only implemented if PARAVIRT_XXL is
> selected. This creates some complications in arch/x86/boot/, because
> a few files manually undefine PARAVIRT* options. As a result
> <asm/paravirt.h> does not define the lazy_mmu helpers, but this
> breaks the build as <linux/pgtable.h> only defines them if
> !CONFIG_ARCH_HAS_LAZY_MMU_MODE. There does not seem to be a clean
> way out of this - let's just undefine that new CONFIG too.
>
> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
> ---
>  arch/arm64/Kconfig                                 | 1 +
>  arch/arm64/include/asm/pgtable.h                   | 1 -
>  arch/powerpc/include/asm/book3s/64/tlbflush-hash.h | 2 --
>  arch/powerpc/platforms/Kconfig.cputype             | 1 +
>  arch/sparc/Kconfig                                 | 1 +
>  arch/sparc/include/asm/tlbflush_64.h               | 2 --
>  arch/x86/Kconfig                                   | 1 +
>  arch/x86/boot/compressed/misc.h                    | 1 +
>  arch/x86/boot/startup/sme.c                        | 1 +
>  arch/x86/include/asm/paravirt.h                    | 1 -
>  include/linux/pgtable.h                            | 2 +-
>  mm/Kconfig                                         | 3 +++
>  12 files changed, 10 insertions(+), 7 deletions(-)

Maybe we can add this to ... ?

Documentation/features/vm/lazy_mmu/arch-support.txt

#
# Feature name:          lazy_mmu mode
#         Kconfig:       ARCH_HAS_LAZY_MMU_MODE
#         description:   arch supports arch_{enter|flush|leave}_lazy_mmu_mode()
#
    -----------------------
    |         arch |status|
    -----------------------
    |       arm64: |  ok  |
    |     powerpc: |  ok  |
    |       sparc: |  ok  |
    |         x86: |  ok  |
    -----------------------


As for this patch, the changes are mostly straight forward around the
configs part. This looks good to me. Please feel free to add: 

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

-ritesh
