Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751743559F1;
	Thu, 30 Oct 2025 10:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761820146; cv=none; b=QOrJAv/64VPdYrVcjotrggQY51E+O5lAmm3mD9xm7p7rVtU/EtrhOh9p7XqyrZZC+oB+KrtOGXCzkPN7hFKSwMohr/87HttISkE9ty2xd2GdOaexycrIC/Ffm767s1X4FTaJ/sh+sBbJ0X829NEyJWIIJZxVBCal/p6dJR6jDFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761820146; c=relaxed/simple;
	bh=maF/DPCYKH1qQebZ70bvPd7/+vjsfX9IrKP3XL5VGvs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Aa/XZAXKvPDNiEPe25TmPh2eylnE2SHzUeRS+JzsZuYVvp9DZIBynkvgMU8hjQ0STsXCH9POV3oMJv8RWm/ldcgOZUdZFXtqB7VK2Bks+uPOjN6QHozFGFnUeltPLxpOeQXk6CRnw+9sDwkBoKdjAigKE85dppEhXN4HEPwgsS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E08BE1EDB;
	Thu, 30 Oct 2025 03:28:56 -0700 (PDT)
Received: from [10.57.69.77] (unknown [10.57.69.77])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A8D363F66E;
	Thu, 30 Oct 2025 03:28:56 -0700 (PDT)
Message-ID: <d0767b70-5686-4f6e-8ca4-10b3f3ff3991@arm.com>
Date: Thu, 30 Oct 2025 11:28:53 +0100
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/12] mm: enable lazy_mmu sections to nest
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
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
 Peter Zijlstra <peterz@infradead.org>, Ryan Roberts <ryan.roberts@arm.com>,
 Suren Baghdasaryan <surenb@google.com>, Thomas Gleixner
 <tglx@linutronix.de>, Vlastimil Babka <vbabka@suse.cz>,
 Will Deacon <will@kernel.org>, Yeoreum Yun <yeoreum.yun@arm.com>,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 sparclinux@vger.kernel.org, xen-devel@lists.xenproject.org, x86@kernel.org
References: <20251029100909.3381140-1-kevin.brodsky@arm.com>
 <20251029100909.3381140-8-kevin.brodsky@arm.com>
 <ef0cd4bc-1a37-4755-8957-d8a7e5c4564e-agordeev@linux.ibm.com>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <ef0cd4bc-1a37-4755-8957-d8a7e5c4564e-agordeev@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/10/2025 17:41, Alexander Gordeev wrote:
> On Wed, Oct 29, 2025 at 10:09:04AM +0000, Kevin Brodsky wrote:
>
> Hi Kevin,
>
>> +#ifdef CONFIG_ARCH_HAS_LAZY_MMU_MODE
>> +static inline bool in_lazy_mmu_mode(void)
>> +{
>> +	return current->lazy_mmu_state.active;
> Whether (nesting_level > 0) is more correct check?
> Otherwise, it returns false while in paused mode.

That's exactly the intention. Lazy MMU is disabled while paused. The
users of that helper want to know if lazy MMU is currently enabled (to
decide whether to batch updates for instance); whether this is because
we are paused or not in any lazy_mmu section (nesting_level == 0) makes
no difference.

> May be check both nesting_level and active and also introduce
> in_lazy_mmu_paused_mode() right away to avoid any confusion?

Can you think of any situation where a caller would specifically want to
know that lazy MMU is paused?

- Kevin
