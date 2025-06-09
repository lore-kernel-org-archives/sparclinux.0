Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731A712CDAE;
	Mon,  9 Jun 2025 13:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749477209; cv=none; b=QoUp6RljnNaeQZzx6ZLCMhCXRCGRAuvxyE81HtlPdbpH2uWi+bG2AbNsXIxrCu37xSiyW8hL4yYEo36x2tBPs9vkZsi1hR977I03T36mvxdvnmXVuLgh/rxfCeWeTgr0K1eTDdcHti2Rx3fGsLqU2q9A4/oENJQITU2s+nuCHXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749477209; c=relaxed/simple;
	bh=V+mythbreill/uQ07oLyN3AK3aHIgulv4FDYTI1Uhu0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=S/J0fBa1ioErsSrsKiTHSMiNNjXzi7qdkjkX6he46aDg+6Voe0zdbB0HpkHjgzA2I2ZClD14RADVtUrUtzR5zPijfD/8N3Z4/ihVm1Jc13EGEbntJBmL9ikOxbs1TAcf0REynCGAcxQ0GCjHu8xejqTZgarbdAM0anrDeVU2EJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J5eKYb80; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J5eKYb80"
Received: by smtp.kernel.org (Postfix) with ESMTPS id EC038C4CEEB;
	Mon,  9 Jun 2025 13:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749477209;
	bh=V+mythbreill/uQ07oLyN3AK3aHIgulv4FDYTI1Uhu0=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=J5eKYb80gQiCBy4nO60/Sr7CO54fAZTk8MzQzfip5fr54nmDMMR2ygpczVRo82ehX
	 gwruTPuor7Jqr2cj3hrr7Tsi6mQ2hiq9pFR2UBo7qTRpYSktmyDsKSQXqYzGIXOjnr
	 AF1McJ2R1+ujKaz11PjpXxg6XQK7P+tP81lye3XVDvPoJF28YnKhiY2hh8hH0yjCwi
	 jl8Fjp1UmDQyQLUgofEyEhbDF6Y0P3vQnTcD+vGMQX0PgaupRPFgDk2DMYI92+kYgK
	 jD+hdpqfGYvzUma8VlTIYfsweBrdrhtghGZGAkdBD410vO1dmlmVx/SO7T2fmG6Ki9
	 lgMLc3/E8oN5Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA80C5B552;
	Mon,  9 Jun 2025 13:53:28 +0000 (UTC)
From: Koakuma via B4 Relay <devnull+koachan.protonmail.com@kernel.org>
Subject: [PATCH 0/2] sparc/module: R_SPARC_UA64 handling to help with LLVM
 IAS enablement
Date: Mon, 09 Jun 2025 20:53:10 +0700
Message-Id: <20250609-b4-sparc-relocs-v1-0-aa52631735af@protonmail.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEbnRmgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDYwNT3SQT3eKCxKJk3aLUnPzkYl0z08Rkc/PkRAtLIwMloK6CotS0zAq
 widGxtbUA0+z9X2EAAAA=
X-Change-ID: 20250305-b4-sparc-relocs-65ac77ca8920
To: "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, Koakuma <koachan@protonmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749477207; l=971;
 i=koachan@protonmail.com; s=20240620; h=from:subject:message-id;
 bh=V+mythbreill/uQ07oLyN3AK3aHIgulv4FDYTI1Uhu0=;
 b=DTvScNJYKi4QCDIPcpVUpBhr7cM6oJp4mKjnD++hSRipZtVeyLWgyFUFxyKQf9lO9wr1ZXLX/
 If7HLxjnZ17CZkF0EP2ln29vZ5SNMbXjYH4DjbHtv1Qe5VpcxAzLRhq
X-Developer-Key: i=koachan@protonmail.com; a=ed25519;
 pk=UA59FS3yiAA1cnAAUZ1rehTmr6skh95PgkNRBLcoKCg=
X-Endpoint-Received: by B4 Relay for koachan@protonmail.com/20240620 with
 auth_id=174
X-Original-From: Koakuma <koachan@protonmail.com>
Reply-To: koachan@protonmail.com

Hello~

This series lets the module loader handle R_SPARC_UA64, which is emitted
by LLVM's IAS in certain conditions. Additionally, I put on a small change
to the error log to make it clearer that the printed relocation number
is in hex.

The intention is to get both the kernel and LLVM in a state where
doing a clang+IAS build is possible.

As with before, on the LLVM side the project is tracked here:
https://github.com/llvm/llvm-project/issues/40792

Signed-off-by: Koakuma <koachan@protonmail.com>
---
Koakuma (2):
      sparc/module: Add R_SPARC_UA64 relocation handling
      sparc/module: Make it clear that relocation numbers are shown in hex

 arch/sparc/include/asm/elf_64.h | 1 +
 arch/sparc/kernel/module.c      | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)
---
base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
change-id: 20250305-b4-sparc-relocs-65ac77ca8920

Best regards,
-- 
Koakuma <koachan@protonmail.com>


