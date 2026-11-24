Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=130.133.4.66
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795532274;
	b=r+CE+VDi4Afl/cIly+Oldrd8WMfqTvxTCNBl9XcHhG8AOHQ6TAoVmizRqfmM+HhcH2DN
	 wDw8SXqFHiDCLAz24fe2UupRk48x6l7EIBXgSTntX0oOZC1wVm66Ltk+n7dtKSfvEPfzl
	 /ck5IVsnTrcbAfxabqfDJJsF+8NDdc97/Ua8vd9mVAB+qJGsRp5bwG7XBEFAifD4yOkNi
	 h/HKXD5HwocKhdv2uq0/z2huiUm5x67zLcs/WNf+Mb0a7M4Zn/GqP78EEBcPyWHaVFUc9
	 m1T/0/qskUjcTByr+xbHHEvjEF+U50A/zVxDRTt1CnlOmAj8+0C9s0uT9MLpg8OfqWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795532274;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Subject:
	 From:To:Cc:Date:Content-Type:Content-Transfer-Encoding:User-Agent:
	 MIME-Version:X-Original-Sender:X-Originating-IP:X-ZEDAT-Hint;
	bh=GHya7Tr0Yh2mOV9GkWuMvozeGZR0bW/HvE2nDT1QfTo=;
	b=rzqYBQ5NL/u43ypb59bq6w6T2RvkXTMNZiorF8UzKmZDw3clYdYwDSgPxkE9A4i0UCxt
	 48HtJhkZiEIeDN/aTIEvc/EdorQkiYFVQFrlJtTD65wBjH4d0LlVVQyXiDUTpoxPHdU+E
	 QtDelNjCNUJBhkdIF+MYDX0V9VqR0UIHND5kTA8OR+daN/BRUEMBBxOAGxdlzCpeqP3oD
	 fhasMFXfQoxX+e5hF/6msZ+XdQlCfTTHgFZGN1j5j28Ev13rOXdaXsAanaDzQIH1FjD2B
	 67RwdnXg20Elij/NSvwJm3BaDy5eTGctCVSTX+VWwBHoAMUb29bghWD8KPFQh39hYDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=physik.fu-berlin.de;
	spf=pass smtp.mailfrom=zedat.fu-berlin.de;
	dkim=pass header.d=fu-berlin.de header.i=@fu-berlin.de header.a=rsa-sha256 header.s=fub01 header.b=ZZqtMlHf;
	arc=none smtp.remote-ip=130.133.4.66
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C41D606A321
	for <sparclinux@vger.kernel.org>; Tue, 24 Nov 2026 14:57:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C41D606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.a=rsa-sha256 header.s=fub01 header.b=ZZqtMlHf
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:Date:Cc:To:From:Subject:Message-ID:From:Reply-To:Subject:Date:
	Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=GHya7Tr0Yh2mOV9GkWuMvozeGZR0bW/HvE2nDT1QfTo=; t=1795532273; x=1796137073; 
	b=ZZqtMlHfMBOcMEL+lMvF6Vh54HxypNPTR46f/NBmvt5b7dAAwAg9z4oCqruuLV05hFo+RptntS4
	VNtN7DNvTnzB7HybE5zUL3tAiyUGnce9Hnmh7aRrzVpq0fRA8WEv6bgh2i4bF9oc6/CJ9CAUblcP0
	QjuS4fKE9zR1RxjVl9z+zBeucOseyg42zqyk54yuQkUkwvoga90EVQaKcoa0n1HjFuVwcFU67eQSq
	CHPJ6aANE37gJuime0kKmSIOnRkv7CTsBve/1RrtkvoL2kI+gnd91zW3rFkltWGYT7GxKRhXNXmK/
	8TX0PczuqdnCyNw0kvBBN/8nfyigQPGkMQzQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.100)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1xVrxv-00000001hgc-1lE9; Tue, 24 Nov 2026 15:57:51 +0100
Received: from p57bd95b5.dip0.t-ipconnect.de ([87.189.149.181] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.100)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1xVrxv-0000000473O-0j2C; Tue, 24 Nov 2026 15:57:51 +0100
Message-ID: <14af96f20e7b24734c45f6f71b1800b6ce46b888.camel@physik.fu-berlin.de>
Subject: Need help replacing one of Debian's SPARC T4-1
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: "<debian-sparc@lists.debian.org>" <debian-sparc@lists.debian.org>
Cc: sparclinux <sparclinux@vger.kernel.org>
Date: Tue, 24 Nov 2026 15:57:50 +0100
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

the motherboard of one of Debian's SPARC T4-1 servers just failed:

-> show /System/Open_Problems

Open Problems (1)
Date/Time                 Subsystems          Component
------------------------  ------------------  ------------
Tue Nov 24 13:48:08 2026  System              MB (Motherboard)
        A chassis voltage supply is operating outside of the allowable rang=
e. (Probability:100, UUID:xxxx, Resource:/SYS/MB, Part Number:7063388, Seri=
al Number:XXxX,=20
        Reference Document:http://support.oracle.com/msg/SPT-8000-DH)

->=20

I'm looking for a solution to either replace the mainboard or the
whole machine now. If anyone is interested in supporting me in this
effort, please let me know. The easiest way would be to just replaced
the faulted board or server with an identical model.

Thanks,
Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
