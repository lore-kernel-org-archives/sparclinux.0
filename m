Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C8936215F;
	Fri, 16 Oct 2026 21:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792186737; cv=none; b=mC8iha9ymTCsne+sSWsKDEXrZHUqjj8bnsX3gMs50r3+IYOrLa2uQOLsQ4iGEPU1XRgwRtXv2lYKobM0QI1jZmGH/XucNEV+L5FIECXRV+yzPXLu/OYU5VoJYQtEaNdOmg4eaLXDEMzVloP9p7qv3zEmTD4Mlz385GMu8m7NJw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792186737; c=relaxed/simple;
	bh=mbuynC9ckjkhYp367TPn/C+i6WQ2VNaT3Tlp8u5SIqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dTaKcXSbERGiCweknqqe9sDHOrcO6pZJDMtQkfVP3cDzp2e5pyTZQiExxDNhyO2oD3WM0W3sDUoSCeOuIfSwtcz6VCZQiPwF8M0lKVnuZ9wd1oaqW3dDmK99JNT4VNytcwb0XTz0edkjNGIKgQs3m+m4S46XBz7sZtaHlL/B/ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XGcdq4JA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bdkIdvqW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XGcdq4JA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bdkIdvqW"
Date: Fri, 16 Oct 2026 23:38:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792186734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mbuynC9ckjkhYp367TPn/C+i6WQ2VNaT3Tlp8u5SIqg=;
	b=XGcdq4JAHgCp4aBhqqoZ9g5VK2aE6JNPG6KhUi9xN2UUwDGJH1iNw+egEct4U4isixctIQ
	WxV9A7n+7Jy98VjmG0aVHU5Hmv2MEgahgEW1um/QVsRC7gdvA211xOGe7trXtc64FFN5Y9
	5JB4+ftdDYANep4lBEz83Fe11l/vhuEqjYH5UU/+c0YQ8nBhhH9UFn6wGW3NHo3DPhbfM7
	XjjskvYlAOJalZELbpTRwFkhvgaqnrLA9kkoE+5U6i4B0lJzas9X+g6W2WVcyJefZOXg/H
	zIWk7hARK4Zw7ES/GQ1MqtfYMll86b5fXpSmgZHmmuMkrKizULPF1yjS8abs8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792186734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mbuynC9ckjkhYp367TPn/C+i6WQ2VNaT3Tlp8u5SIqg=;
	b=bdkIdvqWrg1tPh+lh15OqybqstG9J9aDQ4fIv/rFpxCpWcGOQtRqJbyT49qJUXdEK/0XSY
	oVGwUCme75AXQtCA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Magnus Lindholm <linmag7@gmail.com>
Cc: pavan.chebbi@broadcom.com, andrew+netdev@lunn.ch, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3] tg3: normalize inherited BCM5718 register
 byte order
Message-ID: <20261016213852.o_aG9SgB@linutronix.de>
References: <20261011194228.981141-1-linmag7@gmail.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20261011194228.981141-1-linmag7@gmail.com>

On 2026-10-11 21:41:58 [+0200], Magnus Lindholm wrote:
> Firmware can leave BCM5718 vendor registers byte-swapped while standard
> PCI fields retain normal byte order. Detect this from the host-control
> revision marker, byte-swap bit and swapped product ID, without matching
> a platform model or PCI subsystem. Prefer the normal revision marker
> so already-normal controllers do not enter the normalization path.
=E2=80=A6
>=20
> Limit detection to BCM5718, whose register layout and inherited state
> were checked on M3000 hardware. Other controller families retain their
> existing initialization path.

This boils down to firmware sets BYTE_SWAP and we need get it out in
order to have the device working and break anything while at it.
I have here DEVICE_TIGON3_5720 on x86. I forced that byte in, had the
register swapped and then it fixed it back.

> Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian
