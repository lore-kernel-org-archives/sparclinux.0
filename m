Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03A133B6FB;
	Fri,  5 Dec 2025 13:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764939659; cv=none; b=AnF2q3WsQlj38kTYz37ydFwoDmzJGakJSZRzb5VFJmRkuA0Vsu7nsVQqxlFub53qeLi4/RvnbsOXsjNfN1bXi6AxHuVWGoPaVbVH3QFeBhqXYLiKQGd5IcfuVw4vvbFRyYVQwBvi0zYo3LiZFjjANPtQ3U+qCZst8MG5pPfK6Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764939659; c=relaxed/simple;
	bh=O/A7vZpgIBnKA8LnxsqL7KkP6nyGfOKKNJo36CMVlRE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HzCde1TrpwcCvTBELup0BfXqbH8NLEB5Zk6nukqPK8co48GKqTA6oDc6jwmg3lvaie45yZRuQBmNeU9+tq0V9p2epE5d7LqwxNesTtf59I8F/6Q07XtuOR0n9vros2HpguryK7D3I9zKLKEQeseddEKHg/DTGNz5sj+P/h4QIHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A482F19F6;
	Fri,  5 Dec 2025 05:00:42 -0800 (PST)
Received: from [10.44.160.68] (e126510-lin.lund.arm.com [10.44.160.68])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 164973F59E;
	Fri,  5 Dec 2025 05:00:39 -0800 (PST)
Message-ID: <f07f5f70-eb4c-4e45-b7d6-96c8455255d2@arm.com>
Date: Fri, 5 Dec 2025 14:00:37 +0100
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/12] Nesting support for lazy MMU mode
To: Venkat <venkat88@linux.ibm.com>
Cc: linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
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
 Thomas Gleixner <tglx@linutronix.de>, Vlastimil Babka <vbabka@suse.cz>,
 Will Deacon <will@kernel.org>, Yeoreum Yun <yeoreum.yun@arm.com>,
 linux-arm-kernel@lists.infradead.org,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, sparclinux@vger.kernel.org,
 xen-devel@lists.xenproject.org, x86@kernel.org
References: <20251124132228.622678-1-kevin.brodsky@arm.com>
 <94889730-1AEF-458F-B623-04092C0D6819@linux.ibm.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <94889730-1AEF-458F-B623-04092C0D6819@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 03/12/2025 17:08, Venkat wrote:
> [...]
> Tested this patch series by applying on top of mm-unstable, on both HASH and RADIX MMU, and all tests are passed on both MMU’s.
>
> Ran: cache_shape, copyloops, mm from linux source, selftests/powerpc/ and ran memory-hotplug from selftests/. Also ran below tests from avocado misc-test repo.
>
> Link to repo: https://github.com/avocado-framework-tests/avocado-misc-tests
>
> avocado-misc-tests/memory/stutter.py
> avocado-misc-tests/memory/eatmemory.py
> avocado-misc-tests/memory/hugepage_sanity.py
> avocado-misc-tests/memory/fork_mem.py
> avocado-misc-tests/memory/memory_api.py
> avocado-misc-tests/memory/mprotect.py
> avocado-misc-tests/memory/vatest.py avocado-misc-tests/memory/vatest.py.data/vatest.yaml
> avocado-misc-tests/memory/transparent_hugepages.py
> avocado-misc-tests/memory/transparent_hugepages_swapping.py
> avocado-misc-tests/memory/transparent_hugepages_defrag.py
> avocado-misc-tests/memory/ksm_poison.py
>
> If its good enough, please add below tag for PowerPC changes.
>
> Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>

Many thanks for the testing! Will add your tag to patch 1, 3 and 10.

- Kevin
