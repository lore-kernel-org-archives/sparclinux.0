Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512A74EE842
	for <sparclinux@vger.kernel.org>; Tue, 13 Oct 2026 12:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791894965; cv=pass; b=hhr1NAdX2dpd8J+ljDmEXu8WlyaXLQAoJVQthTWPvxkj7ANWLxebpRtvO8C5mjLg9pnQ7UvlAV/w45jNJDcj9kinjF8LOPcqOaHG84zXPq2iPwgNhM321RHhmw5XP9g7Dgdzh3qLW4SeWDIK8ADJnD5ejejT/loTTtKuMMGA8dA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791894965; c=relaxed/simple;
	bh=KJz0ljhpxQV0dxuLmyAZzCH6KN1a+1DHS+L2+lDvs9U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t/LrdKWcmYgwxxMg7VnLubfe4Uyjte0jM3xy5q8xWd6qLTQyMwJ8ruitBe/K41FZ45MEbA5Ht/P4OMJaRV/RbqLjx36vrhlfOs+ZKA5iht8PalNfhdm1KjW/Yv+EMp/AXqj++C+FyqwqeHGG/YkLGAN0vHf4WsFof4hq/IMrtyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HEzqavGD; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=qN9sj0/q; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HEzqavGD";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="qN9sj0/q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791894963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ooKLa1R3KGvywNv1R+3CFpG+InkWtGBVvbQRUtpRSf4=;
	b=HEzqavGDVm27rpHXWPwhy/SncpPuXeG2heUDAh+82wPoVFN4EOHMPspodITW890lZv9RK/
	bK359dt+dUCsO7TQkf/IYO16RpEOb7bTivPq9DaXBrStYQcQHFNM8//ryCg2d9HsL43XTm
	iIHcvaV66rA15qIKn8AwEHHqY55PlJU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-uT2N58AwOVqPXAW76YXutg-1; Tue, 13 Oct 2026 12:36:02 +0000
X-MC-Unique: uT2N58AwOVqPXAW76YXutg-1
X-Mimecast-MFC-AGG-ID: uT2N58AwOVqPXAW76YXutg_1791894961
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c2e71425f87so321547866b.2
        for <sparclinux@vger.kernel.org>; Tue, 13 Oct 2026 05:36:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791894961; cv=none;
        d=google.com; s=arc-20260327;
        b=XOFsmzh4FAnn7Q/0JKDlyj1CQLRvmJaxm90I1CI07bqPcX2JBFidn0M78nb9qO7wpP
         lxDDYm+m3+WUHbnUOlaUwjnAv6NJl5zkoX3sKJY+PY9B76iGaVBugUfF/C0sGVXeK2cc
         53CLD9dnp3ilvT9WtHGtDqrkaQUCdUaEVHhDNoFxgFW1KZTjMqt+EoeYeLK5tVPDtBPv
         miijCI1BsZ864+51m6bMScY0xUo9RJxvAxAy854wB3VoiKp/IlAlg2tHi1pmAfKuo9eW
         OhJvmnIDP5d6gpmbMFAI/T03pINpFr1RVQ+KsnRC6ZwzTz5V7WGgJClbylda+QAKdeSq
         j8MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ooKLa1R3KGvywNv1R+3CFpG+InkWtGBVvbQRUtpRSf4=;
        fh=fVrlAdawOTCV+SS+iJHPKKi0m9lwUU2kIHPfouNIf64=;
        b=GL3RUiMLO5LF7krzuJd58GPWisrZusthFKEDT31sxvK9HGKVZ25b4zNFsM98LxXVXx
         jIWMHNeU7lq9ybWMy6NhzG08/vYbWEpJIigu3eDmBSXOrzc11BLtdrhixUcQrlhqB+r9
         xLpDEU+fY3z2+Oj0Ekt1V6IHTDa7UAgFKZF0Ga42KBgJEHN4lzWRbDpAWMf0SzlFEjLU
         fc98gmAnXnOpX5DhWBU2d9oO/KzduLayhX0+DGDuRi6s1wREJQB6o6YflgOdP+8DXFiu
         SeRK9gGblue/x4+fjkS7J8NYrC2VDC7WOQ+MUCH9g8U/keXIAhoMyZugzk78htac7Ndu
         t2yg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791894961; x=1792499761; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ooKLa1R3KGvywNv1R+3CFpG+InkWtGBVvbQRUtpRSf4=;
        b=qN9sj0/qpSwVX0hym3c536rh0X0xIr6LYY9Jutr7HegnNShbckMgjQvGSZL1Vy/TCE
         dghsx63NgzR54LRp7NoIDOpD+Uu5Ri756w1MeLOIm3j7ZSacARJmJa0oBntsmOY3KFp5
         0sGleFMFb+fC+VazN+t+Kb73PfzdS/jxG86X/rNZ5eeyV5Zgmunb2xdzk4lQsydG5RyS
         srcza0R+iDjOfFS7aouDVhXIMo12bhuXQ/kFztyNDFgLqg23Ko0QsVzZIPCU0erWckeu
         pw4v5xd1x0Ea1HJuTdLtJMlNx8frNFT5MnFpEtjMGk5PppS81+V2/VQJ2vVUiOTV1Cbp
         qs4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791894961; x=1792499761;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ooKLa1R3KGvywNv1R+3CFpG+InkWtGBVvbQRUtpRSf4=;
        b=s9y4HtlkJiYo6OOEQwwzNzlmF2TdKJZIxQYlaIXrFZxtsbaExlmR6/gjuO+yZxvkyV
         UiGcxrvF19pNEvSZdjac/tfVLq6UF4WGZpNCavCyWbgXI3Eu1jwFlWnmqq/214JMre5R
         VxKo75k0D56qYu1YB+3NOr1RhLYPUikEUAdtXKKMNUMF03H6tMo2/PSUfGhKTzdnKOHp
         hKW4mUj2AJvJrMmTSsyh4uvub69mVbOdjparVqGs8xcdB1tUY81QxwrfuTudReguTHF6
         d1RAdVlSMMt6tgVCUI/pMjPZXaJFDRX5O4OBmefLJtzZXNSr8mu+HwKEHY/bAKPF4Z6V
         djdw==
X-Forwarded-Encrypted: i=1; AKwUvBxNp+tzfZP7J/b5gVgc1OEvVt3OAV83Bd/0ZJYu5ceT3vyIdvFpw+9vaNxmOB5qh9KKMT3mKCVMM65Z@vger.kernel.org
X-Gm-Message-State: AFq9FYJ/UVh19VzGLCJkw0HymZEH24vGtfJYqDnxtxyJrULISQbPhJfn
	/Zut0E4D4movCXwwjhy4jgGtCyPQ0Fwgn8msanL3afbOMfyZRCQP4ihCSLn3aw/0Hx7eitvcjRU
	grENYdLYRtrQlifLlRD8YHSSh46qBYfcdoWMBFnGciOxoLWXHywh4oiQYkI/ntNT3XY6riLBLi9
	BDM5Cbr+OvfNVQGLcLvfw2Pr6g2ab3f74vc06KPA==
X-Gm-Gg: AYBFou14M5qT/ReblzpJmSLDoLH9rt+Nw90n96kiI6HZWWJdhXr1xLnTUbTXpYaKUc+
	vje+YVmvs7VC/uTGYs+jpA+6ki01+fsFrCDvGqHD5FxtBJ5RChVAXfM/RwZvzBSAHuGufofPGZa
	XKhp8jx6D1Ymb4rjtx4B3G5EcPRi8ZqeefFHHWtJ0AvXsW76F8AMZkMX6wVD3sf/lQA+DD/aYG6
	FzLhYeEhgtci+ybIoGkpf9PJFXxvQxay8fUwNJiXH1zZ0BfJOnbrQeZ4RiopbznP4tcvUOYlrYg
	fHQ=
X-Received: by 2002:a17:907:7b8a:b0:c2e:1b4d:e9e9 with SMTP id a640c23a62f3a-c31a9f6ade4mr1135549266b.30.1791894960706;
        Tue, 13 Oct 2026 05:36:00 -0700 (PDT)
X-Received: by 2002:a17:907:7b8a:b0:c2e:1b4d:e9e9 with SMTP id
 a640c23a62f3a-c31a9f6ade4mr1135542366b.30.1791894959880; Tue, 13 Oct 2026
 05:35:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1790088067.git.rrobaina@redhat.com> <CAHC9VhQ=FFYVNmQdiMsqg+5KDDrSC3SZS+H2=r_GkhfwQox8tg@mail.gmail.com>
In-Reply-To: <CAHC9VhQ=FFYVNmQdiMsqg+5KDDrSC3SZS+H2=r_GkhfwQox8tg@mail.gmail.com>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Tue, 13 Oct 2026 09:35:48 -0300
X-Gm-Features: AclHuK-0QABZ6yrPwALI3VDGc1f2HfQWIB06SZ96BvTfEuUJkskwg4GU5NbIk1c
Message-ID: <CAABTaaBL=TScs8Qqu3b8F6KZPGMyvwy6cBC3teDaBL6MGMucNg@mail.gmail.com>
Subject: Re: [PATCH v3 00/14] audit: log all six syscall arguments in the
 SYSCALL record
To: Paul Moore <paul@paul-moore.com>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, bpf@vger.kernel.org, eparis@redhat.com, 
	sgrubb@redhat.com, oleg@redhat.com, richard.henderson@linaro.org, 
	mattst88@gmail.com, linmag7@gmail.com, linux@armlinux.org.uk, 
	catalin.marinas@arm.com, will@kernel.org, guoren@kernel.org, monstr@monstr.eu, 
	tsbogend@alpha.franken.de, jonas@southpole.se, 
	stefan.kristiansson@saunalahti.fi, shorne@gmail.com, 
	James.Bottomley@hansenpartnership.com, deller@gmx.de, 
	ysato@users.sourceforge.jp, dalias@libc.org, glaubitz@physik.fu-berlin.de, 
	davem@davemloft.net, andreas@gaisler.com, richard@nod.at, 
	anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net, chris@zankel.net, 
	jcmvbkbc@gmail.com, tglx@kernel.org, peterz@infradead.org, luto@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 1, 2026 at 6:06=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
>
> On Tue, Sep 22, 2026 at 3:21=E2=80=AFPM Ricardo Robaina <rrobaina@redhat.=
com> wrote:
> >
> > The SYSCALL record currently logs only four of the six syscall
> > arguments (a0-a3), silently discarding the remaining two. This
> > leads to the need for auxiliary records when audit-relevant
> > data lands in the 5th or 6th argument of a syscall.
> >
> > This series extends the SYSCALL record to log all six arguments,
> > by adding arguments a4 and a5 inline within the existing record.
>
> Thanks Ricardo, this looks great!

Thanks, Paul!

>
> There are a few things in some of the individual patches which I reply
> to in a minute, but there are a couple of "global" things that I
> wanted to mention:
>
> * As pointed out by Sashiko, when you were converting all of the
> arches, it looks like you missed alpha.  I took a quick look and it
> appears that it should be a pretty straightforward conversion like
> most of the others.

I've actually dropped the alpha patch as per Magnus's request [1].

[1] https://lore.kernel.org/audit/CA+=3DFv5T4826T2sd0Gbh-nfZsqcWK_phdBKy4BL=
WOvDTt92t5Eg@mail.gmail.com/

>
> * We need to get ACKs from all the various arch maintainers.  Aside
> from the parisc changes all of your arch specific patches are trivial
> (and cleaner than the existing code IMO) so I don't expect anyone to
> complain, but getting ACKs will likely take some time.  Even the
> parisc patches aren't that bad, and arguably they fix a problem for
> seccomp so that should make asking for ACKs easier :)
>
> Since I expect chasing down all the various maintainers for ACKs will
> take a little while, and I'd like to start getting this patchset some
> basic testing, I'm going to merge it into dev-staging now.  While the
> dev-staging branch doesn't feed into linux-next (this isn't likely to
> land in the next merge window) it is one of the branches that gets
> tested automatically and included in my kernel-secnext RPM builds.
> This also means you won't need to worry about keeping this patchset
> up-to-date with rebasing, as I rebase dev-staging as needed (it
> intentionally isn't a stable branch).  Going forward, if there are any
> minor changes to this patchset, e.g. a few line change in one of two
> patches, please just send a fixup patchset based against
> audit/dev-staging and I'll squash it into the relevant patch in the
> series.  However, in the unlikely event that a major rewrite is
> needed, just send a new patchset ... but I'll be very surprised if
> that happens here :)

Sounds good!

>
> --
> paul-moore.com
>

-Ricardo

