Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=130.133.4.66
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795548833;
	b=plAdJJHa7MERVe7ZL4CSxG/MwPOTrby9VWX+nNz0GdL/KgnJoPVEctBx154bmfR2P5Eo
	 0qGVaRVByrlycTq7WLlyjVb+8+9v094M96qE957M0YKhsVehRb45sZPc41eeV4a19aw99
	 P1T+ORoA5eu2uoAhxsR4DpsKZiu97bi6bvJBmI/9I/L9dzOve6nNyfGlCLVtjSLWNSHpP
	 XWX3uylmZ8p6VNxBFDeZBZd4ek2RNpYiCZDzEk1CarhuLYEW2W80PZWrvULErtMjrA9Jl
	 zCO2LyHSlxdFIG+tfZc4GApjmXuY+h3QjiKVFDQCLt3QZBDP9F9sPdeXtAzPAGmY6KQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795548833;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version:X-Original-Sender:
	 X-Originating-IP:X-ZEDAT-Hint;
	bh=IVtZSHrw/20vsPvenADnoVXON8x/eogtw0OG4c6P4ho=;
	b=bRv5OMk9mzf6Gm2/J2uIt5m91ub4k9DFxvyeex5PR8Q39o/LUCgtKYH3xfXRFN30IdZN
	 NrGZKASuy7q1dsTwEcC2Ey2NP4znKKyvXQNNmHX1Nj37z+uBDySPhs2+5N9s/hN6vI2fT
	 wLMNVxTqQE7yzDPUTdKNxylp0h2eIpR+IKv7ALFPoprFoMiliUVHkLBJ4gy+gL3GY9OJi
	 KQPyIDMoK69kH0tgmku2aVNPLPR2/g+9YBmLsONK2eqdY1I3H8GgWsC1YWrGd5B7RhGCw
	 LVv0A4G4cgWpHOnfnVe6OW4UyUwp1NsBrVQzha0otx6mQo4Ft/pAETgwz9Rep63Qvbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=physik.fu-berlin.de;
	spf=pass smtp.mailfrom=zedat.fu-berlin.de;
	dkim=pass header.d=fu-berlin.de header.i=@fu-berlin.de header.a=rsa-sha256 header.s=fub01 header.b=eo6iiz5B;
	arc=none smtp.remote-ip=130.133.4.66
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C903E606A31E
	for <sparclinux@vger.kernel.org>; Tue, 24 Nov 2026 19:33:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C903E606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.a=rsa-sha256 header.s=fub01 header.b=eo6iiz5B
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=IVtZSHrw/20vsPvenADnoVXON8x/eogtw0OG4c6P4ho=; t=1795548831;
	x=1796153631; b=eo6iiz5Bz0pYGA5K0NJog01Q2NSxx8s9Df22+peZDYpHmaE9vnchRo9UP+m2T
	q+yxrCeJBzarE0YlrcNOl0d3XFK4WC52J5+f4mA9KilTnmUg8GpH9CrFcbBzyZKDEkMwjeuE8PjyO
	0pdQM8kRJKq7jmYmjlZnPqlkTVp4lV19bijhvrjrSsZoRkYO3uHpUr+dGIAsupqqj4QT23sIo34kZ
	nvwuQ/XSJyMi9D3qj3DC9U5rWKP/8Ug3hjpi3iqNud9IzWmIW9/6k9y3anfM4glZn7rBdypIwXdVm
	ZYWwOju5HpQoIEoH13wMXcrizpib/FwUH647YN+YfwQ0aKtDtA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.100)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1xVwGz-00000002qot-3ReI; Tue, 24 Nov 2026 20:33:49 +0100
Received: from p57bd95b5.dip0.t-ipconnect.de ([87.189.149.181] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.100)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1xVwGz-000000014eE-20lD; Tue, 24 Nov 2026 20:33:49 +0100
Message-ID: <1173bfb0f35755820ac7d94a3154e90f759a1558.camel@physik.fu-berlin.de>
Subject: Re: Need help replacing one of Debian's SPARC T4-1
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Kjetil Oftedal <oftedal@gmail.com>
Cc: "<debian-sparc@lists.debian.org>" <debian-sparc@lists.debian.org>, 
 sparclinux <sparclinux@vger.kernel.org>
Date: Tue, 24 Nov 2026 20:33:48 +0100
In-Reply-To: <CALMQjD9JtaF0V+eVanujrjBiR17V6tSGhUK1+cj9J1JmLPhfHw@mail.gmail.com>
References: 
	<14af96f20e7b24734c45f6f71b1800b6ce46b888.camel@physik.fu-berlin.de>
	 <d7695125c69b38407ab4a11f67b25bf2eb8f8b80.camel@physik.fu-berlin.de>
	 <CALMQjD9JtaF0V+eVanujrjBiR17V6tSGhUK1+cj9J1JmLPhfHw@mail.gmail.com>
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

Hi Kjetil,

On Tue, 2026-11-24 at 20:25 +0100, Kjetil Oftedal wrote:
> Just looking at the error. Might it be that you need a new powersupply
> instead of a motherboard?

The machine has two power supplies and both failing at the same time is
unlikely. These voltage errors are not uncommon SPARC T servers and we
have seen these on our SPARC T5 as well in a different way.

On the T5, we had to replace the CPU modules to fix the issue.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
