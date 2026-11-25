Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.189.121.228
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795608439;
	b=Gr0xyHFU9nXo6KNNhRl/qN9thh5rAf5UlwojmPTnaT5kFqeKaBJmedUV02UTM5MyCGLp
	 VOZXySjlWx5lVEBNZonn/RnJ+z7Kn6rMtj9CxhuE+F5cfWnmfio274nRhhxnCzOFAeHH6
	 CLZqQH3fiv08SdYOBKw9qaAWyu26o5RTyfPzpsAAxDcy7/CjHc9t5Jp2d05jL2VqdJknu
	 hVSpZgQtXPOA99/bQti233CskpoMFJqiyFNOojmmYBbnhNeBOb0ONac28n5qpqLQN6eFi
	 /pBLEDTKWdChw+wFBW5CbidKOwgRUd2jkwxhGMuSGlngGq/EkBsz4at91GU0HWoxK2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795608439;
	h=DMARC-Filter:Message-ID:DKIM-Signature:Subject:From:To:Cc:Date:
	 In-Reply-To:References:Content-Type:MIME-Version;
	bh=IVjYGPjhmv5sTTW5j25dSP5lfl0OsGKTOoj4SnRtwE4=;
	b=lMvvNI+tCanh9rYSJhNNxpgaTkW8JQrE3HndwAwAQG577AtmU67yKH4IHuW6xxPNVm2b
	 6gwiFEyKCm9tHhxzxDapr/M0OhshJm1F2kAarzy5kze8LbVjflGlyVCR5TniPMM2fs4Wx
	 oBrcrP4MzYXeF8xH1/xG8PqZWZLjc9PbNPEjLrmqAtcs4uXDHitYQcdQTPT2RWjrlJ0JH
	 IoUtKueh/PEbOdEYJs/NPgksW3S/5TZwYDSnIFvaSilxiA5pdcHqL2UCIV1j81v/Dk9nM
	 pypAPum54fOSuybjyFtyFf4a46DjYLsy4oEq4TpkaObaH0qCStvbyHxyeDqDYqikBZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=itx.no;
	spf=pass smtp.mailfrom=itx.no;
	dkim=pass header.d=itx.no header.i=@itx.no header.a=rsa-sha256 header.s=mx.itx.no header.b=G21FPXV0;
	arc=none smtp.remote-ip=91.189.121.228
Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3A0606A31E
	for <sparclinux@vger.kernel.org>; Wed, 25 Nov 2026 12:07:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE3A0606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.a=rsa-sha256 header.s=mx.itx.no header.b=G21FPXV0
Message-ID: <2f525cda544581acee89ee67ead7281ec1918bd0.camel@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1795608435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IVjYGPjhmv5sTTW5j25dSP5lfl0OsGKTOoj4SnRtwE4=;
	b=G21FPXV0V2GqZd2pEMvb5Dv2TVQIL7eWHaT8ij2I6QMDR0mHdyqkvs075XNGn8i4DQrh3g
	QEZ0SLYcM3Kua5v1z4hiVtpSPOFzZhDeVQsjK3qbXcULmhUzylERDbLCINYldjkjzsZNAW
	esrADqNiZsjd+AKjf8P2iQ7p2enPXZg=
Subject: Re: [PATCH] sparc64: Report the fault address when a user window
 cannot be saved
From: Stian Halseth <stian@itx.no>
To: sashiko-reviews@lists.linux.dev
Cc: sparclinux@vger.kernel.org
Date: Wed, 25 Nov 2026 13:07:14 +0100
In-Reply-To: <sashiko-outbox-233087@kernel.org>
References: <20261125094446.537502-1-stian@itx.no>
	 <sashiko-outbox-233087@kernel.org>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-nSYwDIwz8ecVshBALNqc"
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Post: <mailto:sparclinux@vger.kernel.org>
List-Help: <mailto:sparclinux+help@vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:sparclinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0


--=-nSYwDIwz8ecVshBALNqc
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

Sashiko tested the patch against Linux 5.12-rc2, davem/sparc.git.
vma_lookup() was added later, and force_sig_fault() no longer has the
trapno argument.

Agree with the Fixes tag:
Fixes: 5b4fc3882a64 ("sparc64: Make corrupted user stacks more debuggable."=
)

Andreas, can you add the tag if you apply the patch, or do you want a v2?

On the final low finding:
The straddling window case needs sp just below an unmapped or read-only
page. A stack overflow always faults at sp itself, so I kept it to the
window address.

/Stian

On Wed, 2026-11-25 at 10:07 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential
> issues to consider:
> - [High] sparc64: call to undeclared vma_lookup() in
>   fault_in_user_windows()
> - [High] sparc64: missing trapno argument to force_sig_fault() in
>   process_64.c
> - [Low] sparc64: missing Fixes trailer in commit message for
>   fault_in_user_windows()
> - [Low] sparc64: fault_in_user_windows() uses base sp on page-straddling
>   fault
> --
>=20
> commit ee3413b56ca2f61248a64fe34c40cdf99b9dde0c
> Author: Stian Halseth <stian@itx.no>
>=20
> > sparc64: Report the fault address when a user window cannot be saved
> >=20
> > When the kernel spills a user register window and the store faults,
> > the window is kept in the thread's window buffer. On the way back to
> > user space fault_in_user_windows() writes it to the stack. If that
> > write fails as well, it sends SIGSEGV with force_sig(). The handler
> > gets SI_KERNEL and si_addr =3D=3D 0.
> >=20
> > When a thread overflows its stack, the first store into the guard page
> > can be a window spill. If the kernel does that spill, for example
> > during a system call, the window goes through this path. Stack
> > overflow handlers compare si_addr with the guard page. With
> > si_addr =3D=3D 0 they cannot tell that the stack overflowed. The Rust
> > runtime then resets the handler, and the process dies with SIGSEGV
> > instead of reporting the overflow. Rust's
> > tests/ui/runtime/out-of-stack.rs fails this way:
> >=20
> >   ferris[157185]: bad register window fault: SP fff800010f60bf90 (orig_=
sp fff800010f60b791) TPC fff800010f3a2db0 O7 00000100016039e4
> >=20
> > Pass the address of the window to the signal, as stack_unaligned()
> > does for SIGBUS in the same file. Look up the VMA to choose the
> > si_code, as process_fpemu_return() does on MIPS. A spill into a
> > PROT_NONE guard page then reports SEGV_ACCERR, whether the hardware or
> > the kernel did the spill.
> >=20
> > Closes: https://github.com/sparclinux/issues/issues/132
> > Signed-off-by: Stian Halseth <stian@itx.no>
>=20
> [Severity: Low]
> Should this include a Fixes tag for the commit that introduced
> force_sig(SIGSEGV) in fault_in_user_windows():
>=20
>   Fixes: 5b4fc3882a64 ("sparc64: Make corrupted user stacks more debuggab=
le.")
>=20
> > diff --git a/arch/sparc/kernel/process_64.c b/arch/sparc/kernel/process=
_64.c
> > index 7afd0a859a78c..af8d2efc0dd43 100644
> > --- a/arch/sparc/kernel/process_64.c
> > +++ b/arch/sparc/kernel/process_64.c
> > @@ -530,6 +530,8 @@ void fault_in_user_windows(struct pt_regs *regs)
> >  {
> >  	struct thread_info *t =3D current_thread_info();
> >  	unsigned long window;
> > +	unsigned long sp;
> > +	int si_code;
> > =20
> >  	flush_user_windows();
> >  	window =3D get_thread_wsaved();
> > @@ -539,7 +541,7 @@ void fault_in_user_windows(struct pt_regs *regs)
> >  		do {
> >  			struct reg_window *rwin =3D &t->reg_window[window];
> >  			int winsize =3D sizeof(struct reg_window);
> > -			unsigned long sp, orig_sp;
> > +			unsigned long orig_sp;
> > =20
> >  			orig_sp =3D sp =3D t->rwbuf_stkptrs[window];
> > =20
> > @@ -569,7 +571,13 @@ void fault_in_user_windows(struct pt_regs *regs)
> > =20
> >  barf:
> >  	set_thread_wsaved(window + 1);
> > -	force_sig(SIGSEGV);
> > +	mmap_read_lock(current->mm);
> > +	if (vma_lookup(current->mm, sp))
>=20
> [Severity: High]
> Does this fail to build because vma_lookup() is not declared in this tree=
?
> process_fpemu_return() in arch/mips/kernel/traps.c uses find_vma() and
> checks vma && vma->vm_start <=3D addr instead.
>=20
> > +		si_code =3D SEGV_ACCERR;
> > +	else
> > +		si_code =3D SEGV_MAPERR;
> > +	mmap_read_unlock(current->mm);
> > +	force_sig_fault(SIGSEGV, si_code, (void __user *) sp);
>=20
> [Severity: High]
> Does force_sig_fault() fail to compile on SPARC without the fourth trapno
> argument?  SPARC defines __ARCH_SI_TRAPNO, so force_sig_fault() requires =
a
> trapno parameter as in stack_unaligned() just above:
>=20
> arch/sparc/kernel/process_64.c:stack_unaligned() {
>     ...
> 	force_sig_fault(SIGBUS, BUS_ADRALN, (void __user *) sp, 0);
> }
>=20
> [Severity: Low]
> Can looking up and reporting sp report the wrong fault address and si_cod=
e
> when the register window straddles a page boundary?
>=20
> If sp lies near the top of a writable page and [sp, sp + winsize) crosses
> into an unmapped or non-writable upper page, copy_to_user() faults in the
> upper page and returns the uncopied byte count rem, but the VMA lookup an=
d
> force_sig_fault() use sp in the writable lower page.  Computing the fault
> address from the uncopied byte count (sp + winsize - rem) would report th=
e
> faulting page.
>=20

--=-nSYwDIwz8ecVshBALNqc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTK1ph9OaYoND1R57zoeAEuJe36VgUCawbPcgAKCRDoeAEuJe36
Vk41APwIVZtYAk2eq8ccobBV4d7VnzsfbjX1ri9Ha7lIVV0kUAEAumxE3+eNHdN1
kraQOM+DrDRCs32Rhs7R3ouBkT8qKQs=
=vwuX
-----END PGP SIGNATURE-----

--=-nSYwDIwz8ecVshBALNqc--
