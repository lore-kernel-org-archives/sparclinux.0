Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D61F340D84;
	Tue,  9 Sep 2025 14:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757427329; cv=none; b=t3jV+cBOeT/PZDMgN3yEj+0/Tnh0vCc8r1cGolk7i5BD8yX6RH0k9iGwj4ZuOttDNQWs37AR0ff4/Da6RryU0MPWknXm8A1rW7cjkqirpTXNGBsjCQ4XzRPznBGdUYdRrzPQio1uGJ7WmOEB1mbhFWZl4bGBiq0Sy/kFwHPhGVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757427329; c=relaxed/simple;
	bh=8LeUDwQ1TQcxoiiJ+B3yhPNPi07lHBnO96DM93lKFxs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DcSX/DOpGIwxzPRZX/btmEkNMUPQQ1N4zSSJdMVyS5BOr+L2twSsoGqa0lFsbZBYMv9ekmOTFMjG6HTTXnc4KomkfG4JJ2CWJ+xh2FLp8CTDlA2ow5Rnmlqx8uGnDCEr5PFWC9REUTQGRWb0DRtQmx20NOKxoDwMDlgBaSkvP/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2C94C1424;
	Tue,  9 Sep 2025 07:15:18 -0700 (PDT)
Received: from [10.44.160.77] (e126510-lin.lund.arm.com [10.44.160.77])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0C5F63F66E;
	Tue,  9 Sep 2025 07:15:15 -0700 (PDT)
Message-ID: <f27a2684-6656-4eb0-8255-e7bc4811ce87@arm.com>
Date: Tue, 9 Sep 2025 16:15:12 +0200
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] mm: introduce local state for lazy_mmu sections
To: Juergen Gross <jgross@suse.com>, David Hildenbrand <david@redhat.com>,
 linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
 Andreas Larsson <andreas@gaisler.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, Borislav Petkov
 <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "David S. Miller" <davem@davemloft.net>, "H. Peter Anvin" <hpa@zytor.com>,
 Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
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
 sparclinux@vger.kernel.org, xen-devel@lists.xenproject.org
References: <20250908073931.4159362-1-kevin.brodsky@arm.com>
 <20250908073931.4159362-3-kevin.brodsky@arm.com>
 <d23ea683-cca4-4973-88b1-4f6fd9b22314@redhat.com>
 <f6965a43-c299-4726-896e-6cccd0a23ae5@suse.com>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <f6965a43-c299-4726-896e-6cccd0a23ae5@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 09/09/2025 12:57, Juergen Gross wrote:
> On 09.09.25 11:07, David Hildenbrand wrote:
>> On 08.09.25 09:39, Kevin Brodsky wrote:
>>> [...]
>>>
>>> Note: it is difficult to provide a default definition of
>>> lazy_mmu_state_t for architectures implementing lazy_mmu, because
>>> that definition would need to be available in
>>> arch/x86/include/asm/paravirt_types.h and adding a new generic
>>>   #include there is very tricky due to the existing header soup.
>>
>> Yeah, I was wondering about exactly that.
>>
>> In particular because LAZY_MMU_DEFAULT etc resides somewehere
>> compeltely different.
>>
>> Which raises the question: is using a new type really of any benefit
>> here?
>>
>> Can't we just use an "enum lazy_mmu_state" and call it a day?
>>
>
> The comment about the "header soup" made me look into this problem:
>
> It seems some of the "#include <asm/paravirt.h>" instances in the code
> base can just be dropped.
>
> For the remaining cases I'd like to suggest a reorg of the related
> headers:
> Instead of having the non-paravirt definition in one header and the
> paravirt
> ones in paravirt.h, maybe it would be better to have only the paravirt
> generic definitions in paravirt.h and the specific functions in the
> header
> defining the non-paravirt variant. This would probably resolve the
> problem
> with the "soup", as paravirt.h wouldn't rely on so many other headers.
>
> I'm just preparing a patch doing the removal of the not needed
> includes, but
> I'd be willing to address the disentangling as noted above.
>
> Thoughts?

I don't know enough about these headers to express an informed opinion,
but it does sound like a useful cleanup. Do you think it would allow
<asm/paravirt_types.h> to include <linux/mm_types.h>? This is what we
would need to have a generic definition of lazy_mmu_state_t (which could
be overridden by defining some __HAVE_ARCH macro in <asm/mmu.h>).

- Kevin
