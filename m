Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9041236AB61;
	Sat, 21 Mar 2026 10:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774090785; cv=none; b=DV4SFLU6ZnM7pzjSqdLN+RGgQP7D4ROMQpujqwa+ZWWCYEwQ+4RakGyOjTwACjNZOf9F9OyY0kRRLgSxOsQGDr9sAiiXa0U7CFCd/oNDR+YH2Cra7DDDxzVv+IxhzsgxgZcGIp1L/4gpWm3cEQ3ut7xCKQvYVvwmlN6M/6POE3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774090785; c=relaxed/simple;
	bh=KuJ0qSKVDTO5kYDsu9BNj5ITynbKA5w2OweBy2N+yDI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pXhQTyhoXZzeWDh6F5nFoqycGx9z6QuU/0bNKpQBXgZ0FaIfRrFh2CkwZpSK3bLjvim2qHJeZ6Cap1pdUpBC6eeMIH7vzi3Aq27HfsHOjwP9kSeVer/uBvdWRZ2fG+cIXj/nEdSfL8EycqtXy3b3lWQpFJcJTd/Zk7KJ7igufTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b=OALECA7o; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b="OALECA7o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
	s=iohv2404; t=1774090779;
	bh=TGfbWQuBf+vWZHfxVms8yIOv1i8spMOYrGQg7u8kioA=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=OALECA7ofe2Kbj/0nOSLmlPIYsS2fyLrj7n7dhGeYDVGfVi4HiEXuaJiXAb78rs14
	 99PUsoownmZAqBOT3tl1uwEO3gC4w8kRqaU2nNglrFcx7Hdw2rDVhgqdKfLwbDs4sk
	 MlqkDnBytlBFhKfEFxXz2l4wdHLXRn9yf0wUTYBA=
X-QQ-mid: esmtpsz19t1774090778t9d25d4be
X-QQ-Originating-IP: FexrMMAhYqSmz/B2XHuN1JNlgu7NYzLuN8chFMQUiFU=
Received: from localhost.localdomain ( [116.172.93.199])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 21 Mar 2026 18:59:35 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2378410286923065694
EX-QQ-RecipientCnt: 13
From: Kexin Sun <kexinsun@smail.nju.edu.cn>
To: davem@davemloft.net,
	andreas@gaisler.com,
	akpm@linux-foundation.org,
	rppt@kernel.org,
	kevin.brodsky@arm.com,
	agordeev@linux.ibm.com,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: julia.lawall@inria.fr,
	xutong.ma@inria.fr,
	kexinsun@smail.nju.edu.cn,
	yunbolyu@smu.edu.sg,
	ratnadiraw@smu.edu.sg
Subject: [PATCH] sparc32: remove deadwood swift_flush_tlb_page() debug code
Date: Sat, 21 Mar 2026 18:59:35 +0800
Message-Id: <20260321105935.8068-1-kexinsun@smail.nju.edu.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:smail.nju.edu.cn:qybglogicsvrgz:qybglogicsvrgz5b-0
X-QQ-XMAILINFO: MWgnKUIRcMzUi2wsckyWJzHW9p2iPyAXKe8nebHiWpvtoigjq5Bzt7TP
	toVkcktkWxgV0J7HoQTo0PyF4ulAfzx6H7X6jUx1iyHTpETH34AuhfNHzdbZpBSUVYp114E
	hIe4dEisXFv7LKyhnmekLTfb7ODBWNLnGf442if24Yt/kRJI9YkxGx6KaZmHjzyhGHiFIg9
	ibiCztmj/NgtYx4PXSeFX6US1pVHpkzyNTo54UL3pxDCpCquGUOklE7P/hRJkncc2shrJUe
	vq2s/O1Cn22FB7uZ2DUvZKtYvXoFqJpRHm9sQlXOQD/OBZp0DJd/EhDEiAG/JtBNXYIRZa3
	iBSkJxYfzeYPmW9qyKdHBLoanz1//liojfQiwi4QmvFXj/3Aidqd1i/MbmG3LnGDAL83L12
	zQkQwcoPXORPaxcX1ze0JbRWKgpkV9O63f7V7MIRKpI2lMtbio1tqRoq076V5zCs7sagx4K
	WFLr0ezQQvdNBrGIu/GCMDcgL2aHwXHbCycehx8x2Iw/2JFDS0peFB3PFFkWHdvV3/Xmjfq
	okLZEdgXqqWWwvNy3jfhn2VEuArEBHCCPAr6fwqFv6jPmsCftxB0/95QJ00e6lrtcZemf1C
	nv1CEILJbUSn9uhjjT17YL37JTpwp13yuNmU3kluQupgltx0jUgjOUoNom/fEro1w86D2Cy
	IHpqlu303m57/s+m83Hd1qhd7owsu8PPDZCYudMQLjq0Pc0hLWnBfRf8x+hA0fJdECBnmtL
	0QIVxmG8R+TFSnbM2Dw4Sw9wSXIsFChB+2e84rasTgUmrld7mwDXgjFpIu4+MynKTR0jP0P
	Ovtdknxz+bpWZ4WXEFB6n1s3IETYKGSJMhDiSN4LLFFnjpzTqIxxnQbM1MEHkkUNrGGcIqf
	MEbcdCMPeS9j/SLiMPg3d1L9dgTzd3i20jZ4ksECAJ80TwtIeH8ruf9Bt/5Vb8zL1WA/W3U
	Yd12GocbPA9S2oAOX+IyLgDSlKStBMbJRRpQoDNp8KEFtlVcTDP1gwk0HYpd3F/0auoGut6
	bLOWl2WKZzL6a4idWTFXouUgFEcQltm68olybEXyfkStazz4CUvhUa13lbSd42EwOoeeaqx
	5/x6Uda71fW
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0

Remove an #if 0 block that has been dead since at least
Linux 2.6.12.  The block was marked "P3: deadwood to debug
precise flushes on Swift" and contained a never-compiled
alternative implementation of swift_flush_tlb_page().  It also
referenced the since-removed srmmu_flush_tlb_page(), dropped
in commit 3d5f7d37c8b4 ("sparc32: drop unused functions in
pgtsrmmu.h").

Assisted-by: unnamed:deepseek-v3.2 coccinelle
Signed-off-by: Kexin Sun <kexinsun@smail.nju.edu.cn>
---
 arch/sparc/mm/srmmu.c | 29 -----------------------------
 1 file changed, 29 deletions(-)

diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index 1b24c5e8d73d..9a74902ad181 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -581,35 +581,6 @@ extern void swift_flush_tlb_range(struct vm_area_struct *vma,
 				  unsigned long start, unsigned long end);
 extern void swift_flush_tlb_page(struct vm_area_struct *vma, unsigned long page);
 
-#if 0  /* P3: deadwood to debug precise flushes on Swift. */
-void swift_flush_tlb_page(struct vm_area_struct *vma, unsigned long page)
-{
-	int cctx, ctx1;
-
-	page &= PAGE_MASK;
-	if ((ctx1 = vma->vm_mm->context) != -1) {
-		cctx = srmmu_get_context();
-/* Is context # ever different from current context? P3 */
-		if (cctx != ctx1) {
-			printk("flush ctx %02x curr %02x\n", ctx1, cctx);
-			srmmu_set_context(ctx1);
-			swift_flush_page(page);
-			__asm__ __volatile__("sta %%g0, [%0] %1\n\t" : :
-					"r" (page), "i" (ASI_M_FLUSH_PROBE));
-			srmmu_set_context(cctx);
-		} else {
-			 /* Rm. prot. bits from virt. c. */
-			/* swift_flush_cache_all(); */
-			/* swift_flush_cache_page(vma, page); */
-			swift_flush_page(page);
-
-			__asm__ __volatile__("sta %%g0, [%0] %1\n\t" : :
-				"r" (page), "i" (ASI_M_FLUSH_PROBE));
-			/* same as above: srmmu_flush_tlb_page() */
-		}
-	}
-}
-#endif
 
 /*
  * The following are all MBUS based SRMMU modules, and therefore could
-- 
2.25.1

