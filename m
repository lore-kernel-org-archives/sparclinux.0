Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4D945A2A2
	for <sparclinux@vger.kernel.org>; Sun, 11 Oct 2026 19:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791748671; cv=none; b=i+LN0aoXc2XfoAMzylSZimqwrrGm1PnvgRVjVvva02CpdFSBLNAZ+HN6Ds1OBPT2cUml56QSkySbSyK57wIRScAIsRg5Xo5aqVwRraS17bzZkqIpGlUWX16eeM+gx9rh6/UiK9rSqsrk8blkektGUqkjg6M0CUlMsmGZMtYH2A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791748671; c=relaxed/simple;
	bh=Le1SYPb2jPNj5MhF8OuGIlzFKKsBR2rEDTHPqcMQNeM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dx5Q531ChHYpPYxhFPlEFHewlZkX2B7qgKlfYhgCULWZtQqu8730jkaOUHX7UwVSoGb+Rw0vbxzeDBCnOyXokOMWiYBLb+Oi1gI+5tZ2C89LUalMCAfV3r/E8O/nofUytkg2VXFLttcpM91yF36fAZ+Oxr8yDlGGcMz7Zp6CS/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q1DXwjwZ; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q1DXwjwZ"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c34bff61551so51821766b.2
        for <sparclinux@vger.kernel.org>; Sun, 11 Oct 2026 12:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791748668; x=1792353468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZtyEZmwj0f19Lpw83gnqEqbS3r4hbHydMWKTWR/TdRU=;
        b=Q1DXwjwZx0ewCGYTzlldBhwAvBE5AFrZmnFiUCBx4qQIm27xdFd9CxirUs56NxYjun
         Ur4oHEYAn7SBy3slGVOLiEU1iGdv5fAE9yo2QbNaAkaGYMQIYpz8VA4+5jBObOTkpIbQ
         g1gf07nXLAGnZEFljdbRhALTcYoJB0TQQoFM/pwlVtJ2O4UW27SyQOjwy/Frb3+TMrpo
         oJVh2DRQkq4zP6IVGarJBh+/4Ij35cn2xEoJ1cJ3r2Fu2lo1+fh6h/Ci2+lF0iCa1sRG
         jwoE4rpvY+suqOtbQhOAx/jGZTIGKLOmg8PRDB+ZKrs+58Lrby/s4bixVTkt1OBUtfJV
         +bzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791748668; x=1792353468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZtyEZmwj0f19Lpw83gnqEqbS3r4hbHydMWKTWR/TdRU=;
        b=nDSjHSR4kcvR1kS5vU9bwK+RYInJ+LpQ4XmPOLEgEM5vQEMKq1LzCe2DUYkYL5FyH4
         LSx1PVmLZcbcGbXs/eb/msosEeyXY+IQp+MAV3jQH1sx9Mqa5K6W1SJM8SOqa/ehiyt/
         FnHPlujXJlninuIuq5FhEVCOoHWCDgaKhHXCfwdK/hLdrqK9Wa2T3hZbAMVj0GCC4p6L
         sKeZBTuwChEmNpPvF1qxFDiWZ2B1Jq3sNM9NqzTD9PZKCNBp3ndZrEjIONV/jpjikpkR
         rFKck7MGngteRzZFnpIxHLnma/gEDFjosyQzjlJRxWc66p/rmVVY9OnypVhmZDypB8DF
         gnSw==
X-Forwarded-Encrypted: i=1; AKwUvBx92VESoE7Jwt5Uzylm3nSw+6EbMo1mEQaj3KWSNbBn8uA3JZrlFKuJV7frgRzh95ZUqfxESB2XOoCI@vger.kernel.org
X-Gm-Message-State: AFq9FYLwn7bt4vkE4ypvAgfxPhtCgv9qbxG3yH7rZX0BvqlLXQjZnWiO
	Q9TcY7nIV3Qe6NpoIROl3XZs73cqB0PWV2cEQmKvoxFVWCSAaohL11beWbDKkHqO
X-Gm-Gg: AYBFou28diQ3H3YNb7zSrZwefHV5Tc/q2cM9OzFuPwJ5k81qxa4WjlLDZoTxYo1/7yq
	hNnyrpmNbfb1hsS+NjuNEHwVNe7/HkYgu9gVvLeBfkBQv6KwUXjP+IQKWDm/zb8qtmoTdRNeDqy
	p1XrTJ9X+EIhiPdUFWUNS+vC+MLOtt3Mw/cEiTI0nIU8qkM82vvMx8TJ47ojVZFDEHI4hhuXlLS
	IwmYRICAHTgKeTF6LqVP64o+k5UdMSBmvdWZmsXAZuuBJEcgZur64n94OrwUXHsfxM/YEipfMzA
	oWYrNoLd4j48lNxTxS98ryB6DLu+IrldtCp8bGcpInmLuC7hYEudJtJN3QPh6IFY+z8fA1L5165
	ArdEPbFDCicKP7xbbPiOd6OAJ4MyPF6hFq+MFDjjcyEkfTsldxfQriLJqmX29WgfsJgXHeXP/2p
	7V41AdpDtUNPb2bGYDiZjtBZurIjk7mGgB7Gs22iWprBmy5XxRgvqzU/biS+MwXuToDSotBY+CB
	0UPwdXX/zIElPCl9/77cwfLJa+VKrkw5b+9kWkFD2+Sj8V0TDM=
X-Received: by 2002:a17:906:dc8c:b0:c31:8984:7fad with SMTP id a640c23a62f3a-c31a9feb114mr762553566b.15.1791748668114;
        Sun, 11 Oct 2026 12:57:48 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c31a9a3ae9fsm381315566b.26.2026.10.11.12.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 12:57:47 -0700 (PDT)
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
Subject: [PATCH v2 1/6] sparc64: return from the generic clear_page implementation
Date: Sun, 11 Oct 2026 21:55:53 +0200
Message-ID: <20261011195729.981243-2-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261011195729.981243-1-linmag7@gmail.com>
References: <20261011195729.981243-1-linmag7@gmail.com>
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
-- 
2.43.0

