Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794493784;
	b=E+vFPAmO1acnd0/KTTb0JyprsjHrqHVeOU58j45hfkSRiC4PegSxxmZC3/etrqb4IiNe
	 yrhrPggRglpnesM7nWKCaAcFXwZiFia1zJCuRZFHIQbFRJaNLC/7LnJZFhCuTJhYpmvUt
	 V9WhtYWpgH7y0yPbKl5Qtv00rQMI80jrxYqMfPvkZcVaXh8vBvxGwViFvQBojUk7XpimU
	 50C8aa49fmbG0ovPTm3jbzgQ7QbwTK5nuG5bd0xas/0dch0mMOx+cCy+zsgNZdEBhi7nT
	 FerdWAqHVEBlExwNrMEnME1RjXG4EDqSIN3LIHmqA4L1NxbBvJSlhgku8RBjQF3rveg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794493784;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=hW2E8kdKpJ+xUhN2MQnavUZAOOSD3qe4wipNiYEXhF0=;
	b=SpbGIQ7HSeLabzT9LDts46XgsgIEJ6m6tP7p8ABwmrXRjL2sGRbza7/seMRSGpJokWQK
	 UqngrkOeoylwF1qqN9QEbpgeG8w/fNj0p+f3rSe54uWOZLslXG0MrYdQOZa3yLN87U0iL
	 L2QTb6U9tTryQOiWw4hMc+sLD804xMom1AHz4JUJikFSROdaIsf26XdtaReRjjB7DZrVL
	 UCAkT6RAApo0wD6/oUYUxfQaLjh+H4T8VlLHAJMYdi2OnE/DT/ddWChpIIZzm+wmAXKz4
	 KvXZyOqxVZPfS42r49nsOzfK9tgrIJkrvSQjIiM+oSnBPHn8csBVndUs3oSUwR0i/lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arndb.de;
	spf=pass smtp.mailfrom=arndb.de;
	dkim=pass header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=lIQ24iap;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=z7uYGf1b;
	arc=none smtp.remote-ip=202.12.124.144
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D594606B08B
	for <sparclinux@vger.kernel.org>; Thu, 12 Nov 2026 14:29:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D594606B08B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=lIQ24iap;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=z7uYGf1b
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfout.stl.internal (Postfix) with ESMTP id 89F5B1D00247
	for <sparclinux@vger.kernel.org>; Thu, 12 Nov 2026 09:29:43 -0500 (EST)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Thu, 12 Nov 2026 09:29:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1794493775;
	 x=1794580175; bh=hW2E8kdKpJ+xUhN2MQnavUZAOOSD3qe4wipNiYEXhF0=; b=
	lIQ24iapvAOQZVZ6ydsaVLJRRfDklhCsnX5aWzqcvZWpSm74aBJ3q6Hx1/B43cz6
	tghk4YVJTkzKPWelDxsaEZY/pHj+fcFEMBrnFUtmfDZry4L3GXILayeDk4pzccI1
	ECii1eSH/CovFmPj+EMEATyhjfyAjeucokX2VUTCrxEPfifLvwNaLA9ec4MJ5TB8
	EcVx21Qhzn3cJlk+0VZk39O28/xQ7euIhAlhMHLb20RHuohj5BMiWbGvmsnCC16x
	pdAqGH25Y+55iotIA8JG1IqixS7kapCE/OzUsvxgkhYnm45oW52yuIyr9BJjFVwC
	Yyz3yDYwVlbKgF29hdvj6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794493775; x=
	1794580175; bh=hW2E8kdKpJ+xUhN2MQnavUZAOOSD3qe4wipNiYEXhF0=; b=z
	7uYGf1bjt1U31PectUTsNVtzl+fZ0kQ7hAuBKicVJQ3Nf8+yoxbOLYyKH0vLxDEF
	IInberIjgAPtJucmqLnasoEPxPqTfm1P8DCWSvitqDypwjCtX1lmMMo3jRR7SEKi
	u6xLhpA8nIKkwB7M8hdZWfV/wVK+i3pauW2fGangVw/eo+qh98B2K5AXoy0gAPVi
	hQ90gk2UPTnkGy6PAwygBCnUgHdw/2e+1B0ZU1pjci+/G6jHYpQdXtN+ytooCzfo
	pokIWr9EvwywYrdU/UuRI0LobiXq/TReVtpmUPPYSuVzl71honacR5AR9+upsLXl
	G4yGZmGQ26rFrVUgRi9fw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=arndb.de a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794493775; d=arndb.de;
	mf=PGFybmRAYXJuZGIuZGU+;
	rt=PHNwYXJjbGludXhAdmdlci5rZXJuZWwub3JnPg==;
	s=fm2:rsa-sha256:ZRZ9zd3TpY3EvwbDdaTMCEPaQ3PmeHY8GYSiD45VlJgt7Mx
	jQ2mEadnbK7icQVbBU880vlkdXa0GsGoF+DmsF1dW8Q+yznllQuD2Sg3DoaU81KS
	7fMz6nogrHQz+6s8boKkyfCC7qx3cYKtGeWEtkJwKOV/6A/svuayF4oNeAHrr8rI
	UJz+a2rEYtRU0WDFnezYMapW8vSH/6zxn8vCXHbQeA+yQaRt5CY4W7U/5/jrZkdS
	7810SEQL7jyzjdT822AOQFo11N2NOgm/Uf44mU1R5JqyvT/ga97el2sHQ1Taz9P5
	Rw/U9D5g5wXOrb1j/zCilSPZe1j4YkW0KsaE99A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:KLKsz76cCoX4bOmDJGRV1iSPAdKOSqbFzYrIdbKT5DU=:t7kJO9uHylXzRNb/saffCqXhmz3H9h9mv/zp8RPQLpw=;
X-ME-Sender: <xms:Ss31as8XlTp6Rf0ylYvh2uYDxjtKqqxbZArthPyjH3T6fDJ52m26aA>
    <xme:Ss31avjwQTXEKWQ0d-EMKq16Z8kYuiIYW1i8TieVKZxmiw1AKaQnV1ekUWXHqMkmi
    fJR7benYkgPmJf07qMa1xjl-L8mzZxL0udrYJyngAZfNUpIKYOvEjWQ>
X-ME-Proxy-Cause: dmFkZTF2xlVBsTh7U0+KvcObs9lebmg4eeF4qotrVTF4RJE/4rVxnvYFU+GvGJ0J78d3gI
    BKJeLU6Si+YOg+wV9ocag27R2ErF1ahBsw81IPIsdo2TzZkvh+s9Zuzsv5K0e8PyxSxPEO
    0NEK/ykQ5eI7J8+aYgpoK09BsOeJ55ra6nlere87u9LJF3Hb47gWCKSc+1B+aapWOPtBa3
    qlwiHoznyMBeqjKfbUvnRiEAsE7tClJykrOnNbX+BJznQUkPg2aWw1FwD9g3vhOfWnSPkK
    728R4pfNK8cNCiT/OMyWFmeTExafPquSHVmgz8VCtEIZce4WrUMol2SBW21gKHHeYv88Ph
    MA/L+Mydzg8WJe7Y5Pn1h5Ox6usNldsxgBT9+ttA3Yo06NmzNUvGqKzz12IM3IRGz1dNCV
    Bkn6dhbNhoeLqVXg7Yckdou2t2EiuFb0QoCEIHSfZnv/P3sT9363SK1jgXdfuAxSRifqlq
    p15XI4Fmu3U913n2/jfO57kzfdLZTx4DnfVb0FV55OyAR0FRgDYm3G5emo1sYWul1+xLJM
    QeUGr7GcxlSsvOADcJWaAyalDt4nivh2F8GmKLi18TZXjGy8n3cQdI64CFo6PtnK5+kycL
    tambxqkz2bsvSEBGzAu79v20sOxZAJuU7n6aqQZKh0Ot2dzuMjZj8eNGOauQ
X-ME-Proxy: <xmx:Tc31aghH90_vDLqZUJG0Y60jMs0hPyIl52yEifSg5QBpUMIyGG8RZQ>
    <xmx:Tc31apfhJNW-s6mLeYNDN9yh56rKHDyLEXRI0e7JDIK0PQ5jAss4oQ>
    <xmx:Tc31an0neS0kqsvncjRPK7yaTmZ-mkrR9EQvCHc4HK7m4eN7DXmsiQ>
    <xmx:Tc31atrt3VmIh5W6ll5oUBQ4fIl3lK-kHW_7sXw9RuFQ4Z8xJfYWYg>
    <xmx:T831ajLG6GO3pgBdNoZwdHYtHcO0A2pz-6dM0EambJ8miToDE4E4JE19>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id DA43032A0099; Thu, 12 Nov 2026 09:29:30 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Post: <mailto:sparclinux@vger.kernel.org>
List-Help: <mailto:sparclinux+help@vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:sparclinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ThreadId: ACPK2aFADPe-
Date: Thu, 12 Nov 2026 15:29:10 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 "Masami Hiramatsu" <mhiramat@kernel.org>
Cc: "Christian Brauner" <brauner@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org, kernel-dev@igalia.com,
 "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
 linux-alpha@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, soc@lists.linux.dev,
 linux-mips@vger.kernel.org, sparclinux@vger.kernel.org
Message-Id: <d9b0cca7-5c28-4a48-97c9-36d64e46ee9c@app.fastmail.com>
In-Reply-To: <20261105-tonyk-syscall_table-v9-6-8d1275885d9c@igalia.com>
References: <20261105-tonyk-syscall_table-v9-0-8d1275885d9c@igalia.com>
 <20261105-tonyk-syscall_table-v9-6-8d1275885d9c@igalia.com>
Subject: Re: [PATCH v9 06/15] mips: Remove duplicated syscallnr.sh
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026, at 21:05, Andr=C3=A9 Almeida wrote:
> The common scripts/ already have a script for generating the numbers of
> syscalls file. Use it and drop the custom script.
>
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> ---
>  arch/mips/kernel/syscalls/Makefile     |  7 +++----
>  arch/mips/kernel/syscalls/syscallnr.sh | 26 --------------------------
>  2 files changed, 3 insertions(+), 30 deletions(-)

Acked-by: Arnd Bergmann <arnd@arndb.de>
