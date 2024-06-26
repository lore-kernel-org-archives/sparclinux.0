Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A817C17B515
	for <sparclinux@vger.kernel.org>; Wed, 26 Jun 2024 10:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719399108; cv=none; b=mYXTMajhu3UNHufHpzSxDPczSoyYnrj4ASDMPUDDDo49IOBCOZ0i/MWJv1x2wsMvyXenB24O7GfZ5/SM0wlsWzR6R4GelVVdC7RRQ8DRNuJkus5ImcB9RUNYPT3WgH+6w0KShVurWFOOXx5aT9jdWiV5e+Nv9i1X0NVATfQVW2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719399108; c=relaxed/simple;
	bh=IYp6s9dumUTDnxq8nPc4PYWKRMd2LaNg2CReE7Tj8Ks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wb3WGLqfvcytACPcarYxRNc5s0XDSDkEcXouNGyauaB9RiFZdmtJIfFsvcLCTF/XotyKYIJNgLAXXwaSVA6zA17wBoxu7I2mWvWMiyBQHqG+dZQUbNu46EOBcoZNtynAizwCGjr8axUYA4h1QiKZwnSLg6y1ugVl/ms/8FQP5Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PWbdqHM+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PWbdqHM+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719399104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bRpiuIFyD0DYgN6Da02SxVnuYQtZmCOUl7INhZ5MXTw=;
	b=PWbdqHM+3gVHxDQd9cFOcEIr7FSIaBL9xWiCq5RDDOBsCw94wkPHHkz0FyiKRz7obaxs6s
	u7hjIinXcuLAtNy7uddMRKFEVkFUEbmIPLWZnUL0ohmDNsKqmMrJemywceHEVodhMXRbR2
	PCKZVETs/YMx1XHGJzo5nHu368vqtkU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-353-2LD4IfWcMYu3I7VgzLHJKg-1; Wed,
 26 Jun 2024 06:51:40 -0400
X-MC-Unique: 2LD4IfWcMYu3I7VgzLHJKg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EEA5419560AD;
	Wed, 26 Jun 2024 10:51:38 +0000 (UTC)
Received: from localhost (unknown [10.72.116.83])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 949E7300021A;
	Wed, 26 Jun 2024 10:51:36 +0000 (UTC)
Date: Wed, 26 Jun 2024 18:51:32 +0800
From: Baoquan He <bhe@redhat.com>
To: Hailong Liu <hailong.liu@oppo.com>
Cc: Uladzislau Rezki <urezki@gmail.com>, Nick Bowler <nbowler@draconx.ca>,
	linux-kernel@vger.kernel.org,
	Linux regressions mailing list <regressions@lists.linux.dev>,
	linux-mm@kvack.org, sparclinux@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: PROBLEM: kernel crashes when running xfsdump since ~6.4
Message-ID: <ZnvytLzoLrVwymXv@MiWiFi-R3L-srv>
References: <ZnqspTVl/76jM9WD@MiWiFi-R3L-srv>
 <Znq6tEtCgB6QnnJH@pc638.lan>
 <Znq/8/HAc/0p6Ja0@MiWiFi-R3L-srv>
 <ZnrjZRq5-_hemrbD@pc636>
 <ZnrnADHvOiNcZv9t@MiWiFi-R3L-srv>
 <Znr1IQ1mssdNNXbv@pc638.lan>
 <ZnsjIB2byIxSgbjc@pc636>
 <20240626051206.mx2r4iy3wpexykay@oppo.com>
 <ZnvcToH1h-sVtikh@pc636>
 <20240626100342.2dudj6fjjx6srban@oppo.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626100342.2dudj6fjjx6srban@oppo.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 06/26/24 at 06:03pm, Hailong Liu wrote:
> On Wed, 26. Jun 11:15, Uladzislau Rezki wrote:
> > On Wed, Jun 26, 2024 at 01:12:06PM +0800, Hailong Liu wrote:
> > > On Tue, 25. Jun 22:05, Uladzislau Rezki wrote:
> > > > > > > > > /**
> > > > > > > > >  * cpumask_next - get the next cpu in a cpumask
> > > > > > > > >  * @n: the cpu prior to the place to search (i.e. return will be > @n)
> > > > > > > > >  * @srcp: the cpumask pointer
> > > > > > > > >  *
> > > > > > > > >  * Return: >= nr_cpu_ids if no further cpus set.
> > > > > > > >
> > > > > > > > Ah, I got what you mean. In the vbq case, it may not have chance to get
> > > > > > > > a return number as nr_cpu_ids. Becuase the hashed index limits the
> > > > > > > > range to [0, nr_cpu_ids-1], and cpu_possible(index) will guarantee it
> > > > > > > > won't be the highest cpu number [nr_cpu_ids-1] since CPU[nr_cpu_ids-1] must
> > > > > > > > be possible CPU.
> > > > > > > >
> > > > > > > > Do I miss some corner cases?
> > > > > > > >
> > > > > > > Right. We guarantee that a highest CPU is available by doing: % nr_cpu_ids.
> > > > > > > So we do not need to use *next_wrap() variant. You do not miss anything :)
> > > > > > >
> > > > > > > Hailong Liu has proposed more simpler version:
> > > > > > >
> > > > > > > <snip>
> > > > > > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > > > > > index 11fe5ea208aa..e1e63ffb9c57 100644
> > > > > > > --- a/mm/vmalloc.c
> > > > > > > +++ b/mm/vmalloc.c
> > > > > > > @@ -1994,8 +1994,9 @@ static struct xarray *
> > > > > > >  addr_to_vb_xa(unsigned long addr)
> > > > > > >  {
> > > > > > >         int index = (addr / VMAP_BLOCK_SIZE) % num_possible_cpus();
> > > > > > > +       int cpu = cpumask_nth(index, cpu_possible_mask);
> > > > > > >
> > > > > > > -       return &per_cpu(vmap_block_queue, index).vmap_blocks;
> > > > > > > +       return &per_cpu(vmap_block_queue, cpu).vmap_blocks;
> > > > > > > <snip>
> > > > > > >
> > > > > > > which just takes a next CPU if an index is not set in the cpu_possible_mask.
> > > > > > >
> > > > > > > The only thing that can be updated in the patch is to replace num_possible_cpu()
> > > > > > > by the nr_cpu_ids.
> > > > > > >
> > > > > > > Any thoughts? I think we need to fix it by a minor change so it is
> > > > > > > easier to back-port on stable kernels.
> > > > > >
> > > > > > Yeah, sounds good since the regresson commit is merged in v6.3.
> > > > > > Please feel free to post this and the hash array patch separately for
> > > > > > formal reviewing.
> > > > > >
> > > > > Agreed! The patch about hash array i will post later.
> > > > >
> > > > > > By the way, when I am replying this mail, I check the cpumask_nth()
> > > > > > again. I doubt it may take more checking then cpu_possible(), given most
> > > > > > of systems don't have gaps in cpu_possible_mask. I could be dizzy at
> > > > > > this moment.
> > > > > >
> > > > > > static inline unsigned int cpumask_nth(unsigned int cpu, const struct cpumask *srcp)
> > > > > > {
> > > > > >         return find_nth_bit(cpumask_bits(srcp), small_cpumask_bits, cpumask_check(cpu));
> > > > > > }
> > > > > >
> > > > > Yep, i do not think it is a big problem based on your noted fact.
> > > > >
> > > > Checked. There is a difference:
> > > >
> > > > 1. Default
> > > >
> > > > <snip>
> > > > ...
> > > > +   15.95%     6.05%  [kernel]        [k] __vmap_pages_range_noflush
> > > > +   15.91%     1.74%  [kernel]        [k] addr_to_vb_xa <---------------
> > > > +   15.13%    12.05%  [kernel]        [k] vunmap_p4d_range
> > > > +   14.17%    13.38%  [kernel]        [k] __find_nth_bit <--------------
> > > > +   10.62%     0.00%  [kernel]        [k] ret_from_fork_asm
> > > > +   10.62%     0.00%  [kernel]        [k] ret_from_fork
> > > > +   10.62%     0.00%  [kernel]        [k] kthread
> > > > ...
> > > > <snip>
> > > >
> > > > 2. Check if cpu_possible() and then fallback to cpumask_nth() if not
> > > >
> > > > <snip>
> > > > ...
> > > > +    6.84%     0.29%  [kernel]          [k] alloc_vmap_area
> > > > +    6.80%     6.70%  [kernel]          [k] native_queued_spin_lock_slowpath
> > > > +    4.24%     0.09%  [kernel]          [k] free_vmap_block
> > > > +    2.41%     2.38%  [kernel]          [k] addr_to_vb_xa <-----------
> > > > +    1.94%     1.91%  [kernel]          [k] xas_start
> > > > ...
> > > > <snip>
> > > >
> > > > It is _worth_ to check if an index is in possible mask:
> > > >
> > > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > > index 45e1506d58c3..af20f78c2cbf 100644
> > > > --- a/mm/vmalloc.c
> > > > +++ b/mm/vmalloc.c
> > > > @@ -2542,7 +2542,10 @@ static DEFINE_PER_CPU(struct vmap_block_queue, vmap_block_queue);
> > > >  static struct xarray *
> > > >  addr_to_vb_xa(unsigned long addr)
> > > >  {
> > > > -       int index = (addr / VMAP_BLOCK_SIZE) % num_possible_cpus();
> > > > +       int index = (addr / VMAP_BLOCK_SIZE) % nr_cpu_ids;
> > > IIUC, use nr_cpu_ids here maybe incorrect.
> > >
> > > take b101 as example, nr_cpu_ids is 3. if index is 2 cpumask_nth(2, cpu_possible_mask);
> > > might return 64.
> > >
> > But then a CPU2 becomes possible? Cutting by % nr_cpu_ids generates values < nr_cpu_ids.
> > So, last CPU is always possible and we never do cpumask_nth() on a last possible CPU.
> >
> > What i miss here?
> >
> Sorry, I forget to reply to all :), I write a demo to test as follows:
> 
> static int cpumask_init(void)
> {
>        struct cpumask mask;
>        unsigned int cpu_id;
>        cpumask_clear(&mask);
> 
>        cpumask_set_cpu(1, &mask);
>        cpumask_set_cpu(3, &mask);
>        cpumask_set_cpu(5, &mask);
> 
>        cpu_id = find_last_bit(cpumask_bits(&mask), NR_CPUS) + 1;
>        pr_info("cpu_id:%d\n", cpu_id);
> 
>        for (; i < nr_cpu_ids; i++) {
>                pr_info("%d: cpu_%d\n", i, cpumask_nth(i, &mask));
>        }
> 
>        return 0;
> }
> 
> [    1.337020][    T1] cpu_id:6
> [    1.337338][    T1] 0: cpu_1
> [    1.337558][    T1] 1: cpu_3
> [    1.337751][    T1] 2: cpu_5
> [    1.337960][    T1] 3: cpu_64
> [    1.338183][    T1] 4: cpu_64
> [    1.338387][    T1] 5: cpu_64
> [    1.338594][    T1] 6: cpu_64
> 
> In summary, the nr_cpu_ids = last_bit + 1, and cpumask_nth() return the nth cpu_id.

I think just using below change for a quick fix is enough. It doesn't
have the issue cpumask_nth() has and very simple. For most of systems,
it only adds an extra cpu_possible(idex) checking.

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 633363997dec..59a8951cc6c0 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2542,7 +2542,10 @@ static DEFINE_PER_CPU(struct vmap_block_queue, vmap_block_queue);
 static struct xarray *
 addr_to_vb_xa(unsigned long addr)
 {
-	int index = (addr / VMAP_BLOCK_SIZE) % num_possible_cpus();
+	int index = (addr / VMAP_BLOCK_SIZE) % nr_cpu_ids;
+
+	if (!cpu_possible(idex))
+		index = cpumask_next(index, cpu_possible_mask);
 
 	return &per_cpu(vmap_block_queue, index).vmap_blocks;
 }

