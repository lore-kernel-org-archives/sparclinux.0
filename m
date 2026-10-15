Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE07472061
	for <sparclinux@vger.kernel.org>; Thu, 15 Oct 2026 09:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792056133; cv=none; b=QLVwk9LCJqAMr7bdbb4ohDHTOTHnBvaV6EwPQjKu8m7zbfzedfH544pYIS7Rj93161yYd/zrvbcCpYMejJLPcvEz/mtYoaCBzlFCup5GxSmHIeHsfo/4sy1jaZyx21XY1864nGz7z2ZPZWyf8smJYd5njZk1ZeNR4oR5PdOpd9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792056133; c=relaxed/simple;
	bh=jy/Pjbi02wz7ArJryz+o6kKuOwg+ED2RqJ07aUl5AGo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Wk7/CLVLBFIroqn5Xax1TmIaj4b2knvWXlWRGJrNjprnpQs+44/RS/PHb7u8QH+bqajoJqGJ0+pSS+j7sD/p9Q2mQ5Q+WtVL5cQ0FdhBIwYdQOnY0rmkZoNrT6JaJIZFN8RQikD3D6T1rAP405AYU/x6L35xTNgX1fGva4U3NY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=e8H4uCkR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lVHD5jLM; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="e8H4uCkR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lVHD5jLM"
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B755E7A00EB
	for <sparclinux@vger.kernel.org>; Thu, 15 Oct 2026 05:22:11 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Thu, 15 Oct 2026 05:22:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1792056127;
	 x=1792142527; bh=UJw67Cs+GGD+XvNA13jOJdaU98z3SpAw+sGf1WWAOBM=; b=
	e8H4uCkRrgj+D3HXGRxtApd0b6+RmzkbvyXiXpprfPvTdrxwnDH4bvKEFpFWKC9Q
	SX8BndZrupxfjq2osDFrdv1xmEz7GcLUd3uK86V3vHxV1QCbVCT1w+PFLAHruFtn
	uoN4+cx6Tf5507aprfGCuVno274zOa0AyWQn3nDfSixEzblvKKrZEYdMDd7j9lSh
	Wihs48Bhg3+sLHytLVrTK7HgJPhEUAhRMi9O6wMp6fRhhlkk7EBldOt7w+Eb7Zds
	eAVGRSppU2Ajk/913m4OtO5/+IhRt5qZlLvG05zy1UbTVF3MnG0uQLEVJtfJrZhK
	+dyuKm6F0iWggYAdEFpLBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792056127; x=
	1792142527; bh=UJw67Cs+GGD+XvNA13jOJdaU98z3SpAw+sGf1WWAOBM=; b=l
	VHD5jLMGfJWKE/TKWkusMnPwnw4MCU4UzB/mHD182aig3mNsF9spxkMKMxi2NrEF
	8EG8GKSK1N+kXf9vTN8RMQ3cv5QHukJvMmKKoiJUdux8T7/9iq2MQeTrkEZpgas6
	oiMGh6+jQ4X+spgjaPQNXVANhOBlSinKv52mcKPYI23j5M5gmJcN6WJKmDLCycq2
	Z1FKeEyVApuvfW6gOQtRWPk7E0G9fYzLt6XcqXqrX6gtrF5rkosuonJ/lmpT2x73
	QNWwoG3C5cXES4Q/bb2n4rd6DTYzQDNyHp/REXLNGGUEfQB/tYITuTK9QmFiX7gm
	+70ROaJkj8UiauJ2Rf/wQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=arndb.de a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792056127; d=arndb.de;
	mf=PGFybmRAYXJuZGIuZGU+;
	rt=PHNwYXJjbGludXhAdmdlci5rZXJuZWwub3JnPg==;
	s=fm1:rsa-sha256:G+OZHKPRTiVn/V7ylrjHUfUJxJWJzZ3c9sqfttEyLE11OPs
	kNlTOoeC0Ggwd+fV3Ot+cwuCEML7NXecBq4aYdv/MamOaoDjuz6nSD8NWjarbRzO
	a27gBmOXXA5iMaDX/lm1ZFm+x5xrr7Q3XJG10aZslYTXuWO8+v60qAt+qiA6+86W
	EmRUmxKxwugJGCN5sRYPqkwx0mKFuqduiiIhCaKoIw59p1ybW3xzHnu5YVD6FnXI
	Zykirymx3pbVd0UXUsaADwoNyhwg9oiE0Zprhs1JehEd0guGNuZ4tmFUALuU4D5N
	bYnhvCfPZqNpcMtxqvWHw2muQP3IouURewruWew==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:N6DrRUvbfsCYHv5+ONQSza1zW2wWCovUYgLhASy71ek=:jy/Pjbi02wz7ArJryz+o6kKuOwg+ED2RqJ07aUl5AGo=;
X-ME-Sender: <xms:O5vQasLdJo3TUw1w0qfW3UQ1hDPcXg62NKylnCPcDdEnAzdK0zxj9w>
    <xme:O5vQam-LL4u9pZXgzKBpUjwC7rC51mxD9AsRlthqVMpg0gVvbQj8D62G0TDr6fOBA
    dBKVEqTID9oapzsHE3lVaK0Y7Ii9Gc1-7WM49l9Zdfb5W_fyTjtP10>
X-ME-Proxy-Cause: dmFkZTEQ7tL+B0cmzPWmlgl0t++8TW1ShCWzPJnHiO/VhQBdk7F9qwt1ajSxMo5o1EE6FZ
    c6ZytwrSuz2sbC7x17i5y+tf7a7sKwtGTF38zSByiOWFeV/oN0qyHnrsTKa/RJIEs//Ik1
    CsUNAGVG+xVVAuoOc2ABA0X6BKJzYJl52ZjWbsvSi0fQjdSTbNI1cA3OghEKD1p+43AYJ3
    OxTqr0ulnZfc6/NjgEV8qrLN/Eb3IdCSFIh1mVujbhlDiK+SWdXvx9h2yT9kGBRYESPgrg
    ICzD/MXD5lAQy8hqcGgITwMt9mT6ZTG66cw9BaLCVoXVAmcc44nBGm8xjf302WXX8dkRXe
    P5mEkvnQD9yF3IbyPJhNooHFxsQfiTTqOUudk+zjIoCwI/VZm0KFR4TZOM0g+Z6kGe8thZ
    WNisi8ZahG/+QK/wrMK+McN93E/1iDJqJIqU55IMWx73bX35uDZiZdFMFBVc4+/Yqg92Aq
    H8+ZpixK9TBPh/pRy96+lp4ZaJJlmvX9rwyzr7S/zqx0fHKpIFbSUXvCFOyrTcAhWAfjeF
    NmXgG2sh7XXTRF3xc1iPMS2VYGfad2hB4e2x42+dKnOEY/LMt3gHcnjkPn94rTTYwDziiM
    E39EidKrgA7XTU9Zh2etkbGJFygw3PD8jnH/PbPu3Wu1F3o+jQRFRCC8IhmA
X-ME-Proxy: <xmx:PJvQagJBrMGekYTKSYoZ7H_RrSEgExG8-jRVg0IGWAgm7hRHtCAlgA>
    <xmx:PJvQasJ3T8OOm1Q9-8-dSr4oS01bW1LeiCLy3JpP003beNSl9DDmmA>
    <xmx:PJvQai6aCbS0uO3Lcd8qN86BHlL_Vw-GOR7psnlXInfA31lpDoM3FA>
    <xmx:PJvQaufZt4HDIOz6wuKNs9ztJBsyYiU3jAClOycRsHZHfniqJ5MgYA>
    <xmx:P5vQapCNeGiPWKx6M90CT50mk4urtOlaGeOB-lWDYl3ek_hMBinTzQGq>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id E912B32A008E; Thu, 15 Oct 2026 05:22:02 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A6clDngWoEfo
Date: Thu, 15 Oct 2026 11:21:32 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Ramin Moussavi" <ramin.moussavi@yacoub.de>,
 "Andreas Larsson" <andreas@gaisler.com>,
 "David S . Miller" <davem@davemloft.net>
Cc: "Thomas Gleixner" <tglx@kernel.org>,
 "Peter Zijlstra" <peterz@infradead.org>,
 "Guenter Roeck" <linux@roeck-us.net>, sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-Id: <026b6108-f25b-47a1-a4e0-fa7717d926d4@app.fastmail.com>
In-Reply-To: <20261015085545.3246951-5-ramin.moussavi@yacoub.de>
References: <20261015085545.3246951-1-ramin.moussavi@yacoub.de>
 <20261015085545.3246951-5-ramin.moussavi@yacoub.de>
Subject: Re: [PATCH 4/4] sparc32: add the sparc_atomic_cmpxchg_32 system call
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Oct 15, 2026, at 10:55, Ramin Moussavi wrote:
> User space built for v8 has no compare-and-swap. C libraries emulate it
> with ldstub locks of their own, and those have two problems the kernel
> cannot see. They are not async-signal-safe: a handler that reaches an
> atomic while the code it interrupted holds the lock spins forever. And
> the kernel does not know them: FUTEX_WAKE_OP and robust futexes write
> the same words without taking those locks.

As far as I know, the baseline in sparc32 glibc has been leon3 or
sparcv9 for a long time, so CASA should always be available.

Any remaining sun4m users are on an ancient userspace with a
pre-futex glibc.

> Let user space ask the kernel instead. The call goes through
> futex_atomic_cmpxchg_inatomic(), so it agrees with whatever the futex
> code does to the same word, casa on LEON or the hashed lock otherwise,
> and a single system call cannot be interrupted by a signal halfway.
> m68k solved the same problem the same way with atomic_cmpxchg_32.

This sounds like actively regressing performance on LEON compared
to just using CASA and futex. What are you actually trying to
achieve?

> diff --git a/arch/sparc/kernel/syscalls/syscall.tbl 
> b/arch/sparc/kernel/syscalls/syscall.tbl
> index 5b9fe0e8140f..939e0130b7e2 100644
> --- a/arch/sparc/kernel/syscalls/syscall.tbl
> +++ b/arch/sparc/kernel/syscalls/syscall.tbl
> @@ -518,3 +518,4 @@
>  470	common	listns				sys_listns
>  471	common	rseq_slice_yield		sys_rseq_slice_yield
>  472	common	fchroot				sys_fchroot
> +473	32	sparc_atomic_cmpxchg_32		sys_sparc_atomic_cmpxchg_32	sys_ni_syscall

Wrong syscall number.

     Arnd
