Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794493023;
	b=ifaj9WWgWyIVhVqjpxM+X2be7NAlbGnm0Yd8alBQNigtySOmBICUr1z+WJ7OF7m/rDaY
	 Xapn/tRn1zAJH9ZdhI2n8oegtH/blUA+jIo5rtBETTYaEG+hj/6OLxocuPZ9REQ72c2zu
	 J1S7Dc0yx7vPYPGTLP9tIYcqKAC+l4A5uxcIbh3H09nL/vz5YOS5xqEWfCkmOk49YGyWE
	 IWD18HlnFEYEVi/ph2+PQ9lopxtf3e2M41ckUD4o8xf6oh9BVvS2PIKlWgS5HsGlX3PIH
	 cPexZVFjRlZFOmqsB511LWRGRb0PwezTsPdwAuQo+BHn2DuWqPCO7dD5C2o1uVAOB4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794493023;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=UbnPlEC24dkXjKamOs3/pbar/DmSKOkynvOR6CwNOYI=;
	b=zW8RdmcVqslLsdPLoG1YsvR+BVqWqGrsdJqD94p8ZrQwebgBzyj7xkrcc4uH7yFLejgb
	 xFj7bhNTqLY/vL3enrsYiQI1lz6kIJGhmXZGHp9BjlWW1HqBXyl9VWOsenKaOccmv0J9Y
	 VBacbFXapTXgeyc5o6wLpeANrWB+Rom4UDNhNZI2muI5YYLAM762ST1JwuTGKfjJqUZkZ
	 fUw4Xn/Q4aHtF6YKXwbSLwMoNxDCg2NTC+PWYALFMLpB8h9mPBCak+k6B5AEx9fghk03p
	 oNY7szxS+wu7dRknTw+Hy344ZP4Fi5hRRjRDOvVUMTigRkShnpXRmnKU2GoO3Mf5y7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arndb.de;
	spf=pass smtp.mailfrom=arndb.de;
	dkim=pass header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=Zo9efcIB;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=XhhVe9IY;
	arc=none smtp.remote-ip=202.12.124.144
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EC0606A8A4
	for <sparclinux@vger.kernel.org>; Thu, 12 Nov 2026 14:17:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88EC0606A8A4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=Zo9efcIB;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=XhhVe9IY
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfout.stl.internal (Postfix) with ESMTP id D1D9B1D00118
	for <sparclinux@vger.kernel.org>; Thu, 12 Nov 2026 09:17:02 -0500 (EST)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Thu, 12 Nov 2026 09:17:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1794493014;
	 x=1794579414; bh=UbnPlEC24dkXjKamOs3/pbar/DmSKOkynvOR6CwNOYI=; b=
	Zo9efcIBsV78Vf7GQOyuzvtCvTm2u3MlgEKOux4tEFcwIxcLJDAElgyImkKJZWGM
	RW8b/ibuCWyFPs4J/4r2X14zHg295WnvPsaAeswZzrgqtWFjP5sXGAaZIE2DGyGu
	PQzy8ZLLXtPB45VkkoDzxuXnCGMXaWwdJcwYoPZd90DojaeXxIQMrLdtgouHNmAB
	num6RS2HUj+pD1yxMzAN1uak93kdgfOVd2YiISsSy/cWw5d54zPRYYV7aThMlAXw
	UcVn9pirhBrOb6+N4bAQd+p+vVH/huRZfn+Ma8rq5f+viyORhqCpaX+JPDyoL90t
	j6UVGOGE4m7h9YEfDdeawA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794493014; x=
	1794579414; bh=UbnPlEC24dkXjKamOs3/pbar/DmSKOkynvOR6CwNOYI=; b=X
	hhVe9IYYq7iI/u1fU8tbuZ4FHSYY/53NyzJh7/mAIFWl/8U99ycxaF1H6lANmhIi
	bVjyp+45zE7Q1cm2do/HF2qh6F5gCGVnfE+5HuX7hPxFfoOwAXx0KjpXbwBO/tTC
	Vd8X8OVaheeQ4buEDOoLwgmoDku1J5ST0xaZzpMHkmKi92XZvvYrGzThEY0dLGVk
	ZjVFLII8bFfsH2lrybiI1OBpHwXL5fTtUb8xLYe4tIXAPslzLMnT39jTFz6uv5iZ
	vRY2lie75dslydLYg5XvHDJSkKkB5EB9VoGHmQpoVpeXcwFsmaMOrqhsWRh/k//x
	rPvQKHYw9shsucBIgAPqQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=arndb.de a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794493014; d=arndb.de;
	mf=PGFybmRAYXJuZGIuZGU+;
	rt=PHNwYXJjbGludXhAdmdlci5rZXJuZWwub3JnPg==;
	s=fm2:rsa-sha256:BB1QdHS2/gR5jXDHdI3exogqa0ECBfCMABiVh9MEPlXmWvB
	nZGiPZZRLSRgj/CwFGky1/3SLlr1yWzaLL5R348xONLiNDwclu6ShykPnyimUAbU
	WK25W8hW/Ygp7AvbyHm1UiBaT88ivzbihH0dAEYrkcfHrFsh9I1XlRC0giRlhCS1
	Y6Y5XL6d/3oPndP+OkczjUZMG+CbCbv3bPtLS168cCtcAUNrUPl4DOegPBubeKNT
	qLa54ts355kTK/f5sepseZK0T/jp1VXcSncO+u/59OvGLa1UzBbldz0OJfK16r0o
	aHmQJvU2wdo3f90kFgKMhVlWBqbHVpQ2VZsqUgw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:RJMoJlBKzRz4YafuepOWgyGgRwmbNROO/4+xzp0wgnA=:voWKWCaOGlpdmVP0Cwkilh51Ef0aw4U3oRcvlpmnlcI=;
X-ME-Sender: <xms:Usr1asjg9G4PPrrr82juOslt7WKJN2ox9e-bN6SzpTxkGdZM0A_dDg>
    <xme:Usr1av04JsRqLh9v9gbHE1H_izlBix8MV34vFWayd6EjzWrkxHPwiFWLrHvDmo26s
    ovJDj8__BsFibCUgFTXI737JjmO5mwOO0BL3xeXFvJrkizs4QQO0SsY>
X-ME-Proxy-Cause: dmFkZTGU1UV2oYSfQ0TDb1+YCaM1GfW0+RS3kK7MgTRdv3CA05JCz48Ta9CCSLlOcpZnTE
    5+ZOMsON9AJ3ihTXUUpRdagXPodCCoX6aSe4q5jQysfDOpftb9F+DFbYH7T2XBDQ7VjKfO
    kI6OhDcTdOghERSXPTFLEsqkUrMOnhT6vfB2kbZOXMxWGEnfDaRp9cSlFXHNSKBIf4r47G
    4UHIhOtAVLx1q6wW8GKxQdM7x6pA399ztVauThgsUqwHlKALouxJ7qbpJSnrvVw4HdBBfn
    rr0IGOO4fLpCz/qnjaC4U0it81fcb+Ukr6/dPb2fOTpIwMvU1Q1LkaugEouHuqsMSRrZMR
    wV2gg/g3S07ecr7z3571XaK5lEBI91xNUybORKYiWEuNXxwFFwvfUgSLVVUKe9kW/uxhbd
    GX8PX23AF79RywweGYodz3PlJe9ZozIMs2roOlsVr8lH0EB+TwL3walkuyEZQ+gY4fJSqa
    PRURPvRwJTeZh3C0FKz/ZoYkgakQuZmn8A3xnYOOTXuTOsozSOJV4MTOvyXPBX0L4u6EZP
    ZFekd1SJrKrVK/v5LX7o5DqlBAVNNSyi2f8yamaDRcunU86gEoaMyuQQj+9YR8LUFBeUyD
    uNY4M0HCGLraPM58SZuaw6nEEdvr0veDZlNZKCN8poVAPde3S/fO9I4sgxWQ
X-ME-Proxy: <xmx:VMr1aqkc6vj6abTdLo9cLUp0T0kq2sgpni80YY7mV3HtE5BBDfwxkA>
    <xmx:VMr1aiR95H7Gh3yZfCsXTicuFLoqUwgsX_WWV7HkuqoxcsoHYiNRkg>
    <xmx:VMr1aoYQy0UwsKNL0xGgEHQMls0uV32cDihyhr37Cxc9GbjGJVFSpA>
    <xmx:VMr1aq88aO4veFItIVp-gV4Ex-D1sEipyC0nBa7yTRep2NeKu6s2tA>
    <xmx:Vsr1aivy198MKwqJ4bN_4_eeISMyguI0Px1x3gP4D8vhBtwwmWJfmHEJ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 78F7432A0099; Thu, 12 Nov 2026 09:16:50 -0500 (EST)
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
X-ThreadId: AytIAyy8u7pB
Date: Thu, 12 Nov 2026 15:16:29 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 "Masami Hiramatsu" <mhiramat@kernel.org>
Cc: "Christian Brauner" <brauner@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org, kernel-dev@igalia.com,
 "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
 linux-alpha@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, soc@lists.linux.dev,
 linux-mips@vger.kernel.org, sparclinux@vger.kernel.org
Message-Id: <d7086f73-c6c7-466f-9f33-e64af741f126@app.fastmail.com>
In-Reply-To: <20261105-tonyk-syscall_table-v9-4-8d1275885d9c@igalia.com>
References: <20261105-tonyk-syscall_table-v9-0-8d1275885d9c@igalia.com>
 <20261105-tonyk-syscall_table-v9-4-8d1275885d9c@igalia.com>
Subject: Re: [PATCH v9 04/15] s390: Use the common syscall table
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026, at 21:05, Andr=C3=A9 Almeida wrote:
> Remove some of the duplicated code by using the common syscall number
> table.
>
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> ---
>  arch/s390/kernel/syscall.c            |  2 ++
>  arch/s390/kernel/syscalls/Makefile    | 12 ++++++---
>  arch/s390/kernel/syscalls/syscall.tbl | 49 --------------------------=
---------
>  3 files changed, 10 insertions(+), 53 deletions(-)

Acked-by: Arnd Bergmann <arnd@arndb.de>
