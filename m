Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B09770FE;
	Thu, 12 Feb 2026 05:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770874394; cv=none; b=GJTIWK3oDzvaitiEk0lkhQGTq72K6cM9r9m2hRcFsVj+dySdcRDVRy9FGMHdjIAKdwKupyLQQ0yifeWzYBrike/bvgpmuE661dFmlYum6qRW9ECi+BRHMocS6dIVDHpcIqgB7gjaH2YWnqI2dq+ptZ9DFD8M1IK8Q/ZNy5/VTEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770874394; c=relaxed/simple;
	bh=xWdXZIArybbo9Rgxccq3nL2HLMDxrTRxGRMmTyJ92Ek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=djLoT/Kk+9pEThaGVdBaSXB+pnlsoiQYT0rKVdT8qURacVBExasiHj3cExYDf2uBH3AM8sniqmB55G3YGDOad51dHtI84pXJxrvYa2yMFwHTFif8dHUu/T9JskUqQ7rmlyQHNg5oH6W9X8bIE2kKW4rHsgveD1zDPyK/zeqUoWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fnRt4bNT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fnRt4bNT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D227FC4CEF7;
	Thu, 12 Feb 2026 05:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770874394;
	bh=xWdXZIArybbo9Rgxccq3nL2HLMDxrTRxGRMmTyJ92Ek=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fnRt4bNTruqGWDCex4UgCYs5xfFXruN8Lon65hP9g22+WBdZKtSwF7Vlpe0Cerco4
	 bvwxt2r8yj+pM8xOwU8CRkM4OmUaUA/+Tzc72yQC0G+UVZeUmzyMyMPGyxL/xNIa4X
	 +/VC+HyZKbjW0nnljKGakLZZFB897pqnLw9d71EIpoTCJ5wnD5VHVMEklBRL/Jcabq
	 Mwmjfv/JZu6GfI7SyoqZ+mxEsaOK/PQXeGkhDnmh+ztI8JZFzkYG9tnpHFUHqIR6N4
	 w+N5IHX73Du91X+qNAEJ7TQrDCCl9z1LnQGwJBdYZfNUoF2uBKOsddFYGgsxivKLws
	 KFvp/8rynpEOQ==
Message-ID: <0b420450-a85f-4f7c-93c2-4d2de37d257b@kernel.org>
Date: Wed, 11 Feb 2026 23:33:09 -0600
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] arch, mm: consolidate empty_zero_page
Content-Language: en-US
To: Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Andreas Larsson <andreas@gaisler.com>, Borislav Petkov <bp@alien8.de>,
 Brian Cain <bcain@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 "David S. Miller" <davem@davemloft.net>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 David Hildenbrand <david@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Guo Ren <guoren@kernel.org>,
 Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Johannes Berg <johannes@sipsolutions.net>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Magnus Lindholm <linmag7@gmail.com>, Matt Turner <mattst88@gmail.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Michal Hocko <mhocko@suse.com>, Michal Simek <monstr@monstr.eu>,
 Palmer Dabbelt <palmer@dabbelt.com>, Richard Weinberger <richard@nod.at>,
 Russell King <linux@armlinux.org.uk>, Stafford Horne <shorne@gmail.com>,
 Suren Baghdasaryan <surenb@google.com>, Thomas Gleixner <tglx@kernel.org>,
 Vineet Gupta <vgupta@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
 Will Deacon <will@kernel.org>, linux-alpha@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
 linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
 linux-m68k@lists.linux-m68k.org, linux-openrisc@vger.kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
 linux-mm@kvack.org, x86@kernel.org
References: <20260211103141.3215197-1-rppt@kernel.org>
 <20260211103141.3215197-4-rppt@kernel.org>
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20260211103141.3215197-4-rppt@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/11/26 04:31, Mike Rapoport wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> Reduce 22 declarations of empty_zero_page to 3 and 23 declarations of
> ZERO_PAGE() to 4.
> 
> Every architecture defines empty_zero_page that way or another, but for the
> most of them it is always a page aligned page in BSS and most definitions
> of ZERO_PAGE do virt_to_page(empty_zero_page).
> 
> Move Linus vetted x86 definition of empty_zero_page and ZERO_PAGE() to the
> core MM and drop these definitions in architectures that do not implement
> colored zero page (MIPS and s390).
> 
> ZERO_PAGE() remains a macro because turning it to a wrapper for a static
> inline causes severe pain in header dependencies.
> 
> For the most part the change is mechanical, with these being noteworthy:
> 
> * alpha: aliased empty_zero_page with ZERO_PGE that was also used for boot
>    parameters. Switching to a generic empty_zero_page removes the aliasing
>    and keeps ZERO_PGE for boot parameters only
> * arm64: uses __pa_symbol() in ZERO_PAGE() so that definition of
>    ZERO_PAGE() is kept intact.
> * m68k/parisc/um: allocated empty_zero_page from memblock,
>    although they do not support zero page coloring and having it in BSS
>    will work fine.
> * sparc64 can have empty_zero_page in BSS rather allocate it, but it
>    can't use virt_to_page() for BSS. Keep it's definition of ZERO_PAGE()
>    but instead of allocating it, make mem_map_zero point to
>    empty_zero_page.
> * sh: used empty_zero_page for boot parameters at the very early boot.
>    Rename the parameters page to boot_params_page and let sh use the generic
>    empty_zero_page.
> * hexagon: had an amusing comment about empty_zero_page
> 
> 	/* A handy thing to have if one has the RAM. Declared in head.S */
> 
>    that unfortunately had to go :)
> 
> Acked-by: Helge Deller <deller@gmx.de>   # parisc
> Tested-by: Helge Deller <deller@gmx.de>  # parisc
> Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---

>   arch/nios2/include/asm/pgtable.h          |  7 -------
>   arch/nios2/kernel/head.S                  | 10 ----------
>   arch/nios2/kernel/nios2_ksyms.c           |  1 -

For nios2,

Acked-by: Dinh Nguyen <dinguyen@kernel.org>
