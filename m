Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A794B1B42;
	Tue, 15 Sep 2026 11:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789473009; cv=none; b=AjtCLBR8l4n0MCZJBzb2mUQSvwg10TLa24NMpoFqEwIiNBHJ0DQJRBtAwh+mQzAIYstLGZBLpRAt3fwWTtfAUqwYLzPATF2g1EjoxM9emwJ9ap8MjTTwGeykAutu+89t564MSlHogj922maEGwv8Y5Ts0w7X/d1PVCPsv3aOVW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789473009; c=relaxed/simple;
	bh=0AqS3flkVTKIPJ2xTjcUKZeFykacsXD9uqwa7hl1oQY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=F5lUL3K4oPkrYxtEhU9eWqw+J4OuRmpY+r4Jr0AK69/ya3PRNSr1G3VfOpRXcuBRMJFRS2ge/YU/DgiboJsXDfgD8qQJ7KL5OK5s/QVUUqR2si9mO/ZDBI7WXXHM9xBQAXu5rYucOwaQADUBK3mxU57RaEQtygehXueLnowbLL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FZyLQujg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FZyLQujg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA52D1F00898;
	Tue, 15 Sep 2026 11:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789473007;
	bh=Wvy04NbJid/rHT9Oo2y6und5H0C/2sS7C4rNvZsUJ+M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FZyLQujgrSLTLItt0atdLygYtPLJy07BtTpqJEj8tK4rCFepTR6WTdgjVU1CUaviY
	 /2kxpiaHyjwEq8od5PpCP63amvdhTsJyZVoAXJVFzklNTY1gegcdWYDDoR+/XePScz
	 MHrJT4NoUt8HIfXHRaVC5PMjCIQJVPlEkfbh8gaQY1dgXLLaPf3I5PVcxiOdPbdNhp
	 egKHXLxlo+8hU8IJMPwEDm1igMoQNQ50LWjgaSmTwzy6Kkr1xxWZeZvflO3a23mVwB
	 kOkyNkCaEN1wr6HpAzVJp/5fzNLTwrIjdFvuyd/aBdf6hTcIxBdJ3Y3aTJX6C30ppL
	 nzwCXruPvLzow==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 09/50] m68k: commit fds on syscall exit
Reply-To: sashiko-reviews@lists.linux.dev
To: "Linus Torvalds" <torvalds@linux-foundation.org>, "Christian Brauner" <brauner@kernel.org>
Cc: kexec@lists.infradead.org, linux-openrisc@vger.kernel.org, io-uring@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-mips@vger.kernel.org, "Eugenio
 Perez" <eperezma@redhat.com>, linux-mm@kvack.org, linux-sh@vger.kernel.org, "Jann
 Horn" <jannh@google.com>, virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, "David
 Airlie" <airlied@redhat.com>, bpf@vger.kernel.org, linux-hyperv@vger.kernel.org, kvm@vger.kernel.org, sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-hexagon@vger.kernel.org, linux-gpio@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-alpha@vger.kernel.org, "Ingo
 Molnar" <mingo@redhat.com>, linux-um@lists.infradead.org, "Michael S.
 Tsirkin" <mst@redhat.com>, linux-parisc@vger.kernel.org, "Peter Zijlstra" <peterz@infradead.org>, "Jan
 Kara" <jack@suse.cz>, dri-devel@lists.freedesktop.org, =?utf-8?b?Q2hy?=
 =?utf-8?b?aXN0aWFuIEJyYXVuZXIgKEFtdXRhYmxlKQ==?= <brauner@kernel.org>, linux-snps-arc@lists.infradead.org, linux-csky@vger.kernel.org, "Jens
 Axboe" <axboe@kernel.dk>, "Oleg Nesterov" <oleg@redhat.com>, linux-fsdevel@vger.kernel.org, "Alexander
 Viro" <viro@zeniv.linux.org.uk>
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-9-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-9-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 11:50:04 +0000
Message-Id: <20260915115004.CA52D1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] m68k: single-step SIGTRAP lost on fd-allocating syscalls
--

commit 731b1387fc76d92d165ee1f28de694e3d228627b
Author: Christian Brauner <brauner@kernel.org>

m68k: commit fds on syscall exit

Add TIF_FD_SLOTS and test it on the untraced return from a system
call in all three entry paths. A task that reserved descriptors calls
syscall_trace_leave(), which commits them before the ptrace exit stop.

[ ... ]

> diff --git a/arch/m68k/kernel/entry.S b/arch/m68k/kernel/entry.S
> index 338b474910f74..9e4471f681652 100644
> --- a/arch/m68k/kernel/entry.S
> +++ b/arch/m68k/kernel/entry.S
> @@ -229,6 +229,8 @@ ret_from_syscall:
>  syscall_exit_work:
>  	btst	#5,%sp@(PT_OFF_SR)	| check if returning to kernel
>  	bnes	1b			| if so, skip resched, signals
> +	btst	#4,%a1@(TINFO_FLAGS+2)	| TIF_FD_SLOTS: commit descriptors
> +	jne	do_trace_exit

[Severity: High]
Does this new branch cause delayed trace (single-step) SIGTRAPs to be lost?=
=20

If a process is being single-stepped (TIF_DELAYED_TRACE is set) and execute=
s a=20
syscall that allocates file descriptors (TIF_FD_SLOTS is set), this=20
unconditionally branches to do_trace_exit.=20

Looking at do_trace_exit, it executes syscall_trace_leave() and then direct=
ly
jumps to the exception return path, bypassing the jmi do_delayed_trace logi=
c=20
completely.=20

This means single-stepping over a system call like open() could fail to=20
deliver the expected SIGTRAP, which might break debugger functionality.

>  	lslw	#1,%d0
>  	jcs	do_trace_exit
>  	jmi	do_delayed_trace

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-work-fd-re=
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D9
