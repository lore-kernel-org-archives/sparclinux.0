Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F6514A4FF;
	Tue, 25 Jun 2024 09:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719309342; cv=none; b=ERwkLdM0woTD8j9chXDJkQI0zdLn/60tIUk3wMmjyMYEM/fbrNL9fOC9uzHiUMXFbqm6T26sziV4UckYzysSZBLVHujN+4VquEGfSbhVebblmhOzwHbHySJHhuZpa3BI5Q5m9BiCqqyGKxt/zVEiQPf5+WwaNb44Y9ZHumJ1oB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719309342; c=relaxed/simple;
	bh=5GSjkAsYu/hzXKXjxyztHTxUXS3GjYOhaLYPSlTbE4M=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hFOFruDLbNGyjzXDvIlGzoWxomG6uRF3WAHQ2X46pZJXZCw/B4LzCutTLWenJOtJG/LqPLVNe9bf3837jjFI4KQ6iEPwYzDjJyeCL9MFkBA6+sdvNd4WUW0e8+p3aPMGfYBMIDn5mheQ/t6NPD7IY7KHIySBD55448v8WOCGpso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ivpu298P; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ivpu298P"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2e72224c395so58565541fa.3;
        Tue, 25 Jun 2024 02:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719309339; x=1719914139; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gfQp3tHSHToj1eIsyyv3AOWK2ep4ErUvO8iv0wMJcac=;
        b=ivpu298PSlqrkWjMxMAWbbJzMzNSYi2/WejVRLCnikIZ81TE6i3RFkQZdTRXBxst9M
         ZSE7ttJ7c+8WS4haojgvFs5607w7VmoQbAQEJq7a+uwvCuU78vrCipPl2vh47CXitAVI
         Qokd/FJk56xmN2AYuzRgWwR682B7BcIvPydRFVrzKa86xdRj9QPUpqA+ZAAyfJa6WbVe
         QX9Vl6ddYsnvU7Vkhw3XOHW1IKH0pWiTDIv7T2FysZ9Wq+W4b9R4sbwg6zIXpsmIEstF
         6CiNRLmM7EKmfb4SQKV8qQSXgegcWt2207iWqGbnrb549ocVTt7GuopAisJpQ2JbqK/+
         gxHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719309339; x=1719914139;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gfQp3tHSHToj1eIsyyv3AOWK2ep4ErUvO8iv0wMJcac=;
        b=QKGgcrZmZ45OHyOZ7H63+tG2ohjjt/AnXYnxB3+XyGbxGZHKN3rAYoY6eFSKScwYv6
         yT3nNEY/UdhmLVgjZvQj8dNN3knr+GX31a8cNhJXZmaCQDkYgIWRr+eiYUBnLqnOl3eV
         bvUl7g5sCmdsfQb6YWcsSAWCfVK+CwACYYAHp6Nndgl9JNfFkFQWBoLJKpmB5MTYTJsL
         Cj+O3EgijzM/tr+9j21w1oFJfAf0o3PEoYEABDSGEAVcV6gp9VLz8JFNy/OrmyqluoIP
         7Euu8YzOoavtB9hrMBkxJSUlJu1wl0QOMOXN0FOef23xB6EZrH9LeupTp75mWLZ+GtYR
         ls7g==
X-Forwarded-Encrypted: i=1; AJvYcCXVXkHNx7TIS4oTHR9AVnEqp8lv1Clg3b4+Xp/+6+hUv2PRPs9M+KwyJ2KHrVOIkiFgJCA3TkBDZTVJwGze+5UzrsizCN/2FB1ZcYZZnLmR0UZorm2BaKI/g7BZVhfx00n+c76MlmSXYw==
X-Gm-Message-State: AOJu0YytAEcXAo/Y82iz/+x9upQcO5qlF1iqsof++gxRGqL5mBuR6dao
	FWd7lcwynaZAWMchMLhgjxcZUF9n2aaUm8wtwQ8uGdNSJiCs5Vbg
X-Google-Smtp-Source: AGHT+IFDyTMqAyCzv4pa7W+j1ChiYbIQFSUuiDfMgLet2zKOii0moGRZ7U4DIe72eYKnmsBvJ0cFFA==
X-Received: by 2002:ac2:5311:0:b0:52c:8479:21fb with SMTP id 2adb3069b0e04-52ce1835594mr3967757e87.27.1719309338345;
        Tue, 25 Jun 2024 02:55:38 -0700 (PDT)
Received: from pc636 (host-90-233-219-252.mobileonline.telia.com. [90.233.219.252])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ce042dcd1sm761886e87.70.2024.06.25.02.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 02:55:37 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Tue, 25 Jun 2024 11:55:35 +0200
To: Hailong Liu <hailong.liu@oppo.com>, Baoquan He <bhe@redhat.com>
Cc: Uladzislau Rezki <urezki@gmail.com>, Baoquan He <bhe@redhat.com>,
	Nick Bowler <nbowler@draconx.ca>, linux-kernel@vger.kernel.org,
	Linux regressions mailing list <regressions@lists.linux.dev>,
	linux-mm@kvack.org, sparclinux@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: PROBLEM: kernel crashes when running xfsdump since ~6.4
Message-ID: <ZnqUF14C_2RH71wu@pc636>
References: <75e17b57-1178-4288-b792-4ae68b19915e@draconx.ca>
 <00d74f24-c49c-460e-871c-d5af64701306@draconx.ca>
 <20240621033005.6mccm7waduelb4m5@oppo.com>
 <ZnUmpMbCBFWnvaEz@MiWiFi-R3L-srv>
 <ZnVLbCCkvhf5GaTf@pc636>
 <20240621111545.awvgrap2nscgehxv@oppo.com>
 <ZnlkIy4XuzGBKinQ@pc636>
 <20240625092601.uo7266gp5joluyg5@oppo.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625092601.uo7266gp5joluyg5@oppo.com>

On Tue, Jun 25, 2024 at 05:26:01PM +0800, Hailong Liu wrote:
> On Mon, 24. Jun 14:18, Uladzislau Rezki wrote:
> > >
> > > IMO, I thought we can fix this by following.
> > > It doesn't initialize unused variables and utilize the percpu xarray. If I said
> > > anything wrong, please do let me know. I can learn a lot from you all :).
> > >
> > >
> > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > index 11fe5ea208aa..f9f981674b2d 100644
> > > --- a/mm/vmalloc.c
> > > +++ b/mm/vmalloc.c
> > > @@ -4480,17 +4480,21 @@ void __init vmalloc_init(void)
> > >          */
> > >         vmap_area_cachep = KMEM_CACHE(vmap_area, SLAB_PANIC);
> > >
> > > -       for_each_possible_cpu(i) {
> > > +       for (i = 0; i < nr_cpu_ids; i++) {
> > >                 struct vmap_block_queue *vbq;
> > >                 struct vfree_deferred *p;
> > >
> > >                 vbq = &per_cpu(vmap_block_queue, i);
> > > +               xa_init(&vbq->vmap_blocks);
> > > +
> > > +               if (!cpu_possible(i))
> > Why do you need such check?
> IIUC, take this issue as example, cpumask is b101 and nr_cpu_id is
> 3, if i = 1, There is no need to initialize unused variables here;
> initializing the xarray for the hash index is sufficient.
>
But. It does not make much sense to skip initialization or keep it "half"
initialized. At least we can guarantee that all data structures are properly
setup.

One concern is what Baoquan raised about per-cpu variables. In your
scenario, b101, accessing to second per-cpu variable is not allowed.

So, we need properly check that concern.

--
Uladzislau Rezki
