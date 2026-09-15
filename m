Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851E3439F98
	for <sparclinux@vger.kernel.org>; Tue, 15 Sep 2026 17:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789494729; cv=pass; b=qfyW1+DRdU4rNAZLb+T7wokGgnkYTvg9aOV4vQ3mL+AXMQ3BVeMrUnT2b32++ZoYC9hvspJ0fzBchTQcxzQ58X47c+5GW2SFTG5spV7FYR7GKObQU7Y4fM94jK7KToHmiDFqshlN1fWoUuzUpLpnR7WhEJyBJOVajNyr3B9H4HI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789494729; c=relaxed/simple;
	bh=+4G5uXJmB7HF3o1L37WqbjganRxVa3Gn0saA7lTxNiM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wl7TMPFlJ8PPi2roC3Rx87K2x2ULHTKuVTh1/2F7eAdtQzKN91MOYGVEI6+ciWfY0qSMV8zPH0LB0SGf6FJYrCdCa7br8g10LF84WSzG6QajOQtxLtyLvezMXiU+F1buEcQWd+wXEhJH8Yu1FsOGMxTywxYniILVDPZDD1kY7LY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WPgx9Wh6; arc=pass smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WPgx9Wh6"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2db425c9050so12115ad.0
        for <sparclinux@vger.kernel.org>; Tue, 15 Sep 2026 10:52:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789494727; cv=none;
        d=google.com; s=arc-20260327;
        b=bYn9468BC8rUfWVARhmNTzeyUD4fwXjKztjb+uTpXzdXI1moHU0ej4kYny4fqIexcJ
         dD2DNxZsQyTa9sbo17x2CRy4RK8uZyEW1Wv6h2rp6KRrRK6NXmwUD2CXbbg7Jc+L2vI8
         pVZw3q5Z/85xrZisVyfuCYnva2mggmBnvYd7LmqVEYZuQ8AvMWBv4G0YzFW795jawI1D
         LZyTCgysFggAUEudZApglq/CMSXI/H5zhIlBtUPm+H626DDtj7oOdCMgfgRPTlVTdk/d
         r2rse4vzd97+fRnrypwFmURq1TY1O1bgpRHLtXj3l21kCvkRuZtjleUMA1yFDCm6NWnQ
         VDNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+4G5uXJmB7HF3o1L37WqbjganRxVa3Gn0saA7lTxNiM=;
        fh=ZUimOQfRsktL6wBiU5fPMa4AuaBGQDcP4Ksvppw1HfU=;
        b=OY+RfY6gLtDzBLzyFXGufJzOA0vBU0Q3VXcO2sZ+uHYxILPHFPauUw3XiTQ5/MJ+tb
         3A/QmnvnbRUksoyzuRoYw4wKiOC73dHyT67ApGxVWWhd7QLAZYzN6wZATcOjdm4xiOr+
         der0iOBAXiXaZOVTiktvmRynIWhlSsz8Kj2ie2xNoW4f6LCVdq5+wNGVjzEl7vpjg3rI
         5h29OGXq+3mJKcd39sPjCPCgACOU5ETBoTQlZuTZJDRCYk8i2x8DrQFmzD+WNeqfrEDZ
         p56QoZY0m5DmcLwYuGobd3JT/EQEWBRfn5RaXeqrm7duSWsSOnkzRFjkNo6UVZsSjuzu
         5NFA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789494727; x=1790099527; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+4G5uXJmB7HF3o1L37WqbjganRxVa3Gn0saA7lTxNiM=;
        b=WPgx9Wh6g8ehXMOaZf8ZSNtevHb9fzr3lXk5INKsJirqC99dpiARLSwTsIwHA4pbMW
         JbWx8MvBxDUFu6opqA60njTwuSet+XjH0Wga4OKXeEmVhOXoy61UWc3rqiL6EU8/l428
         EjMY1UqvowxmFEZiD+cpXVE0I3gM0Ssco82ZH8FSIs0h6jzSdSLoGG2b/9Ga+W+7Aup7
         R3Y2jKX2VRyqaVjVjF8po02JGQLWYioBTM31SQGX//CGOHsZjgwuKy0KaaC3tSzQflwo
         ISJi8sLOMT0xayOGlmIx3TnuUJAs8/tTEps0xY78QDJPw7a+XDrg4k1OSruo0M4Rr9uE
         eRpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789494727; x=1790099527;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+4G5uXJmB7HF3o1L37WqbjganRxVa3Gn0saA7lTxNiM=;
        b=pdHGQ/UZpIwclgfJuxsWLy56KD4PPe4tS9Z0pb2rdNPeMamT4kdbU2Z2UsdxljcWhU
         WDfHE0kgDSKQ7eIz/OA9hGxm9rOEM/mxLUEu3hqcMkHBfueL7rMdwL78fTDyAbMFIVms
         Ysfv09Pltg5MJaQvV16QmPFl8PyGngBfwxwovTCOJTS2PkPCcyi6i+KrgT0WK2KaHHag
         D28C+MlwaM/UmqCPdAe27t9EpmH/pV72LfTRxD/+DJFQp6ASShYoVLZY9pG8iGUUzMaL
         ybNX4ItO2G0kUvGqyxNMYk6+FMxI4qu88lsCpSqS2kt6+i88gcFoJLUpR1ICAWHzzkF7
         twXQ==
X-Forwarded-Encrypted: i=1; AKwUvBwYSKnr3/4ZIlZ37XYioJpLTD5V2c+WBi64l3L7zBf4dq4M8MaShN9guLrAyVTNFbWkzZF/D+2zEM0K@vger.kernel.org
X-Gm-Message-State: AFuF++nCLA6+uxwSDSHZUlbIKcYl6STRxzj4zyp+ThLwPt+bQbRSDg6Z
	uoKNIF9jNoXw+lg+sE8I9Jmt5ZMvzsMSRBluR4Ldj2aDNrR6PYQNAbJzIb0z7mSAWwKXOSr/Jwm
	xuuIVIfBs1jif7tVhoRQAq038DWp7o9fQYkGKJMIj
X-Gm-Gg: AYBFou28H1liEVhZUS57Qk1Cc3oXrAXEgKnhIipBGn6ufFsuDLur1wj56oFdqGNbNeb
	Ul4kaxs1O2V5E8f9xhguxUGM3X+3Owb/1iJm9JeLjMEAfk6zkxAWrmuM61llOGe3kblIAOsGYy4
	oeD+Xbup1zq3rq1xvMEon42cEAo8pb/oD0YwtPcqfImOwC7MkZ/uANPWPILvvHEZeKZfuMh948l
	tyoigRgJzJG1NGxofjK4xCaNmVD1AiFhcfB0hlivIKHmogxfoxOWiFOsyB5wZN6x8Mb2SZA2cMS
	gzb/NGEQXRqIjT2T+6iZc00uzBzTa/lqrLWcRTTrY5NLZ/U476hmtCxQVhfEMXn0YNo+jt7a+Gu
	dDL4NBuQesr+dKsNT+EbdXANtDWpr1zx1YXDVXosKA+58T6LXWBs=
X-Received: by 2002:a17:902:f612:b0:2dd:5363:31ec with SMTP id
 d9443c01a7336-2dd89c0c38amr177395ad.14.1789494726332; Tue, 15 Sep 2026
 10:52:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Tue, 15 Sep 2026 19:51:27 +0200
X-Gm-Features: AcwNN1Vhgv53PI2-XyXtJBbVzCNkGiiWjtvOE2b-8zHim7-UybJ3H2xniPj1VUE
Message-ID: <CAG48ez1RsdT=O=-0city3vjgWhDvY424KtTmrCJntWy5ds3HBQ@mail.gmail.com>
Subject: Re: [PATCH RFC POC 00/50] file: handle files on syscall exit
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Oleg Nesterov <oleg@redhat.com>, linux-alpha@vger.kernel.org, 
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
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 1:31=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
> TL;DR, this lets arch code handle fd install and cleanup. fd_prepare()
> allocates a descriptor like get_unused_fd_flags() does and records it in
> a slot on the task. fd_stage() attaches the file to that slot and
> returns the number.

I'm not really a fan but I feel like if you want to do this, you
should be using task_work so you don't have to touch the entry/exit
paths directly? (And if task_work is too inefficient somehow, you
could tinker with the task_work implementation.)

> When the syscall returns success the exit path installs every staged
> file. When it returns an error it drops the descriptors and the files.

Is this mainly about stuff like "we installed a file descriptor and
then the following put_user() failed"? Because if so, I think a nicer
fix would be to have a policy of "if userspace provides unwritable
memory to a syscall, just keep going and pretend the access worked",
and maybe have a sysctl that kills the process when this happens to
emphasize that userspace should not be doing this.
