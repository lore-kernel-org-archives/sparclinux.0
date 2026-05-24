Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409E523AE9B;
	Sun, 24 May 2026 13:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779628116; cv=none; b=X4n7hoHkZHW28I7NmUrxw8D45ooQfmx+Vd460TwKwZh4OT9ZJtQzD9jpd7z5y9KObp+2jYen9j+SkC8y4xjj7vZcfUT4JHCr0Us7nTI9KO9Iq8MKwOKtaAxwTr17ifCXemcUF/T/0cfrAUFATwzNoVg6gGScof6r6Yta9yoBLbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779628116; c=relaxed/simple;
	bh=HnINGEElf+cFs/o6H3DbACfo9TvtEM6xeZhDBEb+zcc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=r7ougADtsI8D5i6TxdOk1sfOQD2rDFtp2IaTdcZ5Q5qXWcc5kviAWpmN5lOwqtyNjwAHpMHIUT1jbT2dS6qBUXjVV7LMZ7E2WH0ytQvrXFvnQJgaYHo1RyUL1uYWkpWCLA2Nc3Rj2Bnr+Kdi5/ZC9ICreK/igW9dcgLFEQRiBSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=Gincxl6Z; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="Gincxl6Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1779628113;
	bh=HnINGEElf+cFs/o6H3DbACfo9TvtEM6xeZhDBEb+zcc=;
	h=From:Date:Subject:To:Cc:From;
	b=Gincxl6ZuJAWWtk1Nkb+thI8IqnjCH0IbiayYpQN8RrwHVjv64Y9b8JDjeO+1QtfT
	 H8hvohsYeH/sh2unEFTywrgdY2ym6KvtV5dW6LoAtEyUyhOFXNjgfuzSfqcNMX+EJ4
	 h7hOyxFmZw5HOlf7B7RwmQDNp+nCtvDowBV8A320=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 24 May 2026 15:08:26 +0200
Subject: [PATCH] sparc: Avoid -Wunused-but-set-parameter in
 clear_user_page()
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260524-sparc-clear_user_page-v1-1-baa5b90e5d0d@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/y2N0QrCMAxFf2Xk2cKstVN/RWTEGjUisybrGIz9u
 1H3eODccydQEiaFQzWB0MDKr85gvaog3bG7keOLMfjax3rrN04zSnLpSShtsXGb0aQmhF2Me/S
 hiWDbLHTl8dc9nv6s5fyg1H9jiyH0LnbYL9o8fwBhyW04jgAAAA==
X-Change-ID: 20260523-sparc-clear_user_page-7448669a2476
To: "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, 
 Ankur Arora <ankur.a.arora@oracle.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779628112; l=1935;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=HnINGEElf+cFs/o6H3DbACfo9TvtEM6xeZhDBEb+zcc=;
 b=ODZNu9939fV4D0gBDrZYU1IOxlJYPrPKN5N+UI2e4Kugt90FbU4LqBsnPbhXfeyVEr9ZUs/l/
 KV+8CNiQKr0BRItnkVL2Z82MJ+xVr0z28T3gLqajf2zfk4RkPPkJiNs
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The loop in clear_user_pages() iterates over all pages and calls
clear_user_page() for each of them. During the loop "vaddr" is modified.
However on sparc clear_user() is a macro which does not use "vaddr".
The compiler sees a variable which is modified but never used and emits
a warning for that:

	include/linux/highmem.h: In function 'clear_user_pages':
	include/linux/highmem.h:234:63: warning: parameter 'vaddr' set but not used [-Wunused-but-set-parameter=]
		static inline void clear_user_pages(void *addr, unsigned long vaddr,

Other architectures use an inline function for clear_user_page() which
avoids the warning. This is not possible on sparc, as
sparc_flush_page_to_ram() is not yet declared where clear_user_page() is
defined. Including cacheflush_32.h will trigger recursive and lots of
other issues.

So hide the warning with a cast to (void) instead.

While we are here, do the same for copy_user_page().

Fixes: 62a9f5a85b98 ("mm: introduce clear_pages() and clear_user_pages()")
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 arch/sparc/include/asm/page_32.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/sparc/include/asm/page_32.h b/arch/sparc/include/asm/page_32.h
index c1bccbedf567..1972d62bdd29 100644
--- a/arch/sparc/include/asm/page_32.h
+++ b/arch/sparc/include/asm/page_32.h
@@ -20,10 +20,12 @@
 #define clear_user_page(addr, vaddr, page)	\
 	do { 	clear_page(addr);		\
 		sparc_flush_page_to_ram(page);	\
+		(void)vaddr;			\
 	} while (0)
 #define copy_user_page(to, from, vaddr, page)	\
 	do {	copy_page(to, from);		\
 		sparc_flush_page_to_ram(page);	\
+		(void)vaddr;			\
 	} while (0)
 
 /* The following structure is used to hold the physical

---
base-commit: d87895ce6e45997825cfe1b3565a1843e8ac8011
change-id: 20260523-sparc-clear_user_page-7448669a2476

Best regards,
--  
Thomas Weißschuh <linux@weissschuh.net>

