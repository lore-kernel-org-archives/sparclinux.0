Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6282144B1;
	Mon,  3 Mar 2025 14:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741011368; cv=none; b=nw9h0cVPeRgcmHget4W8Z28uPdQw7r/lRHqPtU7my+oueATvoMkU1cyj+FlRfpkMQvW5g9rf7ylV/rTMAebSEhIl658S7xlSg9/o2rNqCnKAuCmcWinVDhHp755/9+MZ6Hk8dizYHg9L8xQVaSdRmBbKYrG4y/sClXA0Xn+VxGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741011368; c=relaxed/simple;
	bh=cpNGeWLEjm/fRiUkGRaHGZ0QWlWY3HGpU8bx6ai8MnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UxZm9ipi46g+C+FxKQxyxCKUbH4vt2utFL9SVuLDX2Bv3rCrpLbAySbGEenPckctaY0PX6X/3zqKuOzzmnxmu7+yfgYxobX4pPTw0LitpYNn+G2PNyllGyUjq98xRO3mzz80GBdCZgYvmgDH0lmyOmOCHvj2uZd7eU4XWU5aL+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F7BE106F;
	Mon,  3 Mar 2025 06:16:20 -0800 (PST)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2C3CA3F66E;
	Mon,  3 Mar 2025 06:16:04 -0800 (PST)
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
	linux-kernel@vger.kernel.org,
	David Hildenbrand <david@redhat.com>
Subject: [PATCH v2 5/5] Revert "x86/xen: allow nesting of same lazy mode"
Date: Mon,  3 Mar 2025 14:15:39 +0000
Message-ID: <20250303141542.3371656-6-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250303141542.3371656-1-ryan.roberts@arm.com>
References: <20250303141542.3371656-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 49147beb0ccb ("x86/xen: allow nesting of same lazy mode") was
added as a solution for a core-mm code change where
arch_[enter|leave]_lazy_mmu_mode() started to be called in a nested
manner; see commit bcc6cc832573 ("mm: add default definition of
set_ptes()").

However, now that we have fixed the API to avoid nesting, we no longer
need this capability in the x86 implementation.

Additionally, from code review, I don't believe the fix was ever robust
in the case of preemption occurring while in the nested lazy mode. The
implementation usually deals with preemption by calling
arch_leave_lazy_mmu_mode() from xen_start_context_switch() for the
outgoing task if we are in the lazy mmu mode. Then in
xen_end_context_switch(), it restarts the lazy mode by calling
arch_enter_lazy_mmu_mode() for an incoming task that was in the lazy
mode when it was switched out. But arch_leave_lazy_mmu_mode() will only
unwind a single level of nesting. If we are in the double nest, then
it's not fully unwound and per-cpu variables are left in a bad state.

So the correct solution is to remove the possibility of nesting from the
higher level (which has now been done) and remove this x86-specific
solution.

Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 arch/x86/include/asm/xen/hypervisor.h | 15 ++-------------
 arch/x86/xen/enlighten_pv.c           |  1 -
 2 files changed, 2 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/xen/hypervisor.h b/arch/x86/include/asm/xen/hypervisor.h
index a9088250770f..bd0fc69a10a7 100644
--- a/arch/x86/include/asm/xen/hypervisor.h
+++ b/arch/x86/include/asm/xen/hypervisor.h
@@ -72,18 +72,10 @@ enum xen_lazy_mode {
 };
 
 DECLARE_PER_CPU(enum xen_lazy_mode, xen_lazy_mode);
-DECLARE_PER_CPU(unsigned int, xen_lazy_nesting);
 
 static inline void enter_lazy(enum xen_lazy_mode mode)
 {
-	enum xen_lazy_mode old_mode = this_cpu_read(xen_lazy_mode);
-
-	if (mode == old_mode) {
-		this_cpu_inc(xen_lazy_nesting);
-		return;
-	}
-
-	BUG_ON(old_mode != XEN_LAZY_NONE);
+	BUG_ON(this_cpu_read(xen_lazy_mode) != XEN_LAZY_NONE);
 
 	this_cpu_write(xen_lazy_mode, mode);
 }
@@ -92,10 +84,7 @@ static inline void leave_lazy(enum xen_lazy_mode mode)
 {
 	BUG_ON(this_cpu_read(xen_lazy_mode) != mode);
 
-	if (this_cpu_read(xen_lazy_nesting) == 0)
-		this_cpu_write(xen_lazy_mode, XEN_LAZY_NONE);
-	else
-		this_cpu_dec(xen_lazy_nesting);
+	this_cpu_write(xen_lazy_mode, XEN_LAZY_NONE);
 }
 
 enum xen_lazy_mode xen_get_lazy_mode(void);
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 5e57835e999d..919e4df9380b 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -99,7 +99,6 @@ struct tls_descs {
 };
 
 DEFINE_PER_CPU(enum xen_lazy_mode, xen_lazy_mode) = XEN_LAZY_NONE;
-DEFINE_PER_CPU(unsigned int, xen_lazy_nesting);
 
 enum xen_lazy_mode xen_get_lazy_mode(void)
 {
-- 
2.43.0

