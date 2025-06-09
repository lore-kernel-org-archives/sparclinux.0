Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732031D6187;
	Mon,  9 Jun 2025 13:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749477209; cv=none; b=forOdMAunzhF/Zq89Zc8pTRPbUnhz/v/H/FgEhkeiiT2YCzkaWz5QTT34k/pzB9E8z1hgSDQoIs1V+CN9coEZrBCIjI5M8MQxegdwcOwnvN2A89onTG+7TwushIo06qK8/jLSRXdCzPNtCHZUfv915vm/C1h60DoekRNR12cc0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749477209; c=relaxed/simple;
	bh=T3sqKukzXDr9hOyP9SoVz9qsR+9q2tdxwgiv0BMU1pk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RI0TWHmOOM+TUEIAa/EDW51f9KAgCOG69vs4qorgihpf40PgHeHwZSjEAW729YjlKtDV3jJWQoTByAYGfFgCkMg01GEBfUwh2C7NqUIyHlMgEKLVWXf+7F8iAdOxH767nPIMlOwBipXVoRDb9lCvQzVY7qGDgQmsXk1sCxHL80k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cVIPHuYT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cVIPHuYT"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1C750C4CEF2;
	Mon,  9 Jun 2025 13:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749477209;
	bh=T3sqKukzXDr9hOyP9SoVz9qsR+9q2tdxwgiv0BMU1pk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=cVIPHuYTIgbscIhYiAzeDYrgKtbbRexlf5FArOd1ipzLppYy35e8mF5vX8tCUJceI
	 5lDzcg84Q9l5gIEqjfcM5/vgfeDCS17oIZtcFtxO5wjn69rSytq+fqFr0kSx+wBYQ3
	 8JRqV1jprj6PWkOaUeL4AGaKQ83TyfHgfIbdrhIHjSvmLImXmeK6U2Eu5/xe6zITf9
	 wKwTIqk77dypjAWl7nkets0l3fD6yziTaLrpfAXqg9eWKXqJ1DlVkFLlKEN28lU2hT
	 Z0wtXDVHdO04mW5cHW9JMSahx8AgCzOkcLCKvb+OOFzgJfUdEYent6Bhes9IN+TO7V
	 TvqR3P2UEuqFg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0917FC71131;
	Mon,  9 Jun 2025 13:53:29 +0000 (UTC)
From: Koakuma via B4 Relay <devnull+koachan.protonmail.com@kernel.org>
Date: Mon, 09 Jun 2025 20:53:12 +0700
Subject: [PATCH 2/2] sparc/module: Make it clear that relocation numbers
 are shown in hex
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250609-b4-sparc-relocs-v1-2-aa52631735af@protonmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749477207; l=784;
 i=koachan@protonmail.com; s=20240620; h=from:subject:message-id;
 bh=7SKx1LyVSxb9rnPPXP8b4RhjM/ieyIDEQGTuXHHGuv0=;
 b=7wx6sVYWxVRMZKF1bCXsTh6PwiVpWEyHcpD7XVsKksAbsttXnXku6ruD/sZvYyV3JbeaW8z2W
 nVXopwnT6LFCTJSTfvAdw+TKa0kXc+dB2AxFV+Y5Uj9WJPMrNaP5xNS
X-Developer-Key: i=koachan@protonmail.com; a=ed25519;
 pk=UA59FS3yiAA1cnAAUZ1rehTmr6skh95PgkNRBLcoKCg=
X-Endpoint-Received: by B4 Relay for koachan@protonmail.com/20240620 with
 auth_id=174
X-Original-From: Koakuma <koachan@protonmail.com>
Reply-To: koachan@protonmail.com

From: Koakuma <koachan@protonmail.com>

This is to ease debugging by removing the ambiguity of the shown
number base.

Signed-off-by: Koakuma <koachan@protonmail.com>
---
 arch/sparc/kernel/module.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/kernel/module.c b/arch/sparc/kernel/module.c
index 6e3d4dde4f9ab33040b300c40d5fd5d0584e166d..49740450a6859fda566459ee4679869f9854b760 100644
--- a/arch/sparc/kernel/module.c
+++ b/arch/sparc/kernel/module.c
@@ -142,7 +142,7 @@ int apply_relocate_add(Elf_Shdr *sechdrs,
 			break;
 
 		default:
-			printk(KERN_ERR "module %s: Unknown relocation: %x\n",
+			printk(KERN_ERR "module %s: Unknown relocation: 0x%x\n",
 			       me->name,
 			       (int) (ELF_R_TYPE(rel[i].r_info) & 0xff));
 			return -ENOEXEC;

-- 
2.49.0


