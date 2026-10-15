Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08364E433C
	for <sparclinux@vger.kernel.org>; Thu, 15 Oct 2026 09:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792055387; cv=none; b=pdCBDqqt+oBXeja8NbnFiEnc7QF2wAOWmbmm9XirgxhktqmErS/k09Gc7O9W5ZOiq2s8bd2qwbYUaPdAJtcQONWaEAwl66DmwLJcWDzkoGjEIMs5FJd4DX4PxMQ+oWEN1sUTojht85OZY9Fuv5FzykYCptQYZS5+7kn4hm6nRBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792055387; c=relaxed/simple;
	bh=d9alAxIXvFZM40lTHvWaninJ3uGKww6lRmkHHeBRZ6M=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Dos1fXEBBw1bZz+1rc4H8DwXrcmTFkMwPOpW00D8hF4qP7wTh24POu6jn5ePl2SFHjUg45kolhIS1Ekd2RT360k457Nfg14fr9oI5mxAzmqyJXrm61GXOUnSgsVhJwFtovtQhJefPrriG73qR71p+xOOpbjElIKtkgUAlSy7JVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=D+qa8S8G; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wBgnDK/T; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="D+qa8S8G";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wBgnDK/T"
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfout.stl.internal (Postfix) with ESMTP id D2C171D00133
	for <sparclinux@vger.kernel.org>; Thu, 15 Oct 2026 05:09:43 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Thu, 15 Oct 2026 05:09:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1792055379;
	 x=1792141779; bh=VRGmGdH6b6ZroBNEdtOfe+OMOyoDJIYRbWMgS31lg80=; b=
	D+qa8S8GS2I5k/AAROGYklkPil4cj/ftiCO8HSrPmWbha76piaeoXFyZ7PPtmb/1
	UcdWfXERBYuzfb2f2McUVkcIjc4fWIIZg/2FDHX4bJDEFVsL56GyBJhPq0QcjdQL
	GQ4qUziSU1YhcWHyeOIkdGxL/YwoJIudfLnNaU03WWyQIkxstpLH/tUQccAPpl3t
	CmASQtr4dJPlJ9Wom8rLI23ZdyGRZHCsFEWX2NRxyrZCAacwGkdl5B/+szER19Nc
	8xPS/KHAha4+cpX6VJqaOhrZdfBgT/9j2+f0wrb/opTTvYVtCt0TsSSXUQxDPxp7
	08v7SOistG/cVmGABFRnKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792055379; x=
	1792141779; bh=VRGmGdH6b6ZroBNEdtOfe+OMOyoDJIYRbWMgS31lg80=; b=w
	BgnDK/TdcefE+xyU/aBCPk3HKwGLdxbuxowpFBlQ4C/6v2XXb7VDse+ETiXVbBXO
	wkiz7LSJcwbQbmpqqnBOQplpfEq4APpwO0ktr5a/Cvg+i+GUqxe1VVGnUeA4qedV
	YCny+6SFlC4k7eGx/Kl2iiLQGKWgYuN3+/zmLTJPl4+4BbcNS09LKMHjSjorgkQD
	nUz278tEPHvBgj4juR4C8nFUfqMp4sphDufB8DMysf+xJQcXXI3ZGFTBSSR96J8X
	wCIwzaXfZ0RrK1plT9b9/wvC2+fXqmrefY/hc/K9JyfMKq6WiBG77UG/pgXlEUEv
	4vXFOq57qGCVgkCLZFETA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=arndb.de a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792055379; d=arndb.de;
	mf=PGFybmRAYXJuZGIuZGU+;
	rt=PHNwYXJjbGludXhAdmdlci5rZXJuZWwub3JnPg==;
	s=fm1:rsa-sha256:MkdAZpmCS2gYTHt/YzNuD+oB9H5+5QKJYB8u+TI/mtxXnO6
	O+SazKtzQxAP/qS1ePAe7UUfgQxmWtbrzfBpIrv3oB1l1WNO9NUuLroZ3uzvL6XT
	UOrcp/12s5JeR/7ByNpkxooElu9cQPeVTOR3wDEn7hOXhmSYBo2nZiGk2PbLykyD
	0Nt/bQ0hcgjD88bZGm5eRyeMgw8DZyFXE/A1iP2m0ma/tIxEKwUjlNbgk3y4F+R0
	K7qV6Ovl6KhRH6WPhN9Y++pRmvJ2BKg3bNKSfiCCZAEL0/Cuzi/1Fa6lkLZJqvQP
	8xoABGYHjydkImf7whzdmpJfKol6yHdHOkI3IsQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:PhAVofAeBeWbvcuAWvb712oJzRWQJZggJ04JJEhL7aI=:d9alAxIXvFZM40lTHvWaninJ3uGKww6lRmkHHeBRZ6M=;
X-ME-Sender: <xms:TpjQasiUp8G8-6JT--_GppFuXoXwZXu7ahXr4513kPgNfuvPVkZScQ>
    <xme:TpjQav3c9Hfj23wlGxwJow2wQkKGbMuJiA1ewGHX0wyTSlsooK1Ug8g3a3Ege0rKb
    jm6GzwWd64iAAYEuh27nCA8n_SMOdLME_8WO3YGX-Z4OelKjmzw2h83>
X-ME-Proxy-Cause: dmFkZTElMuyMN587ocprs+/zKZPwMudeRGeqblrqozgh9MgO5qIhq+0aFXFVnTRKTxgetS
    AgyOWIPVaLt6YuoFc56gMMxQ7wQje6NplP9eXUQF74eoc0sLDwhZRL9QUmSdDtXr/V61/v
    rD0bbQuXbWxPIJaGCv5bYXGiesoRH8kFMICwboMfD/aS8VOjGF0a8AFvOv+z6Z0TJKc2tp
    rO4sUI1bF8DLFx1qUSvcKuN+SK69d+sumRQJVUMFcBMgGiPIe7Egorp82imBSOh99PEdM4
    YOS9wSV9T6FaDhGtXwNf82cBd8w3Qr30zKczMBF+pCyiz5Q1SSXcPlfOQt6ppLmqqc4NQv
    lm1I1e6B633op5n89Dp1F5IDxKyIdZRCQjuMSog0rmL9SV5/p1bTXO5CFncJ6cvtnoiOj4
    f+CN1hFKoLK9mzrVWSk1Ft0rI9DghuRT2JEv5PbxDMedOz1a4eIUPTaO7sotdUiJh12Q2d
    x95IW86FsDeTBgXV23pRcwPx6XflZGeVtdaXr9wq+itEMnCx0QNdUdQ0ExpC4kEHmUS7mh
    d66a1u+HrLfN4eWTu8hHoErBpEAi/Hu5gyDDncpG6htqYF5q8uV4D1ntihEWInGPQIClFq
    a58hFz5PzNNENdK07nkVmXbSGV/x/0+3uUVKpz8fFE558D25EUcRFPN6TASg
X-ME-Proxy: <xmx:UJjQalh0F3ScKsCJxRh4vRGalunC4atUNw0RHUvw12wg5IP9YlFG4w>
    <xmx:UJjQamCXW_JxNONBr0HzO9qFz_cYJJdCeI_3yQ6NqFouf2ZFb5kSpA>
    <xmx:UJjQanQEQ8r5Zy1S5EU_q-cNnHQqZwhH4fZOsBp6YwifxJ_68ji5rg>
    <xmx:UJjQarX9LDrWbB-A-VCipFQjYnYAH5IRjeeyL8HnOQ7ahnA6SRdE3A>
    <xmx:U5jQan7dRTBahe3cDVqezArV0MhLS1KQANLrwuGA1rg8nIa-jiPtyoU9>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 8C29C32A008E; Thu, 15 Oct 2026 05:09:34 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AQvcS6cpqXYc
Date: Thu, 15 Oct 2026 11:09:13 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Ramin Moussavi" <ramin.moussavi@yacoub.de>,
 "Andreas Larsson" <andreas@gaisler.com>,
 "David S . Miller" <davem@davemloft.net>
Cc: "Thomas Gleixner" <tglx@kernel.org>,
 "Peter Zijlstra" <peterz@infradead.org>,
 "Guenter Roeck" <linux@roeck-us.net>, sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-Id: <26e4d054-c1d6-4422-962c-e123269d36a9@app.fastmail.com>
In-Reply-To: <20261015085545.3246951-3-ramin.moussavi@yacoub.de>
References: <20261015085545.3246951-1-ramin.moussavi@yacoub.de>
 <20261015085545.3246951-3-ramin.moussavi@yacoub.de>
Subject: Re: [PATCH 2/4] sparc32: wait for secondary CPUs by time, not by loop count
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Oct 15, 2026, at 10:55, Ramin Moussavi wrote:
> smp4m_boot_one_cpu(), smp4d_boot_one_cpu() and leon_boot_one_cpu() give
> a starting CPU 10000 rounds of udelay(200) to show up in cpu_callin_map,
> which is meant to be two seconds. But udelay() is only as long as
> loops_per_jiffy says. Under qemu the delay loop calibration varies from
> boot to boot depending on host load -- on an emulated SPARCstation 20
> between 4 and 671 BogoMIPS for the same kernel and command line -- and
> with a low value the wait shrinks to a few milliseconds. The boot CPU
> then reports
>

The patch is not wrong, but having a broken udelay() is still problematic
in other places, so it may be better to fix that instead.

On most modern targets, we tend to just use the cycle counter if the
frequency is known and avoid the delay loop calibration entirely.
Any reason that sparc32 still needs the calibration?

     Arnd
