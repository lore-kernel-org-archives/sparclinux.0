Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76107349B16
	for <sparclinux@vger.kernel.org>; Mon, 26 Jan 2026 16:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769446446; cv=none; b=qKiMYqZ7MrC8CVM6YMX6DAjqHZfJ6Alfx79mPBVB0zsdNJIA3o56J3DTPuM2cZvG85Drqz1qMom4ZZ54/rKr4gNTaUaOPn2lR9mtyTJctzHp7193/xxy8KBIuj+uguQSzeoMjZr9zPrStwDMQzDzkHwICEmr1cw2kIamp8IZ5QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769446446; c=relaxed/simple;
	bh=tfBgG8E9RKZ6azvygNwm+lkuogxz96cYcXYpI4pyrcc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jcAQVu4kG2WNmQNsnZmAt6zfTBjgSi4A66U/qEeE+U36Q4qkXwSTwYGoNmQkmHlppkkEDyCrFJ93X9fYQFoZcGEsJIBTEqLi+doxVgkD3t7efShEh78BNTUFXr1tAIzR36U5YPXrm63Mu2dNGn7Zb6PVtL2gzgaG67yk90pBF4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=eZwGP2+W reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="eZwGP2+W"
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4f0F4B4fsvz1DPkw;
	Mon, 26 Jan 2026 17:54:02 +0100 (CET)
Received: from [10.10.15.30] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4f0F4B2kjqz1DDXm;
	Mon, 26 Jan 2026 17:54:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1769446442;
	bh=QtxQLz8W5cQKXmMncL9Hro2yPhboEWrK9+XU3B4/Xto=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=eZwGP2+WuFK31TI4xdGuBGm01gTQxK3r+VNE7urwSERKiffc3vECgvdaEzj+JxdEK
	 V32SbaPfWwVrdfcKXHHOh7Ik5lBYXuOoskoHHAYp6Im5uXTMbnfUF9ybeS3q10pYom
	 /GmFuaN4U7aDRSc/Z2pznodtTjOO0fMfWix1f70MdDo98cnZB9xPfSgREo0voQofRU
	 o/Sa7pXFquFxBklVvEHPQG4Zx1pj4ChFOKBGfArpLbGvoGo9NcULcvHv3ujG69IqS9
	 G2ed1Gs3Cp19+P6dKZYa8lYHaOjpQRmBdzXU6dFsjGJNxopqjJS6a02v1nWBaJ3h3E
	 Yq6uE9s2vPcqQ==
Message-ID: <163838aa-62fa-49a9-9948-e50ba3a5aba2@gaisler.com>
Date: Mon, 26 Jan 2026 17:54:02 +0100
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arch/sparc32: remove unused variable strtab
To: alexs@kernel.org
Cc: kernel test robot <lkp@intel.com>, sparclinux@vger.kernel.org,
 "David S . Miller" <davem@davemloft.net>
References: <20260112063715.179733-1-alexs@kernel.org>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20260112063715.179733-1-alexs@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

> [PATCH] arch/sparc32: remove unused variable strtab

Although the commit that made it unused did changes for sparc32, this
cleanup is not only for sparc32. Also, no need for the "arch/". Please
use "sparc:" instead of "arch/sparc32".


On 2026-01-12 07:37, alexs@kernel.org wrote:
> From: Alex Shi <alexs@kernel.org>
> 
> The commit 1b35a57b1c178 ("sparc32: Kill off software 32-bit multiply/divide
>  routines") removed the last usage of strtab in funtion module_frob_arch_sections
> Therefore, it can be removed now.
> 
> Reported-by: kernel test robot <lkp@intel.com>

Did the kernel test robot also suggest a "Closes:" line as well? If so,
please also add that.

> Signed-off-by: Alex Shi <alexs@kernel.org>
> Cc: sparclinux@vger.kernel.org
> Cc: David S. Miller <davem@davemloft.net>
> ---
>  arch/sparc/kernel/module.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/sparc/kernel/module.c b/arch/sparc/kernel/module.c
> index 49740450a685..2a8770369beb 100644
> --- a/arch/sparc/kernel/module.c
> +++ b/arch/sparc/kernel/module.c
> @@ -29,7 +29,6 @@ int module_frob_arch_sections(Elf_Ehdr *hdr,
>  {
>  	unsigned int symidx;
>  	Elf_Sym *sym;
> -	char *strtab;
>  	int i;
>  
>  	for (symidx = 0; sechdrs[symidx].sh_type != SHT_SYMTAB; symidx++) {
> @@ -39,7 +38,6 @@ int module_frob_arch_sections(Elf_Ehdr *hdr,
>  		}
>  	}
>  	sym = (Elf_Sym *)sechdrs[symidx].sh_addr;
> -	strtab = (char *)sechdrs[sechdrs[symidx].sh_link].sh_addr;
>  
>  	for (i = 1; i < sechdrs[symidx].sh_size / sizeof(Elf_Sym); i++) {
>  		if (sym[i].st_shndx == SHN_UNDEF) {

Other than the above, LGTM.

Thanks,
Andreas

