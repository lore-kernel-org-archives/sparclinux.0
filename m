From: "David S. Miller" <davem@redhat.com>
Date: Thu, 19 Aug 2004 01:43:03 +0000
Subject: Re: [2.6] busybox EFAULT on sparc64
Message-Id: <20040818184303.1ae13c98.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20040818235528.GA8070@triplehelix.org>
In-Reply-To: <20040818235528.GA8070@triplehelix.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Joshua Kwan <joshk@triplehelix.org>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Oops, it's possible that the bug fixed by this patch
might fix your problem...

=== include/asm-sparc64/pgtable.h 1.42 vs edited ==--- 1.42/include/asm-sparc64/pgtable.h	2004-08-14 22:20:36 -07:00
+++ edited/include/asm-sparc64/pgtable.h	2004-08-18 18:29:17 -07:00
@@ -335,7 +335,7 @@
 	pte_t orig = *ptep;
 
 	*ptep = pte;
-	if (pte_present(orig))
+	if (pte_val(orig) & _PAGE_VALID)
 		tlb_batch_add(mm, addr, ptep, orig);
 }
 
