Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D87D303A39;
	Mon, 10 Nov 2025 13:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762780715; cv=none; b=fp0MTvktxFF8dSU3CkfndM2eae22QhODfJIveOwviPFp1y4vd55kFcHBR/cZ4GIeABlaadtC3F+Wp9BgtYhE22ISTqrj0tnuoiQkFaE0sXS8w/Xf2czXzWLWs5BbrQbhHq9meOr86yFsxYN5k+2wRKUoM2lkvnCOmBY8xIe7mjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762780715; c=relaxed/simple;
	bh=e61PmBuBpKPW0kEFbYkXrje4f08ptI1Bgty+XwFb8EM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cLJu9lgvmcujp4KL4nZKWZ9+i4COOoilkH88sg2ypvqCl3ox4jsiinU9o6Af+qq9MTjcIhW+wJ4HJ7xaZfPqHtZR+iWMUncR01eVL+Sd3B6qlZVhArmDkD58mRkHfiy65lD4STnyUrvFOS3hH26uhhbKYew60+0ZFr13QV/egvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E7B25497;
	Mon, 10 Nov 2025 05:18:22 -0800 (PST)
Received: from [10.57.39.147] (unknown [10.57.39.147])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D493F3F63F;
	Mon, 10 Nov 2025 05:18:22 -0800 (PST)
Message-ID: <d0ce35ad-bfcd-496b-996d-17e59a1d5a73@arm.com>
Date: Mon, 10 Nov 2025 14:18:20 +0100
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/12] powerpc/64s: Do not re-activate batched TLB
 flush
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, linux-mm@kvack.org
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
 Peter Zijlstra <peterz@infradead.org>, Ryan Roberts <ryan.roberts@arm.com>,
 Suren Baghdasaryan <surenb@google.com>, Thomas Gleixner
 <tglx@linutronix.de>, Vlastimil Babka <vbabka@suse.cz>,
 Will Deacon <will@kernel.org>, Yeoreum Yun <yeoreum.yun@arm.com>,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 sparclinux@vger.kernel.org, xen-devel@lists.xenproject.org, x86@kernel.org,
 Venkat Rao Bagalkote <venkat88@linux.ibm.com>
References: <20251029100909.3381140-1-kevin.brodsky@arm.com>
 <20251029100909.3381140-2-kevin.brodsky@arm.com>
 <87qzud42n1.ritesh.list@gmail.com>
 <b3e4a92f-5b51-4eee-bfb8-c454add0f0d2@arm.com>
 <87cy5t4b0a.ritesh.list@gmail.com>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <87cy5t4b0a.ritesh.list@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 08/11/2025 00:35, Ritesh Harjani (IBM) wrote:
> Kevin Brodsky <kevin.brodsky@arm.com> writes:
>
>> [...]
>>
>>> With this analysis - the patch looks good to me. I will give this entire
>>> patch series a try on Power HW with Hash mmu too (which uses lazy mmu and
>>> let you know the results of that)!
>> That'd be very appreciated, thanks a lot!
>>
> I did give this patch series a run on Power10 with Hash MMU. I ran the
> following stress-ng tests and didn't observe any issues (kernel warnings) so far.
>
> stress-ng --all 0 -t 60s --perf -v --verify \
> --tlb-shootdown 0 \
> --fault 0 \
> --userfaultfd 0 \
> --fork 0 \
> --exec 0 \
> --memfd 0 \
> --numa 0 \
> --pkey 0 \
> --remap 0 \
> --vm 0 \
> --rmap 0 \
> -x swap,pagemove
> (Note not all options shown here will work with --verify)

That's great, many thanks!

> Let me know what else I can run for validation?
> Do you know of any specific tests for validation of lazy mmu feature?

I don't think there is - lazy MMU is not supposed to have any observable
effect, all we can do is exercise the paths that use it and check that
nothing explodes.

That said it wouldn't hurt to run the mm kselftests:

    make -C tools/testing/selftests/ TARGETS=mm

Thanks!

- Kevin
