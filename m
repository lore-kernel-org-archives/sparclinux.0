Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7DD230BD9;
	Wed,  4 Feb 2026 13:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770212479; cv=none; b=cxUW/8nXB7tbm4dQwZ7PKYXPd3s8WUXnufaHs1EhMNdt0wa/PJH5YuZiAaajT0Uw4bluHjiINUNbOYCigZOOgdbx97r+i4+kEi1ll9h6nfZk+QSCrqPd9OV9Anqtu778O3hRVqCC5r3gwqb9ABbIsxhr5fXq3tx6d3LmhxBOgx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770212479; c=relaxed/simple;
	bh=mLkazTaO2g4/WQcJMHjdJ2Xim907QZFyaEWs3sJmzak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AE7sPNLczVhoz0+T92e9AXmwmB5Jh6Fx209wi6SF60ui1hntF+eEQ6+Q/pez/8u6SvlWuZnzZ4NRPIXwOTxC+g2DOQuae7CivVyxoYRZSjooMl4t0g2LGeXuGk7f5bS3qyr1mef0JW/1g+hoWsOseOlQBCYFQvOUC7+gcPobAJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (2.8.3.0.0.0.0.0.0.0.0.0.0.0.0.0.a.5.c.d.c.d.9.1.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:19dc:dc5a::382])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sam@gentoo.org)
	by smtp.gentoo.org (Postfix) with ESMTPSA id AEC49342232;
	Wed, 04 Feb 2026 13:41:16 +0000 (UTC)
From: Sam James <sam@gentoo.org>
To: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Cc: glaubitz@physik.fu-berlin.de,
	Sam James <sam@gentoo.org>,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] sparc: don't reference obsolete termio struct for TC* constants
Date: Wed,  4 Feb 2026 13:40:29 +0000
Message-ID: <db618c0a5a47e512fafc06304042cdda147c5088.1770212429.git.sam@gentoo.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <123e6a3a-6360-45cb-8eef-23b1660b9253@gaisler.com>
References: <123e6a3a-6360-45cb-8eef-23b1660b9253@gaisler.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similar in nature to commit ab107276607a ("powerpc: Fix struct termio related ioctl macros").

glibc-2.42 drops the legacy termio struct, but the ioctls.h header still
defines some TC* constants in terms of termio (via sizeof). Hardcode the
values instead.

This fixes building Python for example, which falls over like:
  ./Modules/termios.c:1119:16: error: invalid application of 'sizeof' to incomplete type 'struct termio'

Link: https://bugs.gentoo.org/961769
Link: https://bugs.gentoo.org/962600
Signed-off-by: Sam James <sam@gentoo.org>
---
v4: Tweak commit message for commit ref and add comments for old definitions.
v3: Fix constants.
v2: Fix title.

 arch/sparc/include/uapi/asm/ioctls.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/include/uapi/asm/ioctls.h b/arch/sparc/include/uapi/asm/ioctls.h
index 7fd2f5873c9e..a8bbdf9877a4 100644
--- a/arch/sparc/include/uapi/asm/ioctls.h
+++ b/arch/sparc/include/uapi/asm/ioctls.h
@@ -5,10 +5,10 @@
 #include <asm/ioctl.h>
 
 /* Big T */
-#define TCGETA		_IOR('T', 1, struct termio)
-#define TCSETA		_IOW('T', 2, struct termio)
-#define TCSETAW		_IOW('T', 3, struct termio)
-#define TCSETAF		_IOW('T', 4, struct termio)
+#define TCGETA          0x40125401 /* _IOR('T', 1, struct termio) */
+#define TCSETA          0x80125402 /* _IOW('T', 2, struct termio) */
+#define TCSETAW         0x80125403 /* _IOW('T', 3, struct termio) */
+#define TCSETAF         0x80125404 /* _IOW('T', 4, struct termio) */
 #define TCSBRK		_IO('T', 5)
 #define TCXONC		_IO('T', 6)
 #define TCFLSH		_IO('T', 7)
-- 
2.53.0

