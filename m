Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9D12D46C8;
	Thu,  4 Sep 2025 22:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757024094; cv=none; b=ghXQGv3eXC+XSd4YqT+xWiBoSGBmEuC8fWvITCCjXi2x1YF2Ds7Xqh7P1v9Zkgz34NB7BphYV5iem2WAWE0QjdaPS+Sx3Q9dt39WdFdYSPqeGKm8xIFpsfMrUk9DDk9xd4LI637Mnwnxtz8XYlYs1T2NG0GThGnFvJsM9GkdYmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757024094; c=relaxed/simple;
	bh=tR8bRPKrAsiMDrBi4Jc86OCZCYcgzukXnSpHEWnXymg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fbx94RoQ8gLO3tmXwpAUgZk2ZqJw9NnulK3rYry9MTXi86qA9zgSGPJjxeOMAZl0mAWSN0JhrwnT0c3V3DNIsjYel+zADKRAnayZRgG70QpGw0EjUMP3bYsJek5S9kbcwAl+FT/P+KuHjFCP6FwZI+OHkmdr4+uDXvjHA7GwRjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2977D1596;
	Thu,  4 Sep 2025 15:14:43 -0700 (PDT)
Received: from [10.57.58.14] (unknown [10.57.58.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 46B793F63F;
	Thu,  4 Sep 2025 15:14:44 -0700 (PDT)
Message-ID: <75db1f58-98b3-463c-af4f-2ce9878cba9f@arm.com>
Date: Fri, 5 Sep 2025 00:14:39 +0200
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] mm: introduce local state for lazy_mmu sections
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Andreas Larsson <andreas@gaisler.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, Borislav Petkov
 <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 David Hildenbrand <david@redhat.com>, "David S. Miller"
 <davem@davemloft.net>, "H. Peter Anvin" <hpa@zytor.com>,
 Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
 Juergen Gross <jgross@suse.com>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Michal Hocko <mhocko@suse.com>,
 Mike Rapoport <rppt@kernel.org>, Nicholas Piggin <npiggin@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>, Ryan Roberts <ryan.roberts@arm.com>,
 Suren Baghdasaryan <surenb@google.com>, Thomas Gleixner
 <tglx@linutronix.de>, Vlastimil Babka <vbabka@suse.cz>,
 Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
 xen-devel@lists.xenproject.org
References: <20250904125736.3918646-1-kevin.brodsky@arm.com>
 <20250904125736.3918646-3-kevin.brodsky@arm.com>
 <22131943-3f92-4f5a-be28-7b668c07a25c@lucifer.local>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <22131943-3f92-4f5a-be28-7b668c07a25c@lucifer.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 04/09/2025 19:28, Lorenzo Stoakes wrote:
> Hi Kevin,
>
> This is causing a build failure:
>
> In file included from ./include/linux/mm.h:31,
>                  from mm/userfaultfd.c:8:
> mm/userfaultfd.c: In function ‘move_present_ptes’:
> ./include/linux/pgtable.h:247:41: error: statement with no effect [-Werror=unused-value]
>   247 | #define arch_enter_lazy_mmu_mode()      (LAZY_MMU_DEFAULT)
>       |                                         ^
> mm/userfaultfd.c:1103:9: note: in expansion of macro ‘arch_enter_lazy_mmu_mode’
>  1103 |         arch_enter_lazy_mmu_mode();
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/pgtable.h:248:54: error: expected expression before ‘)’ token
>   248 | #define arch_leave_lazy_mmu_mode(state) ((void)(state))
>       |                                                      ^
> mm/userfaultfd.c:1141:9: note: in expansion of macro ‘arch_leave_lazy_mmu_mode’
>  1141 |         arch_leave_lazy_mmu_mode();
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~
>
> It seems you haven't carefully checked call sites here, please do very
> carefully recheck these - I see Yeoreum reported a mising kasan case, so I
> suggest you just aggressively grep this + make sure you've covered all
> bases :)

I did check all call sites pretty carefully and of course build-tested,
but my series is based on v6.17-rc4 - just like the calls Yeoreum
mentioned, the issue is that those calls are in mm-stable but not in
mainline :/ I suppose I should post a v2 rebased on mm-stable ASAP then?

- Kevin
