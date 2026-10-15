Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B9750391B
	for <sparclinux@vger.kernel.org>; Thu, 15 Oct 2026 09:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792057534; cv=none; b=Ik6w0ZGmRcnAVezKczoKqH4wmaLP9lKgu5g1CDvGkzE8a4y0jsOr+bZjNsgksgo9LIsTic8uSAEb1YR/GwE8vM/VxS6KrSI9hKS0tQFpVHAOh8PSdoIEiu2y6vLX96MxIKMF4dJsRXqGa9K0jilLMKiWRyd/fTxehTfWhq6rKpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792057534; c=relaxed/simple;
	bh=7uD671pmVMs/GG7qCtecfsIB9Xednz3DnV7yLyykshk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Meac0Q2oBdZNyTNqa4ZxXOXEZkR803Xazxwis9nWwAqgQ2Hhxo27a165a9B0BABQuofQJOW24HmH9K+Rm1QHtv5ufp37zxA6BS40wczNRoJskmZt0EkNjdLG5RDDllEfnOdPjPrinCpym1toSAc+OkGnqQCCbitjFuRrgVzYWs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=ZznzT8HB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cPVh5N6U; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="ZznzT8HB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cPVh5N6U"
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A82337A0141
	for <sparclinux@vger.kernel.org>; Thu, 15 Oct 2026 05:45:31 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Thu, 15 Oct 2026 05:45:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1792057525;
	 x=1792143925; bh=r1tzCOkHV5jDjHScMXSBpN7g/AgiibaU0qItNz/gOGQ=; b=
	ZznzT8HBzk6bqmmI1rvPSALi3WMvqFMheYS+4cu7pgCeNfRF3BO3QpXcNALpEW0c
	43CJWO5TBCD9vGXpZsZKx0/mPQnBrexT1UGKVpKM5dPOZ2fYE+i+DI8jQwb/uvGJ
	Tstxqg+y3ZnplBkz+v5bJqCBcHh6qES7En6wjKN8YaDbDd2Lnu5S2gs0IWDkAQkq
	cgVjVUJ7h4vtoN9+zgnnLZo3wUZBldOCy2TNcBOE9Df8MR0UQ5THjnQwHYTIPdGQ
	ZH9ZUxBlpDXwnf+hkaVNK1TayNHWbPvISVDhklP3xZXaBOOk1yrQk7OBU2h/Z2e6
	sJ4rXiP3dEE9/rFP6fwR1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792057525; x=
	1792143925; bh=r1tzCOkHV5jDjHScMXSBpN7g/AgiibaU0qItNz/gOGQ=; b=c
	PVh5N6U0jMN/uiCAmBT1yRHM+VnKu2gJjggm5sPGmQwzdBLfbwoSM/z693M8aet+
	ghC7p2/zQtI6bK7adwhPcMZtoYgSgzeC0aZwpVE/ZfWM18/ESkILcGAXJ60UJqA1
	Emhf3pV8nxZytnksnYzzA8jNwdsOJlcEds6Lbj2nroLce3isJGidYmDcDe5uwdVr
	hYYXCKsaoBKLdVl0c9MVxvYiEAPo86myhmir32yZPaRjLjGq4C9w3W53ZjYzi9KQ
	iO1JQKZFfZi08UfgEHjHQfHIVX/aRbOAUXdwGALrY6GYBAv5HGWLiqoiP6PJxbLR
	zas26C+72qthTjn4BnNCA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=arndb.de a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792057525; d=arndb.de;
	mf=PGFybmRAYXJuZGIuZGU+;
	rt=PHNwYXJjbGludXhAdmdlci5rZXJuZWwub3JnPg==;
	s=fm1:rsa-sha256:AKJrtizz24kTk6m4r0DSFAsE0QGtbESZAQtYUz5aIE99fWg
	FUpvDQg036ulHjmu6XLB7gIcyxhRkAXHB64e94uEOVPduZdqrEfQM6q5R46Ia8X5
	64erI/RJvHhmaEGuKXko46iujg3WD6Pkc+VVppR2otTwfbQZ7dbE3dRdWw/AJG0L
	WAX1OdMyPX+cKdQMSSbmJN0t+NfGRq01DUKzUCjRztRb7Fusj4sgyQEXoCkEZJjK
	cMFhMOVtKDn66JmQNXtMM8pOGRY4Zb+z+yLDwBXHkLnT6CV4U61HEZRLOsqyYK2/
	Qjhp5a6u9dVZhia3PGyY50Ohh9WoTB4z94chxUQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:8V2xEtLHKoxGmPadnIZenC1kE65qORwVnVXR+y5enuI=:7uD671pmVMs/GG7qCtecfsIB9Xednz3DnV7yLyykshk=;
X-ME-Sender: <xms:sKDQari_DL1nGCfu7E_RDULe9nH0Rdm4t5wrLsbNGaYpadWnG5v37Q>
    <xme:sKDQai3F2xtwAbg-XvO29Z5Xw0gTH5Eal_W3hNbpK8XQu2wmCma0QA7qhg6dfmJEd
    eiiQVEbzBP5rBjF00ITW4LfbVLP3D8U89GZRcXe0dL_aO7uvmGLHg9V>
X-ME-Proxy-Cause: dmFkZTFCCY7MnPrJKPDx8CIW7Q6btopFgmLLsFhNIbGJJZAfC6SzaUN+XTsHmEyFk1CX+o
    /bn/3s68uUGOisZ0cSJuE+4dXBCQgIjmLDZabv55CP4BXOA++zALU7LmrisJdXboI7tDoB
    8CsD+PkBUZAAc31CGiX7Q4f5dnwyISKjJ4qqN/kcNDXDtEM9uC0tLEmEDpwHrFzNvBkuQI
    Yxn810dCgZQgUkMmnKGwpK3SKlxHYeuBVd7c3sH2C3lmro3qXPr/EFryncr4opl9ymMymX
    QfemNtBeJ8SRUQfGXyi51EZiDQrU4U8XC2Lmc5/FvZi6RtvYtFsaGjQevVNyqSOKPtQMcW
    7w/3C/p8l2B+C8vEKNT7nP0W8CZ55uPCOxvDNNPxV5BBWB2KwLgl71ormdAvTKQmbk3N1Y
    yb53SEPLNEYiAd8oOnS+4VjjqzDBjilm/Bh/CYQ+zrrwiHYG8xj2xEY6fNBovkbEZnCtxL
    AdA30czu4C9PUwjuIWRpkBjuiHdcrkwahCXkMQwj3LE121y6tLNzmSZL6J1MQNewlg6Hcg
    Otg2vaV6NfPPXRweIgylLc4ez7DXyX812Dv/8MixHxJJaumTBkYAM4XQsI2aDQCOQYWnkj
    jYHa6o8p4fx2YguprvGSdE1/KloWr4fFuLUyCcoZGLxqBWPhgVSfQhH+mo0g
X-ME-Proxy: <xmx:sqDQanG75E4rx2atLEB5Gkr3hubb11l4T9bzViq8vMUJnm0zS1ufeA>
    <xmx:sqDQashlaaSA6Q0nh_PobMdGmHlyEwlVmoSJ-WhxGIEDZzeKfUoHIg>
    <xmx:sqDQakvILIBfG5DDqruklOqoP1_wcvMmUED4oWP5CtSBiM_FCfDKaA>
    <xmx:sqDQavsvoeAvZgkv5wKK2AcDEsyjyc9fUGKvYmW6YAWydN5OzLVBPw>
    <xmx:taDQarqGM04RQDe1Q4d4heAU-9rg0Hx9EPe00b9gslJZV7Y0d0x45zkm>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 70E3832A008E; Thu, 15 Oct 2026 05:45:20 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AZUAoEL-p1MZ
Date: Thu, 15 Oct 2026 11:45:00 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
 "Ramin Moussavi" <ramin.moussavi@yacoub.de>,
 "Andreas Larsson" <andreas@gaisler.com>,
 "David S . Miller" <davem@davemloft.net>
Cc: "Thomas Gleixner" <tglx@kernel.org>,
 "Peter Zijlstra" <peterz@infradead.org>,
 "Guenter Roeck" <linux@roeck-us.net>, sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Imre Kaloz" <kaloz@kernel.org>
Message-Id: <6ee3bd4f-3563-4e14-a665-df1f766e4710@app.fastmail.com>
In-Reply-To: 
 <ed61723a01eeeb2e94306de3be3a363974b984fb.camel@physik.fu-berlin.de>
References: <20261015085545.3246951-1-ramin.moussavi@yacoub.de>
 <20261015085545.3246951-4-ramin.moussavi@yacoub.de>
 <7334b77c-2ec7-4678-8296-f187e0304f49@app.fastmail.com>
 <ed61723a01eeeb2e94306de3be3a363974b984fb.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 3/4] sparc32: implement futex atomics, with casa detected at run
 time
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Oct 15, 2026, at 11:28, John Paul Adrian Glaubitz wrote:
> On Thu, 2026-10-15 at 11:23 +0200, Arnd Bergmann wrote:
>> On Thu, Oct 15, 2026, at 10:55, Ramin Moussavi wrote:
>> > sparc32 has no futex_atomic_cmpxchg_inatomic() or
>> > arch_futex_atomic_op_inuser() of its own. The generic versions only
>> > work on UP, so FUTEX depends on !(SPARC32 && SMP) and an SMP kernel
>> > has no futexes at all; NPTL cannot run on it.
>> 
>> I believe there are existing patches for LEON with CASA that
>> should just be merged, I would not worry about supporting broken
>> CPUs that never had this.
>
> I think you mean the series by Imre Kaloz [1]? If yes, he actually
> implements CASA emulation unless I'm missing something.

No, I had not seen that one, I was actually surprised that Andreas
never merged it as we had discussed this years ago when I looked
at the Leon downstream kernel. I see it is still part of his
downstream patches at [1], at least the versions from 4.9 to
the latest (6.13).

        Arnd

[1] https://download.gaisler.com/anonftp/linux/linux-2.6/kernel/
