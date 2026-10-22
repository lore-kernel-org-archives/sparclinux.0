Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.189.121.228
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792657247;
	b=5oivvJNmpa4Kh9NfjVRUXz4jL705Ztj+gUuzfmk8EO2lOiZWhuHgahzO2UAs3heiHqxZ
	 tQe3HkAq494pXbYPkN+HOTO9dPrKdedMSAiDOL6Yp8X0bf7U9zg90uCNhIZ1xkuHqpWHg
	 T5mH84oifMraiEn8kM6MrTGEneCLjUJwwJirVS5jdGqTJRZoogx2MAMz3i4SzesZM41Y5
	 sBxKrp5ttjsppQgeuCzBocH2TCgZeu5sD8dmzHmIGPiTCS/matCZ9WLGWyDYu9WWPv+Ut
	 ETN+beJA7gzJ8d9cFhyrdsGtSCBHHrayW3WqFnsMRY26qVlyjpod6yRiuj0JGKAiVSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792657247;
	h=DMARC-Filter:Message-ID:DKIM-Signature:Subject:From:To:Cc:Date:
	 In-Reply-To:References:Content-Type:MIME-Version;
	bh=2otPSQyOzqjKfgmJ37i5ezI5QcKI3c1tok4QLLHQ5dU=;
	b=PYRIxWiRXnr3gBQFsKXQRUhZ7te4iWhM29rZloBLIoonQWNh0rnNpcC1nahUEXFeEo8R
	 jTW6I8JY22bvriXIPeAufbaBd5Y8quqFwhL5dgFxG8/RYY09ReOekUbplhRYS1BlsEQxC
	 yJGQeHqxPGjzQdNAqD2I+Ls9jnGtA8F8Kd/pyJwsQWS4S7GVVJI/XYhokyNdG53nR61ei
	 4Hm2eLKwK2yJ+lwWk9eEZdmZJuzhPUuGUzmvycb+6pDw7mil5lvfQqw/fW+f3WaAeqCJX
	 TQDvJl+npQoeuVY7i9IpM1vstGDnhA/dGDih5yD+/emI+pKWMVRyBIMkof9hcBU8qrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=itx.no;
	spf=pass smtp.mailfrom=itx.no;
	dkim=pass header.d=itx.no header.i=@itx.no header.a=rsa-sha256 header.s=mx.itx.no header.b=hgC3wTTV;
	arc=none smtp.remote-ip=91.189.121.228
Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0ADC606A31B;
	Thu, 22 Oct 2026 08:20:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0ADC606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=itx.no header.i=@itx.no header.a=rsa-sha256 header.s=mx.itx.no header.b=hgC3wTTV
Message-ID: <bfad4b87359161304015b04cc88f15cf07a055e5.camel@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1792657238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2otPSQyOzqjKfgmJ37i5ezI5QcKI3c1tok4QLLHQ5dU=;
	b=hgC3wTTVZl6b2UOCDz/hk0hOx81kefMFmcpfutss1tbAMk0W/Rze7xH3pX6mY2N7uRk4Rx
	GGMzUfyEm7FBn+ccwvijPYUvCWry+ypljW/yfDLcnuM1X7abswRJNX9Je1sNr5t3nIIDby
	VShSW3p7I1lVg7UZqPaf+fmtxTiHB9Y=
Subject: Re: [PATCH v3 0/4] sparc64: D-cache alias flushing fixes
From: Stian Halseth <stian@itx.no>
To: Imre Kaloz <kaloz@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, "Mike Rapoport (IBM)"
 <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
 sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Date: Thu, 22 Oct 2026 10:20:37 +0200
In-Reply-To: <cover.1792609488.git.kaloz@kernel.org>
References: <cover.1792609488.git.kaloz@kernel.org>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-QxkUFBLgW99UfyzqZm2/"
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Post: <mailto:sparclinux@vger.kernel.org>
List-Help: <mailto:sparclinux+help@vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:sparclinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0


--=-QxkUFBLgW99UfyzqZm2/
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Imre,

On Thu, 2026-10-22 at 01:33 +0200, Imre Kaloz wrote:
> These fix D-cache alias flushing on sparc64 CPUs with a virtually
> indexed L1 D-cache (Spitfire and Cheetah).
>=20

Tested on top of Andreas' for-next on my V240 (sun4u, 2xUltraSPARC
IIIi), against the same for-next without the series, both with THP
enabled. The stale reads through a reused vmalloc address are gone, and
moving an 8 MB THP to the other colour now takes milliseconds instead
of seven seconds.

I also checked 1/4 on its own by booting with the vmemmap check in 3/4
disabled. The four cross calls from sparse_init() still reach
xcall_deliver(), but physical address 0 is now left untouched.

4/4 can't really be tested on sparc64, since move_ptes() never
batches, but it builds and nothing changes. Each patch builds
cleanly for SMP and UP.

Tested-by: Stian Halseth <stian@itx.no> # Sun Fire V240

/Stian

--=-QxkUFBLgW99UfyzqZm2/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTK1ph9OaYoND1R57zoeAEuJe36VgUCatnHVQAKCRDoeAEuJe36
VnVCAQD276eDVP9yACZ0pHZnP6jdzf1PGdWYtFTac8LQemBX7AD/Qz1ugQwMouHM
/gljtdjKe4FbEKl+8N+lDB+fTRVFSww=
=yzu4
-----END PGP SIGNATURE-----

--=-QxkUFBLgW99UfyzqZm2/--
