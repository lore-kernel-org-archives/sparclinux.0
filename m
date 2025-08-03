Received: from mail-24428.protonmail.ch (mail-24428.protonmail.ch [109.224.244.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2842E3718
	for <sparclinux@vger.kernel.org>; Sun,  3 Aug 2025 01:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754183717; cv=none; b=bxWbFP22QSwzhP2OcllpNCnza3WoF5eeX27/h6XcIh0Ov/ejXNlUeaBRA2Ljq2FqFgVk14WyT5nYCCstCokzv5Ims6C5UOPDJP1fDfbEs4Ofkq0rr4PKgZlRnoE7aKkzbuAkZNvxMgyqZh/FJhP6l4rmWGs+33b2UMdiTURSohQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754183717; c=relaxed/simple;
	bh=AbaIU6fIUSKXfj+PX0L2qquN4QciTQ3wh05NpGZMtDg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tfGUywGUsxenIZ5rT5py6meT57fPg50WC6AWx8yGkszXIHSNTpCk2A3Hqx5J8SNiUjcZr8k6eVMiBOw3lzk/l0K/rdPX/IdG5GVIEd+i2QBvoFxt7t8kxu4H6U/g0TAyQ/cWaUgXOZt+hGFFccphE3yJ0UtragQ7tW9BlRh6OPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=T97XPUI4; arc=none smtp.client-ip=109.224.244.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="T97XPUI4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1754183706; x=1754442906;
	bh=AbaIU6fIUSKXfj+PX0L2qquN4QciTQ3wh05NpGZMtDg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=T97XPUI4tSewliMskEEfdhM9+rL4wQR5XTgDapne6TbIss9LIky4jV4ZyRS3+5+JF
	 fpi/RTwE7ql0HxcwhfjkZbjImlu2Q7tmFJ/xClJ3+WskhwQrivDObMu5ynWTfvFzT4
	 aMMvFS9asFo5YMj9xYiXkABchmrwWHic28SnmnsrbChrHBBbNXm0SUhTEhcT7teS93
	 s0XagZEbf+7sQRqVDzNkaymm6JjRYsUNdVZm6DCDskZY8DhAQFWrqMnptUcyjg+LB+
	 Tevpf+RfsAR1mG5PYDfzPMhKKeOwwbMx0MflpSc9XSDJ8RnVzi14su5nT2N2hSX2WQ
	 2XWWUtmkYEBpQ==
Date: Sun, 03 Aug 2025 01:15:02 +0000
To: koachan@protonmail.com
From: Koakuma <koachan@protonmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH 1/2] sparc/module: Add R_SPARC_UA64 relocation handling
Message-ID: <L-bOu33R0ouNodufTRVlvyqOoz0SGuskQ_bqQ4X_xBkw91w4XmezvmkG0p6Ith-rsFIKYSkQWHUdMJ_G0lyYJhtg18c-mfWWjPKiI_Or6cE=@protonmail.com>
In-Reply-To: <20250609-b4-sparc-relocs-v1-1-aa52631735af@protonmail.com>
References: <20250609-b4-sparc-relocs-v1-0-aa52631735af@protonmail.com> <20250609-b4-sparc-relocs-v1-1-aa52631735af@protonmail.com>
Feedback-ID: 6608610:user:proton
X-Pm-Message-ID: 1586a313d1b715ac35a542be2107c9680efdcc4c
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Koakuma via B4 Relay <devnull+koachan.protonmail.com@kernel.org> wrote:

> From: Koakuma koachan@protonmail.com
>=20
>=20
> This is needed so that the kernel can handle R_SPARC_UA64 relocations,
> which is emitted by LLVM's IAS.
>=20
> Signed-off-by: Koakuma koachan@protonmail.com
>=20
> ---
> arch/sparc/include/asm/elf_64.h | 1 +
> arch/sparc/kernel/module.c | 1 +
> 2 files changed, 2 insertions(+)
>=20
> diff --git a/arch/sparc/include/asm/elf_64.h b/arch/sparc/include/asm/elf=
_64.h
> index 8fb09eec8c3e796a9a79aa0a7877842ceb7ea6d3..694ed081cf8d99adf70be25e5=
dc0e30a45f70398 100644
> --- a/arch/sparc/include/asm/elf_64.h
> +++ b/arch/sparc/include/asm/elf_64.h
> @@ -58,6 +58,7 @@
> #define R_SPARC_7 43
> #define R_SPARC_5 44
> #define R_SPARC_6 45
> +#define R_SPARC_UA64 54
>=20
> /* Bits present in AT_HWCAP, primarily for Sparc32. */
> #define HWCAP_SPARC_FLUSH 0x00000001
> diff --git a/arch/sparc/kernel/module.c b/arch/sparc/kernel/module.c
> index b8c51cc23d96944037494f13d2d65a43bb187729..6e3d4dde4f9ab33040b300c40=
d5fd5d0584e166d 100644
> --- a/arch/sparc/kernel/module.c
> +++ b/arch/sparc/kernel/module.c
> @@ -87,6 +87,7 @@ int apply_relocate_add(Elf_Shdr *sechdrs,
> break;
> #ifdef CONFIG_SPARC64
> case R_SPARC_64:
> + case R_SPARC_UA64:
> location[0] =3D v >> 56;
>=20
> location[1] =3D v >> 48;
>=20
> location[2] =3D v >> 40;
>=20
>=20
> --
> 2.49.0

Ping. Is there anything else I should do for this?
