Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DC9194124
	for <sparclinux@vger.kernel.org>; Fri, 30 May 2025 16:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748622444; cv=none; b=AXWSoPKueed8braLmm4tbJ4d8doUii1KMe5Jm+w9OAXFJddc2HdsgBowRT0bUzuYjNSzxezqpOyvZQbZgcf63tvPvtTzvCiL8glpXbTuxELQ/cf0jLjKW2ZCsVFo4KV1Ortt80i/0juK4EHd9nmDl4zD3AGlMgu7q3x2L4hNUkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748622444; c=relaxed/simple;
	bh=dF1+gDmyxY/9rUreETaqbpogRNLbyWryW5tlSGlkXTU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZGnWA4KDGcveT8rFsegXdXGmHYxlmfncDCm942ZuolL1mJ5o7cxhsYckGRRw3Fec2q+AfAMHlJEMQD1duEAg8k+3u2psYrdNmk0wUv1UvsQ+jopBY0d+wMcJk2VvXEQD4IA67/kuJnUqX1siD6yEDgeiD+Ka38NfAiFaoDZPPAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z0SHbwEG; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z0SHbwEG"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-601a67c6e61so17a12.0
        for <sparclinux@vger.kernel.org>; Fri, 30 May 2025 09:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748622441; x=1749227241; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wb7EzNeuZNtT7LoNB6YIvTwNTIj8nYWDYSy4GeuX+MM=;
        b=Z0SHbwEG71b+g1+94RD8L73X7DqxpbRlt6Gi80IIC4DLXOIIgwIXnYdZlmy3wDMQMl
         LA84e3xwjtqsj7lvyLSOq1EiQoQtJGWq/r4px+oEoc9w26PNPrvsIPAeALkDTUTYNABu
         FbKNlpgTgh9oMD1MbKa2cmhlE6pZ2uEM6KZRNU1GfRu5TwsjVmZdIn/VDw7+7a6XmL6h
         o+NTnuOpkZ/8bMq/z5J0egoZLu7N+VHvnjVBBOvs5u96APjc5NhwCL2vkwED94Cw4XQj
         C0CtdI/2kagSZWeDsKsyM+HorSSungCWvwZ8xMyIFiMuKpjUioPnG8fIX8FapD4LZzEs
         5Ugw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748622441; x=1749227241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wb7EzNeuZNtT7LoNB6YIvTwNTIj8nYWDYSy4GeuX+MM=;
        b=W69r8e/fBugD+Fc26DoEEvKQ28neheFnhLcY1PzUFHMzH4BKJinGi74KMUha/jtw1I
         Vyvy8TTlin+GSH+zXa9zW6W7AmEwHpXxAURlnbyATSJDFIJ3oQ2Egz+L/2ZDZLEXSuQf
         W/GvQg78/Ah7/4+BxBBSLrE/je3AKKskjh7WqtWmGewrFJ+sWRHvUflaJCDHy0XjNxw4
         60Z6rSBJRetXLq5dnI/R/20sKYp8E1W3Ws0Nv/J8Fx+38b9zJYq6lfeJ0enKBJobil/s
         ecjlXGLiuUbYWHH/lSiWxgENtUo6YTBns2l4TYtbS5hOVRt3cXK/uP6kAppAHLk6zn4T
         KKIA==
X-Forwarded-Encrypted: i=1; AJvYcCV0VARNK48YWqYxAGVgw84pRntxN48dhVjW0xAjcTmshx90ugzRMcO1a9i6bh/N8M6UeQ37m0vFci8s@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9rzr1SHubRxbfUxXnVw6X+zwuvasNNPuogBTL/gtarcyO5NOt
	paHhhhMzymkU91G9rlVtF0hwehREQegyjY8Hlc9IUAWFn7TGjWu5qBeob54KxBWE6KzzmmJcPZk
	e9CQlcTSyhHa9q/IVyRbAnjW9FIBC2rx2xFw9Q1Cy
X-Gm-Gg: ASbGncuTxMoyirbYhGEzD3oC0XxuBDzIWgl9eRcYBbpvTNanlH0kTE9yJsEVH2uXc8v
	7NnkXLMR/tKU46djtoVzJbk/BkhFWpaAwxlQaZo2QdGh0ucvMcAOuJzI3yHyRWXwkpd2nt+MnU7
	cCQD521cocoH3cvnHcMRkX5QdHw7RSHKKl1JRTcmSStYQZ70BlpN4z6I4KNvyn7w/NLNN64qI=
X-Google-Smtp-Source: AGHT+IFvo4UeYXqvvR6hGpmlYjccx/P9qAgBVyNpakUtwWnk/plyYyjpSLFfr/exrsOHq2DB2NbEp4NJnsA/fPm9vYQ=
X-Received: by 2002:a50:f608:0:b0:5e6:15d3:ffe7 with SMTP id
 4fb4d7f45d1cf-60577a55f40mr88916a12.7.1748622440589; Fri, 30 May 2025
 09:27:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250530140446.2387131-1-ryan.roberts@arm.com> <20250530140446.2387131-2-ryan.roberts@arm.com>
In-Reply-To: <20250530140446.2387131-2-ryan.roberts@arm.com>
From: Jann Horn <jannh@google.com>
Date: Fri, 30 May 2025 18:26:44 +0200
X-Gm-Features: AX0GCFt5gaAeg9wlqckCjWiqvoyfvAtwj8XYq0jNIyzkBuWgoy0LcwI3HloBVMo
Message-ID: <CAG48ez2k6ZmM-335EQjXeL6OtKzuOjVPWQDuJ75ww9Z6NMeg5w@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/6] fs/proc/task_mmu: Fix pte update and tlb
 maintenance ordering in pagemap_scan_pmd_entry()
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	"David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
	Juergen Gross <jgross@suse.com>, Ajay Kaher <ajay.kaher@broadcom.com>, 
	Alexey Makhalov <alexey.makhalov@broadcom.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Arnd Bergmann <arnd@arndb.de>, David Hildenbrand <david@redhat.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	sparclinux@vger.kernel.org, virtualization@lists.linux.dev, 
	xen-devel@lists.xenproject.org, linux-mm@kvack.org, 
	Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 30, 2025 at 4:04=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
> pagemap_scan_pmd_entry() was previously modifying ptes while in lazy mmu
> mode, then performing tlb maintenance for the modified ptes, then
> leaving lazy mmu mode. But any pte modifications during lazy mmu mode
> may be deferred until arch_leave_lazy_mmu_mode(), inverting the required
> ordering between pte modificaiton and tlb maintenance.
>
> Let's fix that by leaving mmu mode, forcing all the pte updates to be
> actioned, before doing the tlb maintenance.
>
> This is a theorectical bug discovered during code review.
>
> Fixes: 52526ca7fdb9 ("fs/proc/task_mmu: implement IOCTL to get and option=
ally clear info about PTEs")

Hmm... isn't lazy mmu mode supposed to also delay TLB flushes, and
preserve the ordering of PTE modifications and TLB flushes?

Looking at the existing implementations of lazy MMU:

 - In Xen PV implementation of lazy MMU, I see that TLB flush
hypercalls are delayed as well (xen_flush_tlb(),
xen_flush_tlb_one_user() and xen_flush_tlb_multi() all use
xen_mc_issue(XEN_LAZY_MMU) which delays issuing if lazymmu is active).
 - The sparc version also seems to delay TLB flushes, and sparc's
arch_leave_lazy_mmu_mode() seems to do TLB flushes via
flush_tlb_pending() if necessary.
 - powerpc's arch_leave_lazy_mmu_mode() also seems to do TLB flushes.

Am I missing something?

If arm64 requires different semantics compared to all existing
implementations and doesn't delay TLB flushes for lazy mmu mode, I
think the "Fixes" tag should point to your addition of lazy mmu
support for arm64.

> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>  fs/proc/task_mmu.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 994cde10e3f4..361f3ffd9a0c 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -2557,10 +2557,9 @@ static int pagemap_scan_pmd_entry(pmd_t *pmd, unsi=
gned long start,
>         }
>
>  flush_and_return:
> +       arch_leave_lazy_mmu_mode();
>         if (flush_end)
>                 flush_tlb_range(vma, start, addr);
> -
> -       arch_leave_lazy_mmu_mode();

I think this ordering was probably intentional, because doing it this
way around allows Xen PV to avoid one more hypercall, because the TLB
flush can be batched together with the page table changes?


>         pte_unmap_unlock(start_pte, ptl);
>
>         cond_resched();
> --
> 2.43.0
>
