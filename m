Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E2839B49E
	for <sparclinux@vger.kernel.org>; Mon, 12 Oct 2026 18:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791830930; cv=none; b=jKocsFIqhcN+yRsO+hQ+e3yR/Y6RCkSC2rvupzJb4SQx3CqVay2C2pMtS0Bxx9NYzLl9oQ8/YfKlvG5PgIn92OGraJIEfkBQcJXdpE4m9EnV2UJgzGEEDmVJ+AszmbbvnX4SJRg6qHkGDiRIZOuszu9i2xhL6b/tXGHP6HFNCZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791830930; c=relaxed/simple;
	bh=MgWJ382pjc3YS/Qw5ey/WYCKDvLWKApPLBvDgAkCkd0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mwiBJWmlIzvsRkqvoeH8a/w6AxRNgu+y7EBj8wLZp+1R2f1CchQRXp0mUIGgOxqTnc6MiZdadAj5PThWxuf+pOk/zs8SNvSdh6aae0clxHzBc4F6hTLmYIyHS7bTyFwwYnGB7B8aBmUsOyrkgTtbjbt9BUcTr4oN83MTiBYShYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RdbaUwuH; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RdbaUwuH"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c20ce3c118aso227191166b.0
        for <sparclinux@vger.kernel.org>; Mon, 12 Oct 2026 11:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791830926; x=1792435726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z9MMUbPpbght9b1/Zf38zQrWJao2xsdGIO4miz4qhmM=;
        b=RdbaUwuHIu6iNJGzZh2xdR3mcbEjQev7Yjr1pT/aRT9QEe+1ClJZ9ldQSyix+3RRYE
         wRI2KIXuDI7pK7r9Exdm0mHYiYotpOJa7MuOHj3mOLbkjKNapkMPbNYJ5+YTZa6xR0j6
         MA+7xoZ3CKYNPP0EL1Srr/M7kqN8oW66iIfZZwKX2dnNHdWDv6nCk/f2h3ELvJD9We55
         LENISBn+kLSxxdaitnLTnkCJ7tjMaHQeW2r6cHDFMINy/mnsAeIlKBnZaOdey034EXgf
         kxgw2hC/18SCJAFJ3Yc9D9p13zyYzxTH8G+XdyrEXyTorkX+gOR+UB1BfmygDq+Iz8nN
         ywtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791830926; x=1792435726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z9MMUbPpbght9b1/Zf38zQrWJao2xsdGIO4miz4qhmM=;
        b=hkxW+a192w7U57w60od6nLR1Ja9ktB90wmPTQUVKk1jV0LBRN5krrGTLMN6w+Fhk9f
         pJlXvvY6w4iFlMS6HrP8GI1M8hJeiKjMnER06Gbg0COG0BI5W+krA8s2UtStT1jrXyX/
         5xEwSJHEiTWZdVCVcg/IwEEJX1DFqW9KlWTZbnuqJ4sQ/wQNnJiHOG7/u8zHpTtUcZWq
         Nu1UEmAzDwC175/qafGmkW4HiJOQEMBNholU2yVKf4A3AsfeHJtHmPOyufT8UiTFbsqO
         lvDR1I59s7UyeDoBwtlt2UNJiYMnewTJ55AgT/rrxBSl7MrlsXzf72ZNd1xUNlDHKnbW
         9qOg==
X-Forwarded-Encrypted: i=1; AKwUvBzSSJ4jLlPXFSOHTUsJgprs5ZHsKf+N5yGF++yIhLDLN6wlbyyS7NKnqZWA0sOMgqbP01Ch4vJw2WQn@vger.kernel.org
X-Gm-Message-State: AFq9FYKZVYaZB+B7pLiqYW74eeHe7chT3cwXZBwLm97mnTT1IEIwLysx
	r9IZQktk7t3w2a/5UzBdSHzHACWlT29z5MzIxQqm88agUlvCBwiUcz5D
X-Gm-Gg: AYBFou2s0tbaTerEAO7iwM5aFBjMGEIjr7BvZipGBCyhJVfWFWHOzMQt05UwgJAUKmU
	s2UP/IMMs9vWUmegdr4skr5uAsLFT+x7e64tIEYupmq0ZPgaRspJhjasggHATS/WDuKlgLrELIM
	PC1cagspvpFT81iIoXlVfvwoNiH+/a4BUAsCYpF4o1Pgy4ViEElKwL5HqlJnucgw9uPJl2/pIBO
	yMRepq3/Y8xp7IKH60peHyf0Y9RvSogsfCEBoQtXt++XjTbs4cw4MwTBbDi5saiEvnirTmtMC02
	qxlFIg8ACJ0iUEDgPXyTaJS0cRddTC/EFzDgJBZjYMmqGe+Nhylq44C3knZa9skzcuqIAyMOLWe
	/3umGbKeUAzp7tINNeDqxfTB+OAYg0hW3XZ7RHjc4344psykAK0uUA2bJ0dVUWS6cMjbphEupPd
	f/VEwpIgKubfBlwBN5wRFShog0O8ugYVS5hBYGHcSAoLHq2T+C4gZRE96tMn5UPHgpiZCA1VY5p
	XDgyBMBx98kX8pCwIbvaHuMtX+cwgUbAaeQlhgh
X-Received: by 2002:a17:907:608f:b0:c2e:33f5:766d with SMTP id a640c23a62f3a-c31a9d0fceemr1026790066b.4.1791830926364;
        Mon, 12 Oct 2026 11:48:46 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c31a9aa5aa7sm488517666b.55.2026.10.12.11.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 11:48:44 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: davem@davemloft.net,
	andreas@gaisler.com,
	sparclinux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	linux-serial@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	krzk@kernel.org,
	oleg@redhat.com,
	linmag7@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH v3 1/8] sparc64: return from the generic clear_page implementation
Date: Mon, 12 Oct 2026 20:48:02 +0200
Message-ID: <20261012184826.986050-2-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261012184826.986050-1-linmag7@gmail.com>
References: <20261012184826.986050-1-linmag7@gmail.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GENclear_page falls through into generic_patch_pageops after clearing
its page. The patcher then rewrites kernel text on each invocation.
Return to the caller once the clear loop completes, as GENcopy_page does.
This affects processors using the generic page-operation fallback.

Fixes: 6c70b6fc7b6f ("[SPARC64]: Do not assume sun4v chips have load-twin/store-init support.")
Cc: stable@vger.kernel.org

Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/sparc/lib/GENpage.S | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/sparc/lib/GENpage.S b/arch/sparc/lib/GENpage.S
index c143c4d1de3f..6ce11108e143 100644
--- a/arch/sparc/lib/GENpage.S
+++ b/arch/sparc/lib/GENpage.S
@@ -48,6 +48,9 @@ GENclear_user_page:
 	bne,pt	%xcc, 1b
 	 add	%o0, 64, %o0
 
+	retl
+	 nop
+
 #define BRANCH_ALWAYS	0x10680000
 #define NOP		0x01000000
 #define GEN_DO_PATCH(OLD, NEW)	\
