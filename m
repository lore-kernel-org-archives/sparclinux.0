Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=130.133.4.66
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534893;
	b=aao1/Gp0C81e51n1dVOzBdmOJ96sfZQb9xBd9gpi+2X/rzGZlzZ7cg32Gz2VvekoKOIc
	 1NbIQWawX3TC30AYW/EXtEovC49X7RgrbwOnhxRzxgGAAAzFOtsn5krlK2LA49apZFUpa
	 KIYB3aLbBIU+UyxlSftVxI5aRxq7pCanYXETs4d/JdEfgKGwpgBTxlnhwJULIlaCji+y1
	 IdMCPsX9j7SmAg/ZzB+dRguQhxVlCAkloDNQW8SHrwjffwd3d8mynO23SocwAbr/AEQH9
	 kGDjdENVnrz2aWmuAfJMwdk+ThnjaDhHauatcpghH6hYwxfOaQDSF0ey8peB+teegFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534893;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version:X-Original-Sender:
	 X-Originating-IP:X-ZEDAT-Hint;
	bh=Zml0fzMCOHmbZUBU3TQ91VKBQeHcH3jdtPoeZXxtV6k=;
	b=DbpFx/SjnXCNRvqV0Ymzwo00XqcjaOkOy8bWgFiV9H14IHgF+f9347wDT9gYxQ+1XG8D
	 +dPiBTCrZ94lWSsFgHFX8KfqTG4Ad0VRW/g9vOX7B7mHFODhz4CTxxbsKVmHiv/ZMFwoW
	 gm9j4/BcEGpiRVT0Vsol1m20HPwPOlg1jPwYcDsq8G9vXH34wjwSorc+FAjq6bP5WENbR
	 +lmz/P6DFoyXjzdA1kx7NIC6SgBKz3YkPpmUZAHYLhJAKPHe94jN1pnlx099fYXL313cK
	 uuItIr5Dk5hCR1Q+WecmQFp5PfDYOnoY+Pmi+YiDD1bhibR7JpTwuqRF1JrrHOJf78w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=physik.fu-berlin.de;
	spf=pass smtp.mailfrom=zedat.fu-berlin.de;
	dkim=pass header.d=fu-berlin.de header.i=@fu-berlin.de header.a=rsa-sha256 header.s=fub01 header.b=IptzpfG0;
	arc=none smtp.remote-ip=130.133.4.66
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E52E606A321
	for <sparclinux@vger.kernel.org>; Tue, 24 Nov 2026 15:41:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E52E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.a=rsa-sha256 header.s=fub01 header.b=IptzpfG0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=Zml0fzMCOHmbZUBU3TQ91VKBQeHcH3jdtPoeZXxtV6k=; t=1795534892;
	x=1796139692; b=IptzpfG0hx5OUijnz/wRkdeJCUu/5e/A9NoJVLc/QuLL18g6VRd+0nMBOglBQ
	8mSKsKPPEeaFgsYVSNo6+6RcLxlfm/XzgD9DVOEzq/Ut+QkS7pOlDabGVmxcm9x8O6+m4sv1cIcPS
	FwGKs9Q4x9KW5ippQOJ1ArkFJiMd1VDSjmuNomx+rw29JxEpmU8mN1f5tz6J/XC/vLETHIalQblPi
	yOA/JaKuj7gTdAXgGN2aiO7MfDNGPF61Fw9p0azr+LF9DrzsvlNYplCb7hxF/g3rU8iKVwItvXhI3
	y7IVp3W338GwnVuTLt/4ZHctEXPcVf9AtiEYl0CeNsHM/lMTBA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.100)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1xVseA-00000001uCm-1Qw8; Tue, 24 Nov 2026 16:41:30 +0100
Received: from p57bd95b5.dip0.t-ipconnect.de ([87.189.149.181] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.100)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1xVseA-00000000C4M-0OqS; Tue, 24 Nov 2026 16:41:30 +0100
Message-ID: <d7695125c69b38407ab4a11f67b25bf2eb8f8b80.camel@physik.fu-berlin.de>
Subject: Re: Need help replacing one of Debian's SPARC T4-1
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: "<debian-sparc@lists.debian.org>" <debian-sparc@lists.debian.org>
Cc: sparclinux <sparclinux@vger.kernel.org>
Date: Tue, 24 Nov 2026 16:41:29 +0100
In-Reply-To: <14af96f20e7b24734c45f6f71b1800b6ce46b888.camel@physik.fu-berlin.de>
References: 
	<14af96f20e7b24734c45f6f71b1800b6ce46b888.camel@physik.fu-berlin.de>
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

Hi,

On Tue, 2026-11-24 at 15:57 +0100, John Paul Adrian Glaubitz wrote:
> the motherboard of one of Debian's SPARC T4-1 servers just failed:
>=20
> -> show /System/Open_Problems
>=20
> Open Problems (1)
> Date/Time                 Subsystems          Component
> ------------------------  ------------------  ------------
> Tue Nov 24 13:48:08 2026  System              MB (Motherboard)
>         A chassis voltage supply is operating outside of the allowable ra=
nge. (Probability:100, UUID:xxxx, Resource:/SYS/MB, Part Number:7063388, Se=
rial Number:XXxX,=20
>         Reference Document:http://support.oracle.com/msg/SPT-8000-DH)
>=20
> ->=20
>=20
> I'm looking for a solution to either replace the mainboard or the
> whole machine now. If anyone is interested in supporting me in this
> effort, please let me know. The easiest way would be to just replaced
> the faulted board or server with an identical model.

OK, since I was able to backup the LDOM configuration from ILOM and also
have the latest firmware available, I will just have to look for a replacme=
nt
SPARC T4-1 to get the machine back up.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
