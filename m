Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795003658;
	b=EHzECR4bXpNWM+UnlF82WiaEjOZtaGp9l8JKcJPNA+/VsoBZwbZc7LMfXXFhf5jGBjz+
	 nRK/AdAyrYrn/zQ6wHV3ecGRBnmw1eP1uHB4RHFIxnLTz//gPESuHVafCgSTiyd6wkwXe
	 dEJ4TsWsGTMAemQayaOIQ/YkH58HZdgwf+SHlM7n00prz5x2YL2vp6UxRbrvoxWkNy/8k
	 fSEpw7Qf0nUs+kF4alX1a7XKg3bt2Sh3fBVoLkzOFdGOtREe498dARawDcIcL/Np81Fh3
	 plyfYmWmUXm+QbyutsDfKufRDZ+G4WY4I3au4d4rk2jti37nl4Ds3aYsYWnPrUHLwwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795003658;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=P+0uEEzysBwDVEJFldbQ69RtlM+ycb/aa/1uZEpypS8=;
	b=hKSrpcg+qqO3firK6zW5pTV1oFa6f/XYNc+OTXlGY2NlWNQkDWOLnw0HmMrdtgwT3Tuv
	 If0MMXwCheSLPjh//PRKnDyoqIviVAR/7s74svN0OqpxFTmZM04bGcatI+WygSz2DBJRX
	 uZV3wZRypE0mBlwbwVu8Q7vgCbA52YSjxGFkB1B744ah4kCWQczpKgg0HcGM3YpA9eqU+
	 fZcj68GDvniEs088kFTUwVVGCYh8HxJ884L973ZT9SX4+gzBnP67wSpCekLEUs+ky4xbW
	 B0+bquzP7S76UDB9jm3AVW5sIYQz96HQb88BKY3NW/UCEAXCX8YpdNXt0xb3Jc8BSkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FPySjeK8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9147E606A333
	for <sparclinux@vger.kernel.org>; Wed, 18 Nov 2026 12:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FPySjeK8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F368B1F000D0;
	Wed, 18 Nov 2026 12:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795003658;
	bh=P+0uEEzysBwDVEJFldbQ69RtlM+ycb/aa/1uZEpypS8=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=FPySjeK8l4XXkCbll/DeMe9aB6j5qK8M5mICSOde7fki2iFaYa/fGBX+5H9XxshmT
	 KlRG+r1ZYLtHWw1TyA8KANgMcyksrOd51Vt0t/0hsj1CxsBDVdqakK7DZ7v9k8Xo0U
	 BakvmIOD8h3mC2SbiNRCP+t+y24q26+Ng6HKgO6tKQpjjVkPp+5nmrTd0KxAMvUjWQ
	 D7uwqlkVjOmsoZq5ab4TKGUB4Wi6ujX8tuz0xDKHKKQFEm8t4aCkj6xOu8UZ58M9lf
	 XWFW2CXcrBkChHVfozRFamEl3QtyNBaHdOY0l5lw24VENZCIed+q1dSKugyGxaJ5ot
	 g7Glkm3S31GSA==
Message-ID: <sashiko-outbox-220876@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] sparc64: Stop the hwcap-list parser at an
 unterminated entry
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stian Halseth" <stian@itx.no>, sparclinux@vger.kernel.org
In-Reply-To: <20261118115537.160675-2-stian@itx.no>
References: <20261118115537.160675-1-stian@itx.no>
 <20261118115537.160675-2-stian@itx.no>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 12:07:37 +0000
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Post: <mailto:sparclinux@vger.kernel.org>
List-Help: <mailto:sparclinux+help@vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:sparclinux+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] sparc64: missing Fixes trailer for mdesc_cpu_hwcap_list() bug
  fix
--

commit d3a59092fe2c64c80fb8dba94ba6f29bf1d288f4
Author: Stian Halseth <stian@itx.no>

> sparc64: Stop the hwcap-list parser at an unterminated entry
>
> mdesc_cpu_hwcap_list() walks the hwcap-list strings with strlen() and
> strcmp(). If the last entry has no NUL within the property, both read
> past its end. len then goes negative, and while (len) does not stop.
>
> Measure each entry with strnlen() first, and stop at one that does not
> fit, as of_property_read_string_helper() does.
>
> Signed-off-by: Stian Halseth <stian@itx.no>

[Severity: Low]
This fixes a bug in mdesc_cpu_hwcap_list().  Should this include:

  Fixes: ac85fe8b2124 ("sparc: Sanitize cpu feature detection and reporting=
.")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118115537.1606=
75-1-stian@itx.no?part=3D1
