Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C9D1E9905;
	Wed,  1 Oct 2025 23:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759359671; cv=none; b=HmfikyTNdEffNMn+HsusZpdJnKYpM7G+GhKkmu3yxDtF7AnPEtz2Io5RISwMxAtcqeeY9wkFZ81Z6n4aZb0WFRl4ae5JXT9C+WU5s8hBT6xtk8Zoi8AwUhht77MO9r2PvtDB/kLGqU8+/GZKHJ+N/AywEJV0jCZ0B+JCyIskuV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759359671; c=relaxed/simple;
	bh=nt1HZKeqL4tkgfZAlFPhXU8sfBhzuvaYIJAss/L0stY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XaHBeeFZDOesU0hNWyO28DTo3GmCqmYcBJQxgSCn8CsrhRz+AU2Gd1lPDH+/KARdA78wcfVNBqAEx7ofY0pdf/Q3o3FVJsB1lV0SLi1r/94RouFmNLXZhsGhgkzNOAVfqUXGsapFB4LvLDuBmijg1hzG5/bg46LctAE0HhGYKcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (2.8.3.0.0.0.0.0.0.0.0.0.0.0.0.0.a.5.c.d.c.d.9.1.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:19dc:dc5a::382])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sam@gentoo.org)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 265D5340E49;
	Wed, 01 Oct 2025 23:01:08 +0000 (UTC)
From: Sam James <sam@gentoo.org>
To: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Cc: Sam James <sam@gentoo.org>,
	Stian Halseth <stian@itx.no>,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] sparc: don't reference obsolete termio struct for TC* constants
Date: Thu,  2 Oct 2025 00:00:33 +0100
Message-ID: <e11ecaf723594bf01c66fc5c80c25bda0621f34f.1759359616.git.sam@gentoo.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <99f1a93cf8cd4f0ece8611be2860677084663aac.1759359610.git.sam@gentoo.org>
References: <99f1a93cf8cd4f0ece8611be2860677084663aac.1759359610.git.sam@gentoo.org>
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
v3: Fix constants.
v2: Fix title.

 arch/sparc/include/uapi/asm/ioctls.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/include/uapi/asm/ioctls.h b/arch/sparc/include/uapi/asm/ioctls.h
index 7fd2f5873c9e7..f26befbf690fb 100644
--- a/arch/sparc/include/uapi/asm/ioctls.h
+++ b/arch/sparc/include/uapi/asm/ioctls.h
@@ -5,10 +5,10 @@
 #include <asm/ioctl.h>
 
 /* Big T */
-#define TCGETA		_IOR('T', 1, struct termio)
-#define TCSETA		_IOW('T', 2, struct termio)
-#define TCSETAW		_IOW('T', 3, struct termio)
-#define TCSETAF		_IOW('T', 4, struct termio)
+#define TCGETA          0x40125401
+#define TCSETA          0x80125402
+#define TCSETAW         0x80125403
+#define TCSETAF         0x80125404
 #define TCSBRK		_IO('T', 5)
 #define TCXONC		_IO('T', 6)
 #define TCFLSH		_IO('T', 7)
-- 
2.51.0

