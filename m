Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C112D320E;
	Thu, 12 Feb 2026 08:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770885577; cv=none; b=CTXJ3/FckMGO2Xg1MYWc09upkQ95Gv4awvjldVWi85uMvoHWWZAImlhHnLRRdIHY6oc3EwV+CgLdeD8fIOZyLjTrYz83orgKVwvyXI+JFQ9Rjm5PZ/ThyDi0Lp51yl3UxSldNSqtpYctiwsT+OHcZVdPWfZCNNzKPF7Jafva75w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770885577; c=relaxed/simple;
	bh=BzJbIjAB4mXB/Sc6APaKaqhOX7eJEEX+6i6XmfqBtZc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LN6BD9d94qCbVs0cM4FnzakA7USseWwf0uRTj785gR1ygARSTbC5nZ68DJDvpW6lpK6JIg3pN+IfQhVOlYIM41tyrPCcPm8HE8Ct34TeFbTSCw0ng2VgUvsA6Oy/5nRhOW411UD5rwpxpns96rjuB795jDxFmfnkYtlztoNSJVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=Kom0jmG4 reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="Kom0jmG4"
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4fBTHd471tz1DDXN;
	Thu, 12 Feb 2026 09:39:25 +0100 (CET)
Received: from [192.168.0.25] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4fBTHb5J7Hz1DDZ7;
	Thu, 12 Feb 2026 09:39:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1770885565;
	bh=PGI9E0Ah/sCKqUWdGGZrUCOyQzLXgtvn+/30CBuRp9w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Kom0jmG4cp2aCCPXYGhzvsNdpnID6H+n8FBHwTifdpEYGIUBXrnEh77Zjb+F4Uw9H
	 UXUPUIguRj6rXxio7bPxKL8EDMaAwhGefR3rfI1wHeSXx/zPR33P8qJNbunSZ43qDr
	 NgFlGeDjza2ZQm8OzzMjsW6vlhjo+CZxjlwQT+qLbYqhmgxd8Q8Ihyd2HOc3dvoADp
	 o+xiWOcZDwMxqEP+I8vJDl4qWqdv4qG5u0jzztECJfg3xosxH+CpUDCdgJZ6vEOukO
	 glY3kmdJgj3w/lSoryU0vkLnI0wkwv88sda11lAy2tHIoR1eKoCLmGUm0esizzLPxM
	 ivEADa7FfTprA==
Message-ID: <e2a3798f-cbc4-49c5-bbd3-42509c22c8fa@gaisler.com>
Date: Thu, 12 Feb 2026 09:38:42 +0100
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] arch, mm: consolidate empty_zero_page
To: Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Borislav Petkov <bp@alien8.de>, Brian Cain <bcain@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 "David S. Miller" <davem@davemloft.net>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 David Hildenbrand <david@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>,
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
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20260211103141.3215197-4-rppt@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026-02-11 11:31, Mike Rapoport wrote:
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
>   parameters. Switching to a generic empty_zero_page removes the aliasing
>   and keeps ZERO_PGE for boot parameters only
> * arm64: uses __pa_symbol() in ZERO_PAGE() so that definition of
>   ZERO_PAGE() is kept intact.
> * m68k/parisc/um: allocated empty_zero_page from memblock,
>   although they do not support zero page coloring and having it in BSS
>   will work fine.
> * sparc64 can have empty_zero_page in BSS rather allocate it, but it
>   can't use virt_to_page() for BSS. Keep it's definition of ZERO_PAGE()
>   but instead of allocating it, make mem_map_zero point to
>   empty_zero_page.
> * sh: used empty_zero_page for boot parameters at the very early boot.
>   Rename the parameters page to boot_params_page and let sh use the generic
>   empty_zero_page.
> * hexagon: had an amusing comment about empty_zero_page
> 
> 	/* A handy thing to have if one has the RAM. Declared in head.S */
> 
>   that unfortunately had to go :)
> 
> Acked-by: Helge Deller <deller@gmx.de>   # parisc
> Tested-by: Helge Deller <deller@gmx.de>  # parisc
> Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---

>  arch/sparc/include/asm/pgtable_32.h       |  8 --------
>  arch/sparc/include/asm/setup.h            |  2 --
>  arch/sparc/kernel/head_32.S               |  7 -------
>  arch/sparc/mm/init_32.c                   |  4 ----
>  arch/sparc/mm/init_64.c                   | 11 ++++-------
Acked-by: Andreas Larsson <andreas@gaisler.com> #sparc

Cheers,
Andreas

