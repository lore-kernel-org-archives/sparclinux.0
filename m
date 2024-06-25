Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C969514B965;
	Tue, 25 Jun 2024 12:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719319226; cv=none; b=YMAZ/LXv8jjHGu/PUZv3z30/nB3kCCDKMA/xFZhtYas4lbG7zEcORI6vKX14H6LVtELVd+RSdQS0X9xl21F/cpy0QKlOgtetON+EEnE+0RnOkQoecsCXxTApQpF2Fqm56KzirUoWLWePneIoIStQhNq739JFfhYl2qDek1sfC8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719319226; c=relaxed/simple;
	bh=xJZC0ZWdKW7k5RvmuvvgEZNEvkDgI1taC7UFj87I6eg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PpMwWaH/9+85UWO7sKLVnkDoQlIY0ptVVXdIKyJsxpWXlH4OBjmR7HPKoutxF1/O4vuteKn24arMcjMMQnLrueCanxTotmAtF0Vj/7rKBr3YksF4N59Gfybb1D1IsfleTTXl0DgvA9DTdtzhccvSSXaypl/4Dg0xnclh9RC0yrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PVplCggM; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PVplCggM"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-57d1d614049so6049441a12.1;
        Tue, 25 Jun 2024 05:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719319223; x=1719924023; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WoVkX+/SqvLNF+tl9I//nQP7hSOM7jd83RwihftTHdk=;
        b=PVplCggMWP11VIUJkj5kBHIRJ0XYO3nKTzC5kdDsHuF/wzf0RgpOgTJ7v5FcGT7ZF6
         F4NK7bBQ9/0Jc4bPu2SSSwgp16Wys4Hhnkb9WiOa+pAmTwEy0QC/S7DMon+zYx+Arx2l
         HtBBO0RCFe6aViX5duv813o72G6CyAngr28YSrVx5b+u1qVkkALswuCKF4UynLovyHZ7
         eMkOS72aCVuiDN4WH73OcNj+1eyZRtkQ3G/y+umBF+eddyzU5laEwwuCLXup0CI227xv
         npcxTUBUv/HVrbCPV6N0t9nq2UeeYZWPAnCBMfiwFRiUiOwfau/sFYgvsa4opk3qk18U
         8+NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719319223; x=1719924023;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WoVkX+/SqvLNF+tl9I//nQP7hSOM7jd83RwihftTHdk=;
        b=Naj7eNWVTla435jnNuXg48EaJuxnNg5oGH/jB8b6ivcTpzHcM0PO1cWMtg4agvtOnJ
         1RHhBXr/xUXIP+qLU36ap6VJKKuVIhcdQpLSSGAJ/r9zB6/sdO0Hy0nF9VglAEc8o+PV
         IJTGGyrmjZtQNxFM1ocdDxe86O4aVe13EU6fiRC6lkSDzX8q7UKDNqcZE9eZnXDS2U5m
         ERTYQidqkAyPFJRZJrUizNUoecwCZiHexfRjURqlqsOKnsaGcIFnBhpTeXdVGDWIFO2k
         zcX1fD/scDxCtM+ub0Kd1cJ/ZXKKZ5Yict62FB7PvrhPqs4UM1d89GoP1NZ4GeR+hzkH
         JNKg==
X-Forwarded-Encrypted: i=1; AJvYcCWyB4QpwwOWOYH/NQtP+8TWvfGDN0dlb0fluNoHK6MeKHkiHyGu+4tnljVTmqTRmMkoKlJQav0Hxlw+fiT+sf0RYPKAwEkmUqjb56Z1bJs19TkhAOgpqfGFFz9lf53eIXN+tEhA3gubmw==
X-Gm-Message-State: AOJu0Yx0mgDtpvKLWcvyrtgL8ss2HaGvqZxq1cE/f5q8O69TTmom3pBl
	+c6aN0gw+yyG5QMWep1Mnkmz1siz6ZRkKAh61z8g59AcXtFulNmlFXkG2w==
X-Google-Smtp-Source: AGHT+IFxTLa8c3S5ivxUnXxBLRu48xXYi/65NyP5o9yS4QN739SX8vgF3IZu8OCLLzy1iVUqusy0fA==
X-Received: by 2002:aa7:cb59:0:b0:57d:4fd8:db59 with SMTP id 4fb4d7f45d1cf-57d4fd8dc94mr6295848a12.0.1719319222848;
        Tue, 25 Jun 2024 05:40:22 -0700 (PDT)
Received: from pc638.lan (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d30563440sm5853522a12.84.2024.06.25.05.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 05:40:22 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date: Tue, 25 Jun 2024 14:40:20 +0200
To: Baoquan He <bhe@redhat.com>
Cc: Uladzislau Rezki <urezki@gmail.com>, Nick Bowler <nbowler@draconx.ca>,
	Hailong Liu <hailong.liu@oppo.com>, linux-kernel@vger.kernel.org,
	Linux regressions mailing list <regressions@lists.linux.dev>,
	linux-mm@kvack.org, sparclinux@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: PROBLEM: kernel crashes when running xfsdump since ~6.4
Message-ID: <Znq6tEtCgB6QnnJH@pc638.lan>
References: <75e17b57-1178-4288-b792-4ae68b19915e@draconx.ca>
 <00d74f24-c49c-460e-871c-d5af64701306@draconx.ca>
 <20240621033005.6mccm7waduelb4m5@oppo.com>
 <ZnUmpMbCBFWnvaEz@MiWiFi-R3L-srv>
 <ZnVLbCCkvhf5GaTf@pc636>
 <ZnWICsPgYuBlrWlt@MiWiFi-R3L-srv>
 <Znljtv5n-6EBgpsF@pc636>
 <Zno52QBG0g5Z+otD@MiWiFi-R3L-srv>
 <ZnqcuKt2qrR-wmH3@pc636>
 <ZnqspTVl/76jM9WD@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnqspTVl/76jM9WD@MiWiFi-R3L-srv>

On Tue, Jun 25, 2024 at 07:40:21PM +0800, Baoquan He wrote:
> On 06/25/24 at 12:32pm, Uladzislau Rezki wrote:
> > On Tue, Jun 25, 2024 at 11:30:33AM +0800, Baoquan He wrote:
> > > On 06/24/24 at 02:16pm, Uladzislau Rezki wrote:
> > > > On Fri, Jun 21, 2024 at 10:02:50PM +0800, Baoquan He wrote:
> > > > > On 06/21/24 at 11:44am, Uladzislau Rezki wrote:
> > > > > > On Fri, Jun 21, 2024 at 03:07:16PM +0800, Baoquan He wrote:
> > > > > > > On 06/21/24 at 11:30am, Hailong Liu wrote:
> > > > > > > > On Thu, 20. Jun 14:02, Nick Bowler wrote:
> > > > > > > > > On 2024-06-20 02:19, Nick Bowler wrote:
> > > > > ......
> > > > > > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > > > > > index be2dd281ea76..18e87cafbaf2 100644
> > > > > > > --- a/mm/vmalloc.c
> > > > > > > +++ b/mm/vmalloc.c
> > > > > > > @@ -2542,7 +2542,7 @@ static DEFINE_PER_CPU(struct vmap_block_queue, vmap_block_queue);
> > > > > > >  static struct xarray *
> > > > > > >  addr_to_vb_xa(unsigned long addr)
> > > > > > >  {
> > > > > > > -	int index = (addr / VMAP_BLOCK_SIZE) % num_possible_cpus();
> > > > > > > +	int index = (addr / VMAP_BLOCK_SIZE) % nr_cpu_ids;
> > > > > > >  
> > > > > > >  	return &per_cpu(vmap_block_queue, index).vmap_blocks;
> > > > > > >  }
> > > > > > > 
> > > > > > The problem i see is about not-initializing of the:
> > > > > > <snip>
> > > > > > 	for_each_possible_cpu(i) {
> > > > > > 		struct vmap_block_queue *vbq;
> > > > > > 		struct vfree_deferred *p;
> > > > > > 
> > > > > > 		vbq = &per_cpu(vmap_block_queue, i);
> > > > > > 		spin_lock_init(&vbq->lock);
> > > > > > 		INIT_LIST_HEAD(&vbq->free);
> > > > > > 		p = &per_cpu(vfree_deferred, i);
> > > > > > 		init_llist_head(&p->list);
> > > > > > 		INIT_WORK(&p->wq, delayed_vfree_work);
> > > > > > 		xa_init(&vbq->vmap_blocks);
> > > > > > 	}
> > > > > > <snip>
> > > > > > 
> > > > > > correctly or fully. It is my bad i did not think that CPUs in a possible mask
> > > > > > can be non sequential :-/
> > > > > > 
> > > > > > nr_cpu_ids - is not the max possible CPU. For example, in Nick case,
> > > > > > when he has two CPUs, num_possible_cpus() and nr_cpu_ids are the same.
> > > > > 
> > > > > I checked the generic version of setup_nr_cpu_ids(), from codes, they
> > > > > are different with my understanding.
> > > > > 
> > > > > kernel/smp.c
> > > > > void __init setup_nr_cpu_ids(void)
> > > > > {
> > > > >         set_nr_cpu_ids(find_last_bit(cpumask_bits(cpu_possible_mask), NR_CPUS) + 1);
> > > > > }
> > > > > 
> > > > I see that it is not a weak function, so it is generic, thus the
> > > > behavior can not be overwritten, which is great. This does what we
> > > > need.
> > > > 
> > > > Thank you for checking this you are right!
> > > 
> > > Thanks for confirming this.
> > > 
> > > > 
> > > > Then it is just a matter of proper initialization of the hash:
> > > > 
> > > > <snip>
> > > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > > index 5d3aa2dc88a8..1733946f7a12 100644
> > > > --- a/mm/vmalloc.c
> > > > +++ b/mm/vmalloc.c
> > > > @@ -5087,7 +5087,13 @@ void __init vmalloc_init(void)
> > > >          */
> > > >         vmap_area_cachep = KMEM_CACHE(vmap_area, SLAB_PANIC);
> > > >  
> > > > -       for_each_possible_cpu(i) {
> > > > +       /*
> > > > +        * We use "nr_cpu_ids" here because some architectures
> > > > +        * may have "gaps" in cpu-possible-mask. It is OK for
> > > > +        * per-cpu approaches but is not OK for cases where it
> > > > +        * can be used as hashes also.
> > > > +        */
> > > > +       for (i = 0; i < nr_cpu_ids; i++) {
> > > 
> > > I was wrong about earlier comments. Percpu variables are only available
> > > on possible CPUs. For those nonexistent possible CPUs of static percpu
> > > variable vmap_block_queue, there isn't memory allocated and mapped for
> > > them. So accessing into them will cause problem.
> > > 
> > > In Nick's case, there are only CPU0, CPU2. If you access
> > > &per_cpu(vmap_block_queue, 1), problem occurs. So I think we may need to
> > > change to take other way for vbq. E.g:
> > > 1) Storing the vb in the nearest neighbouring vbq on possible CPU as
> > >    below draft patch;
> > > 2) create an normal array to store vbq of size nr_cpu_ids, then we can
> > >    store/fetch each vbq on non-possible CPU?
> > > 
> > A correct way, i think, is to create a normal array. A quick fix can be
> > to stick to a next possible CPU.
> > 
> > > The way 1) is simpler, the existing code can be adapted a little just as
> > > below.
> > > 
> > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > index 633363997dec..59a8951cc6c0 100644
> > > --- a/mm/vmalloc.c
> > > +++ b/mm/vmalloc.c
> > > @@ -2542,7 +2542,10 @@ static DEFINE_PER_CPU(struct vmap_block_queue, vmap_block_queue);
> > >  static struct xarray *
> > >  addr_to_vb_xa(unsigned long addr)
> > >  {
> > > -	int index = (addr / VMAP_BLOCK_SIZE) % num_possible_cpus();
> > > +	int index = (addr / VMAP_BLOCK_SIZE) % nr_cpu_ids;
> > > +
> > > +	if (!cpu_possible(idex))
> > > +		index = cpumask_next(index, cpu_possible_mask);
> > >
> > cpumask_next() can return nr_cpu_ids if no next bits set.
> 
> It won't. nr_cpu_ids is the largest index + 1, the hashed index will
> be:  0 =<  index  <= (nr_cpu_ids - 1) e.g cpu_possible_mask is
> b10001111, the nr_cpu_ids is 8, the largest bit is cpu7.
> cpu_possible(index) will check that. So the largest bit of cpumask_next()
> returns is (nr_cpu_ids - 1).
> 
/**
 * cpumask_next - get the next cpu in a cpumask
 * @n: the cpu prior to the place to search (i.e. return will be > @n)
 * @srcp: the cpumask pointer
 *
 * Return: >= nr_cpu_ids if no further cpus set.
 */
static inline
unsigned int cpumask_next(int n, const struct cpumask *srcp)
{
	/* -1 is a legal arg here. */
	if (n != -1)
		cpumask_check(n);
	return find_next_bit(cpumask_bits(srcp), small_cpumask_bits, n + 1);
}

--
Uladzislau Rezki
