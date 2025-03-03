Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550D74685;
	Mon,  3 Mar 2025 14:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741011358; cv=none; b=Ft9D//d4dUrpZBZOYNcm/8LUWWGRUaSsdFoRBM8ooLCSUhR4fqTfZQfQpbhtRznDxN257jCLqA0BBfCS39QeoKSuTcxsmr449vVz0tojHjiFVJacrqNflVg4Z5NIKLCKkOi6g089qiQgf5KLUUYabmVxwuan1hW7OXdgqWkkX88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741011358; c=relaxed/simple;
	bh=h2fqgjv7C6q2gg+EhqriK+B50X2nVechT92LfHhTqt8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eZSqHPZxIQcZdAgxR+AFe7MxIbHAjRMWnRUzMXg78q0S/Kvcqv/hovkJZbGhlxv1+GtguBNydMRao/HShM+JDM5po/Vv7xKplUplxYdPAHy+GFa7gZLCabTg0Ey84pKJVaDzdM8MsEftSEFQte+S1tU9gdO7TZAzYpIo7Xs1kxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 535C3106F;
	Mon,  3 Mar 2025 06:16:08 -0800 (PST)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 46EB83F66E;
	Mon,  3 Mar 2025 06:15:52 -0800 (PST)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Juergen Gross <jgross@suse.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Catalin Marinas <catalin.marinas@arm.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-mm@kvack.org,
	sparclinux@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] Fix lazy mmu mode
Date: Mon,  3 Mar 2025 14:15:34 +0000
Message-ID: <20250303141542.3371656-1-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi All,

I'm planning to implement lazy mmu mode for arm64 to optimize vmalloc. As part
of that, I will extend lazy mmu mode to cover kernel mappings in vmalloc table
walkers. While lazy mmu mode is already used for kernel mappings in a few
places, this will extend it's use significantly.

Having reviewed the existing lazy mmu implementations in powerpc, sparc and x86,
it looks like there are a bunch of bugs, some of which may be more likely to
trigger once I extend the use of lazy mmu. So this series attempts to clarify
the requirements and fix all the bugs in advance of that series. See patch #1
commit log for all the details.

Note that I have only been able to compile test these changes but I think they
are in good enough shape for some linux-next testing.

Applies on Friday's mm-unstable (5f089a9aa987), as I assume this would be
preferred via that tree.

Changes since v1
================
  - split v1 patch #1 into v2 patch #1 and #2; per David
  - Added Acked-by tags from David and Andreas; Thanks!
  - Refined the patches which are truely fixes and added to stable to cc

Thanks,
Ryan

Ryan Roberts (5):
  mm: Fix lazy mmu docs and usage
  fs/proc/task_mmu: Reduce scope of lazy mmu region
  sparc/mm: Disable preemption in lazy mmu mode
  sparc/mm: Avoid calling arch_enter/leave_lazy_mmu() in set_ptes
  Revert "x86/xen: allow nesting of same lazy mode"

 arch/sparc/include/asm/pgtable_64.h   |  2 --
 arch/sparc/mm/tlb.c                   |  5 ++++-
 arch/x86/include/asm/xen/hypervisor.h | 15 ++-------------
 arch/x86/xen/enlighten_pv.c           |  1 -
 fs/proc/task_mmu.c                    | 11 ++++-------
 include/linux/pgtable.h               | 14 ++++++++------
 6 files changed, 18 insertions(+), 30 deletions(-)

--
2.43.0

