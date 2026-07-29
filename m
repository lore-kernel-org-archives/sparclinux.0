Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6242417D1
	for <sparclinux@vger.kernel.org>; Wed, 29 Jul 2026 01:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785288978; cv=pass; b=L1HCvJjk8RYRFszSrHtULMzP2h7hdPfLSTObW0sjULXK3S/LsJuFYFQlcTNlGYcmUbE5bcwy8X02rdS64IRU8NILx+aIFgkGI8NBD/JnSCL+6ZQK9Fmxgymf9GdX5PWTPKpj93/TIR5j3FYZP4wiqrYdAJhmzge4GjUaF76XB5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785288978; c=relaxed/simple;
	bh=smrSPmbFPzzbUQc1cVkn2G0XxLhpKiHLkqRA7mUmAXk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fhkmKs9tMynyuSkbVL+ptHNT2vNdvrFyDGR7ZFD+YIK6oOLAJZ/Dngdgu5k/Pq874twyfq/vKYkszNHuAkUBcF76Hb1TM1ZUaafv9KKnYIk9sOb65eYpQeSsl7Nr17rfxhBSM2xpI9D7vf4UT5QKt+ZUk8vYFYrCDBzpJDxs8T0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XaX5e/le; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XaX5e/le"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-697bd21fdc2so609613a12.1
        for <sparclinux@vger.kernel.org>; Tue, 28 Jul 2026 18:36:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785288975; cv=none;
        d=google.com; s=arc-20260327;
        b=KujAbKkUQmwsPcnjb1jDikvmnRQwf3gScozWzpPoCEGMg3d7akvATWdv3mWEx5P2vy
         QTkL2qmhMBdX+cxsuzSLm5r1vKPoTkAmx7n1qwgnkU/DHpVzoQ7lwGhT/ysYyS6FcGL8
         QstxMsCn7mFXqxDYt9lId5f4v26A1iDWq3Umrc+YTHp/JNuPTDD+GRR7A5Du2LyVFHAW
         d7OpQh8635q3NhhjtEihDCoz4GvKulRlldJb1e8wf8v3uvc30s7KeNbsUwSRe6Rd1JQo
         0VXsBrwZIKIVGN78PzuB4nZqXLPdSoG/q9jF5PBmDdBlNLZ2lz0umdChAJo9QK0I53uE
         fPfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=smrSPmbFPzzbUQc1cVkn2G0XxLhpKiHLkqRA7mUmAXk=;
        fh=/vV2knl49+CfRwWzO5tWCueptJLZ8WzJwUPICL4wtbA=;
        b=Sh0xOJL5EQ3g+35ecxpj28nCH22wA1uqkAq92NgiTqHxIIcce5Q/vX1xb3xOfujcmP
         ng177rXk6jD97I6eOi0fpyTknAeAM/3vKFAQfJDt+BdLBz/ZMLS4JVLksEH6CI2u5tr7
         cCk7lSoYfiRj+XaQr2gsIOfkcVdluGnP5U+u1/HgGDtnAOjZnifumoeWbLxfiQFHemCw
         dsfjrD20hIIfshx0HtW7neEml77RKXV+2cV71kN0nBXmg53qHDo1WWBe0k0H2ZAtMaUb
         GVOG/Mj9JQ5jLemGVlZJnZUyh9XBSB786FJ5d3yhDSkSrv4UKAuLvxZMiQSxMU5qyvWa
         J/SQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785288975; x=1785893775; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=smrSPmbFPzzbUQc1cVkn2G0XxLhpKiHLkqRA7mUmAXk=;
        b=XaX5e/lejryy8eBRGEfWv3wq0Nz03uOLR6EOPg7jcQSDfPT4aduSfAxqV2JjR/t889
         OP/QRQqZZyZ22Msw/Ik0B+5g2C45LclHQk/ssSQ9/4ve09nPj1n5wWr4yxqgTpLz0oyF
         LSwPP9rdEqXZ1nWIOmytddm76gQYOBWJPl7dD4BP3KJrOLqAZRK0k5XREgDVKcnLYc5k
         HulNUiGJofUTH0AJRarynzE8/MjUicQ0SNYWPzy4Ls52W0U1RQIQkwcE6KFCqHMdOPBE
         px8JECy7b9DsnMuSCDFH8QpuHGvdJuyCJ8jcfHuxrcgxtJfEOrvMgcms+0Cv0pD07arC
         /wrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785288975; x=1785893775;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=smrSPmbFPzzbUQc1cVkn2G0XxLhpKiHLkqRA7mUmAXk=;
        b=Y6ML4ZVT5mU1FpaFgZsBnA7Zoem6LWFf1+uc0xTgI+xkIcXpQ7pqM2K5bWLWC+E+52
         meLCyJHWO04tLqO7lUuwCYloe8NLpyLGAQehjEnU3ujChzUTMcTrnoK3Wll73XofHhXv
         +tlDydpwMFfXy/SCaT46mwylinZYxPYmxdW5f4ZqY+C1RgExVZ+ai4ppPzEFnADZQcZZ
         +KNkz+wozw/TxEGM0tdQuqpbSd4kwZ8apgZ6trnA/M4QuNpkd4QRhfadbnzWo1La3KEB
         dVzCr7DIWju7QIk0pwi/cLIsmSuy4eb0+Hi3Brd0B0+uryYvNtDTO7dtLD67FMI8o/fo
         SAWQ==
X-Forwarded-Encrypted: i=1; AHgh+Rra/+JCTENTnBnshQm5XdNRwvKMC/MZ9RJak+Okl4p9uxr1CGO+vimORM5tp6yHdikddm0p8FETBnSA@vger.kernel.org
X-Gm-Message-State: AOJu0YxhIQQDy8rcQq0W0Opm6X1bEjVyLtUhkzJlGoyrF+gj3ujoqvhf
	Tb/Xr+bq/75SyFgmf+jXT4/61asHc2055naXeoUFBAXMTJIY5UULcJuPmD5OweJh2zn1cVgka0/
	z6ZQ5psnxsvOLcwXWaa2zAXydPqL1Ddo=
X-Gm-Gg: AR+sD12r7dOMDta0IJ/GD30/LKcyS5geE0l3F4zbhOt36V1Df2DPP70hnI7U7DqSKQq
	xYoQweqiy7CrRDVDIGbruw2CZZDLk8g+3jVAQ0zKPJojoCnmDZqrGY1W1yKPCAVrSSjirUZpXqE
	NcOTp7ZMv4zimT4T59GxQ2F89tVZlRAxPWkdimJNdXQmHuoD6JPve/RfBn51WfxAq3kV222xETu
	COvBBSzvdNJCDPdAO89IhMKF/5qhRWC753ag0Sc+hH9uPjRA/ejO7uG/jUvSwZ1m+GiXZ1xXKt2
	wZ2lmCV7FzZoABYo812bQsYvZ4jGGpB8XqEQ7JR08b/86Gg=
X-Received: by 2002:a17:907:7b81:b0:c15:c658:dc0d with SMTP id
 a640c23a62f3a-c1f7212f768mr251959466b.39.1785288974858; Tue, 28 Jul 2026
 18:36:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716151110.1716607-1-main.kalliope@gmail.com> <amlKS9s1YYh5mOEi@google.com>
In-Reply-To: <amlKS9s1YYh5mOEi@google.com>
From: Nicholas Dudar <main.kalliope@gmail.com>
Date: Tue, 28 Jul 2026 21:36:03 -0400
X-Gm-Features: AUfX_my0gUeQYf1nnJh4m9pf7naN6uxhrPjSsEWTnFIn1kxBlXCU6U98WoIrpbY
Message-ID: <CAJZwKkhoVSuHqeNaC=3CK07UVLfCTAM0MNFRoi=hZ=X=t=nVNQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf, sparc: Add support for BPF_SDIV and
 BPF_SMOD in the sparc64 JIT
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	memxor@gmail.com, davem@davemloft.net, andreas@gaisler.com, 
	bpf@vger.kernel.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, Jul 29, 2026 at 08:33:15AM +0800, Kuan-Wei Chiu wrote:
> I saw that your bpf jit patches span multiple architectures.
> Assuming you don't have access to all these different hardware platforms.
> Just out of curiosity how were these patches tested?

Correct, I used QEMU for my local testing. For sparc64 I cross-compiled
bpf-next 520d7d794202 with sparc64-linux-gnu-gcc 11.4.0, then compared
complete lib/test_bpf runs from stock and patched kernels under
qemu-system-sparc64 -M sun4u. Ten tests changed from FAIL to PASS.

I also compared stock and patched runs for x86_32, parisc32/64 and
MIPS32/64, including MIPS R6.

For LoongArch I reproduced the issue under QEMU and Tiezhu Yang later
ran test_bpf with the patch and supplied Tested-by.

Thanks,
Nicholas
