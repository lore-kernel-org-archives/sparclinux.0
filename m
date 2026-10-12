Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B95C47F3AE
	for <sparclinux@vger.kernel.org>; Mon, 12 Oct 2026 10:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791799823; cv=none; b=hMo44xuFB3YdSiyHWe5cobjeh4tEyoT1ZEm+dsTkN5f4COg8vFbcWLt/YM2wHIzEve2OFHZhWHgnbiMMakdyosoh3crQIzlngAQ47vxiHNspHxFLIjK+WpMn3gPFdpXitjalpvpXnwKZqXJ0TSYLNFg+u7hUPtpJ95D+Ql6nRAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791799823; c=relaxed/simple;
	bh=+DbMSoiQc5wpr6QZbKXbG6hNluqFD2dWM7GClh0hfEw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y6ZfuMaKJN8fRQ6MaxmjWjP5zMzQmz+FA/W4qYo/Uya0RfB/rgIYze6hpsTuQ42EyFk6H3f4GPvkt1Y0ui8b4Pqbm3zumjMTQfTmV8GZQr2Hm6IO6AjvCv9oQOMUQgRi2vU6tYO+mHIDZdSlosgmrQW1p1kgfOGLVvs4upsbauo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=Wdeijydb; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="Wdeijydb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=CWZQIK3Xb3imIK4HFMFxMDMIljdADDMBJ8kJJvmCVLg=; t=1791799810;
	x=1792404610; b=WdeijydbxzKMdb7MIVA/AigaXBGvXQLJE4OGApNRrHmksIHG6N8C1D7PtfJ4n
	IUZBYrildGsDbF3yTOGSG/O2nzhwjUtiuNQpSytANcgNgBLCQ/WzAF/Rf+s1yCFqyylQRnJj3odai
	Zig+7tz3PMzKBBDQO91JjoKurGvK7/yGmZK2jQ6/F15zjtHQ38WwE6rviFYvxjivbbvqdSTw5LUJ+
	rw1Yu2bVpsY1aXvlN7hs23z+lmWzhIxayO2YidVxD5EMszCYYQC3XbVUtUdl0DHdF1BqnJX1F25B1
	30LRazJcZ7hedp+AEeJkTzJ41p+TRHvuGt+ay4xYEQq6hjrScQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.100)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1xGCyn-00000003zM5-35uU; Mon, 12 Oct 2026 12:10:01 +0200
Received: from p5b13a90a.dip0.t-ipconnect.de ([91.19.169.10] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.100)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1xGCyn-000000021Q6-295D; Mon, 12 Oct 2026 12:10:01 +0200
Message-ID: <cada2221182674543d7c122325dc5326c5d0b449.camel@physik.fu-berlin.de>
Subject: Re: Mount crashes with SIGILL on v240 on for-next
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Magnus Lindholm <linmag7@gmail.com>, Stian Halseth <stian@itx.no>
Cc: sparclinux <sparclinux@vger.kernel.org>, Imre Kaloz <kaloz@kernel.org>, 
 Andreas Larsson <andreas@gaisler.com>
Date: Mon, 12 Oct 2026 12:10:00 +0200
In-Reply-To: <CA+=Fv5Rx5_bbotG4hoZA4W=vZxEc+6Mqh0-Lus62gB1kqg3nPQ@mail.gmail.com>
References: 
	<b74cffe77f82562fae8cf611349e765f1f38af2c.camel@physik.fu-berlin.de>
	 <14ae2aabb9e681a69818d3e02da8273cd12261b8.camel@itx.no>
	 <69c1798a6409879a70474c10e3d653fdb37c7246.camel@physik.fu-berlin.de>
	 <ef8e85c1fc00c999e74b2d43048bfa67997c13a2.camel@itx.no>
	 <01bd740a7b5f2c5cd12b4ba025fb9a53573188bf.camel@itx.no>
	 <ed3c37da1320ac19bd45dbfaa89957d9a8c05e0f.camel@physik.fu-berlin.de>
	 <b85e047233f5b38cdbfbd7af852ce30055680b47.camel@itx.no>
	 <c4fd9e838043b2b552ea9c33dfaf716a5e9d5b6a.camel@physik.fu-berlin.de>
	 <6a37e24972e63cf3c6212644e7c3f18a8a9c06da.camel@itx.no>
	 <CA+=Fv5TZYv53K=c9QFhwCSXJMVyCi5Kv6WjPKUcrPxEpU2BKUg@mail.gmail.com>
	 <CA+=Fv5Rx5_bbotG4hoZA4W=vZxEc+6Mqh0-Lus62gB1kqg3nPQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

On Mon, 2026-10-12 at 12:07 +0200, Magnus Lindholm wrote:
> Hi again,
>=20
> On Sun, Oct 11, 2026 at 9:28=E2=80=AFPM Magnus Lindholm <linmag7@gmail.co=
m> wrote:
> >=20
> > The latest kernel has all of these enabled and boots successfully.
> >=20
> > So the failure appears to depend on some other part of Adrian's full
> > configuration, or an interaction between several options. I will
> > continue narrowing the config differences.
> >=20
>=20
> I got a bit further, created a bug report here:
>=20
> https://github.com/sparclinux/issues/issues/113

Thanks a lot for the report. Slightly modified the title and stripped
off "[BUG]" as we use tags for that.

Thanks,
Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
