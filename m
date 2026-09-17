Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C7C49D584;
	Thu, 17 Sep 2026 18:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.121.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789670366; cv=none; b=ZcjkLETZLYlu2j1D60+3UQQMnqupodggWI91KqM2z/UQdBRNVP1K7JYLK2w9Gi8s2UGWAkhXVAWS3540PQ54U+vwE+UjFEvKzBVXLjme5OsiNSSIkbkWeavvllz4GDXKYo40d7IlELLUYyaj1uOwNKzyCIioFU0K+TDYfyLyMj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789670366; c=relaxed/simple;
	bh=3qgheNDpDoNpwe7qjMFsjA+BUMFJzCUNCnyNbURUnh4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ocGEXrEh2HPImgU6hkm5rid6pUOCRksfUHhsV5dU5duNJsCVGSqRwygRDb03rbgyCYy4KkA1UVIErS07NYiq/g78YH77OzCNlur8lCy9N9xigtd6yKUMxawUpr4WwpbhW7fQ2VEN3zz/A+lZytqYpqj4A3ULB4sUDKUfbskxpUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no; spf=pass smtp.mailfrom=itx.no; dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b=jBKG/+XA; arc=none smtp.client-ip=91.189.121.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b="jBKG/+XA"
Message-ID: <079e850678d07392c3bf067e7fff5a21f6ce5308.camel@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1789670361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3qgheNDpDoNpwe7qjMFsjA+BUMFJzCUNCnyNbURUnh4=;
	b=jBKG/+XAvxh4SdlR4QOqtzixele8zu8KNkSpMlfv5iY/dOVfO0Ak8Q4Uhou16Xd3xu4U/J
	CHN+IM+MtBYmh5DL6sTmBcs0Kd18oBOJR4MmUKijXCzz04Jvhp7/eBebzuGWaKDZ9QTcf8
	Befj8JHYuxwapIIlbIBrtNztj1MuE98=
Subject: Re: [PATCH 0/2] fs: honor FOP_UNSIGNED_OFFSET in llseek and
 positional I/O
From: Stian Halseth <stian@itx.no>
To: Florian Weimer <fweimer@redhat.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	sparclinux@vger.kernel.org, schwab@suse.de
Date: Thu, 17 Sep 2026 20:39:19 +0200
In-Reply-To: <7077da32d9aaa1d748bbc39e9416974ccf6aa8ea.camel@itx.no>
References: <20260917151614.376867-1-stian@itx.no>
	 <lhuo6dv50l2.fsf@oldenburg.str.redhat.com>
	 <7077da32d9aaa1d748bbc39e9416974ccf6aa8ea.camel@itx.no>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-IZYTIJt0pRmKUHdmKceO"
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-IZYTIJt0pRmKUHdmKceO
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi again, a small clarification to my last reply.

On Thu, 2026-09-17 at 18:45 +0200, Stian Halseth wrote:
> Hi,
>=20
> On Thu, 2026-09-17 at 18:01 +0200, Florian Weimer wrote:
> > * Stian Halseth:
> >=20
> > > Tested on an UltraSPARC T4: pread(), preadv(), pwrite(),
> > > pwritev()
> > > and
> > > lseek() on /proc/PID/mem at positions above 2^63 return the
> > > correct
> > > data
> > > and offset; a negative position on a regular file or a pipe still
> > > fails
> > > with EINVAL and position 0 on a pipe with ESPIPE, as before; and
> > > the
> > > stock pldd(1) works again.=A0 On other architectures the change is
> > > a
> > > no-op
> > > for every file without FOP_UNSIGNED_OFFSET, and userspace
> > > addresses
> > > never set the top bit, so the new paths are only reachable by
> > > passing
> > > a bogus position to /proc/PID/mem or /dev/mem, which then fails
> > > in
> > > the
> > > driver instead of the wrapper.
> >=20
> > For lseek, aren't some file offsets (the top 4095 bytes or so just
> > before 2**64) ambiguous as error indicators?=A0 You would have to use
> > _llseek when accessing /proc/PID/mem.
>=20
> Yes, for lseek, anything in the top MAX_ERRNO bytes below 2^64 cannot
> be separated from -errno.=A0
>=20
> For that reason _llseek is the interface that can be exact.
>=20
> Patch 1 ensures that _llseek works for everything except that 4095-
> byte
> window. The patch does _not_ change the fact that _llseek can't
> return
> an offset in said window.
>=20
> I think fixing the window requires llseek to report errors separately
> from the offset. A bigger change, I would need some feedback before
> attempting to implement that.
>=20
> That being said, I _think_ the window is unreachable in practice, and
> that no architecture maps user memory there.=A0
>=20
> I could add a sentense to patch 1 noting the limitation, or look at
> the
> larger change if the VFS maintainers think it's worth it.
>=20
> On the glibc side: 64-bit glibc uses lseek except on sparc64 and
> ppc64,
> which use _llseek, so those two get the exact result with patch 1,
> and the rest carry the lseek ambiguity for that top window
> regardless.
Just to clarify:
With patch 1, _llseek for ppc64 and sparc64 behaves just like lseek for
the other arches, correct for every offset outside of that top window.
>=20
> Best regards,
> Stian
>=20
> >=20
> > Thanks,
> > Florian
> >=20

--=-IZYTIJt0pRmKUHdmKceO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTK1ph9OaYoND1R57zoeAEuJe36VgUCaqwz1wAKCRDoeAEuJe36
Vp1QAP9KscPEuOKpQ66mMIyZFCDq+cqLPvG4EWc5NB97BekUXAD/TMgXYRZc1Pad
mf4SBGlYdxlHFcA+/4Tgz941hTB1ig8=
=vogw
-----END PGP SIGNATURE-----

--=-IZYTIJt0pRmKUHdmKceO--
