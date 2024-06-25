Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6566016F29C
	for <sparclinux@vger.kernel.org>; Tue, 25 Jun 2024 15:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719330578; cv=none; b=GDmvUSkykyOh/iWiJUn236lvoQarYNRUjNyZHQ9CT45Oirp0QyNTng8DsmiHqYTnkBfy3dUpV6oUnRaFyrS1ecyFZ2+gm2P/qIXB+j8uZRujb/WN+Dljp/rmW+MRgBgCpqxDYBEmrhTaYIHHvUiARs8gi5HUqDwCIqtA3OSZceY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719330578; c=relaxed/simple;
	bh=d+QWziGpgL0Ca/Wfgs+UUMxW9qcDrjZRRIe7JK15vkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aEdoF26YPyXj+XQcsPb6Yso5Rls/kLZ13PRliQAYpnXL+xd4fAqoOlWPImyL6MGtGrNjw8Uj/d4Xm/u+WuBl8P4H2/oEfuNKLSbScmWD3xD7NCFVEMjXEPlBdlMvmKaI5fogF12bLSJH7h1W4bWRVzkC4rbeCugINADwpakOVhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rt8swqNl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rt8swqNl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719330575;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0wsnVV8wpGfGOkMUutdfBkeh8eoVPXf9ThGK/9X9dRk=;
	b=Rt8swqNlEBQPbMDqdomUWofd17OuFACXBxPmJvZ2I1iPcw3lP80gWnX1hd8kuSmuTVhmJt
	njJdUdQlrR83TqrIiMdvoXhMvdalVvcP3nW7CBFWWh9SOuRb0mez+vCkVdytp4NYaYWpBI
	7nsHC7OjEZxRcuAQrVICIccOBN7BXHg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-648-JgzeuAsjP0qiKJuutWbxvQ-1; Tue,
 25 Jun 2024 11:49:29 -0400
X-MC-Unique: JgzeuAsjP0qiKJuutWbxvQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8163E195608C;
	Tue, 25 Jun 2024 15:49:27 +0000 (UTC)
Received: from localhost (unknown [10.72.116.8])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4F977300021A;
	Tue, 25 Jun 2024 15:49:24 +0000 (UTC)
Date: Tue, 25 Jun 2024 23:49:20 +0800
From: Baoquan He <bhe@redhat.com>
To: Uladzislau Rezki <urezki@gmail.com>, Hailong Liu <hailong.liu@oppo.com>
Cc: Nick Bowler <nbowler@draconx.ca>, linux-kernel@vger.kernel.org,
	Linux regressions mailing list <regressions@lists.linux.dev>,
	linux-mm@kvack.org, sparclinux@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: PROBLEM: kernel crashes when running xfsdump since ~6.4
Message-ID: <ZnrnADHvOiNcZv9t@MiWiFi-R3L-srv>
References: <ZnUmpMbCBFWnvaEz@MiWiFi-R3L-srv>
 <ZnVLbCCkvhf5GaTf@pc636>
 <ZnWICsPgYuBlrWlt@MiWiFi-R3L-srv>
 <Znljtv5n-6EBgpsF@pc636>
 <Zno52QBG0g5Z+otD@MiWiFi-R3L-srv>
 <ZnqcuKt2qrR-wmH3@pc636>
 <ZnqspTVl/76jM9WD@MiWiFi-R3L-srv>
 <Znq6tEtCgB6QnnJH@pc638.lan>
 <Znq/8/HAc/0p6Ja0@MiWiFi-R3L-srv>
 <ZnrjZRq5-_hemrbD@pc636>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnrjZRq5-_hemrbD@pc636>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 06/25/24 at 05:33pm, Uladzislau Rezki wrote:
> On Tue, Jun 25, 2024 at 09:02:43PM +0800, Baoquan He wrote:
> > On 06/25/24 at 02:40pm, Uladzislau Rezki wrote:
> > > On Tue, Jun 25, 2024 at 07:40:21PM +0800, Baoquan He wrote:
> > > > On 06/25/24 at 12:32pm, Uladzislau Rezki wrote:
> > > > > On Tue, Jun 25, 2024 at 11:30:33AM +0800, Baoquan He wrote:
> > > > > > On 06/24/24 at 02:16pm, Uladzislau Rezki wrote:
> > > > > > > On Fri, Jun 21, 2024 at 10:02:50PM +0800, Baoquan He wrote:
> > > > > > > > On 06/21/24 at 11:44am, Uladzislau Rezki wrote:
> > > > > > > > > On Fri, Jun 21, 2024 at 03:07:16PM +0800, Baoquan He wrote:
> > > > > > > > > > On 06/21/24 at 11:30am, Hailong Liu wrote:
> > > > > > > > > > > On Thu, 20. Jun 14:02, Nick Bowler wrote:
> > > > > > > > > > > > On 2024-06-20 02:19, Nick Bowler wrote:
> > > > > > > > ......
> > > > > > > > > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > > > > > > > > index be2dd281ea76..18e87cafbaf2 100644
> > > > > > > > > > --- a/mm/vmalloc.c
> > > > > > > > > > +++ b/mm/vmalloc.c
> > > > > > > > > > @@ -2542,7 +2542,7 @@ static DEFINE_PER_CPU(struct vmap_block_queue, vmap_block_queue);
> > > > > > > > > >  static struct xarray *
> > > > > > > > > >  addr_to_vb_xa(unsigned long addr)
> > > > > > > > > >  {
> > > > > > > > > > -	int index = (addr / VMAP_BLOCK_SIZE) % num_possible_cpus();
> > > > > > > > > > +	int index = (addr / VMAP_BLOCK_SIZE) % nr_cpu_ids;
> > > > > > > > > >  
> > > > > > > > > >  	return &per_cpu(vmap_block_queue, index).vmap_blocks;
> > > > > > > > > >  }
> > > > > > > > > > 
> > > > > > > > > The problem i see is about not-initializing of the:
> > > > > > > > > <snip>
> > > > > > > > > 	for_each_possible_cpu(i) {
> > > > > > > > > 		struct vmap_block_queue *vbq;
> > > > > > > > > 		struct vfree_deferred *p;
> > > > > > > > > 
> > > > > > > > > 		vbq = &per_cpu(vmap_block_queue, i);
> > > > > > > > > 		spin_lock_init(&vbq->lock);
> > > > > > > > > 		INIT_LIST_HEAD(&vbq->free);
> > > > > > > > > 		p = &per_cpu(vfree_deferred, i);
> > > > > > > > > 		init_llist_head(&p->list);
> > > > > > > > > 		INIT_WORK(&p->wq, delayed_vfree_work);
> > > > > > > > > 		xa_init(&vbq->vmap_blocks);
> > > > > > > > > 	}
> > > > > > > > > <snip>
> > > > > > > > > 
> > > > > > > > > correctly or fully. It is my bad i did not think that CPUs in a possible mask
> > > > > > > > > can be non sequential :-/
> > > > > > > > > 
> > > > > > > > > nr_cpu_ids - is not the max possible CPU. For example, in Nick case,
> > > > > > > > > when he has two CPUs, num_possible_cpus() and nr_cpu_ids are the same.
> > > > > > > > 
> > > > > > > > I checked the generic version of setup_nr_cpu_ids(), from codes, they
> > > > > > > > are different with my understanding.
> > > > > > > > 
> > > > > > > > kernel/smp.c
> > > > > > > > void __init setup_nr_cpu_ids(void)
> > > > > > > > {
> > > > > > > >         set_nr_cpu_ids(find_last_bit(cpumask_bits(cpu_possible_mask), NR_CPUS) + 1);
> > > > > > > > }
> > > > > > > > 
> > > > > > > I see that it is not a weak function, so it is generic, thus the
> > > > > > > behavior can not be overwritten, which is great. This does what we
> > > > > > > need.
> > > > > > > 
> > > > > > > Thank you for checking this you are right!
> > > > > > 
> > > > > > Thanks for confirming this.
> > > > > > 
> > > > > > > 
> > > > > > > Then it is just a matter of proper initialization of the hash:
> > > > > > > 
> > > > > > > <snip>
> > > > > > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > > > > > index 5d3aa2dc88a8..1733946f7a12 100644
> > > > > > > --- a/mm/vmalloc.c
> > > > > > > +++ b/mm/vmalloc.c
> > > > > > > @@ -5087,7 +5087,13 @@ void __init vmalloc_init(void)
> > > > > > >          */
> > > > > > >         vmap_area_cachep = KMEM_CACHE(vmap_area, SLAB_PANIC);
> > > > > > >  
> > > > > > > -       for_each_possible_cpu(i) {
> > > > > > > +       /*
> > > > > > > +        * We use "nr_cpu_ids" here because some architectures
> > > > > > > +        * may have "gaps" in cpu-possible-mask. It is OK for
> > > > > > > +        * per-cpu approaches but is not OK for cases where it
> > > > > > > +        * can be used as hashes also.
> > > > > > > +        */
> > > > > > > +       for (i = 0; i < nr_cpu_ids; i++) {
> > > > > > 
> > > > > > I was wrong about earlier comments. Percpu variables are only available
> > > > > > on possible CPUs. For those nonexistent possible CPUs of static percpu
> > > > > > variable vmap_block_queue, there isn't memory allocated and mapped for
> > > > > > them. So accessing into them will cause problem.
> > > > > > 
> > > > > > In Nick's case, there are only CPU0, CPU2. If you access
> > > > > > &per_cpu(vmap_block_queue, 1), problem occurs. So I think we may need to
> > > > > > change to take other way for vbq. E.g:
> > > > > > 1) Storing the vb in the nearest neighbouring vbq on possible CPU as
> > > > > >    below draft patch;
> > > > > > 2) create an normal array to store vbq of size nr_cpu_ids, then we can
> > > > > >    store/fetch each vbq on non-possible CPU?
> > > > > > 
> > > > > A correct way, i think, is to create a normal array. A quick fix can be
> > > > > to stick to a next possible CPU.
> > > > > 
> > > > > > The way 1) is simpler, the existing code can be adapted a little just as
> > > > > > below.
> > > > > > 
> > > > > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > > > > index 633363997dec..59a8951cc6c0 100644
> > > > > > --- a/mm/vmalloc.c
> > > > > > +++ b/mm/vmalloc.c
> > > > > > @@ -2542,7 +2542,10 @@ static DEFINE_PER_CPU(struct vmap_block_queue, vmap_block_queue);
> > > > > >  static struct xarray *
> > > > > >  addr_to_vb_xa(unsigned long addr)
> > > > > >  {
> > > > > > -	int index = (addr / VMAP_BLOCK_SIZE) % num_possible_cpus();
> > > > > > +	int index = (addr / VMAP_BLOCK_SIZE) % nr_cpu_ids;
> > > > > > +
> > > > > > +	if (!cpu_possible(idex))
> > > > > > +		index = cpumask_next(index, cpu_possible_mask);
> > > > > >
> > > > > cpumask_next() can return nr_cpu_ids if no next bits set.
> > > > 
> > > > It won't. nr_cpu_ids is the largest index + 1, the hashed index will
> > > > be:  0 =<  index  <= (nr_cpu_ids - 1) e.g cpu_possible_mask is
> > > > b10001111, the nr_cpu_ids is 8, the largest bit is cpu7.
> > > > cpu_possible(index) will check that. So the largest bit of cpumask_next()
> > > > returns is (nr_cpu_ids - 1).
> > > > 
> > > /**
> > >  * cpumask_next - get the next cpu in a cpumask
> > >  * @n: the cpu prior to the place to search (i.e. return will be > @n)
> > >  * @srcp: the cpumask pointer
> > >  *
> > >  * Return: >= nr_cpu_ids if no further cpus set.
> > 
> > Ah, I got what you mean. In the vbq case, it may not have chance to get
> > a return number as nr_cpu_ids. Becuase the hashed index limits the
> > range to [0, nr_cpu_ids-1], and cpu_possible(index) will guarantee it
> > won't be the highest cpu number [nr_cpu_ids-1] since CPU[nr_cpu_ids-1] must
> > be possible CPU.
> > 
> > Do I miss some corner cases?
> > 
> Right. We guarantee that a highest CPU is available by doing: % nr_cpu_ids.
> So we do not need to use *next_wrap() variant. You do not miss anything :)
> 
> Hailong Liu has proposed more simpler version:
> 
> <snip>
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 11fe5ea208aa..e1e63ffb9c57 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -1994,8 +1994,9 @@ static struct xarray *
>  addr_to_vb_xa(unsigned long addr)
>  {
>         int index = (addr / VMAP_BLOCK_SIZE) % num_possible_cpus();
> +       int cpu = cpumask_nth(index, cpu_possible_mask);
> 
> -       return &per_cpu(vmap_block_queue, index).vmap_blocks;
> +       return &per_cpu(vmap_block_queue, cpu).vmap_blocks;
> <snip>
> 
> which just takes a next CPU if an index is not set in the cpu_possible_mask.
> 
> The only thing that can be updated in the patch is to replace num_possible_cpu()
> by the nr_cpu_ids.
> 
> Any thoughts? I think we need to fix it by a minor change so it is
> easier to back-port on stable kernels.

Yeah, sounds good since the regresson commit is merged in v6.3.
Please feel free to post this and the hash array patch separately for
formal reviewing.

By the way, when I am replying this mail, I check the cpumask_nth()
again. I doubt it may take more checking then cpu_possible(), given most
of systems don't have gaps in cpu_possible_mask. I could be dizzy at
this moment.

static inline unsigned int cpumask_nth(unsigned int cpu, const struct cpumask *srcp)
{
        return find_nth_bit(cpumask_bits(srcp), small_cpumask_bits, cpumask_check(cpu));
}

