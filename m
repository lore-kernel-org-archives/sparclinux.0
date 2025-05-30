Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947B21A5BAF
	for <sparclinux@vger.kernel.org>; Fri, 30 May 2025 16:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748623723; cv=none; b=rfHpPFup+LYHtueGtSz8w/7Thn1CK9/R+Z4JbpeZ0XJ+DXV9jWBveWwOft42sGsIEqo1ncGVuZngT3/x24KhsB7IdXg37CIFwSyxJRtErNMTwR0YdozYoltKchAYHQOG2pm/z1f4m2HbGieJJljUez8TLFCAOZ7dkSa8cw0XGbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748623723; c=relaxed/simple;
	bh=woYXyTHjVEtDNgLXJ+op7181kk5ZG0noslFhtU0+xyg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KlKs/nboJF/O5YeZjnSJlG5oeJ3LWX9nMekWM4bFkKinQwUKvcNv13KFKAcqryuIDAEVqLIsZyW83RafdUtd1Swos2z9xRx75bJg7lwojzSuxsv9x3WFzk9ekyV4CQHIXpy7XWOqXKa9vA4CdxMJ97X4WY1yEsC+NyxwAiczofw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HEopO7ej; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HEopO7ej"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6000791e832so102a12.1
        for <sparclinux@vger.kernel.org>; Fri, 30 May 2025 09:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748623720; x=1749228520; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SfmVEdWuub4CI3JVXdpcy9od0u589O5saOKcmY0n2jY=;
        b=HEopO7ejLV7KK3NU7OdudV3Pnq7hZ5a6BnP9f985DZPCrYpW8vGpW/OOn2SdSDE278
         bBC36aUZcpOOFAolf9K6ZL/cP87ICRze5OE6bdA8qK2EsEuAx/TdaiUI8JjvxyRNMKuM
         FSVs/Y5g0aId7OQMmqMMJnRjDiE7xPpBPe+WQ2zd7l1kFaBE8AxbqaSjfV+cNRlcSVL4
         KNHSV5fCxr0JCmqcL4nicKg6sJWNDPgYm0rIBRv00Ppb72REF2pkLQ4J0tvLm2wEg2NK
         vb1uK66osrkEosEU4CDme9PrwIZzqbSpcFO8bdQzKukpxLDu2RCjaiY9jbyaB0MPK4Nn
         Kg1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748623720; x=1749228520;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SfmVEdWuub4CI3JVXdpcy9od0u589O5saOKcmY0n2jY=;
        b=myTqjx1A5rbrxWJzel25nbu6uJ/ZGSyHhJKloXeNDhvVvQQtpPzkMdNJavocONINCU
         V7KPGESecI78lrRSPQg3JjFn3wlzioXwhBEuyy+xMX42OtSUEH2f+XjKUY3bIF3dz6R7
         elkbc1kdO6P9nC99Th1ru5yMnIaeQf25vTmmd1SOwf+cvzQGPe3Ek1fwZgCi/chaMuNj
         yMmdDRoLPcwbOeTfG73Hv/86ILUZT9QCKdPbTMxfNwsyjAJFtedqWRyKBxFBFSVZwt/l
         IzdqIB/MtmDIWRwQ6WW3VBujsjYEBUumy3RC+q54hL9AsScQ4YoDucGI33a4sK1piVbV
         +4yw==
X-Forwarded-Encrypted: i=1; AJvYcCVQm4yu1TjYGtycc1K9TlrlwRBQ/2A2JmJz+rhsuKrl+RQtuEQ3GFrTglU1wbuaQQv9goW96m85nigp@vger.kernel.org
X-Gm-Message-State: AOJu0YwGeLe1Ajt51CfLvjHsPZsUJAi3/d0prNszS8FMg/jtwi20hxIz
	cHiR8g+GgZB3+Y1uPtz0UsYT6Qds2YvCP9fx/fx5ES0xDDZiPiYF/yfLhXqMAdq0ZeeNDfW+a4f
	38t6NifHbpz7wT9bmEDoTnuXL3frkpqP3weuQL4JT
X-Gm-Gg: ASbGncuVRpwf/0AswBOLaA684ozoRD6Oh2Thvox6rjsQxBiVGnYUDOEBsrcJs/NfRax
	RrjWzJRAzU/6uw/rdKhFR31PWootFTo/dLhAJXlz3HucFJqbaTJ5xcnL6uwB4uwdT/hImYqA0Uj
	acIUNC5PGzGLXiasJb59j6HqXbBPcn6F7rNVEaXd1apJZ7HlYhkZHey9zchAc3Q0P0e3g2zN4W6
	SceneCG5w==
X-Google-Smtp-Source: AGHT+IE4j04MEyqUQCgfbrapQs0vaUyWF/djR96KweNRHT1cvPKfDr7hIyG719V7LSGCiiciPXhWHE48ON6aHoH7Fnc=
X-Received: by 2002:a50:d781:0:b0:601:7b94:b80e with SMTP id
 4fb4d7f45d1cf-60577a3ffadmr87988a12.3.1748623719573; Fri, 30 May 2025
 09:48:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250530140446.2387131-1-ryan.roberts@arm.com>
 <20250530140446.2387131-2-ryan.roberts@arm.com> <CAG48ez2k6ZmM-335EQjXeL6OtKzuOjVPWQDuJ75ww9Z6NMeg5w@mail.gmail.com>
 <d183b3ff-ab61-4dc4-98c8-7ab9c1f6a4aa@arm.com>
In-Reply-To: <d183b3ff-ab61-4dc4-98c8-7ab9c1f6a4aa@arm.com>
From: Jann Horn <jannh@google.com>
Date: Fri, 30 May 2025 18:48:03 +0200
X-Gm-Features: AX0GCFuAT1zEtvLEHv4Z2Un3xyWjY8-HX0RQ4IFigWsX-k02Th9HNwh8AhT-yZ8
Message-ID: <CAG48ez27zfTAPrm-UX7_oqLs5S14-Miw9qreKyq2sMjxkn7q7A@mail.gmail.com>
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

On Fri, May 30, 2025 at 6:45=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
> On 30/05/2025 17:26, Jann Horn wrote:
> > On Fri, May 30, 2025 at 4:04=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.=
com> wrote:
> >> pagemap_scan_pmd_entry() was previously modifying ptes while in lazy m=
mu
> >> mode, then performing tlb maintenance for the modified ptes, then
> >> leaving lazy mmu mode. But any pte modifications during lazy mmu mode
> >> may be deferred until arch_leave_lazy_mmu_mode(), inverting the requir=
ed
> >> ordering between pte modificaiton and tlb maintenance.
> >>
> >> Let's fix that by leaving mmu mode, forcing all the pte updates to be
> >> actioned, before doing the tlb maintenance.
> >>
> >> This is a theorectical bug discovered during code review.
> >>
> >> Fixes: 52526ca7fdb9 ("fs/proc/task_mmu: implement IOCTL to get and opt=
ionally clear info about PTEs")
> >
> > Hmm... isn't lazy mmu mode supposed to also delay TLB flushes, and
> > preserve the ordering of PTE modifications and TLB flushes?
> >
> > Looking at the existing implementations of lazy MMU:
> >
> >  - In Xen PV implementation of lazy MMU, I see that TLB flush
> > hypercalls are delayed as well (xen_flush_tlb(),
> > xen_flush_tlb_one_user() and xen_flush_tlb_multi() all use
> > xen_mc_issue(XEN_LAZY_MMU) which delays issuing if lazymmu is active).
> >  - The sparc version also seems to delay TLB flushes, and sparc's
> > arch_leave_lazy_mmu_mode() seems to do TLB flushes via
> > flush_tlb_pending() if necessary.
> >  - powerpc's arch_leave_lazy_mmu_mode() also seems to do TLB flushes.
> >
> > Am I missing something?
>
> I doubt it. I suspect this was just my misunderstanding then. I hadn't
> appreciated that lazy mmu is also guarranteed to maintain flush ordering;=
 it's
> chronically under-documented. Sorry for the noise here. On that basis, I =
expect
> the first 2 patches can definitely be dropped.

Yeah looking at this code I agree that it could use significantly more
verbose comments on the API contract.
