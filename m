Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1555D3DAAC9;
	Thu, 17 Sep 2026 16:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.121.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789663551; cv=none; b=FIYRP9DDRjYTLcq0Cyi0Roj93yO0cHGNuVBoMmFqcGC29g8Cc6xeoJKKhYjwibuQOb2iAZ+T5kTBIxTH0WqdthhLhF3sKZGq1wxrAnSz0rqwGwukb1UlBu31JMYQuNuB7/pft8TbPKBkmIOQKt7fGtQxylZxZnpJsyfAgAD25Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789663551; c=relaxed/simple;
	bh=wzguD82Bxmn2t0ZmkzkAp/MrCpv/zzbAGjWUCYwhsaA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uREpAb2o2QCiuetYCuXPV76qQX4EM1t0eaaufpyMvocTkRQo45dk0daNCCxLkjr4wXX1GJDQ0TcEYV6P/Frw36nGJsootRhDfyFq3BKj/mHtqkvLRD9CLIoejgmm4AVl6Oz9nsusTlBbZD27G2Pq61EV003MGqxWmagQzCJVnxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no; spf=pass smtp.mailfrom=itx.no; dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b=KeCD27Yt; arc=none smtp.client-ip=91.189.121.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b="KeCD27Yt"
Message-ID: <7077da32d9aaa1d748bbc39e9416974ccf6aa8ea.camel@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1789663547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wzguD82Bxmn2t0ZmkzkAp/MrCpv/zzbAGjWUCYwhsaA=;
	b=KeCD27Yt6Z2BGpiHVPP5ps+cMStp5VYaNRfcTgaSb0vzJhFK2SLo5GfFY+Kho1pBtyE1nt
	t0TCE4PFp1HJX1DTPcEV/KMrjhEbbdsFFFsEYsD4QlPwEJ/HvBpHqQfK9SQ5FqD+08dCnz
	FIT7eXD8EfKfSZDoku4kkRw9nZCsi9s=
Subject: Re: [PATCH 0/2] fs: honor FOP_UNSIGNED_OFFSET in llseek and
 positional I/O
From: Stian Halseth <stian@itx.no>
To: Florian Weimer <fweimer@redhat.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	sparclinux@vger.kernel.org, schwab@suse.de
Date: Thu, 17 Sep 2026 18:45:45 +0200
In-Reply-To: <lhuo6dv50l2.fsf@oldenburg.str.redhat.com>
References: <20260917151614.376867-1-stian@itx.no>
	 <lhuo6dv50l2.fsf@oldenburg.str.redhat.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-ErG7nOQjqGsN6l2Jh7B4"
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-ErG7nOQjqGsN6l2Jh7B4
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, 2026-09-17 at 18:01 +0200, Florian Weimer wrote:
> * Stian Halseth:
>=20
> > Tested on an UltraSPARC T4: pread(), preadv(), pwrite(), pwritev()
> > and
> > lseek() on /proc/PID/mem at positions above 2^63 return the correct
> > data
> > and offset; a negative position on a regular file or a pipe still
> > fails
> > with EINVAL and position 0 on a pipe with ESPIPE, as before; and
> > the
> > stock pldd(1) works again.=A0 On other architectures the change is a
> > no-op
> > for every file without FOP_UNSIGNED_OFFSET, and userspace addresses
> > never set the top bit, so the new paths are only reachable by
> > passing
> > a bogus position to /proc/PID/mem or /dev/mem, which then fails in
> > the
> > driver instead of the wrapper.
>=20
> For lseek, aren't some file offsets (the top 4095 bytes or so just
> before 2**64) ambiguous as error indicators?=A0 You would have to use
> _llseek when accessing /proc/PID/mem.

Yes, for lseek, anything in the top MAX_ERRNO bytes below 2^64 cannot
be separated from -errno.=A0

For that reason _llseek is the interface that can be exact.

Patch 1 ensures that _llseek works for everything except that 4095-byte
window. The patch does _not_ change the fact that _llseek can't return
an offset in said window.

I think fixing the window requires llseek to report errors separately
from the offset. A bigger change, I would need some feedback before
attempting to implement that.

That being said, I _think_ the window is unreachable in practice, and
that no architecture maps user memory there.=A0

I could add a sentense to patch 1 noting the limitation, or look at the
larger change if the VFS maintainers think it's worth it.

On the glibc side: 64-bit glibc uses lseek except on sparc64 and ppc64,
which use _llseek, so those two get the exact result with patch 1,
and the rest carry the lseek ambiguity for that top window regardless.

Best regards,
Stian

>=20
> Thanks,
> Florian
>=20

--=-ErG7nOQjqGsN6l2Jh7B4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTK1ph9OaYoND1R57zoeAEuJe36VgUCaqwZOQAKCRDoeAEuJe36
VkoZAQCDy3TkbtQ6JnO16PSxWhQze7dMZrROIG8dWHifhd1rzQEAglxCtIFZm4TY
fXk9wuxKxj6kBKmCxz81UfctgIiq7wI=
=R+T/
-----END PGP SIGNATURE-----

--=-ErG7nOQjqGsN6l2Jh7B4--
