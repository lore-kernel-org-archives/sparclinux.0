Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC7316EB53;
	Wed, 26 Jun 2024 09:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719393365; cv=none; b=I6h0M2McX4eR/Hel19XYmu+pEvI+o3FHIFUdGuFMk+Q5WJ4xzA7VCS/wFcVaTFAgN7zKEsyO8uhoRO19UuHHUHKYOqFCNOUjfflGnkfb6do5T0CMi5R3lAbG4y8nhTLOh/UtfPVSEn+Fr46Kdo5DyUKoojU1ewInmZfmkhMdW7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719393365; c=relaxed/simple;
	bh=MMtXv5Ri6gnu/ZvxtyFF8jeukfcqm67vgKUvtekW57o=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P5+p7Dou+rfUZLvUkpE7uee727Rc/YSXA4Qp0BuhmhE5/TAKpUPac1hDipcNP1QUWmLZ86LmhDrTi+yvmKe8ar9NjsYrHguj6XbF7JZF05KJ/rpv9H1OavZd9YDKskad9AAIg9Nngv2MfKIBSODHkEIFGTVj7/9t9rzbr5We5Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gNuS/5C+; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gNuS/5C+"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ebec2f11b7so71490011fa.2;
        Wed, 26 Jun 2024 02:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719393362; x=1719998162; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Eto0wDQ+VnHOvIV84i+qZbXGq9+6luYSO1FuNV/i1EM=;
        b=gNuS/5C+VDbFMQAJEgvNxr8YSCFShhYRtwXcqurKVK0ZAcbKwGfJ3BwlP0+TLcnQKC
         th1nteG5eFd69Vt/yR9JZ6w9c3EYlHo5sxPUzneXTzfcBvRFAaqvcAaffsdwPQLq4boF
         WmzAYXK5RXDu+uLzzrwRyT+Tl+P23i2al5iec7YQPZ3U11G3Sq4GHkiAw+1M7E9YUZnB
         T6dYiccDaD2uIVl41I+45EAgIZc367FOgkaQoNkHi4ql6Lz9/Aac/QObMxkmkd0YafIs
         jEEBV3Am5smBrMvIPRjCYKTXJMZ8sJ3WtOnlqB8N6Y4VuIBgUcZsJEOhg0hgEX6cwQyu
         Espw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719393362; x=1719998162;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eto0wDQ+VnHOvIV84i+qZbXGq9+6luYSO1FuNV/i1EM=;
        b=LI9sNUq11zIr+rnkSnKXPbjcSf5jduF1jWOMaIpzkJpEy3xNWChWYPGnlhecDx2NFC
         Wrm6VBgN4Z7FTVBDxaWYWSo/eY+b5yRoAAGvP0t0FvBqiav0W8cJryucuTJnRKgCpuz7
         +a3hQ4FfRIjU9u5cxXZ3TEKEtwPkBX/U8R1IRI36ukLI/mjvNdz034484pq2rsBhGN+/
         L48cTgRAg3RyHREJNuzLfWJFGvRGWIIR/UOgBmnvz0dzcDAblI40ImmbIJhjO+MGXLiw
         W22bh0jb+DckLGNfjdh/Ifr728sz1NDVQtpF25MLW7DCNigfCK6/MvXl2yCM9IAVjNzS
         7Q1g==
X-Forwarded-Encrypted: i=1; AJvYcCXPBswy/V2zsa5ZgBIgsV2kNwbKLiWy/AT1PsUsQHIp09sIGc4GUjTbvPoNYnMET2lf7G0NE+sJUYsVNS+m+zLtL1rWZT4p/Pfq3jUgB1NQAQPcjZ4ECkrQUcUiF7YnUKAm96QMqaUwaQ==
X-Gm-Message-State: AOJu0YzYEdsIjWuNVVlY+9/btOdAycTT4XvxCg4KrtOBrkk12tQC5qcl
	/3VAOfHDABw5uXKlcvZCSSZ2VBNacVeev9TC3APUA8PthomdedNO
X-Google-Smtp-Source: AGHT+IH3CGPS2TZW4EbFb0VD5oUjqGvL3TfaspIt5F5OYeRa/0TR/mOSL97U7IIWNPSpBzA7tuqQqw==
X-Received: by 2002:a2e:3218:0:b0:2ec:55f3:40d with SMTP id 38308e7fff4ca-2ec5b346102mr56875141fa.30.1719393361493;
        Wed, 26 Jun 2024 02:16:01 -0700 (PDT)
Received: from pc636 (host-90-233-219-252.mobileonline.telia.com. [90.233.219.252])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec53b7c876sm11450641fa.62.2024.06.26.02.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 02:16:00 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Wed, 26 Jun 2024 11:15:58 +0200
To: Hailong Liu <hailong.liu@oppo.com>
Cc: Uladzislau Rezki <urezki@gmail.com>, Baoquan He <bhe@redhat.com>,
	Nick Bowler <nbowler@draconx.ca>, linux-kernel@vger.kernel.org,
	Linux regressions mailing list <regressions@lists.linux.dev>,
	linux-mm@kvack.org, sparclinux@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: PROBLEM: kernel crashes when running xfsdump since ~6.4
Message-ID: <ZnvcToH1h-sVtikh@pc636>
References: <Zno52QBG0g5Z+otD@MiWiFi-R3L-srv>
 <ZnqcuKt2qrR-wmH3@pc636>
 <ZnqspTVl/76jM9WD@MiWiFi-R3L-srv>
 <Znq6tEtCgB6QnnJH@pc638.lan>
 <Znq/8/HAc/0p6Ja0@MiWiFi-R3L-srv>
 <ZnrjZRq5-_hemrbD@pc636>
 <ZnrnADHvOiNcZv9t@MiWiFi-R3L-srv>
 <Znr1IQ1mssdNNXbv@pc638.lan>
 <ZnsjIB2byIxSgbjc@pc636>
 <20240626051206.mx2r4iy3wpexykay@oppo.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626051206.mx2r4iy3wpexykay@oppo.com>

On Wed, Jun 26, 2024 at 01:12:06PM +0800, Hailong Liu wrote:
> On Tue, 25. Jun 22:05, Uladzislau Rezki wrote:
> > > > > > > /**
> > > > > > >  * cpumask_next - get the next cpu in a cpumask
> > > > > > >  * @n: the cpu prior to the place to search (i.e. return will be > @n)
> > > > > > >  * @srcp: the cpumask pointer
> > > > > > >  *
> > > > > > >  * Return: >= nr_cpu_ids if no further cpus set.
> > > > > >
> > > > > > Ah, I got what you mean. In the vbq case, it may not have chance to get
> > > > > > a return number as nr_cpu_ids. Becuase the hashed index limits the
> > > > > > range to [0, nr_cpu_ids-1], and cpu_possible(index) will guarantee it
> > > > > > won't be the highest cpu number [nr_cpu_ids-1] since CPU[nr_cpu_ids-1] must
> > > > > > be possible CPU.
> > > > > >
> > > > > > Do I miss some corner cases?
> > > > > >
> > > > > Right. We guarantee that a highest CPU is available by doing: % nr_cpu_ids.
> > > > > So we do not need to use *next_wrap() variant. You do not miss anything :)
> > > > >
> > > > > Hailong Liu has proposed more simpler version:
> > > > >
> > > > > <snip>
> > > > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > > > index 11fe5ea208aa..e1e63ffb9c57 100644
> > > > > --- a/mm/vmalloc.c
> > > > > +++ b/mm/vmalloc.c
> > > > > @@ -1994,8 +1994,9 @@ static struct xarray *
> > > > >  addr_to_vb_xa(unsigned long addr)
> > > > >  {
> > > > >         int index = (addr / VMAP_BLOCK_SIZE) % num_possible_cpus();
> > > > > +       int cpu = cpumask_nth(index, cpu_possible_mask);
> > > > >
> > > > > -       return &per_cpu(vmap_block_queue, index).vmap_blocks;
> > > > > +       return &per_cpu(vmap_block_queue, cpu).vmap_blocks;
> > > > > <snip>
> > > > >
> > > > > which just takes a next CPU if an index is not set in the cpu_possible_mask.
> > > > >
> > > > > The only thing that can be updated in the patch is to replace num_possible_cpu()
> > > > > by the nr_cpu_ids.
> > > > >
> > > > > Any thoughts? I think we need to fix it by a minor change so it is
> > > > > easier to back-port on stable kernels.
> > > >
> > > > Yeah, sounds good since the regresson commit is merged in v6.3.
> > > > Please feel free to post this and the hash array patch separately for
> > > > formal reviewing.
> > > >
> > > Agreed! The patch about hash array i will post later.
> > >
> > > > By the way, when I am replying this mail, I check the cpumask_nth()
> > > > again. I doubt it may take more checking then cpu_possible(), given most
> > > > of systems don't have gaps in cpu_possible_mask. I could be dizzy at
> > > > this moment.
> > > >
> > > > static inline unsigned int cpumask_nth(unsigned int cpu, const struct cpumask *srcp)
> > > > {
> > > >         return find_nth_bit(cpumask_bits(srcp), small_cpumask_bits, cpumask_check(cpu));
> > > > }
> > > >
> > > Yep, i do not think it is a big problem based on your noted fact.
> > >
> > Checked. There is a difference:
> >
> > 1. Default
> >
> > <snip>
> > ...
> > +   15.95%     6.05%  [kernel]        [k] __vmap_pages_range_noflush
> > +   15.91%     1.74%  [kernel]        [k] addr_to_vb_xa <---------------
> > +   15.13%    12.05%  [kernel]        [k] vunmap_p4d_range
> > +   14.17%    13.38%  [kernel]        [k] __find_nth_bit <--------------
> > +   10.62%     0.00%  [kernel]        [k] ret_from_fork_asm
> > +   10.62%     0.00%  [kernel]        [k] ret_from_fork
> > +   10.62%     0.00%  [kernel]        [k] kthread
> > ...
> > <snip>
> >
> > 2. Check if cpu_possible() and then fallback to cpumask_nth() if not
> >
> > <snip>
> > ...
> > +    6.84%     0.29%  [kernel]          [k] alloc_vmap_area
> > +    6.80%     6.70%  [kernel]          [k] native_queued_spin_lock_slowpath
> > +    4.24%     0.09%  [kernel]          [k] free_vmap_block
> > +    2.41%     2.38%  [kernel]          [k] addr_to_vb_xa <-----------
> > +    1.94%     1.91%  [kernel]          [k] xas_start
> > ...
> > <snip>
> >
> > It is _worth_ to check if an index is in possible mask:
> >
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index 45e1506d58c3..af20f78c2cbf 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -2542,7 +2542,10 @@ static DEFINE_PER_CPU(struct vmap_block_queue, vmap_block_queue);
> >  static struct xarray *
> >  addr_to_vb_xa(unsigned long addr)
> >  {
> > -       int index = (addr / VMAP_BLOCK_SIZE) % num_possible_cpus();
> > +       int index = (addr / VMAP_BLOCK_SIZE) % nr_cpu_ids;
> IIUC, use nr_cpu_ids here maybe incorrect.
> 
> take b101 as example, nr_cpu_ids is 3. if index is 2 cpumask_nth(2, cpu_possible_mask);
> might return 64.
>
But then a CPU2 becomes possible? Cutting by % nr_cpu_ids generates values < nr_cpu_ids.
So, last CPU is always possible and we never do cpumask_nth() on a last possible CPU.

What i miss here?

--
Uladzislau Rezki
