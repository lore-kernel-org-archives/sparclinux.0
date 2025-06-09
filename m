Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73269258CF5;
	Mon,  9 Jun 2025 13:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749477209; cv=none; b=gaP/xdsVKSoVc2aEUF4cWc8eVEJzJlDIhuW9ExcgKKU2mS/HvzfWHLYmD3va25CxGFFEa8+uERri8za/eZvD95Ms3oMZQ2V52xYHF2n/fUUWd+aH7TEkUTlFW6+iKQeRnU8DW/o1Wv4faiq7YjkLqBRljeAMa1opyUqvbmQ6HJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749477209; c=relaxed/simple;
	bh=9pd6b+hFtdXp1Xik64bJuC7kG63/UbMRrc+/YUilNC4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UHG1j4Mm11qnarObDuPJSYSJVrQ+px8ubBO2WAWIfY0lieotrmfQ9WrTGOj6jKL7U67fYOdZwrabv/KcxJwydt25elKFdo4Xer2WJlrzDHW7iWOYUoVMxU/RpBxqr4Gm4yvFDx1wMXhfg7VWc4cMvquXyvmZ751J2kPi4a1G7qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GJKAAvi0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GJKAAvi0"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 06EF9C4CEED;
	Mon,  9 Jun 2025 13:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749477209;
	bh=9pd6b+hFtdXp1Xik64bJuC7kG63/UbMRrc+/YUilNC4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=GJKAAvi0B7wDKDFdXgVgQclZskH6mFXHAVYwjmC6r/xNSJTsVt6Hw+t++rbLrBo5P
	 rxUq3Xnj5/ff3a4Mtx2Wt0XS82GBohs/3oPDd2Mj01xl/ox0TlyTMrdHuCWemmcXL+
	 +r7OlOs/2w/7Z2/d4BHcyIlSwWACbXEapUh/IKaCR8OkA6DXqDaNdeNAzj26+lW8Sa
	 I896t8gh4Bd5/vy5VZzpVeFKdbJb9EsQqDYI+DjvPZlWqE05MgIb7lV61ftcEfX8jO
	 lUj5eYacMriUZ6CX0P0nJ39TI3aj1LISfY1FXbcER5F4WBOYnSNCo/uaRYpjxcK7L+
	 ZhMyVwCC7QdxQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF2E3C61CE8;
	Mon,  9 Jun 2025 13:53:28 +0000 (UTC)
From: Koakuma via B4 Relay <devnull+koachan.protonmail.com@kernel.org>
Date: Mon, 09 Jun 2025 20:53:11 +0700
Subject: [PATCH 1/2] sparc/module: Add R_SPARC_UA64 relocation handling
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250609-b4-sparc-relocs-v1-1-aa52631735af@protonmail.com>
References: <20250609-b4-sparc-relocs-v1-0-aa52631735af@protonmail.com>
In-Reply-To: <20250609-b4-sparc-relocs-v1-0-aa52631735af@protonmail.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, Koakuma <koachan@protonmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749477207; l=1232;
 i=koachan@protonmail.com; s=20240620; h=from:subject:message-id;
 bh=zZw7JuY1ThhmEZ0ymDbJ7RVlj2O2wrZSNN0ELhatlwE=;
 b=pHlzGFwzlR+zbyyljMmoJCIWTRSZ1KYty5KLvm70wsrv8QhaNHteqxP6kWlGWfp2pGhYWm5bF
 YgNEPBUbhgXBD3RU8jEfojmrWWyKjf72glTLmx/evMhRBhF2V5aqBCf
X-Developer-Key: i=koachan@protonmail.com; a=ed25519;
 pk=UA59FS3yiAA1cnAAUZ1rehTmr6skh95PgkNRBLcoKCg=
X-Endpoint-Received: by B4 Relay for koachan@protonmail.com/20240620 with
 auth_id=174
X-Original-From: Koakuma <koachan@protonmail.com>
Reply-To: koachan@protonmail.com

From: Koakuma <koachan@protonmail.com>

This is needed so that the kernel can handle R_SPARC_UA64 relocations,
which is emitted by LLVM's IAS.

Signed-off-by: Koakuma <koachan@protonmail.com>
---
 arch/sparc/include/asm/elf_64.h | 1 +
 arch/sparc/kernel/module.c      | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/sparc/include/asm/elf_64.h b/arch/sparc/include/asm/elf_64.h
index 8fb09eec8c3e796a9a79aa0a7877842ceb7ea6d3..694ed081cf8d99adf70be25e5dc0e30a45f70398 100644
--- a/arch/sparc/include/asm/elf_64.h
+++ b/arch/sparc/include/asm/elf_64.h
@@ -58,6 +58,7 @@
 #define R_SPARC_7		43
 #define R_SPARC_5		44
 #define R_SPARC_6		45
+#define R_SPARC_UA64		54
 
 /* Bits present in AT_HWCAP, primarily for Sparc32.  */
 #define HWCAP_SPARC_FLUSH       0x00000001
diff --git a/arch/sparc/kernel/module.c b/arch/sparc/kernel/module.c
index b8c51cc23d96944037494f13d2d65a43bb187729..6e3d4dde4f9ab33040b300c40d5fd5d0584e166d 100644
--- a/arch/sparc/kernel/module.c
+++ b/arch/sparc/kernel/module.c
@@ -87,6 +87,7 @@ int apply_relocate_add(Elf_Shdr *sechdrs,
 			break;
 #ifdef CONFIG_SPARC64
 		case R_SPARC_64:
+		case R_SPARC_UA64:
 			location[0] = v >> 56;
 			location[1] = v >> 48;
 			location[2] = v >> 40;

-- 
2.49.0


