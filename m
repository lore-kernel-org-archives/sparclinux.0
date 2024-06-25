Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A1917CA1E;
	Tue, 25 Jun 2024 20:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719345958; cv=none; b=Cq0qJLEVN0Mlr+DJwxGNpl22s8RSiD9if9rXKrI3NfMNBkUY5BB/MfJ0FgTW8XBzKTdx6AaR0ObH/XGIm4mV8adFdUeSqcHhtNRJ/L4lIj+PFJgB8/u+crlQwSnF1tilcndcESONsqTTnSx1v4i71AESdBFSxft6DurmtgWYjMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719345958; c=relaxed/simple;
	bh=Ouq7UI8r4c/t7O7KVPhqjulOtPMRqxtv7cqfp4ThtPM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CLH5RZP5lBJdUBROjSk2K1PC9WwHeJ0h8Stu5GXuaQyvzxHOV76YKQ4bctun9xHPboSGbw6fokyYZUKIiCPUh926ZXm7S5abrOfCcaRplP0HIyKaSdL4+X+adfFRcglHBeA/7uhZVWi5Hu0omilP2OxS5g2If1Psk+nyuUj3bPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GkAosf7x; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GkAosf7x"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52cecba8d11so1530306e87.1;
        Tue, 25 Jun 2024 13:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719345954; x=1719950754; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2J4hGqbcUzUN0UCwy+GvYQrnL7nzLlsNWsttcQw1Uqw=;
        b=GkAosf7xOOmM5VQ8cjHrjCayr0QqYxAVo07vr1SkulnCrNmIQFDKZ6WYnVhAEpKBfP
         rX0s/87p/zEv15wjbQ/H5SsKKgqC5CkN6orvgHNCeUJh3qNN9gDlqP5Fo0ZWlYfZCar+
         3V8kG6GLMtu4hV2STtLqN+jBrTU0FThuDHiyHzXib0ZUScb7T1Pa27+mAkLCkR9yORWE
         1BFF7YHvETmu0Tvq5ysP2Sba6jb7TwnCZtaEXBLXYCTWBtm1ZOxtPLyFATH1EJg9e66x
         2DCG2ChQcn9q5yOCeYt2pH3NouKNlkfkQzfK6kkEHRkqKcKsNogYI7Zy29VtMB7XsIVo
         WgRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719345954; x=1719950754;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2J4hGqbcUzUN0UCwy+GvYQrnL7nzLlsNWsttcQw1Uqw=;
        b=S955Epf3ouL5eRcq+BvxNxox2L3bJH3ygSvtTBuR/QFfQ8qDPlzY0sDPKfLbbcHuVs
         cDpQVh0s+OoXO8u651B5qlQpjvPvqt1uPJjbPoC5W4LaYje7aKuZxxUv4JZNTF5WZKgi
         RUNVyDw2wbRuWAg9mSHdvnc6oqkRvSdFxWLn9nUvHCRUMjYGAf6713lZXhj9JpU0GNnI
         Kk15CBS9PcxNIqU6FUzRqc6FboiPf/Jc/B4kGoIFXSMnH8ySeHEvw6NmZLmtiv+G1LOV
         wCOUrIqrURDScBrruF+PApvP8XIJmrVwKQ2D9rBxRlCRhITwyfN6MJY1hEAexORQhbRz
         xacA==
X-Forwarded-Encrypted: i=1; AJvYcCWAKbv1cwbdC/QAQkSdqS32gmnfjI2c044Wgs0R+7Sake//8buN/3+ccJCu7wDaLlV5qi7MbTvI7FLe4Hsv939HJQCOGrDreHjZP+NGbGLJK6sOcdBHhm4jsc0zXy6xfq6R2NblUmUWxA==
X-Gm-Message-State: AOJu0YzcvK8DhBXRJ+RurlvnG4fplSe1hJXKAaH1BkKbY28njgFRHhx6
	iPw7krSyr6Ch7AfFtU57JUCwI8csf2kAIfRcWGNDt5TiZDTZGcuL
X-Google-Smtp-Source: AGHT+IGRklP8XrpFFDL63kjNNjIm7656v8ToUlPmmfs60nq9WNExmpGsQL6esjys/LPNfYORPh2NXA==
X-Received: by 2002:ac2:528c:0:b0:52c:df51:20bc with SMTP id 2adb3069b0e04-52ce18350e0mr4502213e87.16.1719345954075;
        Tue, 25 Jun 2024 13:05:54 -0700 (PDT)
Received: from pc636 (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6fe5e27995sm416499666b.0.2024.06.25.13.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 13:05:53 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Tue, 25 Jun 2024 22:05:52 +0200
To: Baoquan He <bhe@redhat.com>
Cc: Nick Bowler <nbowler@draconx.ca>, Hailong Liu <hailong.liu@oppo.com>,
	linux-kernel@vger.kernel.org,
	Linux regressions mailing list <regressions@lists.linux.dev>,
	linux-mm@kvack.org, sparclinux@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: PROBLEM: kernel crashes when running xfsdump since ~6.4
Message-ID: <ZnsjIB2byIxSgbjc@pc636>
References: <ZnWICsPgYuBlrWlt@MiWiFi-R3L-srv>
 <Znljtv5n-6EBgpsF@pc636>
 <Zno52QBG0g5Z+otD@MiWiFi-R3L-srv>
 <ZnqcuKt2qrR-wmH3@pc636>
 <ZnqspTVl/76jM9WD@MiWiFi-R3L-srv>
 <Znq6tEtCgB6QnnJH@pc638.lan>
 <Znq/8/HAc/0p6Ja0@MiWiFi-R3L-srv>
 <ZnrjZRq5-_hemrbD@pc636>
 <ZnrnADHvOiNcZv9t@MiWiFi-R3L-srv>
 <Znr1IQ1mssdNNXbv@pc638.lan>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Znr1IQ1mssdNNXbv@pc638.lan>

> > > > > /**
> > > > >  * cpumask_next - get the next cpu in a cpumask
> > > > >  * @n: the cpu prior to the place to search (i.e. return will be > @n)
> > > > >  * @srcp: the cpumask pointer
> > > > >  *
> > > > >  * Return: >= nr_cpu_ids if no further cpus set.
> > > > 
> > > > Ah, I got what you mean. In the vbq case, it may not have chance to get
> > > > a return number as nr_cpu_ids. Becuase the hashed index limits the
> > > > range to [0, nr_cpu_ids-1], and cpu_possible(index) will guarantee it
> > > > won't be the highest cpu number [nr_cpu_ids-1] since CPU[nr_cpu_ids-1] must
> > > > be possible CPU.
> > > > 
> > > > Do I miss some corner cases?
> > > > 
> > > Right. We guarantee that a highest CPU is available by doing: % nr_cpu_ids.
> > > So we do not need to use *next_wrap() variant. You do not miss anything :)
> > > 
> > > Hailong Liu has proposed more simpler version:
> > > 
> > > <snip>
> > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > index 11fe5ea208aa..e1e63ffb9c57 100644
> > > --- a/mm/vmalloc.c
> > > +++ b/mm/vmalloc.c
> > > @@ -1994,8 +1994,9 @@ static struct xarray *
> > >  addr_to_vb_xa(unsigned long addr)
> > >  {
> > >         int index = (addr / VMAP_BLOCK_SIZE) % num_possible_cpus();
> > > +       int cpu = cpumask_nth(index, cpu_possible_mask);
> > > 
> > > -       return &per_cpu(vmap_block_queue, index).vmap_blocks;
> > > +       return &per_cpu(vmap_block_queue, cpu).vmap_blocks;
> > > <snip>
> > > 
> > > which just takes a next CPU if an index is not set in the cpu_possible_mask.
> > > 
> > > The only thing that can be updated in the patch is to replace num_possible_cpu()
> > > by the nr_cpu_ids.
> > > 
> > > Any thoughts? I think we need to fix it by a minor change so it is
> > > easier to back-port on stable kernels.
> > 
> > Yeah, sounds good since the regresson commit is merged in v6.3.
> > Please feel free to post this and the hash array patch separately for
> > formal reviewing.
> > 
> Agreed! The patch about hash array i will post later.
> 
> > By the way, when I am replying this mail, I check the cpumask_nth()
> > again. I doubt it may take more checking then cpu_possible(), given most
> > of systems don't have gaps in cpu_possible_mask. I could be dizzy at
> > this moment.
> > 
> > static inline unsigned int cpumask_nth(unsigned int cpu, const struct cpumask *srcp)
> > {
> >         return find_nth_bit(cpumask_bits(srcp), small_cpumask_bits, cpumask_check(cpu));
> > }
> > 
> Yep, i do not think it is a big problem based on your noted fact.
> 
Checked. There is a difference:

1. Default

<snip>
...
+   15.95%     6.05%  [kernel]        [k] __vmap_pages_range_noflush
+   15.91%     1.74%  [kernel]        [k] addr_to_vb_xa <---------------
+   15.13%    12.05%  [kernel]        [k] vunmap_p4d_range
+   14.17%    13.38%  [kernel]        [k] __find_nth_bit <--------------
+   10.62%     0.00%  [kernel]        [k] ret_from_fork_asm
+   10.62%     0.00%  [kernel]        [k] ret_from_fork
+   10.62%     0.00%  [kernel]        [k] kthread
...
<snip>

2. Check if cpu_possible() and then fallback to cpumask_nth() if not

<snip>
...
+    6.84%     0.29%  [kernel]          [k] alloc_vmap_area
+    6.80%     6.70%  [kernel]          [k] native_queued_spin_lock_slowpath
+    4.24%     0.09%  [kernel]          [k] free_vmap_block
+    2.41%     2.38%  [kernel]          [k] addr_to_vb_xa <-----------
+    1.94%     1.91%  [kernel]          [k] xas_start
...
<snip>

It is _worth_ to check if an index is in possible mask:

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 45e1506d58c3..af20f78c2cbf 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2542,7 +2542,10 @@ static DEFINE_PER_CPU(struct vmap_block_queue, vmap_block_queue);
 static struct xarray *
 addr_to_vb_xa(unsigned long addr)
 {
-       int index = (addr / VMAP_BLOCK_SIZE) % num_possible_cpus();
+       int index = (addr / VMAP_BLOCK_SIZE) % nr_cpu_ids;
+
+       if (!cpu_possible(index))
+               index = cpumask_nth(index, cpu_possible_mask);

        return &per_cpu(vmap_block_queue, index).vmap_blocks;
 }

cpumask_nth() is not cheap. My measurements are based on a synthetic
tight test and it detects a difference. In a real workloads it should
not be visible. Having gaps is not a common case plus a "slow path"
will be mitigated by the hit against possible mask.

--
Uladzislau Rezki
