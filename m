Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7F92572;
	Tue, 25 Jun 2024 10:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719311551; cv=none; b=rEdeSLRRU7kW/O2D3MMcbkDhlt3Kc7cliwtCZpRIifrhTc44lNO6bJVYuLStTrPj8d9giCken4Oc1beuU2TMBEyjg1YLK5dnKfeemtxuOkxbQbIJhcq6tdfEgHZmKDufrTU+tmBnSzPAr95EHRmyY8faDppGjHSZtoLUM/ZlMXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719311551; c=relaxed/simple;
	bh=eEMtiTydBzBXKAnhVEriEUdUqMmeKAHaJAPKsDPTb8c=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y6ruwYvE9Gr95LxgI1RJMweYzOTCP5SrConOYyjLIVrDv59OwSs7sBnZF/PAc8CpmGEWraJCg/MWefHTd8sffhHVYMTA4Oe27AUkpcDKmcUBjBKBrbOYSPXMJklFDPmx8YXMqGCz4V205SPFzPoaD26wZ6KuV6mFqaET6g+cKzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=grFgfqth; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="grFgfqth"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52cdebf9f53so2713006e87.2;
        Tue, 25 Jun 2024 03:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719311547; x=1719916347; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hwlILf/vswvcQXQNiD+f6wBVsZ6SMfSlkE3EALaPOOg=;
        b=grFgfqth4Vy8zkFHNxwsDas/bJAdMQtZmHyQftO58gcU4PTDIvB0Rxb8LnZtYniJID
         eBppj1OswlJ0B5zUZHA7nYUtk9JAuXcme6i/MIt6/59iWDa7eg1KVhqnsmFt+5NvSKn8
         FuaiwLRPKQeeja7yMlg73hBPZz0fYrTMcP/IXpuPufiAplqXyAnlZvfkUmXQn73cLCd1
         8wzwn2T3/ptsRiSHMmGuXeCezGbEDseieShNft2U9E4ECEKWq09m/+wH/jjTcLRul7Cj
         fxVALUf8jQ1eMnsH+H+882coMpyGxAUhXs6hx7p8WV0H6EigjnwSpbKZAoZraYq68j4n
         RITw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719311547; x=1719916347;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hwlILf/vswvcQXQNiD+f6wBVsZ6SMfSlkE3EALaPOOg=;
        b=AdtqsLPSSBQyOalcBm5TfW/pc6Tq0lrPATGCUrRiGKmnghkkXRuEhz0/KfVVvDS1fD
         q0a6yQ72bptQBz2bnrwxF+DZQOsAeOY6gvz275IZs3aKp67l+r8rmm5SKPRmsyUtiOhf
         M827Gnh932QWRjd+lJEL5CklLKJPK/kU/5jSB7TEpQ+JBansx4PEjs0AsI8rY58GuVYJ
         CSdEuY0h11XfS0zxS1YFq4EjU41xvbUKjHqK3ygzDsEInjNJ9JsejXUrvcxtVFUmXAgs
         ZTXGPBDzh3JYaYmAycq01nw/qbVZlpA8xDwwEE88GM/+nrQFYfwdrimqIcbdWEsEPTRR
         ON7w==
X-Forwarded-Encrypted: i=1; AJvYcCVB4QvntENiTLrU0XllXJk8/bVJGDBDZTtKHvg9049jJX45gV1jb4iUFawL8QJQGjBccdcUEVHr3bdSLJEExt4auFnyPY4k5I92bteUzvxgYVrkDE577z3RnA1OQzY5eC66bJ9iWT4HpQ==
X-Gm-Message-State: AOJu0YyNpt1RdwzUWkY/TDll2FrTCixxS2ZYMMGA8olW8mQ4KkeERcvt
	/1AqGN1+2KK8GqCfOrqDFnwI/jJitgxy0iCobRfxfrpf2jI8JIxp
X-Google-Smtp-Source: AGHT+IHDpYG+hLWunvJBAtgghz7RU1rOfdf/y+G3mJ4Hofm9Q9LEuktQaJ5yAE3vHGX7WYR/sLdxZA==
X-Received: by 2002:a05:6512:2083:b0:52c:e040:7d9 with SMTP id 2adb3069b0e04-52ce0680398mr4513835e87.59.1719311546840;
        Tue, 25 Jun 2024 03:32:26 -0700 (PDT)
Received: from pc636 (host-90-233-219-252.mobileonline.telia.com. [90.233.219.252])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52cdce71c86sm977460e87.142.2024.06.25.03.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 03:32:26 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Tue, 25 Jun 2024 12:32:24 +0200
To: Baoquan He <bhe@redhat.com>
Cc: Uladzislau Rezki <urezki@gmail.com>, Nick Bowler <nbowler@draconx.ca>,
	Hailong Liu <hailong.liu@oppo.com>, linux-kernel@vger.kernel.org,
	Linux regressions mailing list <regressions@lists.linux.dev>,
	linux-mm@kvack.org, sparclinux@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: PROBLEM: kernel crashes when running xfsdump since ~6.4
Message-ID: <ZnqcuKt2qrR-wmH3@pc636>
References: <75e17b57-1178-4288-b792-4ae68b19915e@draconx.ca>
 <00d74f24-c49c-460e-871c-d5af64701306@draconx.ca>
 <20240621033005.6mccm7waduelb4m5@oppo.com>
 <ZnUmpMbCBFWnvaEz@MiWiFi-R3L-srv>
 <ZnVLbCCkvhf5GaTf@pc636>
 <ZnWICsPgYuBlrWlt@MiWiFi-R3L-srv>
 <Znljtv5n-6EBgpsF@pc636>
 <Zno52QBG0g5Z+otD@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zno52QBG0g5Z+otD@MiWiFi-R3L-srv>

On Tue, Jun 25, 2024 at 11:30:33AM +0800, Baoquan He wrote:
> On 06/24/24 at 02:16pm, Uladzislau Rezki wrote:
> > On Fri, Jun 21, 2024 at 10:02:50PM +0800, Baoquan He wrote:
> > > On 06/21/24 at 11:44am, Uladzislau Rezki wrote:
> > > > On Fri, Jun 21, 2024 at 03:07:16PM +0800, Baoquan He wrote:
> > > > > On 06/21/24 at 11:30am, Hailong Liu wrote:
> > > > > > On Thu, 20. Jun 14:02, Nick Bowler wrote:
> > > > > > > On 2024-06-20 02:19, Nick Bowler wrote:
> > > ......
> > > > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > > > index be2dd281ea76..18e87cafbaf2 100644
> > > > > --- a/mm/vmalloc.c
> > > > > +++ b/mm/vmalloc.c
> > > > > @@ -2542,7 +2542,7 @@ static DEFINE_PER_CPU(struct vmap_block_queue, vmap_block_queue);
> > > > >  static struct xarray *
> > > > >  addr_to_vb_xa(unsigned long addr)
> > > > >  {
> > > > > -	int index = (addr / VMAP_BLOCK_SIZE) % num_possible_cpus();
> > > > > +	int index = (addr / VMAP_BLOCK_SIZE) % nr_cpu_ids;
> > > > >  
> > > > >  	return &per_cpu(vmap_block_queue, index).vmap_blocks;
> > > > >  }
> > > > > 
> > > > The problem i see is about not-initializing of the:
> > > > <snip>
> > > > 	for_each_possible_cpu(i) {
> > > > 		struct vmap_block_queue *vbq;
> > > > 		struct vfree_deferred *p;
> > > > 
> > > > 		vbq = &per_cpu(vmap_block_queue, i);
> > > > 		spin_lock_init(&vbq->lock);
> > > > 		INIT_LIST_HEAD(&vbq->free);
> > > > 		p = &per_cpu(vfree_deferred, i);
> > > > 		init_llist_head(&p->list);
> > > > 		INIT_WORK(&p->wq, delayed_vfree_work);
> > > > 		xa_init(&vbq->vmap_blocks);
> > > > 	}
> > > > <snip>
> > > > 
> > > > correctly or fully. It is my bad i did not think that CPUs in a possible mask
> > > > can be non sequential :-/
> > > > 
> > > > nr_cpu_ids - is not the max possible CPU. For example, in Nick case,
> > > > when he has two CPUs, num_possible_cpus() and nr_cpu_ids are the same.
> > > 
> > > I checked the generic version of setup_nr_cpu_ids(), from codes, they
> > > are different with my understanding.
> > > 
> > > kernel/smp.c
> > > void __init setup_nr_cpu_ids(void)
> > > {
> > >         set_nr_cpu_ids(find_last_bit(cpumask_bits(cpu_possible_mask), NR_CPUS) + 1);
> > > }
> > > 
> > I see that it is not a weak function, so it is generic, thus the
> > behavior can not be overwritten, which is great. This does what we
> > need.
> > 
> > Thank you for checking this you are right!
> 
> Thanks for confirming this.
> 
> > 
> > Then it is just a matter of proper initialization of the hash:
> > 
> > <snip>
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index 5d3aa2dc88a8..1733946f7a12 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -5087,7 +5087,13 @@ void __init vmalloc_init(void)
> >          */
> >         vmap_area_cachep = KMEM_CACHE(vmap_area, SLAB_PANIC);
> >  
> > -       for_each_possible_cpu(i) {
> > +       /*
> > +        * We use "nr_cpu_ids" here because some architectures
> > +        * may have "gaps" in cpu-possible-mask. It is OK for
> > +        * per-cpu approaches but is not OK for cases where it
> > +        * can be used as hashes also.
> > +        */
> > +       for (i = 0; i < nr_cpu_ids; i++) {
> 
> I was wrong about earlier comments. Percpu variables are only available
> on possible CPUs. For those nonexistent possible CPUs of static percpu
> variable vmap_block_queue, there isn't memory allocated and mapped for
> them. So accessing into them will cause problem.
> 
> In Nick's case, there are only CPU0, CPU2. If you access
> &per_cpu(vmap_block_queue, 1), problem occurs. So I think we may need to
> change to take other way for vbq. E.g:
> 1) Storing the vb in the nearest neighbouring vbq on possible CPU as
>    below draft patch;
> 2) create an normal array to store vbq of size nr_cpu_ids, then we can
>    store/fetch each vbq on non-possible CPU?
> 
A correct way, i think, is to create a normal array. A quick fix can be
to stick to a next possible CPU.

> The way 1) is simpler, the existing code can be adapted a little just as
> below.
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
cpumask_next() can return nr_cpu_ids if no next bits set.

Thanks!

--
Uladzislau Rezki
