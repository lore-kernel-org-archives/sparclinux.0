Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34BD33C50D
	for <sparclinux@vger.kernel.org>; Mon, 30 Mar 2026 21:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774905839; cv=none; b=IW7KMAZofKtBuRPpPBQC1yMOLsc5r/pQj0UtXhhIkdgGeIYWr5iQj0lqTdfXNeSL3zBPOh7gZKmo9Z51LNiTqo3irpKL9zVxZEhp1rq5s+EkzNUzZNbDmPIECxUylBaxXEVOMPu7J+2YVBo5Ntw/FNMU149Bk2tgeAiVv/4Syn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774905839; c=relaxed/simple;
	bh=gg/+qd9lKJZ3VbFlkE39x5JH1DDKZMGJVqccM56LzXs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hGNbRf6URLz9bt4+597IXBivoesEHB5Ikd2Vskx89k4RAqpOqWcfpjnGoh2sY17WpiSK5IRSRZJa8XGdy6hmssGXAPn6abkTHUHBh/yy2q8fC/gpeke9EDqpnUTRtoMPVjGRoTsRCaEr97eKl/654O98vwhWND8NwhUe0BSGva4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UEwiP2sW; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UEwiP2sW"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-35c1a131946so2902614a91.0
        for <sparclinux@vger.kernel.org>; Mon, 30 Mar 2026 14:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774905837; x=1775510637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XjjIrXPfDSSBntPUXBfY9smmOGuXahxeNABshAdAH/Q=;
        b=UEwiP2sWttJK/z+Lsx3tFxRyiLCnxsW4jsBgYT9AXsx70QNw9wijDX/gj9djvXUj2z
         VstiVXlTa/pKGLj57ULU30UVoNyofsAJzbpA/Bs6RM2nUNinPeZuTgEPXNTOISiOuILz
         9+XnGu2cELKN4qGd7iuG/mvnX8VBZt9VqiTjQrJkc/XkiJZy5i3N4AzdlvPWUPQOdlnP
         Fs9GRMPPHqUD+S4ivEs0+OpRYedb2FSXH8elqdA4/UNDoJMPagcdHnbvRZX3bDzzbZwB
         KnAWShK+2YPcDwEz3jZKfaii+XuI8AYg4oaGbGHIH/vbaTxJ+s+1KJiuXu272jCb2IdR
         A7Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774905837; x=1775510637;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XjjIrXPfDSSBntPUXBfY9smmOGuXahxeNABshAdAH/Q=;
        b=gM8hYHmGYU+hOHISif1YpbIaFgxhjbq9cmn9iFRQtWlATKSsVNgHxcOppR+xBbzoxn
         iukapNU++bQfua7p1fSuqkKTbgjgQcBB1d7v5H4HCrGNKN1w/pqzGwI3GCyZ+jh94kBa
         ovh9LI3+ZSyv6fX2p0cWAA9qMjK0zcQhx41PL1YAuvTN0n1Uo8v7ZRvBgYIFlppu7Yly
         Viozcu0sLs1C1j/8ol5aOe0nVBMHJM5J0qWoPTfD0IqurGKt8/qhcaXRReBeI7j8LgOZ
         UCZ4WAYrXbqCxLb9jVAFcCbmPcgDBlH+BUhFMKOeIN0sS+9mPtGDYbmlaUO5WK+ZTCWA
         pGtQ==
X-Gm-Message-State: AOJu0YyIvZ33k1vqyEKJNOF0xN552uz+AY1S4OzXAVY3xf57uQU9zL53
	4jpbJmj4tEVkIrA2ExwskP9wi+heBW1UD1EdgYs/mnCjNh17SBb7FQoLv+tO5LjA
X-Gm-Gg: ATEYQzz/aXYFvykdGnDpzhOuJyl33jc0L3UVy6YGgDjkXcBIef7pLdVegjoPMPueALG
	Y4uK6QBiyVXIzj5dmXcxbCzrKrVhArClp6JUvTKL05UXeSXTH7giRSxlzc+BiX3fLHcSzn9bb58
	sCTq/yyh7Ts09Ehx6oOaIA44NFR2nAGo65D4CSlz9q9kBn6rhPzghmHqRza3/qBO+eI9BhlbSSR
	ngLWD+5/Hc8OM2Fhrh0AjKA7INXz+NtYi+lGpNggRznQGT5cJS5qjwC9ArZ5wbd5G2X0zQlZcNN
	vuQrcTnqfv1EjbsH53CqF1uSg4I5ozDV4POCzlFE9T9WHV4I/wvoT4+rNlRj2zxJRJHRmkCcA8L
	+GrWTvGJm2CQICuMzrncZbv9AVy/83bxNct3ouiqN21MSHMB/Ze0zhhMzOsauaRVEqmasDjMf/C
	Z5r+kZSSJ3H3I8q4HMbUtY2q/mVMewwBl5YRv9vn3g8mfNu7moCmetpMc=
X-Received: by 2002:a17:902:ccd1:b0:24b:1585:6350 with SMTP id d9443c01a7336-2b25eed40e1mr8421245ad.11.1774905836913;
        Mon, 30 Mar 2026 14:23:56 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2427b15a2sm111083995ad.73.2026.03.30.14.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 14:23:56 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: sparclinux@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] oradax: allocate ccb_buf with ctx
Date: Mon, 30 Mar 2026 14:23:39 -0700
Message-ID: <20260330212339.16673-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use a flexible array member to allocate together and avoid freeing
separately.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/sbus/char/oradax.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/sbus/char/oradax.c b/drivers/sbus/char/oradax.c
index 45df0b274491..7313585ff3a2 100644
--- a/drivers/sbus/char/oradax.c
+++ b/drivers/sbus/char/oradax.c
@@ -189,7 +189,6 @@ struct dax_cca {
 
 /* per thread CCB context */
 struct dax_ctx {
-	struct dax_ccb		*ccb_buf;
 	u64			ccb_buf_ra;	/* cached RA of ccb_buf  */
 	struct dax_cca		*ca_buf;
 	u64			ca_buf_ra;	/* cached RA of ca_buf   */
@@ -200,6 +199,7 @@ struct dax_ctx {
 	union ccb_result	result;
 	u32			ccb_count;
 	u32			fail_count;
+	struct dax_ccb		ccb_buf[];
 };
 
 /* driver public entry points */
@@ -533,7 +533,6 @@ static int dax_close(struct inode *ino, struct file *f)
 		dax_unlock_pages(ctx, i, 1);
 	}
 
-	kfree(ctx->ccb_buf);
 	kfree(ctx->ca_buf);
 	dax_stat_dbg("CCBs: %d good, %d bad", ctx->ccb_count, ctx->fail_count);
 	kfree(ctx);
@@ -643,13 +642,9 @@ static int dax_open(struct inode *inode, struct file *f)
 	struct dax_ctx *ctx = NULL;
 	int i;
 
-	ctx = kzalloc_obj(*ctx);
+	ctx = kzalloc_flex(*ctx, ccb_buf, DAX_MAX_CCBS);
 	if (ctx == NULL)
-		goto done;
-
-	ctx->ccb_buf = kzalloc_objs(struct dax_ccb, DAX_MAX_CCBS);
-	if (ctx->ccb_buf == NULL)
-		goto done;
+		return -ENOMEM;
 
 	ctx->ccb_buf_ra = virt_to_phys(ctx->ccb_buf);
 	dax_dbg("ctx->ccb_buf=0x%p, ccb_buf_ra=0x%llx",
@@ -671,8 +666,6 @@ static int dax_open(struct inode *inode, struct file *f)
 	return 0;
 
 alloc_error:
-	kfree(ctx->ccb_buf);
-done:
 	kfree(ctx);
 	return -ENOMEM;
 }
-- 
2.53.0

