Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=144.76.212.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792771980;
	b=JQ2TZClQiww7MRV0P6+wb+QETfgEideR86qszHDTjka+/mY1E/cGoZ7L6dRIRYAe1Pm0
	 3VNYJY2OE57DHQNJ5w1n9uu1ArCo3T8OgS9T8irXIxpWT+YXtlNgWLTGYsNtklhn8SRyt
	 3ttaWCuHh+mzww7ciIMpqIMny3HY/zTY9UGD2YBxbhTvPnNPmzFker4RhaQZakF7Y3Meu
	 ei2HAu24SlvJzqrIDfN1qtHoIrVt9F43TaM9bTgZbskvQXZhoDUSly77gqLTjPDvKj3RW
	 B5PitfHbNcErOsjJm7uBLkJ9QbVjdlwSrvnl4aCaamL+Dq0rjoYRl2s0+v4ytbhA48A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792771980;
	h=Received:Received:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:User-Agent:MIME-Version:Content-Type;
	bh=yGzcuHazbyB+iutCF/crNYjapM1+TJ+FOmVntG5BXf0=;
	b=2nkI7YWEWCfjFq7Y5rN1WSAKPd5nsrOLjwQ1v6L4ORQ9Cg2HEKKOM63guj3LKsgKhXNz
	 wxv1zDIw6RLGVnwOHpYtlvssznZ7GJvTDABVEimseDYSp0zcqdqqgpmO/VLX/iiUTP/QI
	 nko65NsLlkOFc/g+ciOz1lIzuY1OyII1AJfVCz6xtgtu7S3AEs2hoamumhgNjB6AzEJLd
	 NPHWngr9uKxaD6rMqvCsQ8I7GYOffRCR0Z67zTU8do6up035j6J1e2qGd66+BTx6TDzr1
	 Kugy8hqZ0TPh53IlQpDCgyadxHbY9yl35qZ8iIIHKAJLM/MkTiI0Q+yZ1w5zwKRK3zA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=permerror header.from=inai.de;
	spf=pass smtp.mailfrom=inai.de;
	arc=none smtp.remote-ip=144.76.212.145
Received: from a3.inai.de (a3.inai.de [144.76.212.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6D1606A31A;
	Fri, 23 Oct 2026 16:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=inai.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inai.de
Received: by a3.inai.de (Postfix, from userid 25121)
	id 08B551003C513C; Fri, 23 Oct 2026 18:12:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by a3.inai.de (Postfix) with ESMTP id 062991100AC26F;
	Fri, 23 Oct 2026 18:12:57 +0200 (CEST)
Date: Fri, 23 Oct 2026 18:12:57 +0200 (CEST)
From: Jan Engelhardt <ej@inai.de>
To: Stian Halseth <stian@itx.no>
cc: andreas@gaisler.com, davem@davemloft.net, sparclinux@vger.kernel.org, 
    Tony Rodriguez <unixpro1970@gmail.com>, linux-kernel@vger.kernel.org, 
    david.laight.linux@gmail.com, glaubitz@physik.fu-berlin.de, 
    thuth@redhat.com, regressions@lists.linux.dev, nroach44@nroach44.id.au, 
    kaloz@kernel.org
Subject: Re: [PATCH v3 1/2] sparc64: increase kernel thread stack size to
 32K
In-Reply-To: <20260927212913.3237082-1-stian@itx.no>
Message-ID: <s0sp6639-42q3-s06n-q1p1-rp8410841949@vanv.qr>
References: <20260927204912.3667-1-kaloz@kernel.org> <20260927212913.3237082-1-stian@itx.no>
User-Agent: Alpine 2.26 (LSU 649 2022-06-02)
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Post: <mailto:sparclinux@vger.kernel.org>
List-Help: <mailto:sparclinux+help@vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:sparclinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII


On Sunday 2026-09-27 23:29, Stian Halseth wrote:
>
>Kernel stacks on sparc64 are 16K and this is no longer enough:
>several machines (SPARC T5-2, Sun Ultra 45) panic early in boot
>during USB hub enumeration with "corrupted stack end detected inside
>scheduler".

I happened to now run into this too with a T5240/Linux 7.3.0,
but (only) under a custom build that uses CONFIG_SMP=n.

The patch addresses this indeed.

Tested-by: Jan Engelhardt <jengelh@inai.de>
