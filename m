Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08062176230;
	Tue, 25 Jun 2024 16:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719334183; cv=none; b=NmIv43yc7TdIhwcciA3Ssw+lKQYhVPTg+0aq7UKhO6vFTlrTxeW21TeZ5BfD6psxKPA7jnwjryZF39umbjbO9slFhOHTPpz6T9iRDuBtmj9vVuTQ1lfz3CCogMpemlTk4EpfLuiX1LmqoHMQr5AX3IUCWVP8pZCk45ww3TyVciM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719334183; c=relaxed/simple;
	bh=9/N/lZxSE7O6j9KicH3kaHG+FZylOMFwRNg/yBKCloI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t/v+lqG5yUddk2yf6ibfNHkxfcs+xwagH+jCvNhOWk0Eu51Px+1z0SOniKRi8RVyCl2zHhdwQ33L0AT00gT8IzpVjB4+GZzwmeZjk/hvatz5u2pP26HS4UP8ZE6rvJd0KQ83khBjagQeK7cL+tvv/DlFNN8VdhauwTjFb1j78gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l2b0PcRb; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l2b0PcRb"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a6fe61793e2so217878866b.0;
        Tue, 25 Jun 2024 09:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719334180; x=1719938980; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i8tcHw7piGXCwRcIpKZBGAUeAPhX7LMHTxD2UwRCUME=;
        b=l2b0PcRb9pwdu8s0K1Wudk7UbVyCyFBCU1+okSr2KCpKL57POsRtoStpFV4u93m3fU
         grGZtHOSCGeI/ttPxZMWi1HWSaPFpB3OkJfFw5f8HkT1tld8f7OAmmL8pDsJwBEEnGeJ
         JabNei1SPap9f0pWeTDh4ODB2F2LVOIfCDbUb4/X5Q7CkcURhZptN98nlosBJ/TsY1kU
         ROT0cVNi1P59Ma68QGTVi/Lzioav4nXVowGH1dgC5MBi5QunkTSBQL+kEQy7BtQig5+e
         pAqHmkmd8k6cg1e59y+WBmwEPrEhLhSl/ntcjoy9y2c+pnJrQxxoOkDAVbCbT+I1MXht
         5PDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719334180; x=1719938980;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i8tcHw7piGXCwRcIpKZBGAUeAPhX7LMHTxD2UwRCUME=;
        b=Wo2o2ZJO3u9+SKunb6j2pPHGhmDYZSYrQWSDy1uytaW06GmyarOZ99uAjWqEZ/DVMZ
         LtICOfxdZ8bkE7xIYv7OYvzle26YhtlfsCeVx3hUrZKmXQspl2k/GnNcPymXM8n/sTzP
         0b5zYrHZVdNvw83AByCWmr7k73RmUGdczGoyFn6icm1XpkpcqIpUeqme0Y5COdRiiohC
         tKPzocUTygPg374yCFEFbjei/Ml4NNS3OmT3QNpZHZsMfPFoX0L57HnGKRo8VsEeZd0m
         KCl6XC/TpLu9+P6LOuOMwTU+vI7ZTj49Sd+HRNuSNj53El2WVkZN9gkt8pO3X5RbtT9M
         3y7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXfYPbyG52hL+HASg9LDOoWTZQQbtNrQgdPOOH0GyCfRXbAkHKRJqDVOuuwiyfQMk1+8EV7x9YoLgq01x4ftYq/Pcr1u6s/PhqTZlAZvMmczNQ1PAkWcMRIyK1752IY8lOba4vKQJxfGg==
X-Gm-Message-State: AOJu0YxFkWSsviM7MChopzObNuchAwgSotxIAUNlQ/2wUnN+p9DuwpAv
	8G75Gp1/VnF3BT9gRuWQHzKuwBuAFN20vLHb9insC2cs/krosiHh
X-Google-Smtp-Source: AGHT+IG1iYnAnB1dQfk+8aYmQF2ecfD43JBj0FrCqW8RDRv+XN+QynXr42cGTxWqNwxe8YLLOqAPmw==
X-Received: by 2002:a50:ab5b:0:b0:57d:2659:9143 with SMTP id 4fb4d7f45d1cf-57d4bde078cmr6401540a12.37.1719334180082;
        Tue, 25 Jun 2024 09:49:40 -0700 (PDT)
Received: from pc638.lan (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d30583e93sm6095989a12.96.2024.06.25.09.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 09:49:39 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date: Tue, 25 Jun 2024 18:49:37 +0200
To: Nick Bowler <nbowler@draconx.ca>
Cc: Uladzislau Rezki <urezki@gmail.com>, Hailong Liu <hailong.liu@oppo.com>,
	Nick Bowler <nbowler@draconx.ca>, linux-kernel@vger.kernel.org,
	Linux regressions mailing list <regressions@lists.linux.dev>,
	linux-mm@kvack.org, sparclinux@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: PROBLEM: kernel crashes when running xfsdump since ~6.4
Message-ID: <Znr1IQ1mssdNNXbv@pc638.lan>
References: <ZnVLbCCkvhf5GaTf@pc636>
 <ZnWICsPgYuBlrWlt@MiWiFi-R3L-srv>
 <Znljtv5n-6EBgpsF@pc636>
 <Zno52QBG0g5Z+otD@MiWiFi-R3L-srv>
 <ZnqcuKt2qrR-wmH3@pc636>
 <ZnqspTVl/76jM9WD@MiWiFi-R3L-srv>
 <Znq6tEtCgB6QnnJH@pc638.lan>
 <Znq/8/HAc/0p6Ja0@MiWiFi-R3L-srv>
 <ZnrjZRq5-_hemrbD@pc636>
 <ZnrnADHvOiNcZv9t@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnrnADHvOiNcZv9t@MiWiFi-R3L-srv>

> > > > /**
> > > >  * cpumask_next - get the next cpu in a cpumask
> > > >  * @n: the cpu prior to the place to search (i.e. return will be > @n)
> > > >  * @srcp: the cpumask pointer
> > > >  *
> > > >  * Return: >= nr_cpu_ids if no further cpus set.
> > > 
> > > Ah, I got what you mean. In the vbq case, it may not have chance to get
> > > a return number as nr_cpu_ids. Becuase the hashed index limits the
> > > range to [0, nr_cpu_ids-1], and cpu_possible(index) will guarantee it
> > > won't be the highest cpu number [nr_cpu_ids-1] since CPU[nr_cpu_ids-1] must
> > > be possible CPU.
> > > 
> > > Do I miss some corner cases?
> > > 
> > Right. We guarantee that a highest CPU is available by doing: % nr_cpu_ids.
> > So we do not need to use *next_wrap() variant. You do not miss anything :)
> > 
> > Hailong Liu has proposed more simpler version:
> > 
> > <snip>
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index 11fe5ea208aa..e1e63ffb9c57 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -1994,8 +1994,9 @@ static struct xarray *
> >  addr_to_vb_xa(unsigned long addr)
> >  {
> >         int index = (addr / VMAP_BLOCK_SIZE) % num_possible_cpus();
> > +       int cpu = cpumask_nth(index, cpu_possible_mask);
> > 
> > -       return &per_cpu(vmap_block_queue, index).vmap_blocks;
> > +       return &per_cpu(vmap_block_queue, cpu).vmap_blocks;
> > <snip>
> > 
> > which just takes a next CPU if an index is not set in the cpu_possible_mask.
> > 
> > The only thing that can be updated in the patch is to replace num_possible_cpu()
> > by the nr_cpu_ids.
> > 
> > Any thoughts? I think we need to fix it by a minor change so it is
> > easier to back-port on stable kernels.
> 
> Yeah, sounds good since the regresson commit is merged in v6.3.
> Please feel free to post this and the hash array patch separately for
> formal reviewing.
> 
Agreed! The patch about hash array i will post later.

> By the way, when I am replying this mail, I check the cpumask_nth()
> again. I doubt it may take more checking then cpu_possible(), given most
> of systems don't have gaps in cpu_possible_mask. I could be dizzy at
> this moment.
> 
> static inline unsigned int cpumask_nth(unsigned int cpu, const struct cpumask *srcp)
> {
>         return find_nth_bit(cpumask_bits(srcp), small_cpumask_bits, cpumask_check(cpu));
> }
> 
Yep, i do not think it is a big problem based on your noted fact.

Nick, could you please test your machine with below change?

<snip>
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 45e1506d58c3..5458fd2290cf 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2542,9 +2542,10 @@ static DEFINE_PER_CPU(struct vmap_block_queue, vmap_block_queue);
 static struct xarray *
 addr_to_vb_xa(unsigned long addr)
 {
-       int index = (addr / VMAP_BLOCK_SIZE) % num_possible_cpus();
+       int index = (addr / VMAP_BLOCK_SIZE) % nr_cpu_ids;
+       int cpu = cpumask_nth(index, cpu_possible_mask);

-       return &per_cpu(vmap_block_queue, index).vmap_blocks;
+       return &per_cpu(vmap_block_queue, cpu).vmap_blocks;
 }

 /*
<snip>

Thank you in advance!

--
Uladzislau Rezki
