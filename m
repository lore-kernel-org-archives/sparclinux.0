Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=130.133.4.66
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793780830;
	b=EItiPd8xLDDY9AXoN9FRrE8FamgbDVPz3LdQUV/3j3u50FGD41N87/vuCqB2rF2Kp8L8
	 tZuCTdjw4xSsY/k6xfxkqk28RSTcq64K9hqFZawJFZ+I+iIWgSnvwImsf+Fe4O1A0gC9b
	 XnbTRhMlNXlVPiH46ZeqCSmeTOs4Xeptza77WLW9vDrEFp7luNeb0vteWFuTbHbgpFDtQ
	 DnQUpsrwbo+chrxMxVidsDUuvToIsu0025jkGlK66hPQrETLN5twLQWOh45a8qV50fCQ5
	 hz8XXK5raO1ZN2chdjHMF/uCNyyRSYTZJMvT8oQyHqPw1avIbjqEY5W2+k7hxrSKkVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793780830;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version:X-Original-Sender:
	 X-Originating-IP:X-ZEDAT-Hint;
	bh=s22dXJcp8/NUgMIEFS9UdVvM8WzYzrAsnia60zSo5QY=;
	b=gW0DNva9oEpD3BCrtTmLoKMl5xZtlvl7Y4SqAtPpd9OeeJeA0/buCaFS7cyaUcx6HAde
	 1xn8LzDKslaWN5KvvHQKUnSNox3C9yhGO2mbcDhy8/sYOmJ0yULxFMyOV9c7kza3QHV8i
	 2hsgzNRqIv1bcI5QdlN+j77Kz1IlVkdX2kagNgwYGLZjC25rjM4Zuw7Yh3B8hv3/6WwHq
	 2JR4rTNFjJ+luiDn4rqSqiR6lkreAJD55BE7x+YnlbIBJTJB50pp4uhZIYj220cafM5Yd
	 uzbhoZHyPoILdyI2Q5vYk2nqTmuNWUbQqeuRaKPis3YzOyNPpR/u2ubFl5Z3Nyw019A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=physik.fu-berlin.de;
	spf=pass smtp.mailfrom=zedat.fu-berlin.de;
	dkim=pass header.d=fu-berlin.de header.i=@fu-berlin.de header.a=rsa-sha256 header.s=fub01 header.b=BrCY9MGp;
	arc=none smtp.remote-ip=130.133.4.66
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052CC606A328;
	Wed,  4 Nov 2026 08:27:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 052CC606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fu-berlin.de header.i=@fu-berlin.de header.a=rsa-sha256 header.s=fub01 header.b=BrCY9MGp
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=s22dXJcp8/NUgMIEFS9UdVvM8WzYzrAsnia60zSo5QY=; t=1793780829;
	x=1794385629; b=BrCY9MGp/Ko95eVn34N71FqQ0aGex1l5lIWh7E+t85V8O8/FpPJCu35gWZt96
	qij9/sCcPNU2pzmO3xKc3M86NCfbQB/YI5icnz7lr/H8zbGpr3nLXxmU8ANKal/sa+gNJ2tpaHUDl
	gj8yoZQCAj+rRLeHOAdrfeD+PYlyIKrUYfOe4Z3R8p9Js8y2TOj7z9Pj8ATZV8X+wdS/u2SWIcfYw
	exG4+QecGti3B2cg1wME2+Wn1MzHhwm2VX7xk1Re6c2x8o5dP8wxELahZtZ3/GcOxtyTgaOcWzE6d
	DB6ORH3rLPtxgY0B/k+2DaqFhJ/thtuBHuT5e8hS9ee42fjkwQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.100)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1xOWKi-00000002TIy-3prZ; Wed, 04 Nov 2026 09:27:00 +0100
Received: from dynamic-093-128-160-215.93.128.pool.telefonica.de ([93.128.160.215] helo=[192.168.178.50])
          by inpost2.zedat.fu-berlin.de (Exim 4.100)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1xOWKi-00000000fE1-2VDH; Wed, 04 Nov 2026 09:27:00 +0100
Message-ID: <c2f6198c9fe5ef5f0b39438f4f664de75e65de07.camel@physik.fu-berlin.de>
Subject: Re: [RFC] Future audit changes
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Steve Grubb <sgrubb@redhat.com>
Cc: Linux Audit <linux-audit@redhat.com>, linux-alpha	
 <linux-alpha@vger.kernel.org>, linux-m68k <linux-m68k@vger.kernel.org>, 
 linux-parisc <linux-parisc@vger.kernel.org>, sparclinux
 <sparclinux@vger.kernel.org>, linux-sh	 <linux-sh@vger.kernel.org>
Date: Wed, 04 Nov 2026 09:26:59 +0100
In-Reply-To: <4855993.31r3eYUQgx@x2>
References: <4855993.31r3eYUQgx@x2>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.62.1 
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Post: <mailto:sparclinux@vger.kernel.org>
List-Help: <mailto:sparclinux+help@vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:sparclinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hello Steve,

On Tue, 2023-08-08 at 10:25 -0400, Steve Grubb wrote:
> 6) Moratorium on new arches being supported. If someone else comes along =
and=20
> really shows *sustained* support for the audit project for a while and th=
ey=20
> want a new arch to be supported, I might consider it. Since my work on th=
is=20
> project is now a hobby, I am not inclined to make more work for my weeken=
ds.

Sorry for being late with my reply, but I just saw this now here [1].

I'm not convinced on this argument because supporting an architecture in au=
dit
just means adding its syscall table in a header file plus some additional s=
him
code [2].

I'm not seeing how this is supposed to be a show stopper in any way. Existi=
ng
syscalls don't change and new ones are rarely added. They can also be easil=
y
synced from the kernel sources which is what libseccomp is already doing.

Am I missing something?

CC'ing the mailing lists of the affected architectures for more visibility.

Adrian

> [1] https://github.com/linux-audit/audit-userspace/pull/559
> [2] https://github.com/linux-audit/audit-userspace/commit/a5dabdc8b52ef79=
8e46d05403f09333fbc2c0f5c

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
