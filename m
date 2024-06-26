Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5ABB181D1E;
	Wed, 26 Jun 2024 10:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719399110; cv=none; b=hJFWi1Q5jmlz2rGt1LiT3YpVXBahA1QeVkzSqEHbQVOhLMieSOkAf1RHKaZ1IFEAAoVFYrTzV5vzOY9ZemRCp9boxiTYPhxy5TZhmu382sTSIV50houvQVM225RuCXf3AEhkhA5f0GdtmzgyrS26QOR2xHTdHVaJThYqiyCAWxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719399110; c=relaxed/simple;
	bh=njPBaVPiJ+OrsgkSQ4O6avilA3ChsvjLomkkhBGXUqg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f0cQTxYwtEdEISM3AbUoiCak3AxWNjIsXAuT+aPy3m/VGkmvOwF0otvb3INDMjoqYtqEd1cWM0JQEyVXGT+g4+A+X9fP5F5EgDLWk6ZhewZ9LwWnGM0MWPiNl0aggAkyws8Ia4174tY+mNyBjnF+kKSs8HXj3eymodKrZM1YhYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KBqcjTXF; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KBqcjTXF"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ec3f875e68so72779241fa.0;
        Wed, 26 Jun 2024 03:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719399105; x=1720003905; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sAF9vjjeL2YSSoAhozbISzvWAPohgaJ/Mqgbub7kNF0=;
        b=KBqcjTXFDPJvvlzoztZbyO1eEma93laC2aOqIY5/6JNG215CqK8GPlpBk2/b2RJ3FU
         VQm8F64JyowC9esCIikt0rgN0Vin/m8g7yxSGvDGoYKE21mCv0xeZ8Oaom7HRRcNrwSk
         4SnEOctnD0Nsn8BfmiIN1Mdjn9fLSTqgymaamKM7hutsLXaxHxSokVBfE1oryr5Y9yH/
         ZVTefXq5khluu12PKN6Ontb1lcs4LJmQAPARj14zwmPHbyk1/IsaMj+n9rioCU9Zyco7
         9Dn0TXVSAL3tzpBS6iJf/04cEMWEdyP9eRYz0yyBl8syE90U3Now8wDUCQns1JImDxCg
         c5dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719399105; x=1720003905;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sAF9vjjeL2YSSoAhozbISzvWAPohgaJ/Mqgbub7kNF0=;
        b=WWvim2+9vurNeBy22ZG9YqeCka+RLXpti8gjy7lcPehEDwHWbNwHgIWuTa3jUr+tBT
         kjYwZhA7zziIMtibap6JHOn8w/WybEw16VdQVE5gdiPpZsUW7AtpcGDuFeTaQD0SqAQR
         vsMSDs9nF9J3I2cwMVnm3wb3VbxNFTE217QajQoagDRkLT7ugVI/JVap2MSv55reqxeJ
         HMMDx/m66fOiMnqPZiTYPfnVWwNV50suF9au68kpGXC3qbhJ+NNthwmsDxPNnYg/iWRV
         NHuc/suKIsrNcjI78X8T+TLOodBbKzskdfODtY7Spt6Ak6yscXGb5KghPGE9z2hfCGhN
         axDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIS/Mk6sKuxAYN0UiHcirIjImW4Vfsxlj2raGl9XKoggq/Wel4tZ02eQrcMBLH67nJiXLRcMz1qLBvKRT/QfDY4btv9t3WxLHLxEjmuCzxaitf4Ir6wey5W/NvEJqdfC3NrOukyAcFjw==
X-Gm-Message-State: AOJu0YxL7ih4nOWSuLkYJQy0LtrOAmhcSKwz3YRHcAcGagTpYw6qKnnH
	lxzShKHJJneeWHEsHN9IsWJiXjKdS8e38yOn3XDbY5DQEOezHS+1
X-Google-Smtp-Source: AGHT+IFKZSVhxM5coOj5/CC3REPwevHkwWRCxIsgNzYe4QGbxv+o6yN+lc0AxHbPqS/w93Knm6WQlQ==
X-Received: by 2002:a2e:9104:0:b0:2ec:57c7:c72c with SMTP id 38308e7fff4ca-2ec5b3d4979mr52834821fa.35.1719399104689;
        Wed, 26 Jun 2024 03:51:44 -0700 (PDT)
Received: from pc636 (host-90-233-219-252.mobileonline.telia.com. [90.233.219.252])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec54860756sm11434241fa.131.2024.06.26.03.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 03:51:44 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Wed, 26 Jun 2024 12:51:42 +0200
To: Hailong Liu <hailong.liu@oppo.com>
Cc: Uladzislau Rezki <urezki@gmail.com>, Baoquan He <bhe@redhat.com>,
	Nick Bowler <nbowler@draconx.ca>, linux-kernel@vger.kernel.org,
	Linux regressions mailing list <regressions@lists.linux.dev>,
	linux-mm@kvack.org, sparclinux@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: PROBLEM: kernel crashes when running xfsdump since ~6.4
Message-ID: <Znvyvof4CnFETJ-v@pc636>
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

On Wed, Jun 26, 2024 at 06:03:42PM +0800, Hailong Liu wrote:
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
> 
OK, i misread the cpumask_nth(). We should go with *_next() variant instead.

Thank you for pointing this. Below is updated version with extra comment:

<snip>
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 45e1506d58c3..03b82fb8ecd3 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2542,7 +2542,15 @@ static DEFINE_PER_CPU(struct vmap_block_queue, vmap_block_queue);
 static struct xarray *
 addr_to_vb_xa(unsigned long addr)
 {
-       int index = (addr / VMAP_BLOCK_SIZE) % num_possible_cpus();
+       int index = (addr / VMAP_BLOCK_SIZE) % nr_cpu_ids;
+
+       /*
+        * Please note, nr_cpu_ids points on a highest set
+        * possible bit, i.e. we never invoke cpumask_next()
+        * if an index points on it which is nr_cpu_ids - 1.
+        */
+       if (!cpu_possible(index))
+               index = cpumask_next(index, cpu_possible_mask);
 
        return &per_cpu(vmap_block_queue, index).vmap_blocks;
 }
<snip>

Thanks!

--
Uladzislau Rezki
