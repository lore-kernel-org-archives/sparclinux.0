Received: from mail-lr2-f13.google.com (mail-lr2-f13.google.com [74.125.230.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE6038734A
	for <sparclinux@vger.kernel.org>; Tue, 15 Sep 2026 23:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789513352; cv=none; b=KolC/vg/Std3Bsm9ArQsv+TleTmA2uAht03MgQ1qeTaPtRex1e0ruzTAkBu+HOassAn/Q/ET8Vupwxu1EZ02i8OTLP8uNhRkkY0yPNeeYy7CJOe/R6tkJ9/oBu6a2QkfwOAxRqv/UXtiyEiK7BgdEgqrJ7MTFx0YULa5/2h/YaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789513352; c=relaxed/simple;
	bh=ITz7hBythv5OWTbmQ9c4e1mzRPysX2+YTMbCrseTj6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ov9P7KBb4rP1IjKJoki+5ISOV1PgjvJM7Fz10EkAIFVfGKPpCxlq6wIk4F2cOQ10+QPb4KnMgoubNs9pm6dE3A/Sh2PdWnWpMJt/cs0CiERoYuEPgfTKMX4utzwsyeicF76ymkMJ4deGEjsH5syvP6iE1Z6n17edBhGle7M4L2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=VHq09vpM; arc=none smtp.client-ip=74.125.230.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VHq09vpM"
Received: by mail-lr2-f13.google.com with SMTP id 38308e7fff4ca-3a5a04b88e9so3099811fa.0
        for <sparclinux@vger.kernel.org>; Tue, 15 Sep 2026 16:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1789513348; x=1790118148; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7NEEN5klK6sYQ7k8fj+V0z2WeSFVNwjy5fJJIdfiMPQ=;
        b=VHq09vpMKSxVgr4SeIaZJHXCX67KF0A5yRyhXYmnZ2urgTE3TkZ6jMSFsFUreWHGxv
         qraVKo9yI+2Io8dOwRyELCMf2r9ouQnj3qpwBk4fSwRxBVOsOR2dDHirXCoE6A5i7JY2
         wTRxqMt90ARTg8N+UpMrjfPklQB73INqAtDJg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789513348; x=1790118148;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7NEEN5klK6sYQ7k8fj+V0z2WeSFVNwjy5fJJIdfiMPQ=;
        b=Z3EfamMjSM7HOOzLCDTnwcA3ygCB2csdXkTIJs/l5FFcBZpJEbWAZI5DBDhPpdXlJZ
         9EgvEz1Lwjw1D+lCCztyJJserk9lbEzSObVa2J3CMavs3wEU1QgcQ8MbOlImA95DDori
         hyc6CZaBXl6BWWphAQrCODNdcIkGYRBsL9wEGibGEmxp2wrm5Xv/Aqw4L0gRzes9rMoF
         D9MkiNe7/6gXGcO31wRtK3mRdg0+RpZa54I/0zXax1v96rZNvmN9vWeGRXjBcDcn/hnW
         65JCGU2sxSSMWN8R5ZtZEDT7snjEO2XYU7ywBi0Jcln9GD3WWhfvEPT2T5o20T27UfZ/
         +PLg==
X-Forwarded-Encrypted: i=1; AKwUvBz1MZgvKi+nihPtEQdLawmdkRgSoCNKczVj7JBCuSEpT+rwdUG91C4vghhOjgoGS3t2Hmo3H+irpxfx@vger.kernel.org
X-Gm-Message-State: AFuF++kLeq89/p4bN7bdwwGokRSXq+Aeh9NebXUQ1036jmmJeQoELn99
	1deX4Y358JFLkr1G7mI/2qv3dpHye0OBHe3uGNdA+8emtpF1E31y+VqKyMVo9ViWVhnc5M7m0oH
	mE4IUWPZM+w==
X-Gm-Gg: AYBFou063Z5y/7ztojyLQ/XMaWqKDU8eOiJqfpTS1kw5zg+PZYZx+oZeUf/qaTwQ2b6
	Ig+lUNR0sAlm9OtGApAE4cC70bg7fWsUYb3KW49GsW6Gpr+iz6/JfcHX8vZfTDkIwos3KxKkoU4
	UtJaT6Zedl/e665A4fBxfp9CiVF9nAuwuNs7Tdz0gtrAyRH5DNq3TXz5oLXLixHEQ6OymXv9Bok
	sKROwO6mhZZll4bxfmYWcL3ILvhYMBnS7qQ40Ghos2BlvhNq8qY0AfSBooNpLHhk5X6Z3aEm9SD
	/eViJepf3avgmJDs2doromNKmYeGcrg3H4fsrS7kdXmTqBgc5gV5NT8F3TRj/JmkqzRarj4HXvm
	CwPtNQizhEa6vvdFHnzG/awsmFGW4vs/BGBU8nY5+SDOaG0TKRYva5jfZlcv+nFEKJS4IMS8L+i
	AQf7X+Uh/XINbDP7xtP2jnhiTWGGkOfhlO9bv/Aq5IF9e1+OSUoxpK08da3XK4b8tfe8c/mfTQ7
	06ntenSsFQFaZWyu+qzV0OIEaybtScgtN9VGsXLKQUaeWUN
X-Received: by 2002:a05:6512:1596:b0:5b6:183c:5c90 with SMTP id 2adb3069b0e04-5b8b6650572mr40363e87.46.1789513348522;
        Tue, 15 Sep 2026 16:02:28 -0700 (PDT)
Received: from mail-lr2-f12.google.com (mail-lr2-f12.google.com. [74.125.230.76])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8b57cc66fsm300236e87.37.2026.09.15.16.02.27
        for <sparclinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2026 16:02:28 -0700 (PDT)
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a47f740839so2895631fa.2
        for <sparclinux@vger.kernel.org>; Tue, 15 Sep 2026 16:02:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByHpD+ECUvPlXyOT2y93L8nkPptb8TO++VzGlf1hsL8NzHFYxD6YlK7zxDVC99KYuwiNrDIdntIZMHH@vger.kernel.org
X-Received: by 2002:a05:6402:5d1:b0:6a9:a6c0:e5ef with SMTP id
 4fb4d7f45d1cf-6aa2244ef06mr218172a12.37.1789512913950; Tue, 15 Sep 2026
 15:55:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <CAHk-=wjeamU=_RYT9cR3dZJ2N-Teo-N1+aYh7jwhrB=iWXD0cg@mail.gmail.com> <CACSVV028AdnTYa6OKDeoJYCau58uTkKMgEdqTn7crNSV8QZxOA@mail.gmail.com>
In-Reply-To: <CACSVV028AdnTYa6OKDeoJYCau58uTkKMgEdqTn7crNSV8QZxOA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 15 Sep 2026 15:54:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjhJF91TCO0Zqeuf+caG2tQZ4AzbLr2qFmRmnMM4dbh4g@mail.gmail.com>
X-Gm-Features: AcwNN1Wx2MaYDtFtmeOlL6MnzYY7doY_FEPpziKatTBWbLOeKsjmritQ5JuAL3M
Message-ID: <CAHk-=wjhJF91TCO0Zqeuf+caG2tQZ4AzbLr2qFmRmnMM4dbh4g@mail.gmail.com>
Subject: Re: [PATCH RFC POC 00/50] file: handle files on syscall exit
To: rob.clark@oss.qualcomm.com
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jann Horn <jannh@google.com>, Jan Kara <jack@suse.cz>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, linux-fsdevel@vger.kernel.org, 
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

On Tue, 15 Sept 2026 at 15:21, Rob Clark <rob.clark@oss.qualcomm.com> wrote:
>
> With fd's it is more than just about error rollback.. exposing an fd
> to userspace mid-way thru an ioctl is an easy security bug to write..

That isn't very common code. It's something that is done by a few
strange cases, and yes, those cases should just do it right.

But "those few cases should do it right" does not mean "make a whole
new subsystem for this thing that makes a simple "open" actually be
slower and stranger".

             Linus
