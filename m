Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D33B447241;
	Sun, 18 Oct 2026 12:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.121.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792326468; cv=none; b=vEXETgAIaBug5bxk420vhXWLNy2V9uYDM8jfWXuN+eTp632ufqgEDUliCoJstG+kZYb5SAVCLCqQXs/JpUBEciWQywhH5JznVGQdbfYxD8u843ivI75166pyAtgGDmRpXz56p7KiDudCUDoFxmnDUvDu+xY2mrv5pUdzg3Pxlpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792326468; c=relaxed/simple;
	bh=qtoHWytmeGIZDJ0WOyGC6H2hnw7nbbsh3nU2J5OtdvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eUw2VjxZCfOhk8c6sn5jetdjGfAZoALZYZCkGNrwxIb7eOo48Se5wwd2OKJlhCL49U0bynHhCmtLizgnUfX/eyU5HE8FFynKkWmhoddISWuIEhu2B8Gtgf2zga6OLRLl9k4ZwiPs5dyO9lEHX1+1b3TzlIg/Jt/l1wentJ5yfNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no; spf=pass smtp.mailfrom=itx.no; dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b=IqUC9U3b; arc=none smtp.client-ip=91.189.121.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b="IqUC9U3b"
From: Stian Halseth <stian@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1792326465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZIZSyB3o/yi3/I0EuVXatOlWLGrztINLGm2bYmFUjyM=;
	b=IqUC9U3b2xO1fhtYmFEisC35Wimp0V2he4OAU4hZuhjOHjCZ5Th/YIlzcF8Omz/cH+TshI
	I8n7bm+J3+vEJWn4uq93HfUcgDjDEq4HcSsfKzaas8vfALVhJOz4VUhVFVuaYUKtBmqaa+
	07I0dIQ7Rym31z5PK1RlMV1+/GsDFew=
To: Andreas Larsson <andreas@gaisler.com>,
	"David S . Miller" <davem@davemloft.net>
Cc: Kees Cook <kees@kernel.org>,
	Michel Lespinasse <michel@lespinasse.org>,
	Jan Engelhardt <jengelh@inai.de>,
	sparclinux@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Stian Halseth <stian@itx.no>
Subject: [PATCH v2 2/3] sparc64: Move the 32-bit PIE base below the legacy mmap base
Date: Sun, 18 Oct 2026 14:27:33 +0200
Message-ID: <20261018122734.2594904-3-stian@itx.no>
In-Reply-To: <20261018122734.2594904-1-stian@itx.no>
References: <20261018122734.2594904-1-stian@itx.no>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

COMPAT_ELF_ET_DYN_BASE is 0x70000000, the same address as
TASK_UNMAPPED_BASE for 32-bit tasks. With the legacy bottom-up layout
the mmap area therefore starts where a 32-bit PIE is loaded, and once
ARCH_HAS_ELF_RANDOMIZE is selected binfmt_elf also moves the brk of an
explicitly executed loader there, on top of the loader itself.

Move it to 1GB. x86, arm64 and powerpc use 4MB, but binfmt_elf now
rounds the load address down to the PIE's p_align, and from a 4MB base
an alignment of 8MB or more can round it down to 0. 1GB keeps every
alignment the old base allowed and leaves room for brk below the mmap
area.

Signed-off-by: Stian Halseth <stian@itx.no>
---
 arch/sparc/include/asm/elf_64.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/include/asm/elf_64.h b/arch/sparc/include/asm/elf_64.h
index 694ed081cf8d9..3f7050369f79d 100644
--- a/arch/sparc/include/asm/elf_64.h
+++ b/arch/sparc/include/asm/elf_64.h
@@ -190,7 +190,7 @@ typedef struct {
    that it will "exec", and that there is sufficient room for the brk.  */
 
 #define ELF_ET_DYN_BASE		0x0000010000000000UL
-#define COMPAT_ELF_ET_DYN_BASE	0x0000000070000000UL
+#define COMPAT_ELF_ET_DYN_BASE	0x0000000040000000UL
 
 extern unsigned long sparc64_elf_hwcap;
 #define ELF_HWCAP	sparc64_elf_hwcap
-- 
2.43.0

