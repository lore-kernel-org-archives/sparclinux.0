Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CB83DB65A
	for <sparclinux@vger.kernel.org>; Sun, 18 Oct 2026 13:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792331382; cv=none; b=XkqUQ0uAvCCt5ZoXIL80pMg3x1lAn/JV5kHrtYkI+ivc2ODy79c1U62Y1j+KoYAHvPNniHZryU5oW970ntW5TeElTDGLrbPNd+YmYARajDTWdZ6EkEjxlO6DyrDbd9XT+3w9EdkiAr/xURP614x46uXtdMTkYIJX04wuLzc9mAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792331382; c=relaxed/simple;
	bh=XS1hfUYBh3IHnLjqYMLanotOueCfYEigxxyKMp4yttk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o2A7V7T7P3WZKVgy3vVnoV7eRdAgiM8wt7YdFf+E9iIUgMbqyYpPppLU3vg1YbbEwsMogr3ZU9WGb1xgct8DzgTA5SN0aVuSiNNgm3IbhYrINZ2AXp/r8Ya24DZEHfo5knLCHOpsXYuqKGLUX7XtXT3nwsWv1Y/0L/vkd58SWvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uj8PuAXi; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uj8PuAXi"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c38ac26cc5dso176401566b.2
        for <sparclinux@vger.kernel.org>; Sun, 18 Oct 2026 06:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792331377; x=1792936177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XrgtN1CfIC918YQEqPq2f1RcPZ7legyk//5piQ8+dDY=;
        b=Uj8PuAXiQssCE/myuDDwafEFSpeV340x80XfFsgxdHrd+PxxleJDzx/TwHIqlmwp4+
         8U4EVOrpnDpIQzUtjR8WWuzvtCRYNuGT0Onwt0GFEtMjwhJCAWZ5oDRDiEYWU94zswH9
         eGpZyurIuSwm9/7UxN341UmN0YhqrCCxpXuqDAW8VNmxZLRybHX57+nEUInhfMYWuv0P
         AOqgdcbaBwTi8kE0dSCna0saVPC8w/fI6Gif77TBMUZKz9PZIukq7rmtHjQP3mzfhz9X
         Qw334Mx4BsYcPajENS3EoMN4L8CAbMkUb7El4VjE2Xc//oXymNaqMZJnj7P/rC7XfXOV
         z8IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792331377; x=1792936177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XrgtN1CfIC918YQEqPq2f1RcPZ7legyk//5piQ8+dDY=;
        b=HlZXxkh4SrE6YFWsrR58ts33ofL+3EgOoxHA1g6+BsH3y7V3+gBbiT14LRmgwLk6QO
         cytq3WLHL5n3/znlq0u92IyEznQtaOpxRmtEXGnoXsAPxVnNHrQE2TFBBCW0nWNoGoX5
         MIHyFXwxTp3vPJJhMHeWtfuCERGC7IwCBC45hPF6g0cHN2ul7RDhZdOfxvv1SYL2elWp
         ohpx3atVj1t251C4bLkDdrIlkKi+EtaaVhru5sU/JnEMnqlqSXyaZqq+46Hp4sC2+kAB
         7eLRd1E3D76xbAnh4LdISCCyUiiqTDMkhCWVVmUvHlwUrDoyTfjlfWuxl1Ri6Cnsed+T
         ez2g==
X-Forwarded-Encrypted: i=1; AKwUvByAngMZP6wvGWTYYXS7KnBfon+mOowMzlI8L/+zsHt94xudCtVk5S9EOaIq+foehYeACfJ2oponkysX@vger.kernel.org
X-Gm-Message-State: AFq9FYJ/zxmokdtjnIQvdv8wSX490eG5TUfQYKaxGfVNXcXalaW6PQ+R
	t9Z1yM02Pyt6cEbdOEb7AERrt734H3n/wL7whC4JigPAcxz2oflCvNls
X-Gm-Gg: AYBFou3CZiJWvx6ORCwOWcOpls1dyJDLmcD34DsB5WysNLv69X1Up5kR0Ua/QKyyp5k
	NblxRq5QsqMwxFzECG21A19nuzHUttqgC03bKAiBxC5j1mi0yFwvrMCoio1PZfrRTw9basTLmfb
	ZhjaHSIQwiBiv3y0Gj7l03R4O/u6/5oSrCASCm49bMjw2TF7j2xlkxY4+cEQkyKCz4xpCYh5Ne0
	F7CMRqAVIqprvZerEsydraN0ShycKwJxq0RafrrMA8Z41jxf1cxXYZtkLOpBQMK5ERa/bOiPzQK
	O3Wu/bM4QitXlgjJOT2h9PdXM37StEVAICZh/A4Zd1Sls02Ht/IAuUZcl7sfHQBeZF/ggbW5ZBC
	ECSTaqvORmdyucXQvKxDl2D1n9wAlxUJuE7bCO8y+kHgO9dXNFz8pFeZnEjlA/qBAPBpCGE7yRX
	V+BVKop8rKaoXlwbGQ/ASsP5gLQlkTTIkKrxXPygqY2J54SRPHsAn1Ebo2ywHjnjAA6DIbSt9ZY
	1RUlc+C2vlWTLDo8CjyZrhZjEfEs+QxQm3VkIKdC61ntw/cZLQ=
X-Received: by 2002:a17:907:c605:10b0:c42:a326:78a9 with SMTP id a640c23a62f3a-c42a3267e26mr126187466b.42.1792331376760;
        Sun, 18 Oct 2026 06:49:36 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c40919c0402sm267678266b.61.2026.10.18.06.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 06:49:35 -0700 (PDT)
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
	linmag7@gmail.com
Subject: [PATCH v4 04/10] sparc64: stop IRQ setup when descriptor allocation fails
Date: Sun, 18 Oct 2026 15:45:06 +0200
Message-ID: <20261018134738.1016106-5-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261018134738.1016106-1-linmag7@gmail.com>
References: <20261018134738.1016106-1-linmag7@gmail.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

irq_alloc() returns zero on failure, but build_irq() then configures
IRQ 0, which is reserved for the timer, as a device interrupt.

Halt before publishing the IRQ or changing its descriptor, matching the
existing fatal handler-data allocation path. Returning zero would let
callers continue treating the timer IRQ as a valid device interrupt.

Fixes: 8047e247c899 ("[SPARC64]: Virtualize IRQ numbers.")
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/sparc/kernel/irq_64.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/sparc/kernel/irq_64.c b/arch/sparc/kernel/irq_64.c
index 3f55c69d5f3b..4cceeba726ab 100644
--- a/arch/sparc/kernel/irq_64.c
+++ b/arch/sparc/kernel/irq_64.c
@@ -619,6 +619,10 @@ unsigned int build_irq(int inofixup, unsigned long iclr, unsigned long imap)
 	irq = bucket_get_irq(__pa(bucket));
 	if (!irq) {
 		irq = irq_alloc(0, ino);
+		if (!irq) {
+			prom_printf("IRQ: cannot allocate interrupt descriptor.\n");
+			prom_halt();
+		}
 		bucket_set_irq(__pa(bucket), irq);
 		irq_set_chip_and_handler_name(irq, &sun4u_irq,
 					      handle_fasteoi_irq, "IVEC");
-- 
2.43.0

