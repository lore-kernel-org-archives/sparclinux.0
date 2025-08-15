Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8452FCBFC;
	Fri, 15 Aug 2025 12:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755260053; cv=none; b=BRZ3gcQphSpT1Zu6TQf21i1rOI5KaH4QRIzra0/xIqaKNd9kmyl7lzysJNBO/84zEyRlwmYqmaSlvl6cosCNyl9znjcKTK11zIpu6wuIoKhgYVISf42mG105XP6z/H+o6uo9uEagkiJhNZjV2jj2ejSnFuLRuaJfSfQtI7mQUJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755260053; c=relaxed/simple;
	bh=zddmMbZ5zwaT5zNB7z4t+0ZLVcw4DW3R3HiTSGuUDB8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=S8Njg299yxD7ms7xQVQMvoQB47Xe4Ck7vMp+piAwIzSPKBTK0y8Kq+aLImbMeKoMmZ8L94LLHi5gK35+LLysjx84k92TCef9UfrFArR2fp+wjnFO4u+TXk2PjLpCanM0C999CWYtwCdftam4AsqV0j3R3kakUStr+si7ONDhiBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=ffRTOM6i; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=n3DDx6GV; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="ffRTOM6i";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="n3DDx6GV"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B948814000E2;
	Fri, 15 Aug 2025 08:14:09 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Fri, 15 Aug 2025 08:14:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1755260049;
	 x=1755346449; bh=ADkEeWrlFrIz2sOyZ2NoUjn4F7snk7WcS9BBBE2kxnA=; b=
	ffRTOM6i2Je/1jhl09k6xvOCGrFVBtirEDlp4B3uzKTMI6Yc4QhZA4X6qRYFWZd/
	IpOkRFUot7lvxFNlhV10ZBzcb/tj7RDt3ZJNTR1n4Pwy6wqpeFrbg4MRi+9qJ3bs
	2c01tttNpfM6BL5Bc2OnfwucCBZ8pZL5A01GFG7QqSZ+HlOIIAYX72ZpV6KkKVjt
	h7zdUNIDOoPGHVRH1c1ufWe5E14DNwywqI0oK4OXrfyUT5xxiTwaxW0vC2N+FPqO
	jQqiUvAdLDruF1DJSs9/eFd1F4OI//CfMypmYjpYAqoI+6+lxn/dSqB5L7IPW1b3
	iFZPavDf+iRb2fNUeJwsiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755260049; x=
	1755346449; bh=ADkEeWrlFrIz2sOyZ2NoUjn4F7snk7WcS9BBBE2kxnA=; b=n
	3DDx6GVwPkuWpCcnl2oBIX51VfAofMymoNKHMxp0wqCgvzdu5ly+WGf5mHiZQIW/
	4Q+OzsoIrADom53K2wdQVYSV6bjflcEt83z4q5A34CvVjJX9VVt05EfGk6LIrH+M
	wt3dT5IjEFrLAcVRE9HGJhbeHCiODpqYzPqoHI1H6LKGCJf/SNhySh669Cw2q8pW
	M3Aiet/Fzdvo32yWh2VVtH4Xz/uuA3BeTQLi2oOQTdxvk6vpiPeVSOeOJawqbDY3
	6tludJG6OhrSOONlusN0C5MAfVugPrI67QeMbPOgTIMUURpPFb/SbXbN7Vdz7gnZ
	3+IKrCa6rty7P/RJc4L1Q==
X-ME-Sender: <xms:kCSfaHCj9ret1UMrNueIywllb_7ctCFfOzaZRXdeMxz_xxY3G37KdQ>
    <xme:kCSfaNhSEP7XVUctVv3MlFDaePKDQIB2DuLzFqbWgLp0InEvfbDMU0MZ9FLVBqJtu
    5jhGY5JcDbl3b5Khms>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeefleefucetufdoteggodetrf
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
X-ME-Proxy: <xmx:kCSfaML6GXd1g0SMTDjWaALMARGnIUZstj51W1sczg6vVkf8Q20C3Q>
    <xmx:kCSfaDZeqTtrZb5JMo8IOE8XA2mVaGSlkZPzPr7Ub3kjC1vB3p9R-g>
    <xmx:kCSfaHnoCXC86-cs0k7cG039i0cnCIAbmOPXhu9ENUXW2TBp-FG9dA>
    <xmx:kCSfaJU5C_il4Kje4L5Qt2Mci8qClMWQWeajnRbPfYatfXtNBBdMew>
    <xmx:kSSfaHxTeagxzR0at-mSPgOMnlSR7ujJYNdqRCw2bukH8tHtIe8rK4GA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8843D700068; Fri, 15 Aug 2025 08:14:08 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ABINBsmLUku7
Date: Fri, 15 Aug 2025 14:13:46 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 "Andy Lutomirski" <luto@kernel.org>, "Thomas Gleixner" <tglx@linutronix.de>,
 "Vincenzo Frascino" <vincenzo.frascino@arm.com>,
 "David S . Miller" <davem@davemloft.net>,
 "Andreas Larsson" <andreas@gaisler.com>,
 "Nagarathnam Muthusamy" <nagarathnam.muthusamy@oracle.com>,
 "Nick Alcock" <nick.alcock@oracle.com>, "John Stultz" <jstultz@google.com>,
 "Stephen Boyd" <sboyd@kernel.org>,
 "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Message-Id: <bf9ec82b-af1b-4684-ada5-8529b7ceb06a@app.fastmail.com>
In-Reply-To: 
 <20250815-vdso-sparc64-generic-2-v2-12-b5ff80672347@linutronix.de>
References: <20250815-vdso-sparc64-generic-2-v2-0-b5ff80672347@linutronix.de>
 <20250815-vdso-sparc64-generic-2-v2-12-b5ff80672347@linutronix.de>
Subject: Re: [PATCH v2 12/13] sparc64: vdso: Implement clock_getres()
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 15, 2025, at 12:41, Thomas Wei=C3=9Fschuh wrote:
>=20
> +#define VDSO_HAS_CLOCK_GETRES		1
> +
>  #ifdef	CONFIG_SPARC64

> +static __always_inline
> +long clock_getres_fallback(clockid_t clock, struct __kernel_timespec=20
> *ts)

> +
> +static __always_inline
> +long clock_getres32_fallback(clockid_t clock, struct old_timespec32=20
> *ts)
> +{

> +}
> +#else /* !CONFIG_SPARC64 */
> +
> +static __always_inline
> +long clock_getres_fallback(clockid_t clock, struct __kernel_timespec=20
> *ts)

> +
> +#endif /* CONFIG_SPARC64 */
>=20

Something doesn't quite line up here: I think the check for
CONFIG_SPARC64 needs to be for "#ifndef BUILD_VDSO32", since
sparc32 kernels don't have a vdso at all yet.

On sparc64 kernels, I think you only need the
clock_getres_fallback() for 64-bit userspace, while
the compat path probably doesn't care about getres, neither
the time32 nor time64 variant.

     Arnd
