Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B497342E40D;
	Sun, 18 Oct 2026 09:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.121.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792316013; cv=none; b=Ub2jIBfahqowhg9tWcXVLASrWi2rksBL8TfwN+2DWYtuAYjjPb5nH6+rDxaAWiMWN3ywX2f5h/IZBpYcANnWV4X0Ut2DkYxJPbhDATDWTQeDNfNhPLvcIyJCAP9dJKxGzQIN/URPw6JAsVAtX+sp5a55thJD63xE4i68XoO4Q7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792316013; c=relaxed/simple;
	bh=Yk28+70tYlvRlZ+qOKj5YSwATs8l/5YZSvBU/XXJIfU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SaH3Y75nnK7Jfddcpex7u0Nu/qlou6YLltu0DV1IyI73gQ38agZw5wW9wqCxOtXBpN2fxIf9ZYV/WcrCLRY2LzvDrqawFf+dvsm5fZGUenTyG+/ngCa3z2Mf++A2H5l9HYcb98+3birKu/yhN8upAuYMPxCsDokjZoKv0TSWsAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no; spf=pass smtp.mailfrom=itx.no; dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b=FuKjjgul; arc=none smtp.client-ip=91.189.121.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b="FuKjjgul"
Message-ID: <7db77dd421c0d6d76460486b7c5b51862d45d896.camel@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1792316009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Yk28+70tYlvRlZ+qOKj5YSwATs8l/5YZSvBU/XXJIfU=;
	b=FuKjjgulR1qJSorX33XA4xKmk/dO2/rj0nQEtSbU17XDU3p4kUk5fRb8phruvbMNlcxt/D
	J/B3NM3vETE0PZMuUwk5EQ7HVshg/0T/L/HV4anh66MNzb94KDdSOGuz5pgL7VUfu8n85F
	W2xNHJqsCQk77OQCmeqJny7/rVVvd1E=
Subject: Re: [PATCH 0/2] fs: honor FOP_UNSIGNED_OFFSET in llseek and
 positional I/O
From: Stian Halseth <stian@itx.no>
To: brauner@kernel.org, viro@zeniv.linux.org.uk
Cc: jack@suse.cz, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org,  sparclinux@vger.kernel.org, schwab@suse.de,
 fweimer@redhat.com
Date: Sun, 18 Oct 2026 11:33:28 +0200
In-Reply-To: <20260917151614.376867-1-stian@itx.no>
References: <20260917151614.376867-1-stian@itx.no>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-Qv/8uhU+y6VaKTutixcQ"
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-Qv/8uhU+y6VaKTutixcQ
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Ping. The series still applies cleanly to current master (7.3-rc7).

Since posting it has run on an UltraSPARC T4-1 (7.2.y) and a SPARC T7-1
(7.3-rc5) as the production kernel for a month. Is there anything you
would like changed before it can be picked up?

https://lore.kernel.org/linux-fsdevel/20260917151614.376867-1-stian@itx.no/

/Stian

On Thu, 2026-09-17 at 17:16 +0200, Stian Halseth wrote:
> Two generic VFS bugs found while fixing pldd(1) on sparc64, where
> userspace is mapped above 2^63 so file positions on /proc/PID/mem
> have
> the top bit set.
>=20
> FOP_UNSIGNED_OFFSET declares a file's offsets unsigned, and
> vfs_llseek(),
> rw_verify_area() and the mmap path honor it.=A0 Two sets of syscall
> wrappers do not:
>=20
> =A0 1. sys_llseek() takes a negative result from vfs_llseek() for an
> error
> =A0=A0=A0=A0 and returns it truncated to int without filling *result.
> =A0 2. pread64/pwrite64/preadv/pwritev reject a negative position
> before
> =A0=A0=A0=A0 looking up the file.
>=20
> Both patches only change behavior for a file with FOP_UNSIGNED_OFFSET
> and a position with the top bit set.=A0 Today that is /proc/PID/mem,
> /dev/mem, the sparc ADI driver and the DRM/accel device files; for
> all
> of them lseek() followed by read() at that position already works, so
> the wrappers now match it.
>=20
> Tested on an UltraSPARC T4: pread(), preadv(), pwrite(), pwritev()
> and
> lseek() on /proc/PID/mem at positions above 2^63 return the correct
> data
> and offset; a negative position on a regular file or a pipe still
> fails
> with EINVAL and position 0 on a pipe with ESPIPE, as before; and the
> stock pldd(1) works again.=A0 On other architectures the change is a
> no-op
> for every file without FOP_UNSIGNED_OFFSET, and userspace addresses
> never set the top bit, so the new paths are only reachable by passing
> a bogus position to /proc/PID/mem or /dev/mem, which then fails in
> the
> driver instead of the wrapper.
>=20
> The glibc side is
> https://sourceware.org/bugzilla/show_bug.cgi?id=3D34641;
>=20
> Stian Halseth (2):
> =A0 fs: fix llseek() result for files with unsigned offsets
> =A0 fs: allow positional I/O on files with unsigned offsets
>=20
> =A0fs/read_write.c | 38 +++++++++++++++++++-------------------
> =A01 file changed, 19 insertions(+), 19 deletions(-)
>=20

--=-Qv/8uhU+y6VaKTutixcQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTK1ph9OaYoND1R57zoeAEuJe36VgUCatSSaAAKCRDoeAEuJe36
VsRyAQCXwnq6yTVnSZUinCYFJ8OGnOZoLr1PPEUKlHLZzTHdDgD/c2tqf9ocAmRj
7xauA9EnnjAHTPJI7qlD0rK93EfK4gc=
=3O06
-----END PGP SIGNATURE-----

--=-Qv/8uhU+y6VaKTutixcQ--
