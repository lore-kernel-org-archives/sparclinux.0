Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CB014D712;
	Tue, 25 Jun 2024 12:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719319321; cv=none; b=oz8k5LgZ4fKEmcwCYrULmsmGETEfkmgzsfNmUFCgA+50fGxBHbJk+AywZ98Zuo/pDVA81F/UFhi4tPPRbHRe/j3lMSLr+YBi0TmqBfCG3BbAHFl/wvSS5wn6Y/2mVLgF8oWjNQlcIp7wsuI5n83HMUVnZAAAJmuweaT63ajedN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719319321; c=relaxed/simple;
	bh=wo5JZVa8axtbZPu/P+YlNFKLSNSVsD1rl5F4Kiopv7A=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GjGOVWT8k4ZVmFo84q3lUUycR/KpK0PoxTB6qAlQIKXHh5P9NmU8sBZOi7bhx8svSU8reQLOLfDBL2DmDTudZbGB7F5LXifstnnVipegm8YDAPGuhWVHUa/HWCmEXGsuqtrcW9fJ4JpNdwStM7ewuiEhWV2NF7tfSHWsjD9OAgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X88Z/qfN; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X88Z/qfN"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a725ea1a385so210016066b.3;
        Tue, 25 Jun 2024 05:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719319317; x=1719924117; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yBzuofG6T7lvGEuAx25osRPS6h4Ox6IqcEZGgGnza9Y=;
        b=X88Z/qfNWUCmq9gJvrCWUV6d/m7+yh09YPLjoQc8JQU8ENxPUvdjFrWQU27T5nRUEK
         aPcxis+USOp0qDFdNUkaS/7D0Vk2lBfHvQZXnLT3pdCLt8xPXRAOWPwWD7ZDNFAeYZaI
         Uiv6i1+KWgcsN065WOJCE8In/E2Vj5wXDIiRqCTOnobHyv/Pyu8+KoAgWwQMIqRGFU+Z
         J+6KZQX4hCqv6Pcr8ZHpcrytNiqRaNJCm4eMMCerYSoqPclFtw4Lkubp3Kz1U6h7jm8t
         XXJH4O1JlCux9Aktz9/ViiwSx9wTrqqBE0/64kfF5B6SBhgK5XgIk6yr7CzzLmtqQKy+
         R/Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719319317; x=1719924117;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yBzuofG6T7lvGEuAx25osRPS6h4Ox6IqcEZGgGnza9Y=;
        b=vZgRHDeT6KexV4jNcCrSo1DrxANC8nrF3hkoBnsTPnnqh7vlh/tkbB4m2WStPeJ/JE
         mBn+qJp7j6y3vgY+9/R5mjq0ASI4qL9oTUFmBp6SDtkVSGCEGkMoBB4J4CsQz8VUdzmJ
         6Kr30dz8B0bG3B0W9ZWMmAPSQoh9ciyd5bU7Sk5eVrH2USQrrIrK3eUJ7O83WhK1f7CZ
         bigfTK08wSdKuUxLn7OwYnfyxEcRsFvYVZocVzvTTV2hibjGxrGE21OvwhtJo9+w86+A
         j+oH76LHVblf8VavTnEdZCYypMbkuwdwC+/0o39rs51mxEogUd27Hg139RueHN9bWPLv
         AKtg==
X-Forwarded-Encrypted: i=1; AJvYcCX7QNBUZZE9v37Yw4wxdBeBfJJuMUuoGcgIB3l2VFvDaMQEUgbYrLb+1cKx/+GIpTKDttVyAycqPOlPiFzlrt0wHNzVFivNpuft8LeifF56eafwdErTv9BWGT/a4HzDcZqM9VsMger3yA==
X-Gm-Message-State: AOJu0YxhkPpxU+4e7YMsrYlAKwOxkc4WAGP7BoJkqv2uSeUz/Diq1tx5
	0/s7yGJ8ht0wYNcIS8gOAUYNy5CMot1tVZ/2GxHWyQY34PbJTY7k
X-Google-Smtp-Source: AGHT+IHBTTZyGAjFLKKGRDnrtRxXSLYDLYujtC0zC79VRvwIGx29Betppcd4H0MdIE0BeqapvW25yQ==
X-Received: by 2002:a17:906:52d2:b0:a6e:f7ee:b1fa with SMTP id a640c23a62f3a-a7242e13207mr406032166b.72.1719319316725;
        Tue, 25 Jun 2024 05:41:56 -0700 (PDT)
Received: from pc638.lan (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7251ace5besm234139266b.179.2024.06.25.05.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 05:41:56 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date: Tue, 25 Jun 2024 14:41:54 +0200
To: Baoquan He <bhe@redhat.com>
Cc: Uladzislau Rezki <urezki@gmail.com>, Nick Bowler <nbowler@draconx.ca>,
	Hailong Liu <hailong.liu@oppo.com>, linux-kernel@vger.kernel.org,
	Linux regressions mailing list <regressions@lists.linux.dev>,
	linux-mm@kvack.org, sparclinux@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: PROBLEM: kernel crashes when running xfsdump since ~6.4
Message-ID: <Znq7EtiOnV8YLHDK@pc638.lan>
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
See below how the patch look like if we switch to hash array:

<snip>
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 45e1506d58c3..a8bcd9ceec2d 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2501,7 +2501,8 @@ struct vmap_block {
 };
 
 /* Queue of free and dirty vmap blocks, for allocation and flushing purposes */
-static DEFINE_PER_CPU(struct vmap_block_queue, vmap_block_queue);
+static struct vmap_block_queue *vmap_block_queue;
+static bool vmap_block_queue_initialized;
 
 /*
  * In order to fast access to any "vmap_block" associated with a
@@ -2542,9 +2543,9 @@ static DEFINE_PER_CPU(struct vmap_block_queue, vmap_block_queue);
 static struct xarray *
 addr_to_vb_xa(unsigned long addr)
 {
-	int index = (addr / VMAP_BLOCK_SIZE) % num_possible_cpus();
+	int index = (addr / VMAP_BLOCK_SIZE) % nr_cpu_ids;
 
-	return &per_cpu(vmap_block_queue, index).vmap_blocks;
+	return &vmap_block_queue[index].vmap_blocks;
 }
 
 /*
@@ -2626,7 +2627,7 @@ static void *new_vmap_block(unsigned int order, gfp_t gfp_mask)
 		return ERR_PTR(err);
 	}
 
-	vbq = raw_cpu_ptr(&vmap_block_queue);
+	vbq = &vmap_block_queue[raw_smp_processor_id()];
 	spin_lock(&vbq->lock);
 	list_add_tail_rcu(&vb->free_list, &vbq->free);
 	spin_unlock(&vbq->lock);
@@ -2657,6 +2658,9 @@ static bool purge_fragmented_block(struct vmap_block *vb,
 		struct vmap_block_queue *vbq, struct list_head *purge_list,
 		bool force_purge)
 {
+	if (!vmap_block_queue_initialized)
+		return false;
+
 	if (vb->free + vb->dirty != VMAP_BBMAP_BITS ||
 	    vb->dirty == VMAP_BBMAP_BITS)
 		return false;
@@ -2692,7 +2696,12 @@ static void purge_fragmented_blocks(int cpu)
 {
 	LIST_HEAD(purge);
 	struct vmap_block *vb;
-	struct vmap_block_queue *vbq = &per_cpu(vmap_block_queue, cpu);
+	struct vmap_block_queue *vbq;
+
+	if (!vmap_block_queue_initialized)
+		return;
+
+	vbq = &vmap_block_queue[cpu];
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(vb, &vbq->free, free_list) {
@@ -2715,7 +2724,7 @@ static void purge_fragmented_blocks_allcpus(void)
 {
 	int cpu;
 
-	for_each_possible_cpu(cpu)
+	for (cpu = 0; cpu < nr_cpu_ids; cpu++)
 		purge_fragmented_blocks(cpu);
 }
 
@@ -2739,7 +2748,7 @@ static void *vb_alloc(unsigned long size, gfp_t gfp_mask)
 	order = get_order(size);
 
 	rcu_read_lock();
-	vbq = raw_cpu_ptr(&vmap_block_queue);
+	vbq = &vmap_block_queue[raw_smp_processor_id()];
 	list_for_each_entry_rcu(vb, &vbq->free, free_list) {
 		unsigned long pages_off;
 
@@ -2822,13 +2831,13 @@ static void _vm_unmap_aliases(unsigned long start, unsigned long end, int flush)
 	LIST_HEAD(purge_list);
 	int cpu;
 
-	if (unlikely(!vmap_initialized))
+	if (unlikely(!vmap_initialized || !vmap_block_queue_initialized))
 		return;
 
 	mutex_lock(&vmap_purge_lock);
 
-	for_each_possible_cpu(cpu) {
-		struct vmap_block_queue *vbq = &per_cpu(vmap_block_queue, cpu);
+	for (cpu = 0; cpu < nr_cpu_ids; cpu++) {
+		struct vmap_block_queue *vbq = &vmap_block_queue[cpu];
 		struct vmap_block *vb;
 		unsigned long idx;
 
@@ -2910,7 +2919,7 @@ void vm_unmap_ram(const void *mem, unsigned int count)
 
 	kasan_poison_vmalloc(mem, size);
 
-	if (likely(count <= VMAP_MAX_ALLOC)) {
+	if (likely(count <= VMAP_MAX_ALLOC) && vmap_block_queue_initialized) {
 		debug_check_no_locks_freed(mem, size);
 		vb_free(addr, size);
 		return;
@@ -2946,7 +2955,7 @@ void *vm_map_ram(struct page **pages, unsigned int count, int node)
 	unsigned long addr;
 	void *mem;
 
-	if (likely(count <= VMAP_MAX_ALLOC)) {
+	if (likely(count <= VMAP_MAX_ALLOC && vmap_block_queue_initialized)) {
 		mem = vb_alloc(size, GFP_KERNEL);
 		if (IS_ERR(mem))
 			return NULL;
@@ -5087,17 +5096,28 @@ void __init vmalloc_init(void)
 	 */
 	vmap_area_cachep = KMEM_CACHE(vmap_area, SLAB_PANIC);
 
+	vmap_block_queue = kmalloc_array(
+		nr_cpu_ids, sizeof(struct vmap_block_queue), GFP_NOWAIT);
+
+	if (vmap_block_queue) {
+		for (i = 0; i < nr_cpu_ids; i++) {
+			struct vmap_block_queue *vbq =
+				&vmap_block_queue[i];
+
+			spin_lock_init(&vbq->lock);
+			INIT_LIST_HEAD(&vbq->free);
+			xa_init(&vbq->vmap_blocks);
+		}
+	} else {
+		pr_err("Failed to allocate vmap_block_queue array, use fallback path!\n");
+	}
+
 	for_each_possible_cpu(i) {
-		struct vmap_block_queue *vbq;
-		struct vfree_deferred *p;
+		struct vfree_deferred *p =
+			&per_cpu(vfree_deferred, i);
 
-		vbq = &per_cpu(vmap_block_queue, i);
-		spin_lock_init(&vbq->lock);
-		INIT_LIST_HEAD(&vbq->free);
-		p = &per_cpu(vfree_deferred, i);
 		init_llist_head(&p->list);
 		INIT_WORK(&p->wq, delayed_vfree_work);
-		xa_init(&vbq->vmap_blocks);
 	}
 
 	/*
@@ -5125,6 +5145,9 @@ void __init vmalloc_init(void)
 	vmap_init_free_space();
 	vmap_initialized = true;
 
+	if (vmap_block_queue)
+		vmap_block_queue_initialized = true;
+
 	vmap_node_shrinker = shrinker_alloc(0, "vmap-node");
 	if (!vmap_node_shrinker) {
 		pr_err("Failed to allocate vmap-node shrinker!\n");
<snip>

Any thoughts?

--
Uladzislau Rezki

