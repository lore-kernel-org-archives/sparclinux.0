Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794916017;
	b=bf3IXB/2zDHnZSLIlw9El83t5Fq0+JjwiMbsLNu4/kPTbqiu0Fd944RHYJ3lfXciurTN
	 eSZm+tO0goPqET5gQyNuJt/30VT4rudPPwkTWFWlriZ99UCPHMcndflpO9PQJItIoGzc4
	 7Hutvrh9ah0guajgHXxzqVjZKr6BR39y2IZ8NDLEW/Oggqu1uf1+BTFSduMKndnM31rfA
	 61ZtQXllHEgev+FRv3DMuzkKEfHqjMFFdIdDH17xdtoyoV+tVef7SyrL0jqIlx/eXG6S6
	 5iQUdUnh9GzABcL76joghaamahOL1QroQv/Shnmb3q8rfyoeswPZ3KrQ2KXcyBY69xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794916017;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hygHB2OrF7wcmH1972mPcZ3Q7QHaWi7ML2WQQ3pf+dM=;
	b=1yy48wHQcBYaoA/DefK4c3jK2ZDCQ9gqr6/nuNJOfgCuM1yx9zYDn83AWVqbq0BEIFYz
	 KWLVRDWRm2e63UU83lGG5y6bwdCTFuVsdfYi6kWFCzEliED5s9QcETZmp5jnAVVD6MFBZ
	 qHgRCabA7D9tRnsC0zdu03AhOUeKQ+uZVV1myadls1zr/I6DGM9U33Oc+J1F8s6y7Xfdh
	 nQGgYR9jMMTqRun+c9Yz8OkfGiXE4DRwQrr27q7Gd9H2rSdnx5KkOw+7or1pDpuQDqAlJ
	 LvnDtNukWJpqIMC6WX3RKaLUszkvzbU+1kLNGlZj55COQzhz8UeGYCebGIatQ0iRjMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FTLIBLnC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1267E606A31C
	for <sparclinux@vger.kernel.org>; Tue, 17 Nov 2026 11:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FTLIBLnC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E4BD1F000C5;
	Tue, 17 Nov 2026 11:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794916016;
	bh=hygHB2OrF7wcmH1972mPcZ3Q7QHaWi7ML2WQQ3pf+dM=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=FTLIBLnCb2j50Ze31UvmWG7MvNK/URJTfOVpSNgfPNJdYTuURO+NUA9Q+s7ykpYMB
	 BaGGivV+lqEgCmrjauE7pCLwopciY0G+ko9rc0b42gT+OxJ89fFBKM1tfRtyAgtZs2
	 c8XY3Aju8wjy6QwQxMeZWQk3hpTWbaDRVGvAFMxIYs977oZZuP/inUYE7zHkXHRAB5
	 TV0h6RWHDzMGYwQq0VZp5eqBum1GmrUL2aacKjAye99kgpTjr3gD0LKFl82UD9DCA8
	 RByzCMObilQsIkTRI1r/qaP8K8000pbHcKvu2glvGPawbxk8YJOfKGfzG5sVcLAua4
	 qR2TOFD/B96/w==
Message-ID: <sashiko-outbox-218725@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] sparc64: Read qemu,hwcap-list from the OF cpu node on
 sun4u
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stian Halseth" <stian@itx.no>, sparclinux@vger.kernel.org
In-Reply-To: <20261117112914.2300417-1-stian@itx.no>
References: <20261117112914.2300417-1-stian@itx.no>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 11:46:56 +0000
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Post: <mailto:sparclinux@vger.kernel.org>
List-Help: <mailto:sparclinux+help@vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:sparclinux+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] sparc64: of_cpu_hwcap_list() enables broken sun4u skcipher FPU
  usage
It also noticed 1 related pre-existing issue this patch does not
introduce:
- [High] sparc: infinite loop and out-of-bounds read in
  mdesc_cpu_hwcap_list() [1]
--

commit 2ca1536e272cd67392d1c65939db77b50052beab
Author: Stian Halseth <stian@itx.no>

sparc64: Read qemu,hwcap-list from the OF cpu node on sun4u

This commit factors out the hwcap-list string parser and uses it to read
CPU capabilities from the OpenFirmware cpu node's qemu,hwcap-list property
when no sun4v machine description is present.

> diff --git a/arch/sparc/kernel/setup_64.c b/arch/sparc/kernel/setup_64.c
> index 48abee4eee29d..f63a05360150e 100644
> --- a/arch/sparc/kernel/setup_64.c
> +++ b/arch/sparc/kernel/setup_64.c

[ ... ]

> @@ -479,25 +480,9 @@ static void __init report_hwcaps(unsigned long caps)
>  		printk(KERN_CONT "]\n");
>  }
> =20
> -static unsigned long __init mdesc_cpu_hwcap_list(void)
> +static unsigned long __init hwcap_list_caps(const char *prop, int len)
>  {
> -	struct mdesc_handle *hp;
>  	unsigned long caps =3D 0;
> -	const char *prop;
> -	int len;
> -	u64 pn;
> -
> -	hp =3D mdesc_grab();
> -	if (!hp)
> -		return 0;
> -
> -	pn =3D mdesc_node_by_name(hp, MDESC_NODE_NULL, "cpu");
> -	if (pn =3D=3D MDESC_NODE_NULL)
> -		goto out;
> -
> -	prop =3D mdesc_get_property(hp, pn, "hwcap-list", &len);
> -	if (!prop)
> -		goto out;
> =20
>  	while (len) {
>  		int i, plen;
> @@ -520,11 +505,53 @@ static unsigned long __init mdesc_cpu_hwcap_list(vo=
id)
>  		len -=3D plen;
>  	}
> =20
> +	return caps;
> +}

[Severity: High]
This problem wasn't introduced by this patch, but can hwcap_list_caps()
read out of bounds and loop forever [1] if the property buffer is not
null-terminated?

If the final entry in prop lacks a terminating NUL byte within len bytes,
strlen(prop) reads past the end of the property buffer and plen exceeds
len.  len -=3D plen then underflows the signed int len to a negative value,
so while (len) never terminates and hangs the boot.  Bounding the string
length with strnlen(prop, len) and checking while (len > 0) would avoid the
overread and underflow.

[ ... ]

> @@ -562,6 +589,8 @@ static void __init init_sparc64_elf_hwcap(void)
>  	cap |=3D (AV_SPARC_MUL32 | AV_SPARC_DIV32 | AV_SPARC_V8PLUS);
> =20
>  	mdesc_caps =3D mdesc_cpu_hwcap_list();
> +	if (!mdesc_caps)
> +		mdesc_caps =3D of_cpu_hwcap_list();
>  	if (!mdesc_caps) {
>  		if (tlb_type =3D=3D spitfire)
>  			cap |=3D AV_SPARC_VIS;

[Severity: High]
Does setting HWCAP_SPARC_CRYPTO in sparc64_elf_hwcap on sun4u cause a
regression where the sparc64 skcipher drivers corrupt FPU state and round
keys across skcipher_walk_done()?

When HWCAP_SPARC_CRYPTO is set, the sparc64 AES, DES, and Camellia skcipher
drivers in arch/sparc/crypto/ register at priority 300.  Their encryption
and decryption loops load expanded keys into FPU registers with FPRS_FEF
enabled once before the walk loop and keep them live across
skcipher_walk_done():

arch/sparc/crypto/aes_glue.c:ecb_encrypt() {
    ...
	ctx->ops->load_encrypt_keys(&ctx->key[0]);
	while ((nbytes =3D walk.nbytes) !=3D 0) {
		ctx->ops->ecb_encrypt(&ctx->key[0], walk.src.virt.addr,
				      walk.dst.virt.addr,
				      round_down(nbytes, AES_BLOCK_SIZE));
		err =3D skcipher_walk_done(&walk, nbytes % AES_BLOCK_SIZE);
	}
	fprs_write(0);
    ...
}

Unlike sun4v's NG4memcpy/M7memcpy (which use VISEntryHalfFast and fall back
to integer copies when FPRS_FEF is already set), sun4u uses U1memcpy or
U3memcpy, which unconditionally execute VISEntry/VISEntryHalf and VISExit
for copies above the VIS threshold.  When skcipher_walk_done() calls
memcpy() on unaligned or multi-step walks, VISenter saves the expanded
cipher round keys over the current task's user FPU state in
current_thread_info()->fpregs[0], and U1memcpy/U3memcpy overwrite the FPU
registers and clear FPRS_FEF, causing boot-time crypto self-test failures
and silent data or user FPU corruption.

[1] https://sashiko.dev/#/bug/linux-93078b7c-14ab-4a50-a56f-abb0c72ca6f5

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117112914.2300=
417-1-stian@itx.no?part=3D1
