Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475492BD58A;
	Wed,  3 Dec 2025 08:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764750047; cv=none; b=sG4kKUsv3+lkP4YYD/+egE/zgkBKFEPw0ZldNkXjFfOr5Xjj4Ijx59h4uwpQ3MUk5m0HO80IHbzvn08ulKkWQNBngI9nGww9P7PNsRCSKe8KfiZkB4fSlg05j2T0HUWklaElUgSPFd/PD7o6TYEebzwv1CgP40h7cLH1UZtWbDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764750047; c=relaxed/simple;
	bh=S0KFo/PIG0zyqfzbOOhhb6fhk0HqyRItHWtVwjF8GfI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XkS4Je/noZtQkr1REEMLQ/ZBWUaT3K1WuZ8uC+ctuAXFnG/+H098u/r8/sI/2SyFzHF4LlnBAjtqhNseK4i49uBdKhAWkusr/2ZfygGBbHU2YrFFO2YARzU/jhqd4+s6HWY3xtzHj9TWZZkcHhabgseWFlUJP+p8UVk2p6eCVB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1B547339;
	Wed,  3 Dec 2025 00:20:38 -0800 (PST)
Received: from [10.57.45.92] (unknown [10.57.45.92])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 49CE33F73B;
	Wed,  3 Dec 2025 00:20:37 -0800 (PST)
Message-ID: <51339cdd-3c73-433c-abf7-24553e0fbd6b@arm.com>
Date: Wed, 3 Dec 2025 09:20:34 +0100
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/12] mm: introduce generic lazy_mmu helpers
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
 <20251124132228.622678-7-kevin.brodsky@arm.com>
 <07ffb66d-1e74-4634-bccb-75575b3862af-agordeev@linux.ibm.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <07ffb66d-1e74-4634-bccb-75575b3862af-agordeev@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/11/2025 14:50, Alexander Gordeev wrote:
> Would it make sense to explicitly describe the policy wrt sleeping while
> in lazy MMU mode? If I understand the conclusion of conversation right:
>
> * An arch implementation may disable preemption, but then it is arch
>   responsibility not to call any arch-specific code that might sleep;
> * As result, while in lazy MMU mode the generic code should never
>   call a code that might sleep;

I think that's a good summary, and I agree that the second point is not
obvious from the comment in <linux/pgtable.h>. This series it not making
any change in that respect, but I'll add a clarification in this patch
(or a separate patch).

- Kevin
