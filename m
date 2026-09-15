Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFC1396D28;
	Tue, 15 Sep 2026 11:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789473595; cv=none; b=DVojsNALbSUhz/CScTNfwS6K1DH0f60c7VfhBohPqDQ6cFv6A2ZFOKpWSn/0x0SVsWmADa45Myn3lSWyAxjxMZ5d5NA9rS8dzRZPfrZ97lpYA1IWOkjPhUxv1utLpGM+CdCwsYHm1tDtoJtXYJR5OKKs4c90UgfyN+wj400bRhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789473595; c=relaxed/simple;
	bh=L7mDOIObVI5akAY7oDYDoeEOuqWJ2hST0g6maRIMw2E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LzI13UqWJFm4QYPlTjzGkcbwWogkytw87rmopNGYhrEbLtSF3NL51mY7+CedyaC5ZZiv4yXVVRo/7M+wqOok/A026YTSyWuDELuOL0yCRddgokbLBiAVy3arwMB/1wrXpdcjRpXm721BTZx4u0dUm96LahNxctw8Fzfit+JJO8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PNkc1SOO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PNkc1SOO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1604F1F000FF;
	Tue, 15 Sep 2026 11:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789473593;
	bh=DQgIYhua5CTViS1X9ZXXGfaSPT/5dqgeOOlUNrKnxWw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PNkc1SOOx+a0MtActP/scxfu+EOEc0okpYmMq9u2IvQ6wdxXtOCmaRwTaDfxAYQfu
	 KNpmxdQzkwQyaCWqsjPY6fMZbe5ub33vKaPoYJ07B7Q1LWFwdlgiCUvB0QQ8c2qsi1
	 FMsSTqEgiIP1sEOamGDSgZSCZ6TfAMEjISixK2R8eaJA2XnzylLgQ4fdlCaNZFxShP
	 J8hVTu3MQPl0lwmGSaxF9w8s3KltrNP5jpWzkNN2BlxuRXTG4UWjQZqj2E6RzHxSaN
	 2Rs03FwwuFJXXN68mTYzdZ8pV7LyInc7Ptt8ORor8BsaOlsL4d3xo27nPcBZv3oI95
	 0hW/vFstsi8gw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 14/50] parisc: commit fds on syscall exit
Reply-To: sashiko-reviews@lists.linux.dev
To: "Linus Torvalds" <torvalds@linux-foundation.org>, "Christian Brauner" <brauner@kernel.org>
Cc: "Peter Zijlstra" <peterz@infradead.org>, linux-sh@vger.kernel.org, virtualization@lists.linux.dev, "Eugenio
 Perez" <eperezma@redhat.com>, "Alexander Viro" <viro@zeniv.linux.org.uk>, "Oleg
 Nesterov" <oleg@redhat.com>, linux-csky@vger.kernel.org, linux-m68k@lists.linux-m68k.org, dri-devel@lists.freedesktop.org, io-uring@vger.kernel.org, kexec@lists.infradead.org, "David
 Airlie" <airlied@redhat.com>, linux-um@lists.infradead.org,
 =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRhYmxlKQ==?= <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, linux-alpha@vger.kernel.org, "Michael
 S. Tsirkin" <mst@redhat.com>, "Jan Kara" <jack@suse.cz>, "Jens Axboe" <axboe@kernel.dk>, linux-arm-msm@vger.kernel.org, linux-parisc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, bpf@vger.kernel.org, "Ingo
 Molnar" <mingo@redhat.com>, linux-gpio@vger.kernel.org, linux-mips@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-openrisc@vger.kernel.org, linux-mm@kvack.org, sparclinux@vger.kernel.org, "Jann
 Horn" <jannh@google.com>
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-14-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-14-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 11:59:51 +0000
Message-Id: <20260915115952.1604F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] parisc: syscall fast path exposes uninitialized pt_regs to ptrace
--

commit 38a139df8c7c61e11fc9314b5f43e371c71a8356
Author: Christian Brauner <brauner@kernel.org>

parisc: commit fds on syscall exit

This commit adds TIF_FD_SLOTS and tests it in syscall_exit once the return
value has been saved. A task that reserved descriptors calls
do_syscall_trace_exit() to commit descriptors and then continues with the
usual checks.

> diff --git a/arch/parisc/kernel/entry.S b/arch/parisc/kernel/entry.S
> index e04c5d806c105..c5807cf6fbd8d 100644
> --- a/arch/parisc/kernel/entry.S
> +++ b/arch/parisc/kernel/entry.S

[ ... ]

> @@ -1765,6 +1767,16 @@ syscall_do_signal:
> =20
>  	b,n     syscall_check_sig
> =20
> +syscall_do_fd_slots:
> +	mfctl	%cr30,%r1
> +#ifdef CONFIG_64BIT
> +	ldo	-16(%r30),%r29			/* Reference param save area */
> +#endif
> +	ldo	TASK_REGS(%r1),%r26		/* struct pt_regs *regs */
> +	BL	do_syscall_trace_exit,%r2

[Severity: High]
Does this expose uninitialized kernel stack memory to a tracer?

When a process executes a system call that reserves a file descriptor slot,
it enters via the fast path which only saves a minimal set of registers to
TASK_REGS. If TIF_FD_SLOTS is set, the fast path directly invokes
do_syscall_trace_exit() here before all registers (like %r3-%r18) are saved.

> +	nop
> +	b,n	syscall_check_resched
> +
>  syscall_restore:
>  	mfctl	%cr30,%r1
> =20

[ ... ]

> diff --git a/arch/parisc/kernel/ptrace.c b/arch/parisc/kernel/ptrace.c
> index 1d9e210702e1f..f142766792afa 100644
> --- a/arch/parisc/kernel/ptrace.c
> +++ b/arch/parisc/kernel/ptrace.c

[ ... ]

> @@ -381,6 +382,9 @@ void do_syscall_trace_exit(struct pt_regs *regs)
>  	int stepping =3D test_thread_flag(TIF_SINGLESTEP) ||
>  		test_thread_flag(TIF_BLOCKSTEP);
> =20
> +	if (test_thread_flag(TIF_FD_SLOTS))
> +		fd_slots_commit(regs);
> +
>  	audit_syscall_exit(regs);
> =20
>  #ifdef CONFIG_HAVE_SYSCALL_TRACEPOINTS

[ ... ]

>  	if (stepping || test_thread_flag(TIF_SYSCALL_TRACE))
>  		ptrace_report_syscall_exit(regs, stepping);
>  }

[Severity: High]
If a tracer attaches concurrently while the process is blocked in a file
descriptor allocation syscall, setting TIF_SYSCALL_TRACE, won't this call p=
ass
the incompletely initialized pt_regs from the fast path to the tracing
subsystem?

This could allow an unprivileged user attaching a tracer to their own proce=
ss
to read uninitialized kernel memory via PTRACE_GETREGS. Also, tracer
modifications via PTRACE_SETREGS to these uninitialized registers would be
ignored because the fast path does not properly restore them before returni=
ng
to userspace.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-work-fd-re=
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D14
