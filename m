Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD63369965;
	Mon,  1 Sep 2025 15:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756739858; cv=none; b=BFRuyCtaUDtFQAfFK4t5VPmo/V5RsxjOzn1F4OYQxH9BR47ILVJYNlW1NdRR6g28l7GqTva6NIKcaFXCiG2MVYlahrVM/7Qj1UviZGCB0RpAPli0i5xoY3a5tGOtOXleRlM5TObV4K5LXK7JH9L1oiO0UbprRRWMtFbNTQ/OeDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756739858; c=relaxed/simple;
	bh=8PXIiPPRnl7IVycBL0AG952KtfLHOuy/NV6IGpvmmVE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=iZAK2woK+6R/y0Ds+WWMmCCFgtmbRnDKeOFCX37mNy1GfvYUqReONwcyIHWXbxNf+7AOKYqIqOf2ooyqGcqiQq+SQd+TZGxox4TDKMVmafO92gzYO2plO1lKmQfbm+BUwFrqia05JFsDtlA2hTQTlMnvoLtwIH3XAIPtRLL33MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=hk4jVTqT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H/0JPw5a; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="hk4jVTqT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H/0JPw5a"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 144107A0248;
	Mon,  1 Sep 2025 11:17:35 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Mon, 01 Sep 2025 11:17:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1756739854;
	 x=1756826254; bh=jadb4EDVY+ByTvcBwpo9rDNcog0QvnUoF/PTU82u4wI=; b=
	hk4jVTqTF1hT3FdNa7bVHa1IxsIwlxKwKcBCivc2Oh2Lb/a/Imvinb/zgmq0HDQp
	MReVGygrrSp7AfrWj0cYcpN/hQ7n6aMLVnd11y7uFnPU3UdgDptJX7wBoBrBpOPd
	BWq7whAf08v8jyIpR3gfIqGhiLF6oBuboacOyHm52roBD6di6t83+xRd8eIm8xKB
	ZjP8fLMgc0FleWMReh9/EERxGH+0wBpGouIk5uDvtFFu11pZxB0JZQTmMnespLYS
	zN3cZjiUrkPECw+TiEwKJuumRV5OzBqp/18AQhJwfnURuTr9ZfFPYZpKfi4UKUpU
	FaC1m4VgVbI/B6sGiSwAgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756739854; x=
	1756826254; bh=jadb4EDVY+ByTvcBwpo9rDNcog0QvnUoF/PTU82u4wI=; b=H
	/0JPw5abdgy6lyqpWiU2mJl6Z7icxgsFwG95dKDs0bgha0tU1+1PutnGH32SzFbF
	7t6lIdFO0Rc1JZiBZ0m69hyyHdz1825ow9wfcVYjoI2XqwQitMQ1LUj2z8rDRq4k
	iRBfe+5i6y9W67zV8/7c+H+j9+XQKf5pzs41OdKW5djvMuqzAAyxfoTuQp3fSRp1
	cPsfK5gmGXwWX1FDk22CwqoGxxyQx//FoZ17R2q8ewQmjPf56/JBScubWTTqY9Sy
	7KzNq0okT0pdKr7narNJ7cj0ua7oUOr5qvCs9ogPFuNmOi/aRjW8en3jR5zpeXBf
	cElYjFmtZABxWhUAvQaxg==
X-ME-Sender: <xms:Drm1aB5Kyr1trtDXSOrAgfg7JBHZcqRpBts9NQGJx7TpsFoF5JNe8g>
    <xme:Drm1aO6eVi1plQuGwG6buxlIkur8R1s1zSb4MV18Ldb3NMUyx-2Sl7ux0qF9EIE52
    Upu0Eao01lYoq3ooi0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduledvgeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepvdfhvdekueduveffffetgfdvveefvdelhedvvdegjedvfeehtdeggeevheefleej
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepudefpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehvihhntggvnhiiohdrfhhrrghstghinhhosegrrhhmrdgtohhmpd
    hrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegr
    nhgurhgvrghssehgrghishhlvghrrdgtohhmpdhrtghpthhtohepjhhsthhulhhtiiesgh
    hoohhglhgvrdgtohhmpdhrtghpthhtoheplhhuthhosehkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehssghohigusehkvghrnhgvlhdrohhrghdprhgtphhtthhopehtghhlgieslh
    hinhhuthhrohhnihigrdguvgdprhgtphhtthhopehthhhomhgrshdrfigvihhsshhstghh
    uhhhsehlihhnuhhtrhhonhhigidruggvpdhrtghpthhtohepnhgrghgrrhgrthhhnhgrmh
    drmhhuthhhuhhsrghmhiesohhrrggtlhgvrdgtohhm
X-ME-Proxy: <xmx:Drm1aIBVcWOj3I1C-9_HdL69QPHsjQHCQTQWUOvyQ1NKIOMRJ0dkUQ>
    <xmx:Drm1aBy1icM59I1WdgiT3ByfnZ_VjCeCWFSNjKwKXX74zpuCag33Rg>
    <xmx:Drm1aGeMqWhy8L0r2JLPWpNgDqUAKOziFTS3-D-U4u5LLAek3RcwWw>
    <xmx:Drm1aOvZs8Rt6pec5JxcCxeMRd3_qQHn678dXLjgRI2gCOUr066_OQ>
    <xmx:Drm1aNomeLEjhm2nTkr-dYiO5on7w7YRZTnN6Nhzm0xlwtx0q7VHd_YY>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 4975A700068; Mon,  1 Sep 2025 11:17:34 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AxKiywhTe-eg
Date: Mon, 01 Sep 2025 17:17:13 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>
Cc: "Andreas Larsson" <andreas@gaisler.com>,
 "Andy Lutomirski" <luto@kernel.org>, "Thomas Gleixner" <tglx@linutronix.de>,
 "Vincenzo Frascino" <vincenzo.frascino@arm.com>,
 "David S . Miller" <davem@davemloft.net>,
 "Nagarathnam Muthusamy" <nagarathnam.muthusamy@oracle.com>,
 "Nick Alcock" <nick.alcock@oracle.com>, "John Stultz" <jstultz@google.com>,
 "Stephen Boyd" <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
 sparclinux@vger.kernel.org
Message-Id: <6390486f-ccc7-4f77-8126-1e0b3b67bc75@app.fastmail.com>
In-Reply-To: 
 <20250829124314-288d0445-a744-4022-93bf-7da255182411@linutronix.de>
References: <20250815-vdso-sparc64-generic-2-v2-0-b5ff80672347@linutronix.de>
 <20250815-vdso-sparc64-generic-2-v2-8-b5ff80672347@linutronix.de>
 <0b223e3d-25af-4897-b513-699dfeedfa04@gaisler.com>
 <20250826074526-a1463084-366a-44d1-874b-b898f4747451@linutronix.de>
 <271c108b-0fe4-4e7a-9bc7-325e75cf60ab@gaisler.com>
 <8f31efde-0212-49b9-a0ea-64d5532c0071@gaisler.com>
 <20250829122023-948f7969-b6b0-4ae2-9c12-71cc39abcf9e@linutronix.de>
 <b7ab1bdca349208532804d0d5e5af56817cd25c6.camel@physik.fu-berlin.de>
 <20250829124314-288d0445-a744-4022-93bf-7da255182411@linutronix.de>
Subject: Re: [PATCH v2 08/13] sparc64: vdso: Switch to the generic vDSO library
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2025, at 12:52, Thomas Wei=C3=9Fschuh wrote:
> On Fri, Aug 29, 2025 at 12:40:59PM +0200, John Paul Adrian Glaubitz wr=
ote:
>> On Fri, 2025-08-29 at 12:37 +0200, Thomas Wei=C3=9Fschuh wrote:
>> > In the meantime I installed a full Debian, but the bug is still not
>> > reproducible in QEMU.
>>=20
>> Please keep in mind that QEMU emulates sun4u (on UltraSPARC II) while
>> Andreas was testing on sun4v (on Niagara 4). There might be differenc=
es.
>
> I am aware. Unfortuntely I don't have anything else available.
> If anybody could test this on real sun4u that would be great.
> Or teach me how to use sun4v QEMU without it crashing on me.
> In the past you offered access to a physical machine.
> Does this offer still stand? Does it also run into the bug?

It should be enough to set the cpu to a different type. As far
as I can tell, the three different cases are all determined by the
MMU/CPU ID, not the platform type (sun4u/sun4v).

As far as I can tell, the options are:

- JPS1 (UltraSPARCIII, SPARC64 V) and later use modern 'stick' operations
- UltraSparc IIe (Hummingbird) uses 'hbtick' without VDSO
- All other plain V9 implementations use 'tick'

To test all three cases, it should be enough to run qemu with e.g.
"-cpu Sun-UltraSparc-IV", "-cpu TI-UltraSparc-IIe", and
"-cpu TI-UltraSparc-II", respectively.

       Arnd
