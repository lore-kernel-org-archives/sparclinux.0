Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BD23955F4
	for <sparclinux@vger.kernel.org>; Tue, 15 Sep 2026 16:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789488626; cv=none; b=tMBVsB4MOdBX9MKFszuoiykQbWTRVOUVvt9S3eVSXTda0vz0DGs52kHohzwnUruVyn1DtMYaeMK19bjoOfYMX7jVtppIQDgBICT0uagF3BNFrUzLu5xkBU/eKen0NECGlYlHUfEPtLzKraifxphP0aLwHy0kwhb1UusX/SfR3VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789488626; c=relaxed/simple;
	bh=TaD3IKHcoZf0PQ+wUUh3mHvOgYZf6uXYuUZRFHNcE+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hl7R9MvrRQRutXqGa/07yqu+p38FFbZgwdzE5XrpgYLPnzsPG058zq5I4Xs55Cwas/KVZSqITPf5l602yv2Q60PFOFa5bSB13/u+UnBymDYOP1teu8GhuAbx5TohUslq1iwWA+YnTfEBFGdvWN2dEa5/NoL494NZ/QCb/xQjVl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=S0+X+h/r; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="S0+X+h/r"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c264788fd58so555640666b.1
        for <sparclinux@vger.kernel.org>; Tue, 15 Sep 2026 09:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1789488621; x=1790093421; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cj8iWYGkmy9fr6Sp+MjBMi0cvssqzarl8Tgut8FUMEc=;
        b=S0+X+h/rnKOcjDIPfCrcHZ9O4Ym4cTnG+GCDXy105OawXTdBdGDgySuvJDcRwmtI+n
         Zsz/XrEcM9GYpcu7JrSI33TvkCDxqw3J7BzYrzsr/0HmI2jsinbc9N0Ebr9WeV3SeNM3
         JXZug+SMra1+rr6EWL8QLTPr5wpFfM/hcxvCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789488621; x=1790093421;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cj8iWYGkmy9fr6Sp+MjBMi0cvssqzarl8Tgut8FUMEc=;
        b=eSejZCoxj4Mkcbxuz+gXNlSJzik4xrO6xD33Il3lCODPaKb01hhAIruejX+zZ9GGMi
         2yHRxmZLkXLWPtO2+cMkIj5kakisGiCoBnKh51ixiRoYNV9ayKxNsZGho1nZXBa4B/M5
         g4Gofs/RoR9nKpJloaf6MvT+95vjUalDmHfll8ocn8+QYa8XhMS8T+cFwwBWvf65LrYP
         2P9ivAKl0/ORNCvxVor1O3hdyUpjhnak2u7NIt2aEh/cuL/CspxnMKTLHfj0gjEnpw9p
         qdlO+R0GVFsa0HaV9SPokOWS+7OqMSIX4nW9EHX7T7wHmgQWpXlWhFjm79UdxjYX3OPx
         d3iw==
X-Forwarded-Encrypted: i=1; AKwUvByxIFvEYY03jrcJilTiu3wIGxBPeXcPteO5Bg3sSkwRQQtHzb+mvBv/3uXUV0pp5u5zJdrWH1vkDlXi@vger.kernel.org
X-Gm-Message-State: AFuF++ndY/L3B1jIqXdLl/SjCPo/2d3drN78HPm20A3k/tWybtVcmJq2
	X5ob6R78cLyqbDljhNW/pdt6I9d6LXSTVbXCGBKPI/GMdqMBrwDOEKXdFiHZCqHO803XUQrrFdZ
	jT74pPrs=
X-Gm-Gg: AYBFou2TiqEsfx/zx4H2VqD25QyeejCx3w6yRzjs+hVQCohX5rYkXH4Vl+E8b9s5qCZ
	fTUDan97HK9HxpTrklaGMZ3WdeAZ/JjSy8vxnVDN3Y6YgekQEs9ey9+fI0f5GSuFWwImmofablr
	AzlNlJWORaOvd5Uh5XJi6+f2usHeTd0EZGJLdbumwWu20Wq1jZuxtNYP07sfnrImx+e5vC30Yih
	SIzo9bER2LWjzrgUpt+AgbqV9Rfp+PQHTf5oq4wdK+I8ok9YAsCloC6kB25OiOIotTzfu5V2Mk3
	dMRnJ+izz+6Kx466LwJhZPADRNczYGStSuBJOyB7RipgG2C4TBLFWxiLfhErkhKEdY38qQ2I9TU
	VxrWc+wOeU3vzp/6CAUcaxbXDIeAE9LQRRiGRtGa6078BYzkEAigKLSqM+Ks3hf5nQGlONvVkvQ
	b3QkVbgdQW4DxWraHyLaZReZubMeD2Aj8VyHKGIadS53FxrdQNSIJukD8cg9feEK1Fjy5/3cVty
	djJkAuRCN7ci03ftoMKqSEdkj8aHErN3WiXRRaShOEcmvl9/A==
X-Received: by 2002:a17:907:9488:b0:c25:64ea:4d70 with SMTP id a640c23a62f3a-c29b84de7f3mr538236966b.1.1789488620744;
        Tue, 15 Sep 2026 09:10:20 -0700 (PDT)
Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com. [74.125.228.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c29de63bfd0sm596066b.52.2026.09.15.09.10.20
        for <sparclinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2026 09:10:20 -0700 (PDT)
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c293c683202so503555066b.3
        for <sparclinux@vger.kernel.org>; Tue, 15 Sep 2026 09:10:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBySg/PVaVslf94PsW8RKSRe48Eq3+6nWFNtm4aVQWMUhKPFh6W4kntjb+iNeVp0e+fI0y0TCrsrvqs1@vger.kernel.org
X-Received: by 2002:a17:907:cd0d:b0:c29:439b:d5c1 with SMTP id
 a640c23a62f3a-c29b86141b9mr553591866b.16.1789488168046; Tue, 15 Sep 2026
 09:02:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 15 Sep 2026 09:02:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjeamU=_RYT9cR3dZJ2N-Teo-N1+aYh7jwhrB=iWXD0cg@mail.gmail.com>
X-Gm-Features: AcwNN1WK06t9f9BcKFBIanysXcyUXK4eRICuH4x14s60AdlpF6ijCATIYaYAAvQ
Message-ID: <CAHk-=wjeamU=_RYT9cR3dZJ2N-Teo-N1+aYh7jwhrB=iWXD0cg@mail.gmail.com>
Subject: Re: [PATCH RFC POC 00/50] file: handle files on syscall exit
To: Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jann Horn <jannh@google.com>, Jan Kara <jack@suse.cz>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Oleg Nesterov <oleg@redhat.com>, linux-alpha@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org, 
	netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, bpf@vger.kernel.org, 
	David Airlie <airlied@redhat.com>, virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	kexec@lists.infradead.org, linux-hyperv@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 15 Sept 2026 at 04:31, Christian Brauner <brauner@kernel.org> wrote:
>
> TL;DR, this lets arch code handle fd install and cleanup. fd_prepare()
> allocates a descriptor like get_unused_fd_flags() does and records it in
> a slot on the task. fd_stage() attaches the file to that slot and
> returns the number.

Honestly, I am *not* a fan. At all.

I think this adds complexity rather than removing it.

The diffstat tells a story:

>  106 files changed, 962 insertions(+), 861 deletions(-)

in how this adds a hundred lines more than it deletes.

But to make things worse, it adds them in bad places: low-level
architecture assembly code.

Those extra lines are *not* making complicated code simpler. Quite the
reverse. They are taking fairly straightforward "just deal with errors
with normal cleanup in the place where it makes sense" and makes the
*straightforward* case simpler, while making the big picture more
complicated and subtle, and adding new code to places that are not
simple and just blindly do somethign that makes no sense in that
context.

IOW: it's more code, and it's more abstraction, and it DOES NOT HELP.

And yes, most of the well-maintained modern platforms (read: x86 and
arm64) use the generic infrastructure and they don't show that
low-level asm effect. So for those cases, it's mainly just  that added
conceptual complexity and a new odd rule - and makes a *successful*
system call go through that "extra work" and indirection phase that it
didn't use to go through.

So it just spreads out the work, and moves it to a less obvious place.

All for the very questionable advantage that you can now randomly add
a file descriptor without the few lines of fairly straightforward
rollback.

IOW, I do not see a single real upside to this, and I see immediate
downsides to it, and a more abstract complicated machinery.

I do *not* see why we woudl want to make this be a "every system call
exit" kind of thing. If there are places that think it's complicated
to do, they could have *their* local little stack of fd's pending. Why
force it onto the low-level system call entry for every system call
when there are only a small handful of actual real cases (the vfs
itself, and random ioctl's by odd driver subsystems).

              Linus
