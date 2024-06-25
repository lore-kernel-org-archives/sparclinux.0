Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9524D1E86E
	for <sparclinux@vger.kernel.org>; Tue, 25 Jun 2024 13:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719320581; cv=none; b=HBEI5Fzyh4UhKwJvRG5s9QqLCaLmHoIz+72CwDh4jRfB7COjTugJq8A7nSAQ1Vtik+JiEapd4DudFCmeRT6u+lNHIrM1gV9hW9l3nr6fVVGjSxuq9Ii4Rwas61mAnUjKeZ2qQP7ZUiq5roq4JFdwUNHpPcHokKUqXdxDwcgEi0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719320581; c=relaxed/simple;
	bh=YdJV4Kq2dR7O5yLWPIpEwajdv82ucKxlCmFy4qMcylU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EJd01MbvvTZnkp2XEsxCGHzn3rivMUjQoQG1NuJkSXlxCsRay7yOmhDHi7AiXTK4sbxF9nY/fAW2kSqz2gjtUT6aUv6durDtJ9cdSUnd14p1K5/sJbt5EGioEJpcDq5VXEQg/Ccz0ywRVw82cHl8qjyYxImWeILl+AB8lQR+uh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ls6BP9MR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ls6BP9MR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719320578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YAo+mAvMNMTh6JHaMr+JDHScaRPfFWHr7epkP1cGn8A=;
	b=Ls6BP9MRC0qun2S2OvwzJb6x8N2CeZrPZlitLlXgB9dR/fLf86Gk5rQWq8au4vCA1v3pww
	8uslrwj2Bjcq9NfQaafiEGH0tvgWE3uDa9sCx8DzIXaXmxEp+8NTRbGneofdhnxGS8oW83
	XL5tcUcelU1FdfoiiNB0ySsKl9ofIqA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-42-TdHssLFeNoemz-W2EyYJVQ-1; Tue,
 25 Jun 2024 09:02:53 -0400
X-MC-Unique: TdHssLFeNoemz-W2EyYJVQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6A60F1956094;
	Tue, 25 Jun 2024 13:02:51 +0000 (UTC)
Received: from localhost (unknown [10.72.116.8])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 095CF1956087;
	Tue, 25 Jun 2024 13:02:49 +0000 (UTC)
Date: Tue, 25 Jun 2024 21:02:43 +0800
From: Baoquan He <bhe@redhat.com>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Nick Bowler <nbowler@draconx.ca>, Hailong Liu <hailong.liu@oppo.com>,
	linux-kernel@vger.kernel.org,
	Linux regressions mailing list <regressions@lists.linux.dev>,
	linux-mm@kvack.org, sparclinux@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: PROBLEM: kernel crashes when running xfsdump since ~6.4
Message-ID: <Znq/8/HAc/0p6Ja0@MiWiFi-R3L-srv>
References: <00d74f24-c49c-460e-871c-d5af64701306@draconx.ca>
 <20240621033005.6mccm7waduelb4m5@oppo.com>
 <ZnUmpMbCBFWnvaEz@MiWiFi-R3L-srv>
 <ZnVLbCCkvhf5GaTf@pc636>
 <ZnWICsPgYuBlrWlt@MiWiFi-R3L-srv>
 <Znljtv5n-6EBgpsF@pc636>
 <Zno52QBG0g5Z+otD@MiWiFi-R3L-srv>
 <ZnqcuKt2qrR-wmH3@pc636>
 <ZnqspTVl/76jM9WD@MiWiFi-R3L-srv>
 <Znq6tEtCgB6QnnJH@pc638.lan>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Znq6tEtCgB6QnnJH@pc638.lan>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 06/25/24 at 02:40pm, Uladzislau Rezki wrote:
> On Tue, Jun 25, 2024 at 07:40:21PM +0800, Baoquan He wrote:
> > On 06/25/24 at 12:32pm, Uladzislau Rezki wrote:
> > > On Tue, Jun 25, 2024 at 11:30:33AM +0800, Baoquan He wrote:
> > > > On 06/24/24 at 02:16pm, Uladzislau Rezki wrote:
> > > > > On Fri, Jun 21, 2024 at 10:02:50PM +0800, Baoquan He wrote:
> > > > > > On 06/21/24 at 11:44am, Uladzislau Rezki wrote:
> > > > > > > On Fri, Jun 21, 2024 at 03:07:16PM +0800, Baoquan He wrote:
> > > > > > > > On 06/21/24 at 11:30am, Hailong Liu wrote:
> > > > > > > > > On Thu, 20. Jun 14:02, Nick Bowler wrote:
> > > > > > > > > > On 2024-06-20 02:19, Nick Bowler wrote:
> > > > > > ......
> > > > > > > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > > > > > > index be2dd281ea76..18e87cafbaf2 100644
> > > > > > > > --- a/mm/vmalloc.c
> > > > > > > > +++ b/mm/vmalloc.c
> > > > > > > > @@ -2542,7 +2542,7 @@ static DEFINE_PER_CPU(struct vmap_block_queue, vmap_block_queue);
> > > > > > > >  static struct xarray *
> > > > > > > >  addr_to_vb_xa(unsigned long addr)
> > > > > > > >  {
> > > > > > > > -	int index = (addr / VMAP_BLOCK_SIZE) % num_possible_cpus();
> > > > > > > > +	int index = (addr / VMAP_BLOCK_SIZE) % nr_cpu_ids;
> > > > > > > >  
> > > > > > > >  	return &per_cpu(vmap_block_queue, index).vmap_blocks;
> > > > > > > >  }
> > > > > > > > 
> > > > > > > The problem i see is about not-initializing of the:
> > > > > > > <snip>
> > > > > > > 	for_each_possible_cpu(i) {
> > > > > > > 		struct vmap_block_queue *vbq;
> > > > > > > 		struct vfree_deferred *p;
> > > > > > > 
> > > > > > > 		vbq = &per_cpu(vmap_block_queue, i);
> > > > > > > 		spin_lock_init(&vbq->lock);
> > > > > > > 		INIT_LIST_HEAD(&vbq->free);
> > > > > > > 		p = &per_cpu(vfree_deferred, i);
> > > > > > > 		init_llist_head(&p->list);
> > > > > > > 		INIT_WORK(&p->wq, delayed_vfree_work);
> > > > > > > 		xa_init(&vbq->vmap_blocks);
> > > > > > > 	}
> > > > > > > <snip>
> > > > > > > 
> > > > > > > correctly or fully. It is my bad i did not think that CPUs in a possible mask
> > > > > > > can be non sequential :-/
> > > > > > > 
> > > > > > > nr_cpu_ids - is not the max possible CPU. For example, in Nick case,
> > > > > > > when he has two CPUs, num_possible_cpus() and nr_cpu_ids are the same.
> > > > > > 
> > > > > > I checked the generic version of setup_nr_cpu_ids(), from codes, they
> > > > > > are different with my understanding.
> > > > > > 
> > > > > > kernel/smp.c
> > > > > > void __init setup_nr_cpu_ids(void)
> > > > > > {
> > > > > >         set_nr_cpu_ids(find_last_bit(cpumask_bits(cpu_possible_mask), NR_CPUS) + 1);
> > > > > > }
> > > > > > 
> > > > > I see that it is not a weak function, so it is generic, thus the
> > > > > behavior can not be overwritten, which is great. This does what we
> > > > > need.
> > > > > 
> > > > > Thank you for checking this you are right!
> > > > 
> > > > Thanks for confirming this.
> > > > 
> > > > > 
> > > > > Then it is just a matter of proper initialization of the hash:
> > > > > 
> > > > > <snip>
> > > > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > > > index 5d3aa2dc88a8..1733946f7a12 100644
> > > > > --- a/mm/vmalloc.c
> > > > > +++ b/mm/vmalloc.c
> > > > > @@ -5087,7 +5087,13 @@ void __init vmalloc_init(void)
> > > > >          */
> > > > >         vmap_area_cachep = KMEM_CACHE(vmap_area, SLAB_PANIC);
> > > > >  
> > > > > -       for_each_possible_cpu(i) {
> > > > > +       /*
> > > > > +        * We use "nr_cpu_ids" here because some architectures
> > > > > +        * may have "gaps" in cpu-possible-mask. It is OK for
> > > > > +        * per-cpu approaches but is not OK for cases where it
> > > > > +        * can be used as hashes also.
> > > > > +        */
> > > > > +       for (i = 0; i < nr_cpu_ids; i++) {
> > > > 
> > > > I was wrong about earlier comments. Percpu variables are only available
> > > > on possible CPUs. For those nonexistent possible CPUs of static percpu
> > > > variable vmap_block_queue, there isn't memory allocated and mapped for
> > > > them. So accessing into them will cause problem.
> > > > 
> > > > In Nick's case, there are only CPU0, CPU2. If you access
> > > > &per_cpu(vmap_block_queue, 1), problem occurs. So I think we may need to
> > > > change to take other way for vbq. E.g:
> > > > 1) Storing the vb in the nearest neighbouring vbq on possible CPU as
> > > >    below draft patch;
> > > > 2) create an normal array to store vbq of size nr_cpu_ids, then we can
> > > >    store/fetch each vbq on non-possible CPU?
> > > > 
> > > A correct way, i think, is to create a normal array. A quick fix can be
> > > to stick to a next possible CPU.
> > > 
> > > > The way 1) is simpler, the existing code can be adapted a little just as
> > > > below.
> > > > 
> > > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > > index 633363997dec..59a8951cc6c0 100644
> > > > --- a/mm/vmalloc.c
> > > > +++ b/mm/vmalloc.c
> > > > @@ -2542,7 +2542,10 @@ static DEFINE_PER_CPU(struct vmap_block_queue, vmap_block_queue);
> > > >  static struct xarray *
> > > >  addr_to_vb_xa(unsigned long addr)
> > > >  {
> > > > -	int index = (addr / VMAP_BLOCK_SIZE) % num_possible_cpus();
> > > > +	int index = (addr / VMAP_BLOCK_SIZE) % nr_cpu_ids;
> > > > +
> > > > +	if (!cpu_possible(idex))
> > > > +		index = cpumask_next(index, cpu_possible_mask);
> > > >
> > > cpumask_next() can return nr_cpu_ids if no next bits set.
> > 
> > It won't. nr_cpu_ids is the largest index + 1, the hashed index will
> > be:  0 =<  index  <= (nr_cpu_ids - 1) e.g cpu_possible_mask is
> > b10001111, the nr_cpu_ids is 8, the largest bit is cpu7.
> > cpu_possible(index) will check that. So the largest bit of cpumask_next()
> > returns is (nr_cpu_ids - 1).
> > 
> /**
>  * cpumask_next - get the next cpu in a cpumask
>  * @n: the cpu prior to the place to search (i.e. return will be > @n)
>  * @srcp: the cpumask pointer
>  *
>  * Return: >= nr_cpu_ids if no further cpus set.

Ah, I got what you mean. In the vbq case, it may not have chance to get
a return number as nr_cpu_ids. Becuase the hashed index limits the
range to [0, nr_cpu_ids-1], and cpu_possible(index) will guarantee it
won't be the highest cpu number [nr_cpu_ids-1] since CPU[nr_cpu_ids-1] must
be possible CPU.

Do I miss some corner cases?

>  */
> static inline
> unsigned int cpumask_next(int n, const struct cpumask *srcp)
> {
> 	/* -1 is a legal arg here. */
> 	if (n != -1)
> 		cpumask_check(n);
> 	return find_next_bit(cpumask_bits(srcp), small_cpumask_bits, n + 1);
> }
> 
> --
> Uladzislau Rezki
> 

