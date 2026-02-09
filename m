Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC71F37E2F2;
	Mon,  9 Feb 2026 15:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770649727; cv=none; b=PL1r6Ycm/x9ZG1MWVJb3fR4cmmxQ0+ABaivGAKhOgBbNjNF+GuxVTpvesjm1/3Rr6Ou4nuzRnhyhWs/Pdk7oImtcmy+g9saEeia8vOfOT22xksU0wlzqnUxGOrpMDAlzXSLo/SitcyJIJOd1ozSj/bW3gVZ5uuOTANoIJFBI6c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770649727; c=relaxed/simple;
	bh=74hxAhJyO+2eTcl7giR1QDsEixnocOOTI/KCVXUN3oc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=raPJBvwkkpdux26cgv60CgfHIdc07KadSXf4bVTJHZmmVnkiByOztjOHfoJD4QjZUcG6aS568JQTHf9xqctroGVaCQqudMupl1ks9rsjtL+mDFpXmWlxQ9ONfwDbVaktMK9rkbfJZq5SK+zZxHPh1gTQyeDrX5cHqS+a/dxwvvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hHysNRIg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hHysNRIg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4E07C116C6;
	Mon,  9 Feb 2026 15:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770649726;
	bh=74hxAhJyO+2eTcl7giR1QDsEixnocOOTI/KCVXUN3oc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hHysNRIgE1EgualKU6aPczQKYfw+TDjGY4OatYFD3fS7TYkGD7WEmgWx3geZeHrfv
	 F1zDDpuaU0nwUv7Ae8xi1oXRUWF9pjvFzqRkh1G83qeRNbE6qwS1sk3FHaw39jYn+r
	 Nk+PQE+5SnWvARHfBa8QAWdgNoL3wy2mlksHsr/SXlqVp8ketneSvd/HphO2nVp9tE
	 BCsZzIL9BLqAHeIK57meLHZ0odqx+OpNBfkHnj8PRzutvNrHUWbq5+TlKgLRN2HHQv
	 huO+HUqNPVA5lqDphasR6vnb5IXL4MN7aVd4+kWDg4t8O5NV52bIkpeW9MtEreTJuG
	 K04aIwqR6xaWg==
Message-ID: <0f15b363-a5e5-4a58-89b0-13b5112772b0@kernel.org>
Date: Mon, 9 Feb 2026 16:08:32 +0100
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] mm: rename my_zero_pfn() to zero_pfn()
To: Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Andreas Larsson <andreas@gaisler.com>, Borislav Petkov <bp@alien8.de>,
 Brian Cain <bcain@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
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
References: <20260209144058.2092871-1-rppt@kernel.org>
 <20260209144058.2092871-3-rppt@kernel.org>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260209144058.2092871-3-rppt@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 09/02/2026 à 15:40, Mike Rapoport a écrit :
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> my_zero_pfn() is a silly name.
> 
> Rename zero_pfn variable to zero_page_pfn and my_zero_pfn() function to
> zero_pfn().
> 
> While on it, move extern declarations of zero_page_pfn outside the
> functions that use it and add a comment about what ZERO_PAGE is.

I guess the idea of the extern declaration being inside its only 
external users was to ensure nobody would start using it directly, hence 
bypassing the overloadable helpers.

Should we at least call the variable __zero_page_pfn instead in order to 
warn people that using it directly requires care ?

Christophe

