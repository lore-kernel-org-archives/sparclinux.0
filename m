Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E195286D4E;
	Tue,  4 Nov 2025 11:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762255996; cv=none; b=GIkVxdimwCKkLTX3u0B6tjIa2+/CqTol/kPNyiHfoT3mY+557ikY57VGqScNWQ3j5+lwAdHsWM+xMxTUSVgQD2W3SFiH/hHCIQ2Sxuvz6A84FPjaH+mHBbwhZnfaVQP5RB8PAPQdy1zEcMORSVlHWm8Ux7AHufxXHqEbSmoWgqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762255996; c=relaxed/simple;
	bh=6WOQeTavzPrauVi8MwJO524evgvZo3Tkv1ShmH0pjuo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mWBYxQYjVVe8e7+6Ot84II5ZI5SscEwikTldA7u50smpTDvgLr66eX1umS5/khcElV4YFlFzGf8p5RLUeGW+nv43E+O20HQ2BB3H5OSU+/vkZeCqzlBDX48XDH6bafgAzzPwFsQAj86n0z0kzJ6/rfJch8OtSqaLItOz+yaH+kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D06201C2B;
	Tue,  4 Nov 2025 03:33:05 -0800 (PST)
Received: from [10.1.38.100] (e126510-lin.cambridge.arm.com [10.1.38.100])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C979F3F63F;
	Tue,  4 Nov 2025 03:33:06 -0800 (PST)
Message-ID: <e3326a9c-108a-4eb2-b12e-bff2b5edd1d3@arm.com>
Date: Tue, 4 Nov 2025 11:33:03 +0000
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/12] powerpc/mm: replace batch->active with
 in_lazy_mmu_mode()
To: David Hildenbrand <david@redhat.com>, linux-mm@kvack.org
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
 Peter Zijlstra <peterz@infradead.org>, Ryan Roberts <ryan.roberts@arm.com>,
 Suren Baghdasaryan <surenb@google.com>, Thomas Gleixner
 <tglx@linutronix.de>, Vlastimil Babka <vbabka@suse.cz>,
 Will Deacon <will@kernel.org>, Yeoreum Yun <yeoreum.yun@arm.com>,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 sparclinux@vger.kernel.org, xen-devel@lists.xenproject.org, x86@kernel.org
References: <20251029100909.3381140-1-kevin.brodsky@arm.com>
 <20251029100909.3381140-10-kevin.brodsky@arm.com>
 <05e2062c-1689-44e7-9cc6-697646ca075d@redhat.com>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <05e2062c-1689-44e7-9cc6-697646ca075d@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 03/11/2025 16:05, David Hildenbrand wrote:
> On 29.10.25 11:09, Kevin Brodsky wrote:
>> A per-CPU batch struct is activated when entering lazy MMU mode; its
>> lifetime is the same as the lazy MMU section (it is deactivated when
>> leaving the mode). Preemption is disabled in that interval to ensure
>> that the per-CPU reference remains valid.
>>
>> The generic lazy_mmu layer now tracks whether a task is in lazy MMU
>> mode. We can therefore use the generic helper in_lazy_mmu_mode()
>> to tell whether a batch struct is active instead of tracking it
>> explicitly.
>>
>> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
>> ---
>
> I suspect you were not able to test this on real HW. Some help from
> the ppc folks would be appreciated.

Indeed, it would be nice to get some testing on ppc HW that actually
uses lazy MMU (!radix_enabled()).

>
> LGTM, but the interaction with pause/resume adds a bit of complication
> on top.

Does it? This series doesn't change when arch_enter() and arch_leave()
are called, batch->active and in_lazy_mmu_mode() should coincide. 

- Kevin
