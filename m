Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E502D593A;
	Wed,  1 Oct 2025 19:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759347618; cv=none; b=et+GteJb7k0JTlBwbRX1JN6YpyEgejlmFzt/fTjstDfcp7jt4Os+qePXIZ+95s2X4T0kQszGGLkP8/umyNJgLpeBT+bVLB3cubvNE+2tr55vPHLkPasPbMkSR/aYvpmGfASeuBjdBhNK8AKMnXfa8xqpFInYpFHHEex/u+zhXZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759347618; c=relaxed/simple;
	bh=l/3Qst18TDXXkeTBwF98n1m4cSpKwYmQ0mRem5yrcug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J8ZxMBeUzvCEOL9XCmoFDJqDsidFgvIIj51rjqjfdGPzN3l2UWETAzk6D9VTtau788KWfNqhDH4my/sBtsnBFnUehRRrAr3ejrOsm5ucIK/kjinhvzzP5zXyLe9i5BR+HnlC4yKAEIBnOBUjwYRZRMtseS7mcJTYMhLk8lvhubw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (2.8.3.0.0.0.0.0.0.0.0.0.0.0.0.0.a.5.c.d.c.d.9.1.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:19dc:dc5a::382])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sam@gentoo.org)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 9E77E340E1F;
	Wed, 01 Oct 2025 19:40:15 +0000 (UTC)
From: Sam James <sam@gentoo.org>
To: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Cc: Sam James <sam@gentoo.org>,
	Stian Halseth <stian@itx.no>,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] alpha: don't reference obsolete termio struct for TC* constants
Date: Wed,  1 Oct 2025 20:39:52 +0100
Message-ID: <0786701193a91a1dde55316304002ed8478cbaf7.1759347592.git.sam@gentoo.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <d55e5e19c4d30ab1602718b1263d051413edf562.1759347592.git.sam@gentoo.org>
References: <d55e5e19c4d30ab1602718b1263d051413edf562.1759347592.git.sam@gentoo.org>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similar in nature to ab107276607af90b13a5994997e19b7b9731e251. glibc-2.42
drops the legacy termio struct, but the ioctls.h header still defines some
TC* constants in terms of termio (via sizeof). Hardcode the values instead.

This fixes building Python for example, which falls over like:
  ./Modules/termios.c:1119:16: error: invalid application of 'sizeof' to incomplete type 'struct termio'

Link: https://bugs.gentoo.org/961769
Link: https://bugs.gentoo.org/962600
Co-authored-by: Stian Halseth <stian@itx.no>
Signed-off-by: Sam James <sam@gentoo.org>
---
 arch/sparc/include/uapi/asm/ioctls.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/include/uapi/asm/ioctls.h b/arch/sparc/include/uapi/asm/ioctls.h
index 7fd2f5873c9e7..b493dea7ca377 100644
--- a/arch/sparc/include/uapi/asm/ioctls.h
+++ b/arch/sparc/include/uapi/asm/ioctls.h
@@ -5,10 +5,10 @@
 #include <asm/ioctl.h>
 
 /* Big T */
-#define TCGETA		_IOR('T', 1, struct termio)
-#define TCSETA		_IOW('T', 2, struct termio)
-#define TCSETAW		_IOW('T', 3, struct termio)
-#define TCSETAF		_IOW('T', 4, struct termio)
+#define TCGETA          0x5405
+#define TCSETA          0x5406
+#define TCSETAW         0x5407
+#define TCSETAF         0x5408
 #define TCSBRK		_IO('T', 5)
 #define TCXONC		_IO('T', 6)
 #define TCFLSH		_IO('T', 7)
-- 
2.51.0

