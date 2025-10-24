Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B1C2DF13D;
	Fri, 24 Oct 2025 12:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761308252; cv=none; b=FAeLtbQ32f1K53A0d5V7FWMILgz4lrSddCYM4zdLP+Sxe2DTrNxgg86XY3UPeDxsBZoxq+Kie7Je2qkFMbgc8FSLMkRT+/pb+c1qmmrxH/sF3IaYotEE3mLY08xbfjOBLlouW80e2W24lZvs+hZx+5UbR0+X3Of3ysoNW1EvJAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761308252; c=relaxed/simple;
	bh=0pqn941rf59LOhvD/M25wUPoVRtPWVt8BoEPjLcQaZk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rywXXn2vS00AG0AS64R/HFxM/EaDLzMcCl8bQ2vr0wCb9y8H9oXOoAxxql1omfyoaum3m2HG0YrO5fA/2xqYopu3z0cmBXmGGhBd9AJXTEOU5uT9AcoFyUXuD6dPInAcPmTHGLjSslH8e1UA3Yhy3atKSHl0BdIKQZUpEEqqfcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA3FF1515;
	Fri, 24 Oct 2025 05:17:22 -0700 (PDT)
Received: from [10.44.160.74] (e126510-lin.lund.arm.com [10.44.160.74])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 38C343F66E;
	Fri, 24 Oct 2025 05:17:23 -0700 (PDT)
Message-ID: <35df96ba-a004-4eb4-8d26-5935892a852c@arm.com>
Date: Fri, 24 Oct 2025 14:17:20 +0200
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/13] mm: introduce arch_wants_lazy_mmu_mode()
To: David Hildenbrand <david@redhat.com>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
 Andreas Larsson <andreas@gaisler.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, Borislav Petkov
 <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "David S. Miller" <davem@davemloft.net>, "H. Peter Anvin" <hpa@zytor.com>,
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
References: <20251015082727.2395128-1-kevin.brodsky@arm.com>
 <20251015082727.2395128-14-kevin.brodsky@arm.com>
 <3d6bba2d-9739-41d0-8f3a-f8b11620c33f@redhat.com>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <3d6bba2d-9739-41d0-8f3a-f8b11620c33f@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/10/2025 22:10, David Hildenbrand wrote:
> On 15.10.25 10:27, Kevin Brodsky wrote:
>> powerpc decides at runtime whether the lazy MMU mode should be used.
>>
>> To avoid the overhead associated with managing
>> task_struct::lazy_mmu_state if the mode isn't used, introduce
>> arch_wants_lazy_mmu_mode() and bail out of lazy_mmu_mode_* if it
>> returns false. Add a default definition returning true, and an
>> appropriate implementation for powerpc.
>>
>> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
>> ---
>> This patch seemed like a good idea to start with, but now I'm not so
>> sure that the churn added to the generic layer is worth it.
>
> Exactly my thoughts :)
>
> I think we need evidence that this is really worth it for optimizing
> out basically a counter update on powerpc.

Ack, I'll drop that patch in v4 unless someone sees a better
justification for it.

- Kevin
