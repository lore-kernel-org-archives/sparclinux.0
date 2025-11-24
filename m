Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13CE36D4F4;
	Mon, 24 Nov 2025 14:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763993516; cv=none; b=Rt9ZMQ6Jo5VQfdc2/V1HGd08Bz/SSRw70lHrV0lzZuRg766w0f/37X6hmoFydYf7x88uv69muWsi7pJsohjd7akV76uYRvEovWsjkXQHcsTg1FGg7wTKKnz7eNgRrfyrxoeuGk8944j3V3P26uubOpqDE0oRXrvpt79WeHaT2no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763993516; c=relaxed/simple;
	bh=pKRds4IT+BzPKh2fxA3wO0tgnvzHdhCWGBCp+0CwG9A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HeC8QBM7RPvJv8W7+ZevoaN95GSGCpbRcAuj44/VvrgW61aPW8JcNNNhjPvM9KZyr8nGiXhhRo9FEvJkeXSOij5Wt5DHJaMGM11bAiLxH69Pdta1CENUCR2A6OtRH04Xdf/h8FfCYnqssoA46Rjt6GlJrmH3H+5ab4xC7BcNW+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TjUGt8Li; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TjUGt8Li"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE78BC116C6;
	Mon, 24 Nov 2025 14:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763993515;
	bh=pKRds4IT+BzPKh2fxA3wO0tgnvzHdhCWGBCp+0CwG9A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TjUGt8Li6YfogSyMUKImhk9t7zCEyR/5lyaBjeNw6RcKDKrbRq6HnmNGUOxqptBCd
	 dLRr5vxSkWtTK/HdcfyyhBGI6jbvcRygLDwJPNmugo/e/qBVwdADZJpApwewQnH0Lz
	 Zvd3xoS+6vTxsekxWrHLixtrCO8PmynL3TGa54AYYvreiAeQp5nXHtEPY83/MIXq9v
	 IDvhAooUaPXLRXgkrwnbgHUW6P169b7ay8AKZtPjbmGcLHflIqg6kF1HvRTZ7a8+u+
	 51pYm9HXbc2JA+xZLuh0Y9NS3lb+de9hbRLWFhjCNgsTJpUFrYKe7BdliclaVXA64P
	 5nWYBjsK1rt0g==
Message-ID: <9800804f-6e8a-4d08-8eb1-f114df6d6b7a@kernel.org>
Date: Mon, 24 Nov 2025 15:11:44 +0100
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 07/12] mm: bail out of lazy_mmu_mode_* in interrupt
 context
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
 <20251124132228.622678-8-kevin.brodsky@arm.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20251124132228.622678-8-kevin.brodsky@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/24/25 14:22, Kevin Brodsky wrote:
> The lazy MMU mode cannot be used in interrupt context. This is
> documented in <linux/pgtable.h>, but isn't consistently handled
> across architectures.
> 
> arm64 ensures that calls to lazy_mmu_mode_* have no effect in
> interrupt context, because such calls do occur in certain
> configurations - see commit b81c688426a9 ("arm64/mm: Disable barrier
> batching in interrupt contexts"). Other architectures do not check
> this situation, most likely because it hasn't occurred so far.
> 
> Let's handle this in the new generic lazy_mmu layer, in the same
> fashion as arm64: bail out of lazy_mmu_mode_* if in_interrupt().
> Also remove the arm64 handling that is now redundant.
> 
> Both arm64 and x86/Xen also ensure that any lazy MMU optimisation is
> disabled while in interrupt (see queue_pte_barriers() and
> xen_get_lazy_mode() respectively). This will be handled in the
> generic layer in a subsequent patch.
> 
> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
> ---

(resending as I pushed the wrong button there ...)

Moving this patch earlier LGTM, hoping we don't get any unexpected
surprises ...

Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>

-- 
Cheers

David
