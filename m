Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C54496D56;
	Tue, 15 Sep 2026 11:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789473597; cv=none; b=kP6tIeRr+wKycC1UVAbF2F3RGzL+pFP/1EzpZZubv1Y1b9nxd6qfyNNumpstKkug0PuZjadzFWnOoDCPZJtYBU9c2TPDyFELPb8BsMFvXRPtRIvorsI01IiBZtoYLd+XUMOo8aPE3L6Chsck4E9Rgv75t1SaeiACX5Vk9QK7Row=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789473597; c=relaxed/simple;
	bh=LV6KjSBSCoMl1BpNEbGW5jNdELn3H1EoTm8/n0WGG8s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jPwA1RNrFhKRcDvu12rRUAT1BS1mGEHkUb6wnOGk8K239lJU5gteXgbRMClHR3Jm1pKTQz+VH3DlD9oXhllDb7jGfhdLiwANNH/G3Bgvx1Q1X7XAFZseZxZTHNlWaatubvaoEFdDAXZ+rU/+47J/YQFapITNcHrY8nhQAg+n49A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LuDfDBIp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LuDfDBIp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B93C1F00893;
	Tue, 15 Sep 2026 11:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789473596;
	bh=XROzleDAWNHKip4xHBVteIb0cCuN7FAQoMQU9zewp/g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LuDfDBIpgc+rUudqugD7YWLMIYTyPSh1djqeFTSZvIqwl+MCFr2F9Jod5sQ3BdeBH
	 Fs4P2kaC4Rq/e2WctPCUaANEEugIP/+ZEAefkQjg3r930Bx3+wPmgnd43osNu5U8C9
	 EyuNiUbu78gNfTdrTeVFFD2nhC1r5SHLm94AIfGff4/9p19OhtUCSOkAUYL8ijEd9H
	 l9DN/Fa9wQdaggqiklG21wysLrbu7J9tNRHYcAgnuhIFYUQdGWbvPhv23a8BBnteix
	 dj3Dz8036WkGhtwkv8ziLkCVxCa1RZBk5Y1nQhcVea1ZYeF0cF/u11/S008mj3HeiR
	 /EId/I6+w1CIA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 05/50] ARM: commit fds on syscall exit
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>, "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: linux-um@lists.infradead.org, linux-openrisc@vger.kernel.org, "Michael
 S. Tsirkin" <mst@redhat.com>, "Peter Zijlstra" <peterz@infradead.org>, bpf@vger.kernel.org, linux-csky@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-gpio@vger.kernel.org, "Eugenio
 Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev, "Jan Kara" <jack@suse.cz>, "Oleg
 Nesterov" <oleg@redhat.com>, linux-hyperv@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-alpha@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-snps-arc@lists.infradead.org, linux-parisc@vger.kernel.org, io-uring@vger.kernel.org, "Ingo
 Molnar" <mingo@redhat.com>, kvm@vger.kernel.org, "Jens Axboe" <axboe@kernel.dk>, "David
 Airlie" <airlied@redhat.com>, linuxppc-dev@lists.ozlabs.org, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, "Jann Horn" <jannh@google.com>, linux-sh@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-arm-kernel@lists.infradead.org, sparclinux@vger.kernel.org, linux-mips@vger.kernel.org,
 =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRhYmxlKQ==?= <brauner@kernel.org>, kexec@lists.infradead.org
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-5-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-5-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 11:59:54 +0000
Message-Id: <20260915115954.7B93C1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] arm: redundant TIF_FD_SLOTS check due to bit-shift overlap
--

commit bdf52635177f575c1b58cdb7e902386551a36647
Author: Christian Brauner <brauner@kernel.org>

ARM: commit fds on syscall exit

Add TIF_FD_SLOTS and test it where the syscall return path decides
between the syscall work and the plain work pending slow path. A task
that reserved descriptors goes through __sys_trace_return_nosave
where syscall_trace_exit() commits them before audit and the ptrace
exit stop.

> diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-commo=
n.S
> index 88336a1292bb7..59a70d90b0b61 100644
> --- a/arch/arm/kernel/entry-common.S
> +++ b/arch/arm/kernel/entry-common.S

[ ... ]

> @@ -83,6 +83,8 @@ ENDPROC(ret_fast_syscall)
> =20
>  	tst	r1, #_TIF_SYSCALL_WORK
>  	bne	__sys_trace_return_nosave
> +	tst	r1, #(_TIF_FD_SLOTS << 16)	@ r1 holds TI_FLAGS << 16
> +	bne	__sys_trace_return_nosave

[Severity: Low]
Is this newly added check reachable?

The preceding tst r1, #_TIF_SYSCALL_WORK instruction appears to intercept
the branch because it inadvertently catches this condition.

In ret_fast_syscall, r1 is loaded with TI_FLAGS << 16. TIF_FD_SLOTS is
bit 5, so shifting it by 16 places it at bit 21 in r1.

_TIF_SYSCALL_WORK naturally includes bit 21 (_TIF_SYSCALL_AUDIT). Because of
this bit-shift overlap, the first test against _TIF_SYSCALL_WORK will
evaluate to non-zero whenever TIF_FD_SLOTS is set. This means the branch to
__sys_trace_return_nosave is taken early, making the new tst instruction
unreachable dead code.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-work-fd-re=
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D5
