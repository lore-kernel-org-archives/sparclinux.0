Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683ED137C2A;
	Mon, 24 Jun 2024 12:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719231649; cv=none; b=AvbUgWcaFjiVC4hH20I2wsC2G2FCCYpMGlyNlzLAuhYSI9XeHDiBqeUF2CnO/GrOowc9RwJPna1JJrP8oypvHYAAsNCV03YoOFJ9I9AYNGQw14aUnG1hz7KyMRaKoSbQdn9MbxkZByfmRcDIL+/v2YlkT9KprNi/MwpdO+8EkPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719231649; c=relaxed/simple;
	bh=BzYVs4L6KpDuCZziyHHbj2IqHKvwwMV1R9l33WlK0HU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hQQ6/fLH+qv4iuyKsHMboxhzGwteKWLl5u+uUZeJhRe7U3Zs2JViTv4iytDMYhLXY5jc72PhgsxyCFxrejpgcdWfdeH77FB1OoUDweVyXdTJbLaivGNj3LpOh+JwZHQ1pJ62CgOcV5IiuXQbARmhLhox+NqwXmh5m1ZqYdcOlPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hqX5dBrA; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hqX5dBrA"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ec59193468so12134031fa.1;
        Mon, 24 Jun 2024 05:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719231645; x=1719836445; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TSI4KQV7tp+wxmh1FMoXKiaVJwFpmSl7UPXF+v3NqxA=;
        b=hqX5dBrA0nEX343JqqaKg3iPY1WkqygULyJj2+jzunoTPIRTPSFIwgkZbQwDTOQnLM
         5AT++9Uxle3cSIIzQlpEhvt5XhdQsATXes0fQHt5maTbpIplpIQA0/SPLczb4vnse4+A
         a7y1DSUgC2Ifjoppy15VTZ5T8gHSRHaKCCX0vZDW1/zDrk1Qy4Yxj/5cUEph3b9elxKT
         iMfyx5e4SdQtcHGh8f0vlRJJB2EHZ11avNasemQ4VRKM0lvrjgKSpRletYDsftaHWa0L
         VR2xYKvm0LjOU/4BUnaNoXiBkMt1gN7L71ps1psqmRa4Yx0cYzxcVK46YRbMWdLXyJ3d
         2mhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719231645; x=1719836445;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TSI4KQV7tp+wxmh1FMoXKiaVJwFpmSl7UPXF+v3NqxA=;
        b=BWpat0ts11UE1dfVngT+wlEY1PtZXoY6YD8dOicH5dm2Udw+4jdQKH5vT02lwAwbUc
         y1cQgSs3miOHKADive2WjrU3MTlMKCYDnxbz7h6Au2Q3Q06K3rgrtYaKwWn91Rp6uL8h
         2qlRNQKng9k8wDx+M9WEJZ4JWzypJYc6OHYig3beyxQw7LdWwKyNEaEGAUx+PvasQPFt
         F+mqaOgdCJ7Wf+xFxVgzsTFyZj863zOT72TLUX8EXOGL96+QLSZ8Bn5exqzG+rU/ztky
         EGNXCTaivWB6J5sQvhg3O5AVcFbaEqdoKjH6xgsO/AIhju2c65jbIPLDd4hjwbPYiCrI
         FxHw==
X-Forwarded-Encrypted: i=1; AJvYcCUPBXRD7PiWx2tLsSQoaZlPAtIfiUvFkMTO7cjKP8G3DGK3BVLa9Ku/Y1ycBU9hhg/IztLMYyVCw12zuWjDL5MxxQeVm+kX6D1Btg==
X-Gm-Message-State: AOJu0YwXHIcK3IWeawxgygqegxz6VJ47McKb+7dZDLrGv1FaEfpF9aZX
	Zexgibravqd4qRKFprMRYH2LFr4sfqH8k2IWxuCx4k9/gkkM0eaN
X-Google-Smtp-Source: AGHT+IEOEr0sFekIupSP3xekgic9S7PT2e9fYoRzjDiwd7jQcu7Ky0Mjk2cBkuub50BcjRZKEkBxKQ==
X-Received: by 2002:a2e:9b0b:0:b0:2ec:5364:c792 with SMTP id 38308e7fff4ca-2ec56c86e7cmr16601251fa.13.1719231645324;
        Mon, 24 Jun 2024 05:20:45 -0700 (PDT)
Received: from pc636 (host-90-233-219-252.mobileonline.telia.com. [90.233.219.252])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec63baecafsm1388471fa.122.2024.06.24.05.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 05:20:44 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Mon, 24 Jun 2024 14:20:42 +0200
To: Nick Bowler <nbowler@draconx.ca>
Cc: linux-kernel@vger.kernel.org,
	Linux regressions mailing list <regressions@lists.linux.dev>,
	linux-mm@kvack.org, sparclinux@vger.kernel.org,
	"Uladzislau Rezki (Sony)" <urezki@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: PROBLEM: kernel crashes when running xfsdump since ~6.4
Message-ID: <ZnlkmkDAi2CtgwDF@pc636>
References: <75e17b57-1178-4288-b792-4ae68b19915e@draconx.ca>
 <00d74f24-c49c-460e-871c-d5af64701306@draconx.ca>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00d74f24-c49c-460e-871c-d5af64701306@draconx.ca>

> On 2024-06-20 02:19, Nick Bowler wrote:
> > After upgrading my sparc to 6.9.5 I noticed that attempting to run
> > xfsdump instantly (within a couple seconds) and reliably crashes the
> > kernel.  The same problem is also observed on 6.10-rc4.
> [...]
> >   062eacf57ad91b5c272f89dc964fd6dd9715ea7d is the first bad commit
> >   commit 062eacf57ad91b5c272f89dc964fd6dd9715ea7d
> >   Author: Uladzislau Rezki (Sony) <urezki@gmail.com>
> >   Date:   Thu Mar 30 21:06:38 2023 +0200
> >   
> >       mm: vmalloc: remove a global vmap_blocks xarray
> 
> I think I might see what is happening here.
> 
> On this machine, there are two CPUs numbered 0 and 2 (there is no CPU1).
> 
> The per-cpu variables in mm/vmalloc.c are initialized like this, in
> vmalloc_init
> 
>   for_each_possible_cpu(i) {
>     /* ... */
>     vbq = &per_cpu(vmap_block_queue, i);
>     /* initialize stuff in vbq */
>   }
> 
> This loops over the set bits of cpu_possible_mask, bits 0 and 2 are set,
> so it initializes stuff with i=0 and i=2, skipping i=1 (I added prints to
> confirm this).
> 
> Then, in vm_map_ram, with the problematic change it calls the new
> function addr_to_vb_xa, which does this:
> 
>   int index = (addr / VMAP_BLOCK_SIZE) % num_possible_cpus();
>   return &per_cpu(vmap_block_queue, index).vmap_blocks;
> 
> The num_possible_cpus() function counts the number of set bits in
> cpu_possible_mask, so it returns 2.  Thus, index is either 0 or 1, which
> does not correspond to what was initialized (0 or 2).  The crash occurs
> when the computed index is 1 in this function.  In this case, the
> returned value appears to be garbage (I added prints to confirm this).
> 
> If I change addr_to_vb_xa function to this:
> 
>   int index = ((addr / VMAP_BLOCK_SIZE) & 1) << 1; /* 0 or 2 */
>   return &per_cpu(vmap_block_queue, index).vmap_blocks;
> 
> xfsdump is working again.
> 
Could you please test below?

<snip>
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 5d3aa2dc88a8..1733946f7a12 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -5087,7 +5087,13 @@ void __init vmalloc_init(void)
         */
        vmap_area_cachep = KMEM_CACHE(vmap_area, SLAB_PANIC);

-       for_each_possible_cpu(i) {
+       /*
+        * We use "nr_cpu_ids" here because some architectures
+        * may have "gaps" in cpu-possible-mask. It is OK for
+        * per-cpu approaches but is not OK for cases where it
+        * can be used as hashes also.
+        */
+       for (i = 0; i < nr_cpu_ids; i++) {
                struct vmap_block_queue *vbq;
                struct vfree_deferred *p;
<snip>

Thank you in advance and i really appreciate for finding this
issue!

--
Uladzislau Rezki
