Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279712222C0;
	Fri, 30 May 2025 14:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748613909; cv=none; b=NOBYcB0IC9KIOcw5H0gymzWbuQ42+0BCkR7PlzoIpu3ZDYU9dC+RlKsa+2yCItsBNB4z+QRXvm8JnrPW5pgUOi93xyI0zt6CP9SLFRDxD6XkWatKuCBf+gXbSPwFxXghr/L7sdt1et9NjCq3cKIvjyfjKUFUIYVTO1mqUFnFaYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748613909; c=relaxed/simple;
	bh=UnYawQEc4ntVkFd8amM1h4wvrs4XjeBDcqt08SIo1n8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pEJpS1p7an9oX4AmgJuh3CX+3Wbg8djFirSa48GwLYxzJIs3VNSW6vFxDN2DWLJmdPqvvzOO/70Kj+kS0tlNq2C6d8axcasPzX/I9kP5dQeA/NomHt81552DmT/81HFQe5TRudI8+T28rZYYiBoRaGM/Gxom9phbDiAZEC1Hz9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 82C55169C;
	Fri, 30 May 2025 07:04:48 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D6E5D3F673;
	Fri, 30 May 2025 07:04:59 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Juergen Gross <jgross@suse.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnd Bergmann <arnd@arndb.de>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	sparclinux@vger.kernel.org,
	virtualization@lists.linux.dev,
	xen-devel@lists.xenproject.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1 0/6] Lazy mmu mode fixes and improvements
Date: Fri, 30 May 2025 15:04:38 +0100
Message-ID: <20250530140446.2387131-1-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi All,

I recently added support for lazy mmu mode on arm64. The series is now in
Linus's tree so should be in v6.16-rc1. But during testing in linux-next we
found some ugly corners (unexpected nesting). I was able to fix those issues by
making the arm64 implementation more permissive (like the other arches). But
this is quite fragile IMHO. So I'd rather fix the root cause and ensure that
lazy mmu mode never nests, and more importantly, that code never makes pgtable
modifications expecting them to be immediate, not knowing that it's actually in
lazy mmu mode so the changes get deferred.

The first 2 patches are unrelated, very obvious bug fixes. They don't affect
arm64 because arm64 only uses lazy mmu for kernel mappings. But I noticed them
during code review and think they should be fixed.

The next 3 patches are aimed at solving the nesting issue.

And the final patch is reverting the "permissive" fix I did for arm64, which is
no longer needed after the previous 3 patches.

I've labelled this RFC for now because it depends on the arm64 lazy mmu patches
in Linus's master, so it won't apply to mm-unstable. But I'm keen to get review
and siince I'm touching various arches and modifying some core mm stuff, I
thought that might take a while so thought I'd beat the rush and get a first
version out early.

I've build-tested all the affected arches. And I've run mm selftests for the
arm64 build, with no issues (with DEBUG_PAGEALLOC and KFENCE enabled).

Applies against Linus's master branch (f66bc387efbe).

Thanks,
Ryan


Ryan Roberts (6):
  fs/proc/task_mmu: Fix pte update and tlb maintenance ordering in
    pagemap_scan_pmd_entry()
  mm: Fix pte update and tlb maintenance ordering in
    migrate_vma_collect_pmd()
  mm: Avoid calling page allocator from apply_to_page_range()
  mm: Introduce arch_in_lazy_mmu_mode()
  mm: Avoid calling page allocator while in lazy mmu mode
  Revert "arm64/mm: Permit lazy_mmu_mode to be nested"

 arch/arm64/include/asm/pgtable.h              | 22 ++++----
 .../include/asm/book3s/64/tlbflush-hash.h     | 15 ++++++
 arch/sparc/include/asm/tlbflush_64.h          |  1 +
 arch/sparc/mm/tlb.c                           | 12 +++++
 arch/x86/include/asm/paravirt.h               |  5 ++
 arch/x86/include/asm/paravirt_types.h         |  1 +
 arch/x86/kernel/paravirt.c                    |  6 +++
 arch/x86/xen/mmu_pv.c                         |  6 +++
 fs/proc/task_mmu.c                            |  3 +-
 include/asm-generic/tlb.h                     |  2 +
 include/linux/mm.h                            |  6 +++
 include/linux/pgtable.h                       |  1 +
 kernel/bpf/arena.c                            |  6 +--
 mm/kasan/shadow.c                             |  2 +-
 mm/memory.c                                   | 54 ++++++++++++++-----
 mm/migrate_device.c                           |  3 +-
 mm/mmu_gather.c                               | 15 ++++++
 17 files changed, 128 insertions(+), 32 deletions(-)

--
2.43.0

