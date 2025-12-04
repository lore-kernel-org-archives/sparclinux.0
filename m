Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E7F18DB2A;
	Thu,  4 Dec 2025 05:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764825969; cv=none; b=IO81lZ6bjAiODgu91KRws34MnlKAFtkC9OIriD9z05b85/NurTdDq5I45Na1AZzaySBiw1vES0LoitzyFbyoOHvv62ahBirDdp99Z4PIBrzcVLqsyz4CHIjBNXYHuHbdP3JxXrH25IuQXCDfG/TTHqVoxTFOpQESRV4U5QdYp4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764825969; c=relaxed/simple;
	bh=CZoXpXrtyIQo2Uy3otgQevui33vCoDvkLsnkSX1hneo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MUmDuiOQMGWSAk0r/cORVHwAY82TOYOcnZQqmUITm30uz5JbTwLJbnln9zHODBCrFdv9uqhGsPzIye4aye8G/pSLWGQWGYmNvAsGMNtN+beH0iCf1hUoD31ufpq9RE+iCveQZUet5bXyh/P+y0Tfv29qFf/AkPhSdJm3+zBRtRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EEB83339;
	Wed,  3 Dec 2025 21:25:56 -0800 (PST)
Received: from [10.164.18.78] (unknown [10.164.18.78])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 80D2B3F59E;
	Wed,  3 Dec 2025 21:25:54 -0800 (PST)
Message-ID: <2c2b3382-7bdb-41a9-b48e-4fa9a44312ba@arm.com>
Date: Thu, 4 Dec 2025 10:55:51 +0530
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/12] mm: enable lazy_mmu sections to nest
To: Kevin Brodsky <kevin.brodsky@arm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>
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
 <20251124132228.622678-9-kevin.brodsky@arm.com>
 <23dcf752-0b75-45a7-84f8-25bddf97af08-agordeev@linux.ibm.com>
 <703cbee6-a813-4970-9232-34ee91ed8961@arm.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <703cbee6-a813-4970-9232-34ee91ed8961@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 03/12/25 1:50 PM, Kevin Brodsky wrote:
> On 28/11/2025 14:55, Alexander Gordeev wrote:
>>> + * in_lazy_mmu_mode() can be used to check whether the lazy MMU mode is
>>> + * currently enabled.
>> The in_lazy_mmu_mode() name looks ambiguous to me. When the lazy MMU mode
>> is paused are we still in lazy MMU mode? The __task_lazy_mmu_mode_active()
>> implementation suggests we are not, while one could still assume we are,
>> just paused.
>>
>> Should in_lazy_mmu_mode() be named e.g. as in_active_lazy_mmu_mode() such
>> a confusion would not occur in the first place.
> 
> I see your point, how about is_lazy_mmu_mode_active()?

Agreed - is_lazy_mmu_mode_active() seems better.
