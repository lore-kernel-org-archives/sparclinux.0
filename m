Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88994A4419
	for <sparclinux@vger.kernel.org>; Thu, 15 Oct 2026 09:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792056251; cv=none; b=j5i1Fenyre1kPPhMBmy1rYbAL8O4Hht30JdyNDVC3AfyXmAKWAqy5K/fTd8BI8ofImTiO/4JAnnt4g/tElOx8VxFKh+oUVZNvHCbj0dJG8HAXC0oyuUBfXk/9LemWnzK6rVuEsch4Mc+sKOQh/qE6PD5+8XZuzyAodOTgP98tys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792056251; c=relaxed/simple;
	bh=+Os2SIm5LSoB8spju0ohIiU91kZIZSkIeuXDrurEVfk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=JhRJJ+0wYDsj1cUEKINFwgtjqgVACD5dtjHPw4TjnXU3QPKPuhQFwe4yXFc7T/KLGE02gwk+H69hSA752cT+aCeS6AzuDiHWjtMzYQtsNtsKLBnH9afFBMjA9+BOzv64k9MtX0itDL3epsD0D4C18fXhnGrKOFv9Lp7DpCesRgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=U2zdJ+NR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gbTK45w8; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="U2zdJ+NR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gbTK45w8"
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0D7007A0172
	for <sparclinux@vger.kernel.org>; Thu, 15 Oct 2026 05:24:09 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Thu, 15 Oct 2026 05:24:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1792056245;
	 x=1792142645; bh=9EMwPwk8ol1gS1BNzaaMpnTmbyLlTztA/AFWJQknBnM=; b=
	U2zdJ+NRscGHm75cbFwI5yAOZCdyja30NRsCSeHnfcZqtEbWjkf2eG2ErP5v2BqI
	2FGa7gyyON+FU9BL0V/XUrUo3WSTWe+8U188IKL/OGS1F16c0ht+GQviiHmGz5xd
	Zx8a/98OCTbbaQK2mG2jO5XK2u6XVFTEQKvyMC1SGBTX4CKM2vt06Dh375VxcCiz
	j7k8uAFaWWV87sfu6izfMXp/ncU39uM+GnXPHhMEa/hKc6ZJGJI2pZxhy+VroZMh
	l+f4daPo4Z/pXrEbZtDdz0bCVGpvo9/xWp4ocCUbTNMZwmdYwh+a3i2xzyXfUELX
	12RIpAA36VV/H2ygGd+6JA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792056245; x=
	1792142645; bh=9EMwPwk8ol1gS1BNzaaMpnTmbyLlTztA/AFWJQknBnM=; b=g
	bTK45w8Avb4sVDU5/lK92TlnO6wOSmELKEQRGhrS9MjTJTQMYquK4ACEtpJNKVll
	1YF/sgwqMmHYcplxriRRUcF92SJSAV5AumCzPi0gHfmFsNJy3D2tZgUZnV/ETJj2
	qNDPu+ZChKamF83RmskKsH188JJhYtLBZA6mkmDu4dckVnZwvEixrEKLRzSDrsGX
	Cf8qOBXMz0+6Zn0OVny/gOom2wGJtj2+ySQmyOeXiFEfACUhYQdPO9i2IXkKfRfz
	pGPfpGNRji39f/cWqWhWElTAZ+CimDpvIm7MGcM4DPl26H31nSpDA3EGyMO3amV1
	V1ILKsF6lvOPv37rgYeRQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=arndb.de a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792056245; d=arndb.de;
	mf=PGFybmRAYXJuZGIuZGU+;
	rt=PHNwYXJjbGludXhAdmdlci5rZXJuZWwub3JnPg==;
	s=fm1:rsa-sha256:gwgU5EFuy5KIQJZ2dCxKHOKnFkkT7jBz5h8o2CdfQqzlyAT
	RZY3Pr+TTEusIMjCay1SiA4EvmrS7tiPChRlYsrFAzoHMwE/2kI1+FOswRvV6GWI
	4cxv6ErjGTT/MBuKzv1lfNL0RS/cpk0NfbCEGaS6lMaaBf7lB8ZBO+Ye03KZZz8U
	A+RKS0Z9X0sXkMlGvvR4STQH5g/h1Dno5f+ESZP3q+HFiAzPxfpqtBbm9XHMjoCJ
	DgGRFW/egLATC+dJ7fZ37FtC0WaYcVYqGao9vuPIsijZ+x4F4Iqo8C2O5ZLMcJY6
	/rlziGt9+iPjV5k5rZAicJm5fa91dgnuQGU/vRw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:DegfGnrqa/jQ+z4Fvt8btUFRAUJpDxoWRViD6af4zZs=:+Os2SIm5LSoB8spju0ohIiU91kZIZSkIeuXDrurEVfk=;
X-ME-Sender: <xms:spvQasmEfTexOeek3k_JDBpqgIOO6vaI61A5rr2_bkCOSGtZ3MA9LA>
    <xme:spvQamrzmPgrZxBsi5auXeMwaGQnyDKaT6ygjCx9mdlYPGI88S1-xhy0QRzdnJ45H
    XDNrS-QIby5GG9LW3Isv1B5ZLfaryEY-zLoz9tx3I0vxnJ-Y38T6otC>
X-ME-Proxy-Cause: dmFkZTGXJXAva6kYy3lYkl74h5at3a6q449Ls9YHnShq7L9OKpjv37Z62ELCfsQp4izh0U
    d0Ab/ynVhd4deqOad74UwlFKZEbdRfmB6VnxeHTnhEWOj3Mw/GFLq4rTisO/M336yumlSW
    pV9g3V0mepq2AsmMYd6exZ1b6t71jS5UPmzPlI99Vri9xd+WG4HF9+eK9wbV/D/Nu8RVhL
    MeG3Pw1Vx5gIeNTY9tzDdrv4R9END9oZc2cuFbCK7RBLKTh3IRQCwkXWMPF9+8cYMFRDhZ
    iwvCJeV3i/j1jGBHRpYl/x2rXFruahXLBtrSNQ0TBeSBLwYB2VBgvdfszShka0bld0PpEp
    GmQa9N/iGa9Oq1Bx6ekNGTJoIbzh6p4i2r9lVVJf0MK5zZOpHIluW9qZ5/moEcyrnHSosP
    rle1wl3+Hej9e00G169BrdcnEOtHNnx+fv3KIGfbvXYEORzIBXvctqA0aJAMp0KIYTSMns
    /lCnte/YnyA8cV3rxKCZOS9tpuzcCIHGmCfmvSTDy6fLORclB7y/EamqAUVZwH+jcHsoz9
    3tDB2aRNKMjhDThI/RR2rWJ+YqOII488StTZq9xRwE5nHs+CCMklZhLSZ4te5QMrmgH1KP
    ADDf2GUuSVGddiaPnG1sdcxSIv/uZ/Rs1N31z9TVpghT3ky2bNZD1UzIQ6bg
X-ME-Proxy: <xmx:s5vQahENf_2Hk_A3JGU7VCzganvQaxDZIumorJYXYd0G8dvZuq_lqg>
    <xmx:s5vQaiXUOb-pCs9PszetlL-DopI0HUEqdCoAw6k6eaMO8q30PGVJiw>
    <xmx:s5vQalXiF4v8caTSRseU4628IZFhqbmRCZpKkobjSCkJk2Gaw9HOHQ>
    <xmx:s5vQaoKckz2sQwwiG334OsgXXSZqNpXTZ1541qoycN5u0DBFgp5p9g>
    <xmx:tZvQavvgu9z7I6TVnGjZB_j-EnGv9bOp4p0ydOwMkoGKf09LcvnxmYm8>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 5DA1F32A0093; Thu, 15 Oct 2026 05:24:02 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AZUAoEL-p1MZ
Date: Thu, 15 Oct 2026 11:23:42 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Ramin Moussavi" <ramin.moussavi@yacoub.de>,
 "Andreas Larsson" <andreas@gaisler.com>,
 "David S . Miller" <davem@davemloft.net>
Cc: "Thomas Gleixner" <tglx@kernel.org>,
 "Peter Zijlstra" <peterz@infradead.org>,
 "Guenter Roeck" <linux@roeck-us.net>, sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-Id: <7334b77c-2ec7-4678-8296-f187e0304f49@app.fastmail.com>
In-Reply-To: <20261015085545.3246951-4-ramin.moussavi@yacoub.de>
References: <20261015085545.3246951-1-ramin.moussavi@yacoub.de>
 <20261015085545.3246951-4-ramin.moussavi@yacoub.de>
Subject: Re: [PATCH 3/4] sparc32: implement futex atomics, with casa detected at run
 time
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Oct 15, 2026, at 10:55, Ramin Moussavi wrote:
> sparc32 has no futex_atomic_cmpxchg_inatomic() or
> arch_futex_atomic_op_inuser() of its own. The generic versions only
> work on UP, so FUTEX depends on !(SPARC32 && SMP) and an SMP kernel
> has no futexes at all; NPTL cannot run on it.

I believe there are existing patches for LEON with CASA that
should just be merged, I would not worry about supporting broken
CPUs that never had this.

      Arnd
