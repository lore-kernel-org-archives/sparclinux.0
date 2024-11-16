Received: from mail-4325.protonmail.ch (mail-4325.protonmail.ch [185.70.43.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A8E195F22;
	Sat, 16 Nov 2024 23:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731800692; cv=none; b=cb/DEhGd2nmrFxc7XuR4vUyiEWtIooZ1No3c0ZHjpYWXFzLAn6Zaufnilr0Nvk8ueKhmzG1dut9fhlTRju/+RgEna5bR2jmmn9S6Vyom3/Cn9lioJMiN5A0hfFKiS+K6SbZy1jmiBwCdQNA+U11XNDN8myIwUwYqaqKGnutmrcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731800692; c=relaxed/simple;
	bh=yX6PXFJsWJV++bCpi3eMzC7Yg2y6EF2jfCPjAS1De6s=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HRORF4DERf8RvTjcnkhrJGMNyFprzJw+GiT1FVW7Nki5MIhhSZPhvbH5X6nywGq8lASo06nWfAx9FiA+wer8i9Za6mYLHuacKJ8xcSL3w3q6dg0LPCJw6blrutukHT0q5MuGB4YCjn61gDwFbG7vJuUvzVa4XFNydE3MketiImM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=N+f6cozo; arc=none smtp.client-ip=185.70.43.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="N+f6cozo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1731800682; x=1732059882;
	bh=yX6PXFJsWJV++bCpi3eMzC7Yg2y6EF2jfCPjAS1De6s=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=N+f6cozoFNiMcqzL9hENR8Og4xWkBrgs3w6gNmsi0UCyUfLVmY9l9QAkYWyHdQYP4
	 /YfiWj93NHEWTTNvhfPHvdxU+E3lfGZe8KD/xnA8qkf5bwZ8Tk9HqdoeOXZauon5j+
	 pk8+fqffvmKCDCXtaRpPuiyk32Ny4qnDjzRxQNzwRvl9Ngnc7z56OQL6lYcd2d6/75
	 eWNwdjWR3eR2sO6plmyXTjktP7ZRM4M89XTE4jDYUTXefdEjXcu2wGzF4ziOsWbxj8
	 y6Zyf39ZN5amoJNNYH6s6cvV1moGuMm2jFFUW5d50OleDyhl4AXdPEge+Gikd8SBbS
	 p3UdbyX5jkr6Q==
Date: Sat, 16 Nov 2024 23:44:37 +0000
To: Andreas Larsson <andreas@gaisler.com>
From: Koakuma <koachan@protonmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v2] sparc/vdso: Add helper function for 64-bit right shift on 32-bit target
Message-ID: <gecz9pMRccdD2v_dImhonTGStG4FmiUko8IM2fkc9Rh2thw_QuSOvlsYTspZSf9bjtidQOD2uVL2aSaQ29-neWABRm1cpyXQr6xV0wELTU0=@protonmail.com>
In-Reply-To: <1b2e776e-0ae3-4f48-a2b9-99b486d49368@gaisler.com>
References: <20240808-sparc-shr64-v2-1-fd18f1b2cea9@protonmail.com> <1b2e776e-0ae3-4f48-a2b9-99b486d49368@gaisler.com>
Feedback-ID: 6608610:user:proton
X-Pm-Message-ID: 3d1c3566c3b675db725ff6937b0d516c7c4c2190
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Andreas Larsson <andreas@gaisler.com> wrote:
> Koakuma via B4 Relay wrote:
> > +notrace static __always_inline u64 __shr64(u64 val, int amt)
> > +{
> > + u64 ret;
> > +
> > + asm volatile("sllx %H1, 32, %%g1\n\t"
> > + "srl %L1, 0, %L1\n\t"
> > + "or %%g1, %L1, %%g1\n\t"
> > + "srlx %%g1, %2, %L0\n\t"
> > + "srlx %L0, 32, %H0"
> > + : "=3Dr" (ret)
> > + : "r" (val), "r" (amt)
> > + : "g1");
> > + return ret;
> > +}
>=20
> Can not residual in bits 63:32 of %L0 potentially pose a problem?

It shouldn't be a problem, upon returning the caller should treat
the upper bits of %L0 as an unspecified value and not depend on/use
its contents.

