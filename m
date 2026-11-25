Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795601236;
	b=hPxu00HDcWGV5Q18lcw+iLYOpE0RivpA8/kmSu00dyC4Pp165pU6MDTD4H3BgtxRWisM
	 IvQf42O0TECOabaLWJ0LoMc9OIr3F0Opr0PvM7g7ZLAkXH30OCHLVa7rIOYobgLIYZaY+
	 pRHgiylS5vy0RCIHZyl4tYwxvDWB5VXPxQMDEcgzFcX5ndKFzNKy/Hz9hFKwWvYo9U2vV
	 l+ZQ9tysj+AvQ0+0h/89KLCsNv9qiNexB6LAeb/koStRi3xaUdstJIh0VHpgsh3dYLgJA
	 +nt/9qngDG5u/vBqA3BY6YohXklGh5jqSpJjtupfDRpE256A+M3ePigKuArxFPW5LpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795601236;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=XPUc0KH0viN+tnos8DZKfyq/cn3ZCFpYiBR5vNgasuw=;
	b=eDjx46rmvNix2NYN1eMIR3/Zbl2PsvDevTqEUlCb2PB2fX8VwkwCC+KU8vaRksAWywZ+
	 wIwXoFOc5HCgtD+8qeGu13zRckgHja/crEDgmW0qSXVkCIR7nWyN2eaHBWWdbD1WwqBn7
	 Nq5LDYpQneKw4kU1bPo/RgPeSEMpY25mC+AMTVr5AqXIK64OiAxc2Y95jzzsQHo0/4H2F
	 0o4OXWt0X5nZ5++dNLTYEQXBW+6SCK3/sS7yKZcOr6G9Y/9bKZ82afR6hwBhF6HSu+guO
	 +Vq3a04x/KmGDlC5LZyuulwsYCjKXNJ8UOKQrPVlCcRxuzYx4Zv2+dr8bBnOVguv9uQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EIzPZplI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57889606A31E
	for <sparclinux@vger.kernel.org>; Wed, 25 Nov 2026 10:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EIzPZplI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 761601F000CF;
	Wed, 25 Nov 2026 10:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795601235;
	bh=XPUc0KH0viN+tnos8DZKfyq/cn3ZCFpYiBR5vNgasuw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EIzPZplIFtPj5CT8FD3rl3x481kYTbkaq6nR85PEXgUc7af4sFoDbnhI0Z6Cevp4g
	 844PyhsxYAwO9p6EgCsklTzXJdJUzVz0wuoADggv05Or2IKhTMKspY1MdKqQm8FBiO
	 e1mVGTR42h8MR0MwpUJ0GS3MjeeyD9kmvrz5Duo98ujF9Z+g3zm8jkxgmybk3dsWDR
	 Gg0zZr3oIgNRvf5FriC8bXgwnh+Ddc6b3amGv26scXynd8xGeYmUBSj1sDxptGfBjP
	 /NRDDKh9a4chep/KR4RGuaziF0QP8dPpHE04ZkCjacgPxlM2XZDiozqVH+4pt6sXXk
	 QEXeaUpv+n4Fg==
Message-ID: <sashiko-outbox-233087@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] sparc64: Report the fault address when a user window
 cannot be saved
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stian Halseth" <stian@itx.no>
Cc: sparclinux@vger.kernel.org
In-Reply-To: <20261125094446.537502-1-stian@itx.no>
References: <20261125094446.537502-1-stian@itx.no>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 10:07:15 +0000
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Post: <mailto:sparclinux@vger.kernel.org>
List-Help: <mailto:sparclinux+help@vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:sparclinux+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [High] sparc64: call to undeclared vma_lookup() in
  fault_in_user_windows()
- [High] sparc64: missing trapno argument to force_sig_fault() in
  process_64.c
- [Low] sparc64: missing Fixes trailer in commit message for
  fault_in_user_windows()
- [Low] sparc64: fault_in_user_windows() uses base sp on page-straddling
  fault
--

commit ee3413b56ca2f61248a64fe34c40cdf99b9dde0c
Author: Stian Halseth <stian@itx.no>

> sparc64: Report the fault address when a user window cannot be saved
>
> When the kernel spills a user register window and the store faults,
> the window is kept in the thread's window buffer. On the way back to
> user space fault_in_user_windows() writes it to the stack. If that
> write fails as well, it sends SIGSEGV with force_sig(). The handler
> gets SI_KERNEL and si_addr =3D=3D 0.
>
> When a thread overflows its stack, the first store into the guard page
> can be a window spill. If the kernel does that spill, for example
> during a system call, the window goes through this path. Stack
> overflow handlers compare si_addr with the guard page. With
> si_addr =3D=3D 0 they cannot tell that the stack overflowed. The Rust
> runtime then resets the handler, and the process dies with SIGSEGV
> instead of reporting the overflow. Rust's
> tests/ui/runtime/out-of-stack.rs fails this way:
>
>   ferris[157185]: bad register window fault: SP fff800010f60bf90 (orig_sp=
 fff800010f60b791) TPC fff800010f3a2db0 O7 00000100016039e4
>
> Pass the address of the window to the signal, as stack_unaligned()
> does for SIGBUS in the same file. Look up the VMA to choose the
> si_code, as process_fpemu_return() does on MIPS. A spill into a
> PROT_NONE guard page then reports SEGV_ACCERR, whether the hardware or
> the kernel did the spill.
>
> Closes: https://github.com/sparclinux/issues/issues/132
> Signed-off-by: Stian Halseth <stian@itx.no>

[Severity: Low]
Should this include a Fixes tag for the commit that introduced
force_sig(SIGSEGV) in fault_in_user_windows():

  Fixes: 5b4fc3882a64 ("sparc64: Make corrupted user stacks more debuggable=
.")

> diff --git a/arch/sparc/kernel/process_64.c b/arch/sparc/kernel/process_6=
4.c
> index 7afd0a859a78c..af8d2efc0dd43 100644
> --- a/arch/sparc/kernel/process_64.c
> +++ b/arch/sparc/kernel/process_64.c
> @@ -530,6 +530,8 @@ void fault_in_user_windows(struct pt_regs *regs)
>  {
>  	struct thread_info *t =3D current_thread_info();
>  	unsigned long window;
> +	unsigned long sp;
> +	int si_code;
> =20
>  	flush_user_windows();
>  	window =3D get_thread_wsaved();
> @@ -539,7 +541,7 @@ void fault_in_user_windows(struct pt_regs *regs)
>  		do {
>  			struct reg_window *rwin =3D &t->reg_window[window];
>  			int winsize =3D sizeof(struct reg_window);
> -			unsigned long sp, orig_sp;
> +			unsigned long orig_sp;
> =20
>  			orig_sp =3D sp =3D t->rwbuf_stkptrs[window];
> =20
> @@ -569,7 +571,13 @@ void fault_in_user_windows(struct pt_regs *regs)
> =20
>  barf:
>  	set_thread_wsaved(window + 1);
> -	force_sig(SIGSEGV);
> +	mmap_read_lock(current->mm);
> +	if (vma_lookup(current->mm, sp))

[Severity: High]
Does this fail to build because vma_lookup() is not declared in this tree?
process_fpemu_return() in arch/mips/kernel/traps.c uses find_vma() and
checks vma && vma->vm_start <=3D addr instead.

> +		si_code =3D SEGV_ACCERR;
> +	else
> +		si_code =3D SEGV_MAPERR;
> +	mmap_read_unlock(current->mm);
> +	force_sig_fault(SIGSEGV, si_code, (void __user *) sp);

[Severity: High]
Does force_sig_fault() fail to compile on SPARC without the fourth trapno
argument?  SPARC defines __ARCH_SI_TRAPNO, so force_sig_fault() requires a
trapno parameter as in stack_unaligned() just above:

arch/sparc/kernel/process_64.c:stack_unaligned() {
    ...
	force_sig_fault(SIGBUS, BUS_ADRALN, (void __user *) sp, 0);
}

[Severity: Low]
Can looking up and reporting sp report the wrong fault address and si_code
when the register window straddles a page boundary?

If sp lies near the top of a writable page and [sp, sp + winsize) crosses
into an unmapped or non-writable upper page, copy_to_user() faults in the
upper page and returns the uncopied byte count rem, but the VMA lookup and
force_sig_fault() use sp in the writable lower page.  Computing the fault
address from the uncopied byte count (sp + winsize - rem) would report the
faulting page.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125094446.5375=
02-1-stian@itx.no?part=3D1
