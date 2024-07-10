Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC6617FD;
	Wed, 10 Jul 2024 09:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720603951; cv=none; b=hEThDf1gnw5vgPq8EWe+POdNRCddkEUm0PkPTy5zMSvNRnqFAd9l+k8OshKUbVEyndE7KilyT97Hh2xY8WzMbEyT7syxlKSp/RNwhsKbb/tug1iT+ztH6LpEZspD2gjYxk5e0veot58U9NDwwcAcifU9NZ/3qzwc9XvWnzZpnCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720603951; c=relaxed/simple;
	bh=acLe3ldn1XAUOZC1eJHeqqQHZemln1Q0UW4ImH3kPpc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ynin7xttHHx17F+uI+zZvD5o3IbkFZqAGR2It0O9x8eicgrYL36yPuMFZ18nu38pBzKn8h8MiKq+Lek3972aq2fws/YhvZlus90n8Tmgg5ho7bqpPVQucfSJAakZ7LYuQD0+/RHnsK994mrH7rG1l9OdmBs9PZI2cx5dA8muJEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=VeczMIl9; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="VeczMIl9"
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4WJsqw0X4Xz1DPkj;
	Wed, 10 Jul 2024 11:24:12 +0200 (CEST)
Received: from andreas.got.gaisler.com (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	by smtp.simply.com (Simply.com) with ESMTPA id 4WJsqv5S0dz1DPkB;
	Wed, 10 Jul 2024 11:24:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=unoeuro; t=1720603451;
	bh=eYu5bXT7dIaOhYcImSTacFJvmy2a/tFfDo4KgkIKANM=;
	h=From:To:Cc:Subject:Date;
	b=VeczMIl9sddXJPmuyutEJAO6jfajx2XYK2OgueiVSyqGu8mdd0u6jxPGix74xWZBu
	 GVslai9DR1j8hfjEre6gfSgb7RqST5aBTvdlxpN5gCtTGxVTvC0LN92QbadqkzhUEx
	 RWpwZB7QXKb9cz+8S+5z/aszuVG+7v1v2X6CM1hI=
From: Andreas Larsson <andreas@gaisler.com>
To: David Miller <davem@davemloft.net>,
	sparclinux@vger.kernel.org
Cc: Sam Ravnborg <sam@ravnborg.org>,
	linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] sparc32: Fix truncated relocation errors when linking large kernels
Date: Wed, 10 Jul 2024 11:23:41 +0200
Message-Id: <20240710092341.457591-1-andreas@gaisler.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use jumps instead of branches when jumping from one section to another
to avoid branches to addresses further away than 22 bit offsets can
handle that results in errors such as

arch/sparc/kernel/signal_32.o:(.fixup+0x0): relocation truncated to fit: R_SPARC_WDISP22 against `.text'

This is the same approach that was taken for sparc64 in commit
52eb053b7191 ("[SPARC64]: Fix linkage of enormous kernels.")

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202405080936.tWaJdO3P-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202406240441.5zaoshVX-lkp@intel.com/
Signed-off-by: Andreas Larsson <andreas@gaisler.com>
---
 arch/sparc/include/asm/uaccess_32.h |  6 ++++--
 arch/sparc/kernel/head_32.S         | 15 +++++++++++----
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/arch/sparc/include/asm/uaccess_32.h b/arch/sparc/include/asm/uaccess_32.h
index 9fd6c53644b6..43284b6ec46a 100644
--- a/arch/sparc/include/asm/uaccess_32.h
+++ b/arch/sparc/include/asm/uaccess_32.h
@@ -95,7 +95,8 @@ __asm__ __volatile__(							\
 		".section .fixup,#alloc,#execinstr\n\t"			\
 		".align	4\n"						\
 	"3:\n\t"							\
-		"b	2b\n\t"						\
+		"sethi	%%hi(2b), %0\n\t"				\
+		"jmpl	%0 + %%lo(2b), %%g0\n\t"			\
 		" mov	%3, %0\n\t"					\
 		".previous\n\n\t"					\
 		".section __ex_table,#alloc\n\t"			\
@@ -163,8 +164,9 @@ __asm__ __volatile__(							\
 		".section .fixup,#alloc,#execinstr\n\t"			\
 		".align	4\n"						\
 	"3:\n\t"							\
+		"sethi	%%hi(2b), %0\n\t"				\
 		"clr	%1\n\t"						\
-		"b	2b\n\t"						\
+		"jmpl	%0 + %%lo(2b), %%g0\n\t"			\
 		" mov	%3, %0\n\n\t"					\
 		".previous\n\t"						\
 		".section __ex_table,#alloc\n\t"			\
diff --git a/arch/sparc/kernel/head_32.S b/arch/sparc/kernel/head_32.S
index 964c61b5cd03..38345460d542 100644
--- a/arch/sparc/kernel/head_32.S
+++ b/arch/sparc/kernel/head_32.S
@@ -118,9 +118,12 @@ current_pc:
 		mov	%o7, %g3
 
 		tst	%o0
-		be	no_sun4u_here
+		bne	2f
 		 mov	%g4, %o7		/* Previous %o7. */
-
+		sethi	%hi(no_sun4u_here), %l1
+		jmpl	%l1 + %lo(no_sun4u_here), %g0
+		 nop
+2:
 		mov	%o0, %l0		! stash away romvec
 		mov	%o0, %g7		! put it here too
 		mov	%o1, %l1		! stash away debug_vec too
@@ -195,7 +198,8 @@ halt_notsup:
 		sub	%o0, %l6, %o0
 		call	%o1
 		 nop
-		ba	halt_me
+		sethi	%hi(halt_me), %o0
+		jmpl	%o0 + %lo(halt_me), %g0
 		 nop
 
 not_a_sun4:
@@ -431,8 +435,11 @@ leon_init:
 #ifdef CONFIG_SMP
 		ldub	[%g2 + %lo(boot_cpu_id)], %g1
 		cmp	%g1, 0xff		! unset means first CPU
-		bne	leon_smp_cpu_startup	! continue only with master
+		be 1f
+		 sethi	%hi(leon_smp_cpu_startup), %g1
+		jmpl	%g1 + %lo(leon_smp_cpu_startup), %g0
 		 nop
+1:
 #endif
 		/* Get CPU-ID from most significant 4-bit of ASR17 */
 		rd     %asr17, %g1
-- 
2.34.1

