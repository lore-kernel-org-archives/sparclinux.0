Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80701EEC8;
	Sun,  2 Mar 2025 14:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740927371; cv=none; b=TbsmoYg7rVOdVA3knFAcFX4XXC1v0nxPy8gl8nbOqnewv6Ny+WUbURczWHtfl9QkDWeAvaoSqbQVOZNQNxbwanY+pnYsh0330ywChN23c3oIf4DmJS4oxp2mKYJs2jv8yovLkQBtydDK+ss5O54y8nEUjMpsqFXcrjHoJUSF9P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740927371; c=relaxed/simple;
	bh=dMlB2sjHftBQmjalgxEYl7xMqHYUTDnf1n48Svx6VTM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eQ3vjD5BRAXj1eyKDfnYX0oCcJ3aBcVb1yL3o9NT1FL06D+18BOiTpIM/7LrnU3rWqIsoKBeQ9cm3n3hv+3lbvE6p53J2e6AlaNJSdH6j/fZJRdjQMqm0YXjcMp1LydlOSm55aiALVRDQMZ+vElTVJhqUNBuMeFniikJe5sSTRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F1AA2113E;
	Sun,  2 Mar 2025 06:56:22 -0800 (PST)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 294533F5A1;
	Sun,  2 Mar 2025 06:56:06 -0800 (PST)
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
Subject: [PATCH v1 0/4] Fix lazy mmu mode
Date: Sun,  2 Mar 2025 14:55:50 +0000
Message-ID: <20250302145555.3236789-1-ryan.roberts@arm.com>
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

Note that I have only been able to compile test these changes so appreciate any
help in testing.

Applies on Friday's mm-unstable (5f089a9aa987), as I assume this would be
preferred via that tree.

Thanks,
Ryan

Ryan Roberts (4):
  mm: Fix lazy mmu docs and usage
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

