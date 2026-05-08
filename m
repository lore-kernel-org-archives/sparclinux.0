Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BBE2F8EBB
	for <sparclinux@vger.kernel.org>; Fri,  8 May 2026 00:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778198936; cv=none; b=cIY/qfYjCHjEOxaylk37+ZzASx2xd73sResNwcOEUjerAnPpnBuQlVBFRIZyHtwMMIG0gVlDtLHRYa3luEOf7CLPFCEz2xgnD+dnzQoYPixrPhE+44G/5DY/RdScdYcHlQ/KN2y1Vh91W9KGQSIYzfOkD5FoMoD+TPDWk+Cz4I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778198936; c=relaxed/simple;
	bh=S8BZCxovO9b7N1yNjqQbGm2G8ks95+KJFQvDYlcZ6nI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ydd/4hWeT7dkvKW+Vk6ig4X7DAuszNAEU+pEWR/P5X9qyySbKbHXDRB64IhwNvU8FvXA+oTI7viN9/Zk+pgiXSixgOxfMBWBZ8XEgfBnlQnHJtSFqEh544Q8nGb7tYhXshqnJ903j58fCBLEWY4KJVtjD8LugNwq2HW3uI4/imU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s6IyKBER; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s6IyKBER"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8b3d6b215cfso23873446d6.3
        for <sparclinux@vger.kernel.org>; Thu, 07 May 2026 17:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778198934; x=1778803734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JiMsd4QNZdhgq2TeK7b6UP9/6dhJg0SmZyNtOPTS9/w=;
        b=s6IyKBERxtS40KGyUh1gjC+OPYX8gZShdafZ0cNxuDDsbr5qVPc0OklU7BqB+3r+Iz
         Dh/biwI1COxrPIAlDJ5XeGgqr1nV9yCeW8F2UAm0iNNdxMw35ejpGWXGd361TBnlE57P
         v9ZMiS31lbIyvqZCllGaUURdxhTU2SPgxErIX1XPoZMNA+CtR7YLkaA5CbdZxpSQXyOj
         AdCgXTBSzCRyXJ9RA67Jgn8y6uqrUPT7a5QKopCt3Cm86eojRQfwKkAeJVxbHH8zrkcg
         ajiUQRfs1gq5CmDfCKQDvBLArORIYQ9xFbv8WSd0OAITwca0hXmZ4cgE//kMO0IysOnv
         B86g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778198934; x=1778803734;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JiMsd4QNZdhgq2TeK7b6UP9/6dhJg0SmZyNtOPTS9/w=;
        b=oE/jy+Rr55cfNsDfLXz2Sd/ADPXV35s1WrzJ7mtXyzY1Rb86TEo5HFT801BojY7YDM
         /uj/ZEI6bw1uJbj2/AE+M2xNYMxLCAOKMI5JTmsO+UTySQofkEIB+Pr964UNI/qNoNs/
         AC+VIxMhamF8Hemz6irn+1YqHDTD5/U1XWYyDQvQ8tiW/H6czjoB5cId66Ej+XvZAaVz
         uYbHnSO+w8kyrIB5cPKxo9XZ/gChpE7luPtKfUOj7t7gYqSkvIY3AgjDVWLyzZLnk7gg
         0cpCj8YSjGZgV/hkxkW1P412KwPgWTq9Z+EfGpJWty5+wIB7K301i1lM8NgMXMFgs6mi
         fy1Q==
X-Gm-Message-State: AOJu0YzZwLl/0a/ADCTmNyuqmGqfum5lM7PW1pSD4PoIMan6XhWEdfwl
	j34R+jgJ9yF4NXdtoqb8ILz9xQeaPMyyumJGAyBmifZCxNVqbH54HAlwdX9RkmDX
X-Gm-Gg: Acq92OGmzEr/kWYDXnyViTzfUdgbYq7/TbWROjDGcJg2QmFs+7z7pI3+CzyD7XT9uTN
	7LD/vnQ4R5fIAagWlQuTsYr/6zqXWCuUVT44tXQ1QQL69D1tGyD7rNnpRvJ3bVm/hvgJ7hOy7U5
	RV0J7WITDkQuSZLiXmzuS9obUlIlZU5fSnZF1VeJ0APNs12/HzSvy0TYtcWgz84qxysgS3/lOeU
	pkiTv79UQ7Lw2XSWOVZ3Jcw/aKR4UdW8cW5WInX9w9syurnjdY/rr/u6a8qPzrNXNeKTlfxeKon
	K8KoDlP8Qo7whRD2f0aDG62x/ooqrR1ed41HRjBh7uBFyHBD9KZ2KK2FH33bvoV8Svx7O7AYYJ8
	5C6BIetAdJ5MT6MUHZxiBCvrjKqvZS0aMBEHOkCJTzEOhm6K/0KcgrfPgCZ8Mr0nGwyPv1kSCBB
	9mVIYdrnUnf6cGXMnItjHcBeVreQz31KbpidAE75sy+Ty0xWkWoJbQda9gQSPdRupVb3yAUeawu
	BgdGmznhn8iUBbtiK+2kp65dUby/jrkCRZB7mSA2JS/jw==
X-Received: by 2002:a05:6214:2424:b0:89c:e2b4:4ee9 with SMTP id 6a1803df08f44-8bc462f7c01mr163074446d6.46.1778198934362;
        Thu, 07 May 2026 17:08:54 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b53d450dcbsm222060286d6.45.2026.05.07.17.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 17:08:53 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: sparclinux@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org (open list),
	llvm@lists.linux.dev (open list:CLANG/LLVM BUILD SUPPORT:Keyword:\b(?i:clang|llvm)\b)
Subject: [PATCH] sparc: Disable compat support with LLD
Date: Thu,  7 May 2026 17:08:34 -0700
Message-ID: <20260508000834.834824-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An LLVM=1 sparc64 allmodconfig enables COMPAT and then tries to
build the 32-bit vDSO. That path cannot be linked with ld.lld:

  ld.lld: error: unknown emulation: elf32_sparc

ld.lld does not support the 32-bit SPARC ELF emulation used for
the compat vDSO, so keep COMPAT disabled when LLD is the linker.
This avoids selecting an unsupported build path while leaving the
existing GNU ld configuration unchanged.

Assisted-by: Codex:GPT-5.5
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 arch/sparc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index a6b787efc2c4..681ab2fd3d8a 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -474,6 +474,7 @@ endmenu
 config COMPAT
 	bool
 	depends on SPARC64
+	depends on !LD_IS_LLD
 	default y
 	select HAVE_UID16
 	select ARCH_WANT_OLD_COMPAT_IPC
-- 
2.54.0

