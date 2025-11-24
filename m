Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04AE527B349;
	Mon, 24 Nov 2025 14:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763993462; cv=none; b=NdF019W8eawiXyqFTE5b+hMM1+kPHkzcCfem2ru/ehTJdFHpW87KgHZCIRWyjzZf/89EE0m9ecdI/8WXve1OekooFhBLH0n+ZTtO75BFFoAKmD5j+Gky2Px7Z7RpUwQtrz+/ZtHT4jeE7nSHUHjD29Vj2Nwgl4E9KHqzRrZNuZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763993462; c=relaxed/simple;
	bh=9kXuey4j1iyNfngrjmnOHDtQji8gClrywMZaIofSoSs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AH+yWArX2niAQLsssHXsDU7YTZtUk3g1FfKrvKY048RMUGfZ8HCWfitqXslb5WZiF6RiiRS+8tir+DtYq9IDUUELsBh61cK0wgzZlos2QkqeUpcEdjTR0j9jMKfU/lGSwhz9kJziw67fq9IQmlKmmikaXDIcOhvuWFuhO+3HGQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ToE45XUa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ToE45XUa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E6DAC4CEF1;
	Mon, 24 Nov 2025 14:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763993461;
	bh=9kXuey4j1iyNfngrjmnOHDtQji8gClrywMZaIofSoSs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ToE45XUaNEKKgD2WXInctkwlv3+HBQ1TWbbC/9sEmPQZUN1wYevCeBRVBAV0rozFL
	 I7wUvi5bxWcACKzxrEjR9VQMVUyaT8qQ5kFVhrVVlB89kgJUI6qWdrkHnaxN18F/OQ
	 mF0tJs2Sp8oYTUiLgE5alNCnrBVLa6AKCyHt+H//u0eb1VNFNAFg7+La3UkcsIK7YK
	 bQXVkMezHzr95Qf3Ef+lnUif4ZyWCABBRpSmPiFrnUGowf1Rr2Xo8pRrZ38LeAit4M
	 dcuirEqLwFTeqTAFHiWTbkf/ytXN0PIulzMPv+dkinYGeRr/hIAHNbLek15LEi+dsr
	 2rHEM1RGj8ISg==
Message-ID: <ef07b0f4-1f77-4c6b-9c67-8228632b1fec@kernel.org>
Date: Mon, 24 Nov 2025 15:10:49 +0100
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/12] arm64: mm: replace TIF_LAZY_MMU with
 in_lazy_mmu_mode()
To: Kevin Brodsky <kevin.brodsky@arm.com>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
 Andreas Larsson <andreas@gaisler.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, Borislav Petkov
 <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "David S. Miller" <davem@davemloft.net>,
 David Woodhouse <dwmw2@infradead.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
 Juergen Gross <jgross@suse.com>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Michal Hocko <mhocko@suse.com>,
 Mike Rapoport <rppt@kernel.org>, Nicholas Piggin <npiggin@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Suren Baghdasaryan <surenb@google.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
 Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>,
 Yeoreum Yun <yeoreum.yun@arm.com>, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
 xen-devel@lists.xenproject.org, x86@kernel.org
References: <20251124132228.622678-1-kevin.brodsky@arm.com>
 <20251124132228.622678-10-kevin.brodsky@arm.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20251124132228.622678-10-kevin.brodsky@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/24/25 14:22, Kevin Brodsky wrote:
> The generic lazy_mmu layer now tracks whether a task is in lazy MMU
> mode. As a result we no longer need a TIF flag for that purpose -
> let's use the new in_lazy_mmu_mode() helper instead.
> 
> The explicit check for in_interrupt() is no longer necessary either
> as in_lazy_mmu_mode() always returns false in interrupt context.
> 
> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
> ---

Nothing jumped at me

Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>

-- 
Cheers

David
