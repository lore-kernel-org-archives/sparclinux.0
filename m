Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7D64776A;
	Mon, 24 Jun 2024 12:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719231463; cv=none; b=JojriDa0ftOZeCIWwjpYaSybSODOqwpdbH3C2tiEpxjIDuxRBCpazv76YYf/MR3ApfgztEcdc1Rp6iWJjKir6Dtt3saFWNAAUWVywEa8Wm2JaxpoNdne/UYc18g4ZSquzhhwMdhTtmIBwXzHTAaemX0tz7jEofH4OsK4670SGZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719231463; c=relaxed/simple;
	bh=8isc60jFDMeop4LN4TyUF39/5jrEisrf7Jddr2pusSI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i2QNmcmTQ1Gq5edw96J3RyZaqfAS+mYt/rRAo2eb6zdEh3shtfzYgiMXjaJIh1Ms2bsSguslN7Kzfi6VdXBXKomUaekf2pgCNWq6H/FyR0pkFLIOwmTwBKs9hjd2BngR9fmVl6TD0elLB9ox1ox/YM2IjlZ8tOZcQ0zB+mNzSgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nddWPtMb; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nddWPtMb"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52ce01403f6so1609577e87.0;
        Mon, 24 Jun 2024 05:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719231460; x=1719836260; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=od+jH6L9t73h5zcRVnTnTfDsZO/0F05mRIypT0waugI=;
        b=nddWPtMbev4kDtDuwHlFA3Z9D98GcR6QJHOXA53CSPfX3eSIazMGpl+xCUJsIXezVE
         57PBSwvjPVYsM4s+idAxgSOwRqKW6ucUT3Y8xgtMQT4gUxbzhSNq6k2SWhfrWOVGIKXC
         HBV2SqqIItrixaJOkROhOstD7XJwp95scMtboVDqbhNQtXCK7rlph4fJvcCY5QhCcA93
         RMqBIG45ukuhCJhktMwAoeOuRkRlVWKUOuU91rhjuZeuvVol1jbrI+IHqLKzav+h3Jk5
         8WNCb3hNeQ8H4YOC/HJjLiBg8UAhDV6uQokdZgLXwjF3lYb7yxjUfWhpWN28KH2iPx4I
         K1ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719231460; x=1719836260;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=od+jH6L9t73h5zcRVnTnTfDsZO/0F05mRIypT0waugI=;
        b=aDuH8uVvxenpNSu7vjaZinLbsqUvZrPKlHkQe/HvLzFwYu4ev7Frb17aVpz1lNapQV
         xu4wVSZ9ZmOVEFGy7Vel8fjAjJj9fgEwE34pEBslijtAwyH1+nTdghtpeADRIkqK4aOP
         dL1gncta5a7IUOPLt+iG/A/q6Vy3qSF2FLfYgcMCgLknsXF+up6fGzEfIUcppm1uYgNf
         s0GL6nFMKAgYg/xp9kldBWWiUSt5PHc8duCbaaBydOptzWrFFDD29VqkOdYyr7pFgBAr
         W8mB9xCeM0FJk7egIg4urwWNK3zKCxfKZVaKFLy9g1gi5k5f15AiX5CsK7nafpmJsc7S
         PnDw==
X-Forwarded-Encrypted: i=1; AJvYcCUaKm2m06VVu27+KHk3T3lMzaSqkBVDLxOToEKFXMJ1Vt6c8DjBQLJ8FW/ZTFA8EsR7IOjEGg7Vxv4M04+HiaJiKWddWY9iYLazbGI22mh6+bFjRy/N0PziHkahq3O9/vsnCOcCkUqK9g==
X-Gm-Message-State: AOJu0YzngwfyLg1tPVHuYzkED2hgDzLAkhhWG14UXzw3ABm5ewo9TLAO
	an02z7t1Y8wRIEVFkRjDDwCdl8Iol0A/ePLT2ksG2UrtEQqq5zLBkuDm+w==
X-Google-Smtp-Source: AGHT+IHcVpH3CudI+W5MvprM1/PmweuKVDd3GbvgLYGCPocT+n9ET+XbztV/qerkXuZ6NHsNPBrR+g==
X-Received: by 2002:a05:6512:55c:b0:52c:d9c6:f934 with SMTP id 2adb3069b0e04-52ce18356e5mr2532189e87.18.1719231459616;
        Mon, 24 Jun 2024 05:17:39 -0700 (PDT)
Received: from pc636 (host-90-233-219-252.mobileonline.telia.com. [90.233.219.252])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ce17c3821sm470190e87.241.2024.06.24.05.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 05:17:39 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Mon, 24 Jun 2024 14:17:37 +0200
To: Michael Kelley <mhklinux@outlook.com>
Cc: Uladzislau Rezki <urezki@gmail.com>, Baoquan He <bhe@redhat.com>,
	Nick Bowler <nbowler@draconx.ca>,
	Hailong Liu <hailong.liu@oppo.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Linux regressions mailing list <regressions@lists.linux.dev>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: PROBLEM: kernel crashes when running xfsdump since ~6.4
Message-ID: <Znlj4YTzoT08XJHH@pc636>
References: <75e17b57-1178-4288-b792-4ae68b19915e@draconx.ca>
 <00d74f24-c49c-460e-871c-d5af64701306@draconx.ca>
 <20240621033005.6mccm7waduelb4m5@oppo.com>
 <ZnUmpMbCBFWnvaEz@MiWiFi-R3L-srv>
 <ZnVLbCCkvhf5GaTf@pc636>
 <SN6PR02MB4157D2FA39A5491C915D186FD4C92@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB4157D2FA39A5491C915D186FD4C92@SN6PR02MB4157.namprd02.prod.outlook.com>

On Fri, Jun 21, 2024 at 01:42:28PM +0000, Michael Kelley wrote:
> From: Uladzislau Rezki <urezki@gmail.com> Sent: Friday, June 21, 2024 2:44 AM
> > 
> > On Fri, Jun 21, 2024 at 03:07:16PM +0800, Baoquan He wrote:
> > > On 06/21/24 at 11:30am, Hailong Liu wrote:
> > > > On Thu, 20. Jun 14:02, Nick Bowler wrote:
> > > > > On 2024-06-20 02:19, Nick Bowler wrote:
> 
> [snip]
> 
> > > > > The per-cpu variables in mm/vmalloc.c are initialized like this, in
> > > > > vmalloc_init
> > > > >
> > > > >   for_each_possible_cpu(i) {
> > > > >     /* ... */
> > > > >     vbq = &per_cpu(vmap_block_queue, i);
> > > > >     /* initialize stuff in vbq */
> > > > >   }
> > > > >
> > > > > This loops over the set bits of cpu_possible_mask, bits 0 and 2 are set,
> > > > > so it initializes stuff with i=0 and i=2, skipping i=1 (I added prints to
> > > > > confirm this).
> > > > >
> > > > > Then, in vm_map_ram, with the problematic change it calls the new
> > > > > function addr_to_vb_xa, which does this:
> > > > >
> > > > >   int index = (addr / VMAP_BLOCK_SIZE) % num_possible_cpus();
> > > > >   return &per_cpu(vmap_block_queue, index).vmap_blocks;
> > > > >
> > > > > The num_possible_cpus() function counts the number of set bits in
> > > > > cpu_possible_mask, so it returns 2.  Thus, index is either 0 or 1, which
> > > > > does not correspond to what was initialized (0 or 2).  The crash occurs
> > > > > when the computed index is 1 in this function.  In this case, the
> > > > > returned value appears to be garbage (I added prints to confirm this).
> > >
> > > This is a great catch.
> > >
> > Indeed :)
> > 
> 
> +1
> 
> More broadly, throughout kernel code there are a number of places
> that incorrectly assume the cpu_possible_mask has no gaps in it. The
> typical case does kcalloc() or kmalloc_array() with num_possible_cpus()
> as the first argument, then indexes into the allocated array with a CPU
> number from smp_processor_id() or a variant. These places should be
> using nr_cpu_ids instead of num_possible_cpus().
> 
> I'm usually working on the code for Linux guests on Hyper-V, and
> there are six occurrences in that code. While they probably don't
> have immediate practical impact because I don't think the ACPI MADT
> in a such a VM would have a gap in the processor enumeration,
> I'm planning to do fixes in the interest of general correctness.
> 
Thank you for valuable information!

--
Uladzislau Rezki
