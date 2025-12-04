Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05C52BB1D;
	Thu,  4 Dec 2025 03:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764819431; cv=none; b=Uxn/oW352lGeSmuxvZiLU21/yk7sv7bwH6JOAyffChFAdYnWXSl3FQFkCNdWAyuODWSyai7qDfPsxDO5MSoRML4uIlJnHttxaISKDA5oi87HWIY4HbyxA8LC8j7G3Ar+CqOCR5j0GTtXqvqMb6KrIn64Vb9ZO79KxxP8JNpaa+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764819431; c=relaxed/simple;
	bh=rwl3csJ1un9FkM+EMLL+mG4TpdKpHd3EbdTJ8K28vQA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=iv+x1A0SvnX+k4NjSWbgxrA+y6V3GUpatpLLgRO+NMUScylZExf+uqkhzuJiw9x2/TtYmsL5vAFZ9/2V21JR+9N/uI3p7wZCYXVytaxlolw5frCRPBzaung5+opzn7SnUhXogrxqTj1zcrQNk1PEK6eTNHMd/ATSGeotmXCp8go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 63087339;
	Wed,  3 Dec 2025 19:37:01 -0800 (PST)
Received: from [10.164.18.78] (unknown [10.164.18.78])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EBB883F59E;
	Wed,  3 Dec 2025 19:36:58 -0800 (PST)
Message-ID: <15cc652c-937b-4d5b-98f3-7cdcecf28e27@arm.com>
Date: Thu, 4 Dec 2025 09:06:56 +0530
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH v5 02/12] x86/xen: simplify flush_lazy_mmu()
To: Kevin Brodsky <kevin.brodsky@arm.com>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
 Andreas Larsson <andreas@gaisler.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, Borislav Petkov
 <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 David Hildenbrand <david@redhat.com>, "David S. Miller"
 <davem@davemloft.net>, David Woodhouse <dwmw2@infradead.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
 Jann Horn <jannh@google.com>, Juergen Gross <jgross@suse.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
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
 <20251124132228.622678-3-kevin.brodsky@arm.com>
Content-Language: en-US
In-Reply-To: <20251124132228.622678-3-kevin.brodsky@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 24/11/25 6:52 PM, Kevin Brodsky wrote:
> arch_flush_lazy_mmu_mode() is called when outstanding batched
> pgtable operations must be completed immediately. There should
> however be no need to leave and re-enter lazy MMU completely. The
> only part of that sequence that we really need is xen_mc_flush();
> call it directly.
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
> Reviewed-by: Juergen Gross <jgross@suse.com>
> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
> ---

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

>  arch/x86/xen/mmu_pv.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
> index 2a4a8deaf612..7a35c3393df4 100644
> --- a/arch/x86/xen/mmu_pv.c
> +++ b/arch/x86/xen/mmu_pv.c
> @@ -2139,10 +2139,8 @@ static void xen_flush_lazy_mmu(void)
>  {
>  	preempt_disable();
>  
> -	if (xen_get_lazy_mode() == XEN_LAZY_MMU) {
> -		arch_leave_lazy_mmu_mode();
> -		arch_enter_lazy_mmu_mode();
> -	}
> +	if (xen_get_lazy_mode() == XEN_LAZY_MMU)
> +		xen_mc_flush();
>  
>  	preempt_enable();
>  }

