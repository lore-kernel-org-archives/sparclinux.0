Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6185116F90F;
	Wed, 26 Jun 2024 10:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719399216; cv=none; b=RDp0ibM6qw14QpBBrqBnFM2jXKnpy466uOe8lihkkN+GjJSA6teM22EjCFM8xHJlwd2O1I3L2vWbihOMRis12Q82jIG5VbAjICDGRBCEwB37LDHSYM1a9r1a7daQybej1kFuKgJT6NXbbJcWsupZLVJABmCHq+tzM5guSJLG5L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719399216; c=relaxed/simple;
	bh=Tjd6qxgmuQq6e7Z+qNWuQjTNx/yB7Hfx5SO8mRDyOyY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tZ2BSse444o3geuJ6UxV+rYVf8/JyoyrL6yO0pfTemMoLrKleO1YFxGJwoH1veb9aiQGEGAjbKu7moLW+19YCyodKBtZ1wjQ/lSai79EBwbpPJd5gywKo/wQqFQ3Uq9iWfkkhAdEWlXktckR1Eu8QwiKnjbYshrkpup/2q2q6qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GP0xq66U; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GP0xq66U"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52cecba8d11so2248523e87.1;
        Wed, 26 Jun 2024 03:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719399212; x=1720004012; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ra0kofcvGPl3NCrJaksVA0UhehBYPZa3ZeHJvA50SBc=;
        b=GP0xq66UWLuW61OMEdgYif0+t/cP37wloBkO2wyLOLUiTywlpHoCoY1uC7VOWTryD5
         EQJg/OQtfqdvOM2AttLi77n5uMWK6lqz6O/yfCV9BEAmWVpvtJ3pFncoo23aLaDabJSK
         K8bl91iPcEsZ8ag+5IYzTSBKqYaTsnz051UU259gMdS0Icc0LFWYS4/jdio1Q8xulJZa
         jxqYW2CXKYHyXf++0ioGK0ZkRp1Dl2D4WJEfGnJkQ4tLwfzoz3tp+UNXmDMnkU92ONn+
         ANwBbBlMxbJErfr0EWJ6zWGFxzCy2RVCgX+2KQ2XnI10cyJb9O4+5u6aRuo4e3bwbG+8
         Rkdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719399212; x=1720004012;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ra0kofcvGPl3NCrJaksVA0UhehBYPZa3ZeHJvA50SBc=;
        b=u3oOhjQikxGS87+SnIsKFEcUu9IIZOtSI6ZP+H5fC9/NzCf4d7uPCM7gVShn3zuEJU
         O7j+hkgh6vtstW1AFRWrD38A9oipHOvQjf1dl6z/CvivLFLvb7qhkRaIfppCVC9BWMCU
         RiAuQB7G4OC1920WO3vQmR8aIUKoMkHlSVM42K22GN2800f5hEXrn73bKTLP/iYVhAab
         X+Lo/CtEAeUQEVadnbctAZEqzNehzQYWQip6TXxl4r3FSO26vSxTGg8CxkGSIqklmEEX
         WZE7P6ohELMEGS4ErzDsUAZh4J3pEkGfyy1H5WO6vC9ZzjM09ntKMZqNI/nzdj90XUt1
         tIUg==
X-Forwarded-Encrypted: i=1; AJvYcCXPYhQu+TAE0EtNTrauxoUMU4oSauD+U5XHS26kuPzgD/dRhJ9OtWTqS3bNOe88AIJkaWx5+1HPFctAYyIMQVq3GeLwE3b1ITOrkfBnP8uoCrFB0p5rgOcKXLRxj5eWC9gfbAOELPmD2Q==
X-Gm-Message-State: AOJu0YxSb2DZU/WJ4NJhu/Dmg3cDPeXtItdu+0ykBlgion9UApWNYT0R
	sQruTT5Aldef0JCGnS5Wt3jLRHvQNYoFNJqgLc2y1yPKIX/aG6I3qa7JpQ==
X-Google-Smtp-Source: AGHT+IGeS99bKAOeCgtMTOiV4Uvt8+JDU6Dm/+UbirbkklB98PLofRgNc3HgnO5Why9YA3EeIRlLoQ==
X-Received: by 2002:a05:6512:39cc:b0:52c:fd46:bf07 with SMTP id 2adb3069b0e04-52cfd46c32bmr2734125e87.49.1719399212035;
        Wed, 26 Jun 2024 03:53:32 -0700 (PDT)
Received: from pc636 (host-90-233-219-252.mobileonline.telia.com. [90.233.219.252])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52cdaa5a36asm1427268e87.141.2024.06.26.03.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 03:53:31 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Wed, 26 Jun 2024 12:53:29 +0200
To: Baoquan He <bhe@redhat.com>
Cc: Hailong Liu <hailong.liu@oppo.com>, Uladzislau Rezki <urezki@gmail.com>,
	Nick Bowler <nbowler@draconx.ca>, linux-kernel@vger.kernel.org,
	Linux regressions mailing list <regressions@lists.linux.dev>,
	linux-mm@kvack.org, sparclinux@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: PROBLEM: kernel crashes when running xfsdump since ~6.4
Message-ID: <ZnvzKSHfYn7A-PPp@pc636>
References: <Znq6tEtCgB6QnnJH@pc638.lan>
 <Znq/8/HAc/0p6Ja0@MiWiFi-R3L-srv>
 <ZnrjZRq5-_hemrbD@pc636>
 <ZnrnADHvOiNcZv9t@MiWiFi-R3L-srv>
 <Znr1IQ1mssdNNXbv@pc638.lan>
 <ZnsjIB2byIxSgbjc@pc636>
 <20240626051206.mx2r4iy3wpexykay@oppo.com>
 <ZnvcToH1h-sVtikh@pc636>
 <20240626100342.2dudj6fjjx6srban@oppo.com>
 <ZnvytLzoLrVwymXv@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnvytLzoLrVwymXv@MiWiFi-R3L-srv>

On Wed, Jun 26, 2024 at 06:51:32PM +0800, Baoquan He wrote:
> On 06/26/24 at 06:03pm, Hailong Liu wrote:
> > On Wed, 26. Jun 11:15, Uladzislau Rezki wrote:
> > > On Wed, Jun 26, 2024 at 01:12:06PM +0800, Hailong Liu wrote:
> > > > On Tue, 25. Jun 22:05, Uladzislau Rezki wrote:
> > > > > > > > > > /**
> > > > > > > > > >  * cpumask_next - get the next cpu in a cpumask
> > > > > > > > > >  * @n: the cpu prior to the place to search (i.e. return will be > @n)
> > > > > > > > > >  * @srcp: the cpumask pointer
> > > > > > > > > >  *
> > > > > > > > > >  * Return: >= nr_cpu_ids if no further cpus set.
> > > > > > > > >
> > > > > > > > > Ah, I got what you mean. In the vbq case, it may not have chance to get
> > > > > > > > > a return number as nr_cpu_ids. Becuase the hashed index limits the
> > > > > > > > > range to [0, nr_cpu_ids-1], and cpu_possible(index) will guarantee it
> > > > > > > > > won't be the highest cpu number [nr_cpu_ids-1] since CPU[nr_cpu_ids-1] must
> > > > > > > > > be possible CPU.
> > > > > > > > >
> > > > > > > > > Do I miss some corner cases?
> > > > > > > > >
> > > > > > > > Right. We guarantee that a highest CPU is available by doing: % nr_cpu_ids.
> > > > > > > > So we do not need to use *next_wrap() variant. You do not miss anything :)
> > > > > > > >
> > > > > > > > Hailong Liu has proposed more simpler version:
> > > > > > > >
> > > > > > > > <snip>
> > > > > > > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > > > > > > index 11fe5ea208aa..e1e63ffb9c57 100644
> > > > > > > > --- a/mm/vmalloc.c
> > > > > > > > +++ b/mm/vmalloc.c
> > > > > > > > @@ -1994,8 +1994,9 @@ static struct xarray *
> > > > > > > >  addr_to_vb_xa(unsigned long addr)
> > > > > > > >  {
> > > > > > > >         int index = (addr / VMAP_BLOCK_SIZE) % num_possible_cpus();
> > > > > > > > +       int cpu = cpumask_nth(index, cpu_possible_mask);
> > > > > > > >
> > > > > > > > -       return &per_cpu(vmap_block_queue, index).vmap_blocks;
> > > > > > > > +       return &per_cpu(vmap_block_queue, cpu).vmap_blocks;
> > > > > > > > <snip>
> > > > > > > >
> > > > > > > > which just takes a next CPU if an index is not set in the cpu_possible_mask.
> > > > > > > >
> > > > > > > > The only thing that can be updated in the patch is to replace num_possible_cpu()
> > > > > > > > by the nr_cpu_ids.
> > > > > > > >
> > > > > > > > Any thoughts? I think we need to fix it by a minor change so it is
> > > > > > > > easier to back-port on stable kernels.
> > > > > > >
> > > > > > > Yeah, sounds good since the regresson commit is merged in v6.3.
> > > > > > > Please feel free to post this and the hash array patch separately for
> > > > > > > formal reviewing.
> > > > > > >
> > > > > > Agreed! The patch about hash array i will post later.
> > > > > >
> > > > > > > By the way, when I am replying this mail, I check the cpumask_nth()
> > > > > > > again. I doubt it may take more checking then cpu_possible(), given most
> > > > > > > of systems don't have gaps in cpu_possible_mask. I could be dizzy at
> > > > > > > this moment.
> > > > > > >
> > > > > > > static inline unsigned int cpumask_nth(unsigned int cpu, const struct cpumask *srcp)
> > > > > > > {
> > > > > > >         return find_nth_bit(cpumask_bits(srcp), small_cpumask_bits, cpumask_check(cpu));
> > > > > > > }
> > > > > > >
> > > > > > Yep, i do not think it is a big problem based on your noted fact.
> > > > > >
> > > > > Checked. There is a difference:
> > > > >
> > > > > 1. Default
> > > > >
> > > > > <snip>
> > > > > ...
> > > > > +   15.95%     6.05%  [kernel]        [k] __vmap_pages_range_noflush
> > > > > +   15.91%     1.74%  [kernel]        [k] addr_to_vb_xa <---------------
> > > > > +   15.13%    12.05%  [kernel]        [k] vunmap_p4d_range
> > > > > +   14.17%    13.38%  [kernel]        [k] __find_nth_bit <--------------
> > > > > +   10.62%     0.00%  [kernel]        [k] ret_from_fork_asm
> > > > > +   10.62%     0.00%  [kernel]        [k] ret_from_fork
> > > > > +   10.62%     0.00%  [kernel]        [k] kthread
> > > > > ...
> > > > > <snip>
> > > > >
> > > > > 2. Check if cpu_possible() and then fallback to cpumask_nth() if not
> > > > >
> > > > > <snip>
> > > > > ...
> > > > > +    6.84%     0.29%  [kernel]          [k] alloc_vmap_area
> > > > > +    6.80%     6.70%  [kernel]          [k] native_queued_spin_lock_slowpath
> > > > > +    4.24%     0.09%  [kernel]          [k] free_vmap_block
> > > > > +    2.41%     2.38%  [kernel]          [k] addr_to_vb_xa <-----------
> > > > > +    1.94%     1.91%  [kernel]          [k] xas_start
> > > > > ...
> > > > > <snip>
> > > > >
> > > > > It is _worth_ to check if an index is in possible mask:
> > > > >
> > > > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > > > index 45e1506d58c3..af20f78c2cbf 100644
> > > > > --- a/mm/vmalloc.c
> > > > > +++ b/mm/vmalloc.c
> > > > > @@ -2542,7 +2542,10 @@ static DEFINE_PER_CPU(struct vmap_block_queue, vmap_block_queue);
> > > > >  static struct xarray *
> > > > >  addr_to_vb_xa(unsigned long addr)
> > > > >  {
> > > > > -       int index = (addr / VMAP_BLOCK_SIZE) % num_possible_cpus();
> > > > > +       int index = (addr / VMAP_BLOCK_SIZE) % nr_cpu_ids;
> > > > IIUC, use nr_cpu_ids here maybe incorrect.
> > > >
> > > > take b101 as example, nr_cpu_ids is 3. if index is 2 cpumask_nth(2, cpu_possible_mask);
> > > > might return 64.
> > > >
> > > But then a CPU2 becomes possible? Cutting by % nr_cpu_ids generates values < nr_cpu_ids.
> > > So, last CPU is always possible and we never do cpumask_nth() on a last possible CPU.
> > >
> > > What i miss here?
> > >
> > Sorry, I forget to reply to all :), I write a demo to test as follows:
> > 
> > static int cpumask_init(void)
> > {
> >        struct cpumask mask;
> >        unsigned int cpu_id;
> >        cpumask_clear(&mask);
> > 
> >        cpumask_set_cpu(1, &mask);
> >        cpumask_set_cpu(3, &mask);
> >        cpumask_set_cpu(5, &mask);
> > 
> >        cpu_id = find_last_bit(cpumask_bits(&mask), NR_CPUS) + 1;
> >        pr_info("cpu_id:%d\n", cpu_id);
> > 
> >        for (; i < nr_cpu_ids; i++) {
> >                pr_info("%d: cpu_%d\n", i, cpumask_nth(i, &mask));
> >        }
> > 
> >        return 0;
> > }
> > 
> > [    1.337020][    T1] cpu_id:6
> > [    1.337338][    T1] 0: cpu_1
> > [    1.337558][    T1] 1: cpu_3
> > [    1.337751][    T1] 2: cpu_5
> > [    1.337960][    T1] 3: cpu_64
> > [    1.338183][    T1] 4: cpu_64
> > [    1.338387][    T1] 5: cpu_64
> > [    1.338594][    T1] 6: cpu_64
> > 
> > In summary, the nr_cpu_ids = last_bit + 1, and cpumask_nth() return the nth cpu_id.
> 
> I think just using below change for a quick fix is enough. It doesn't
> have the issue cpumask_nth() has and very simple. For most of systems,
> it only adds an extra cpu_possible(idex) checking.
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 633363997dec..59a8951cc6c0 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2542,7 +2542,10 @@ static DEFINE_PER_CPU(struct vmap_block_queue, vmap_block_queue);
>  static struct xarray *
>  addr_to_vb_xa(unsigned long addr)
>  {
> -	int index = (addr / VMAP_BLOCK_SIZE) % num_possible_cpus();
> +	int index = (addr / VMAP_BLOCK_SIZE) % nr_cpu_ids;
> +
> +	if (!cpu_possible(idex))
> +		index = cpumask_next(index, cpu_possible_mask);
>  
>  	return &per_cpu(vmap_block_queue, index).vmap_blocks;
>  }
> 
Just submitted the same :) I will send out the patch.

--
Uladzislau Rezki
