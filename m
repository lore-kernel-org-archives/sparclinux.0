Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=85.215.255.23
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793285617;
	b=TN73FLAonXc7A+SuBRQTgZ9uEbK4MZSEZRgJrTk1QwKdUoHxRYOBXShaFzb4nluuVwE+
	 XlT/GTIzZPGbarNQZ1W/jMF48UZN4Sr3QIze4Dvr0FZOqpPqNQkTuP9PLZO3rjAgEgsCX
	 4IG1gmLiPI3YUq33eAO38s4CdV1A/Nefk6F1wEXmUUtKGcGEuCe+zsq98M+v8n85L+8XM
	 xe+If18KNmV99av/0zyqJu1etIBlghn2IaW6sZ48mgZyBlq6MI/FBc5WUIl69NX0TU41N
	 NLBsRyoMv+R0IEh/xnYHiYMgaAEnHaS9LqinYFo4LWWrlk/Fy6Uw7BmHDHYYqkdnEug==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793285617;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	bh=e6a3ejsaJHMW+KDy85U2/gImbBTkpAO1PWITLaqzfdo=;
	b=4jz3RBaWH/SmCxVVbq8PTWVEWZBcv6nIRpVS9eO8RfZQTAA1QP94vM45Dtqq2nf4EX6U
	 HgF3fyP0D2DLAuwIfGRHgNY3sqsWgbBLNa736nkT+Df2h6EC1ElhbMX1qE/JbgaE4Ezc/
	 7yqgVwIyKBZ8N6DJ59lyvvKXMzA9WYfpwS0t+X3zn/lTIrclHBhUZ0NJYi+VJQGoAsDhV
	 GmvHza5g9BrCtHo66FU4NQz/7Ssb3NTraQRSGuFfrRr3dro9JdkACTrVS7r73q1LNk1bf
	 RhxMgbnBAPv1NGZzpOd0CiQDrpPRszh0nmgNbG9JSiatJmPRab6oZlvcpBhTgKJNG7Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outer-limits.org;
	spf=pass smtp.mailfrom=outer-limits.org;
	dkim=pass header.d=outer-limits.org header.i=@outer-limits.org header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=AUYIcL4r;
	dkim=pass header.d=outer-limits.org header.i=@outer-limits.org header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=XZFNg72m;
	arc=fail smtp.remote-ip=85.215.255.23
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.23])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FFD606A320;
	Thu, 29 Oct 2026 14:53:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90FFD606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=outer-limits.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outer-limits.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outer-limits.org header.i=@outer-limits.org header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=AUYIcL4r;
	dkim=pass header.d=outer-limits.org header.i=@outer-limits.org header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=XZFNg72m
ARC-Seal: i=1; a=rsa-sha256; t=1793285607; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=SP8bNBwIw077fjMhz8/z0R56Aqlzq5YJNgTXXUhVNGjNwwnANgrK05627GCcv8BsXd
    1R2M+AjoWcKJ01efl97rSpUwwfXp7eKYYEv8IcrJ96ZGMWkiWJWn+Q1k1Ee4488eT3Ke
    4eUrvTB5bVMihWZRoaQI7TtYfxsJJwrdEL6pWWhKDgV9bI9EafnbwUe7t791OOHrjhkq
    dZOhi4ZETkCrcEyqKOdQSUWUAknVXwOLLNO8JaKOBAjkwnSxUS1UeKGhQL58x37/VCir
    ktu2gbeyt8yzSV+w2jJd22gFBcLX0NSN8SJBSDK914uKvmnLaIs5VzJDQdgtFFELDfX4
    sdwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1793285607;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=e6a3ejsaJHMW+KDy85U2/gImbBTkpAO1PWITLaqzfdo=;
    b=bxJ10KomDUxj50H7guAyXIhm/Rl09UOLvmmv9IWKFdpP0UFiquAQobXG7zQek3jHut
    I0IC+2M3ADdkNK5aPx7DkYcViu3fUA7MqgY/5h+0VhJQdFjlzbLIIkXqQtPKdN8HfuCg
    PKuOeGzVqz850nuCkY6zGaO+TPFQQn74JJTVwO4t+ySjSMpm+Z4V/hHix6yTCwrFBRCX
    vJNWGNJVnpUkb5R4GvqCWpqg6d8c1OOUH9tG/2fc09vtULOBOP61v6lJQv95bVLKehJi
    Q0W4++pns+Z6EKtJ39sNov+mW9yiL4ebIMr7lZ0v3nkkF8TUBgyqZmhHHVicRAug46AV
    WW6g==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1793285607;
    s=strato-dkim-0002; d=outer-limits.org;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=e6a3ejsaJHMW+KDy85U2/gImbBTkpAO1PWITLaqzfdo=;
    b=AUYIcL4rd+yQm/x+F5Xaua13c58mBl/UQiuS8TECZvEkMvlCGgf7Q1I3fLHVe1A+Kp
    njrJTje+OuTUiMRpJxoaYiQUgLhHQ9XwQcidvqUG6DsQnk7YZ5I0qo8qI1m46R/iB9Nf
    exnJ7Pmmv6x/XPJN2AoeOZIw2A10HN5xDBFf8Pc39sy4dxHNROkv1hxbpxqa7b95KWYh
    v0/HGz1rhvUjLod77UkE4bhlDNqXmCtqcRu/dAhDAGgvXQLYctXfZkf8pLrErfHXF98M
    0F3+UwxbeTgpzUr6dRJ0rgIp4QmdwJy6OWRGRlQx76knWNgKEYyIRLyVd+b50w+OEnfq
    6Svw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1793285607;
    s=strato-dkim-0003; d=outer-limits.org;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=e6a3ejsaJHMW+KDy85U2/gImbBTkpAO1PWITLaqzfdo=;
    b=XZFNg72mpMi/ev+I1NyCKE6jTyxvrpN/OkbGgE9Jyv3KFujWK6tbSSBtetDDDk9R+r
    IQAhTpFtBd3shkW9H0Dw==
X-RZG-AUTH: ":JnkIfEGmW/AMJS6HttH4FbRVwc4dHlPLCp4e/IoHo8zEMMHAgwTfqBFXdk1Z5IDmIqDY7xpnOs6mGD64frXxHtrE3e66udIGwZnWwLgga9o="
Received: from julian.home
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id J82cde29TErQz6J
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 29 Oct 2026 15:53:26 +0100 (CET)
From: Julian Vetter <julian@outer-limits.org>
To: "David S . Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Julian Vetter <julian@outer-limits.org>
Subject: [PATCH] sparc: Remove IO memcpy and memset from sparc code
Date: Thu, 29 Oct 2026 15:53:09 +0100
Message-ID: <20261029145309.132218-1-julian@outer-limits.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Post: <mailto:sparclinux@vger.kernel.org>
List-Help: <mailto:sparclinux+help@vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:sparclinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

Remove the IO memcpy and memset from sparc specific code and fall back
to the implementations from lib/iomem_copy.c. They use word accesses if
the buffers are aligned and only fall back to byte accesses for
potentially unaligned parts of a buffer, while the sparc versions always
use byte-wise readb()/writeb() accesses. Other architectures, such as
arm64, csky, loongarch and parisc, have already been converted to the
generic implementation.

This does not drop any memory barriers. The sparc versions don't use
mb(), and the rmb()/wmb() implied by readb()/writeb() on sparc32 and
sparc64 are only compiler barriers.

Signed-off-by: Julian Vetter <julian@outer-limits.org>
---
 arch/sparc/include/asm/io_32.h | 40 ----------------------------------
 arch/sparc/include/asm/io_64.h | 38 --------------------------------
 2 files changed, 78 deletions(-)

diff --git a/arch/sparc/include/asm/io_32.h b/arch/sparc/include/asm/io_32.h
index 549f0a72280d..5df651ee5935 100644
--- a/arch/sparc/include/asm/io_32.h
+++ b/arch/sparc/include/asm/io_32.h
@@ -7,10 +7,6 @@
 
 #define IO_SPACE_LIMIT 0xffffffff
 
-#define memset_io(d,c,sz)     _memset_io(d,c,sz)
-#define memcpy_fromio(d,s,sz) _memcpy_fromio(d,s,sz)
-#define memcpy_toio(d,s,sz)   _memcpy_toio(d,s,sz)
-
 /*
  * Bus number may be embedded in the higher bits of the physical address.
  * This is why we have no bus number argument to ioremap().
@@ -20,42 +16,6 @@ void iounmap(volatile void __iomem *addr);
 
 #include <asm-generic/io.h>
 
-static inline void _memset_io(volatile void __iomem *dst,
-                              int c, __kernel_size_t n)
-{
-	volatile void __iomem *d = dst;
-
-	while (n--) {
-		writeb(c, d);
-		d++;
-	}
-}
-
-static inline void _memcpy_fromio(void *dst, const volatile void __iomem *src,
-                                  __kernel_size_t n)
-{
-	char *d = dst;
-
-	while (n--) {
-		char tmp = readb(src);
-		*d++ = tmp;
-		src++;
-	}
-}
-
-static inline void _memcpy_toio(volatile void __iomem *dst, const void *src,
-                                __kernel_size_t n)
-{
-	const char *s = src;
-	volatile void __iomem *d = dst;
-
-	while (n--) {
-		char tmp = *s++;
-		writeb(tmp, d);
-		d++;
-	}
-}
-
 /*
  * SBus accessors.
  *
diff --git a/arch/sparc/include/asm/io_64.h b/arch/sparc/include/asm/io_64.h
index d8ed296624af..83fb1cf90601 100644
--- a/arch/sparc/include/asm/io_64.h
+++ b/arch/sparc/include/asm/io_64.h
@@ -349,17 +349,6 @@ static inline void sbus_memset_io(volatile void __iomem *dst, int c, __kernel_si
 	}
 }
 
-static inline void memset_io(volatile void __iomem *dst, int c, __kernel_size_t n)
-{
-	volatile void __iomem *d = dst;
-
-	while (n--) {
-		writeb(c, d);
-		d++;
-	}
-}
-#define memset_io memset_io
-
 static inline void sbus_memcpy_fromio(void *dst, const volatile void __iomem *src,
 				      __kernel_size_t n)
 {
@@ -373,19 +362,6 @@ static inline void sbus_memcpy_fromio(void *dst, const volatile void __iomem *sr
 }
 
 
-static inline void memcpy_fromio(void *dst, const volatile void __iomem *src,
-				 __kernel_size_t n)
-{
-	char *d = dst;
-
-	while (n--) {
-		char tmp = readb(src);
-		*d++ = tmp;
-		src++;
-	}
-}
-#define memcpy_fromio memcpy_fromio
-
 static inline void sbus_memcpy_toio(volatile void __iomem *dst, const void *src,
 				    __kernel_size_t n)
 {
@@ -399,20 +375,6 @@ static inline void sbus_memcpy_toio(volatile void __iomem *dst, const void *src,
 	}
 }
 
-static inline void memcpy_toio(volatile void __iomem *dst, const void *src,
-			       __kernel_size_t n)
-{
-	const char *s = src;
-	volatile void __iomem *d = dst;
-
-	while (n--) {
-		char tmp = *s++;
-		writeb(tmp, d);
-		d++;
-	}
-}
-#define memcpy_toio memcpy_toio
-
 #ifdef __KERNEL__
 
 /* On sparc64 we have the whole physical IO address space accessible
-- 
2.53.0

