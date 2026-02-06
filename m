Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AF6366DA3
	for <sparclinux@vger.kernel.org>; Fri,  6 Feb 2026 10:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770374423; cv=none; b=H+1mIrxJGBHOHI3kbX758V0pXLnL6fcKOtsJ83DzEQ+uIZp40E2LlZov7gfAG5MOiyHZCwdGmJBs7e4J/8I8AhEMkdB/4lfNdrA4vQegTBJeUheZlSU8x41BdI1SGpubao8KINio00zNnVcKEoIYHj54vcZ5PqSpiyKzKcp8zfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770374423; c=relaxed/simple;
	bh=jZUyP1mUOQVNjMeWAUmTF3+ITdKYrsPJTorWL8Pvafw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vGCuJvWBBc57mpagsfeGhfcSHJ82AE5vBbr8EiZo2ktYyWieQmL2EfdFE/iJUxg0Egd0KHTQzt2aBoQZEzPCnKrkZQV5dNWN3dKphn5uKzEBJIKaXzB2B6gt+GGeRv7EFIsHYSyvtYp+F3CPGjT2uGebj8+hY7bbt6rbqOb/FCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=Qs4lOgcg reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="Qs4lOgcg"
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4f6rFx2j8Cz1DQrD;
	Fri,  6 Feb 2026 11:40:21 +0100 (CET)
Received: from [10.10.15.18] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4f6rFx0gQbz1DQqy;
	Fri,  6 Feb 2026 11:40:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1770374421;
	bh=ZPBreX3CA4e8/yOFgUEHCbxEWs9erQ3FtxBNfW0PKQw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Qs4lOgcgaFTzvVZmm5m4t001rJVFM9CO0qt7LJfgnD0pvpgprFafyC8n58VenYPQ0
	 CtUgwi9pIX9EQyMAbKi1c6w2Pyb9bzr5X5ZQsjc2wrKmFyM2Wgj74+9Lc8FO+V54Im
	 t4VWX7qwIZUKXggd8XeDdStO+bZovz+7/2Ljrk32RA0Du04h/fedTHsI0L8T7UP5Ja
	 v5ACKHvBBNPaQOdehwvstttld9Pcp0ZwFl+QoeTMPrAdeWF0VftBi9+sch1UypWxRa
	 K1fZw8ofcpr6freEgRqr3RGLgfzOtflc4/qqD9/MxODHADrxmgmOxOcaUYRrmj5Xjc
	 Xb0p2B6wBMvOg==
Message-ID: <7fae2e8a-29e6-4166-943a-b1bbd368a3f0@gaisler.com>
Date: Fri, 6 Feb 2026 11:40:20 +0100
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] sparc: remove unused variable strtab
To: alexs@kernel.org
Cc: kernel test robot <lkp@intel.com>, sparclinux@vger.kernel.org,
 "David S . Miller" <davem@davemloft.net>
References: <20260205134007.31647-1-alexs@kernel.org>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20260205134007.31647-1-alexs@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026-02-05 14:39, alexs@kernel.org wrote:
> From: Alex Shi <alexs@kernel.org>
> 
> The commit 1b35a57b1c178 ("sparc32: Kill off software 32-bit multiply/divide
>  routines") removed the last usage of strtab in funtion module_frob_arch_sections
> Therefore, it can be removed now.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Cc: sparclinux@vger.kernel.org
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Andreas Larsson <andreas@gaisler.com>
> Signed-off-by: Alex Shi <alexs@kernel.org>
> ---
> v1->v2:
>  Change subject prefix: arch/sparc32 -> sparc
> 
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

Reviewed-by: Andreas Larsson <andreas@gaisler.com>

Picking this up to my for-next.

Thanks,
Andreas

