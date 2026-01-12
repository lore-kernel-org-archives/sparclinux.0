Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6A0311958
	for <sparclinux@vger.kernel.org>; Mon, 12 Jan 2026 06:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768199853; cv=none; b=Uv8hcP13twdp/eQcq2S6WDS26vjCGfOEN7UzDpc+LcPCwxw/3O4jtdXfFds/txGG8QT/WgMb7tu/9wmPRHYNBTDlKiw7CvGgzGxAJUe/XkS4bMwZEwDkIiNJq2ZU1SrnYvP6eXK5xVQPSlvn6+camOnxaMZWmbNZQVQVPUQt0kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768199853; c=relaxed/simple;
	bh=DeK7rvnLuYPCFsCfcbVdhTe0261SXK4vr8cFvVT46xw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YNQZ4LHEnwq3YN7QPnRRHFJZkDSf/Bv7uaS5F9gFWAw3MJfjB/wKLU3vlvS2P3LAxEf96WsvJJVSNIsM9BTaJSjrTJ+TtXxqyadT47uxreI23FxIBYhJqxZvLdIa4wsh5bCG2MpMDvvqlmVdIovyLmQfmogZOp26LjBpI2KQz1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U4mYBod/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U4mYBod/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C2BBC116D0;
	Mon, 12 Jan 2026 06:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768199852;
	bh=DeK7rvnLuYPCFsCfcbVdhTe0261SXK4vr8cFvVT46xw=;
	h=From:To:Cc:Subject:Date:From;
	b=U4mYBod/PReFAfH+pY3Lqfj6vUKdAaD1eHQUBwoXNF3RT0pX7QmLHABvriWItW4mQ
	 fsjejCdvG6DI64cEGZkI/KJusx+02/lG/Uo9HsLLW7NAL4dc1dJnnf+nzEWoqlqjjh
	 5pvbzl11lySpMzbgLkFUdcGjbWFbM0JMeddSqDbzz5asuP2PEm9pgmbPxPrzyUcG4x
	 VIv72Vbh4ZIDnMr77JrIK8OZe/IkI6P2YuymfstgjGj8P06kq0IgTq7Wh/fCZKWJaM
	 u7XO6Kyb9m4qUYtmQqs/rZgDzCntSE0bSmQngDHJ0AOwWmSTuZGQwfnRYOqLpvQLI6
	 vnTs2edpZlHBg==
From: alexs@kernel.org
To: 
Cc: Alex Shi <alexs@kernel.org>,
	kernel test robot <lkp@intel.com>,
	sparclinux@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>
Subject: [PATCH] arch/sparc32: remove unused variable strtab
Date: Mon, 12 Jan 2026 14:37:12 +0800
Message-ID: <20260112063715.179733-1-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alex Shi <alexs@kernel.org>

The commit 1b35a57b1c178 ("sparc32: Kill off software 32-bit multiply/divide
 routines") removed the last usage of strtab in funtion module_frob_arch_sections
Therefore, it can be removed now.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Alex Shi <alexs@kernel.org>
Cc: sparclinux@vger.kernel.org
Cc: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/module.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/sparc/kernel/module.c b/arch/sparc/kernel/module.c
index 49740450a685..2a8770369beb 100644
--- a/arch/sparc/kernel/module.c
+++ b/arch/sparc/kernel/module.c
@@ -29,7 +29,6 @@ int module_frob_arch_sections(Elf_Ehdr *hdr,
 {
 	unsigned int symidx;
 	Elf_Sym *sym;
-	char *strtab;
 	int i;
 
 	for (symidx = 0; sechdrs[symidx].sh_type != SHT_SYMTAB; symidx++) {
@@ -39,7 +38,6 @@ int module_frob_arch_sections(Elf_Ehdr *hdr,
 		}
 	}
 	sym = (Elf_Sym *)sechdrs[symidx].sh_addr;
-	strtab = (char *)sechdrs[sechdrs[symidx].sh_link].sh_addr;
 
 	for (i = 1; i < sechdrs[symidx].sh_size / sizeof(Elf_Sym); i++) {
 		if (sym[i].st_shndx == SHN_UNDEF) {
-- 
2.43.0

