Received: from mail-ej2-f41.google.com (mail-ej2-f41.google.com [74.125.228.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AB9233924
	for <sparclinux@vger.kernel.org>; Fri,  2 Oct 2026 16:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790957754; cv=none; b=KiOvR2Irzx/lVgcJIdSgty4b96E/ck/CpdRNRxQec2c6wGPSXkiyFh9Mh/rbl/IAPVsqBtQQ5wjJ9PldykZJI/57n1n6nG8vZSuzACzi1Eg1WnrIALaMbO04pqozYQNJvS2+DhDBhe+fB2cei4TcujsrsWk4vTKuPgib1owXG6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790957754; c=relaxed/simple;
	bh=Le1SYPb2jPNj5MhF8OuGIlzFKKsBR2rEDTHPqcMQNeM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TqHmfE8lDLNPeDgWgGvTTd3GdnZf3chxQ5B5SqJW0/L0k2z98c0P+O1n1GxQXGftkdYCiHJPaxpJtDXVyCXb/Qf6ej70SKs8rXmh0hGBQ8ppMqU0GOMAaozD8kRXMczso6D5RlLJnwxwg+r/Zc1YBPrFG+pFIf67ziNKy62QBZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W61Bo5gY; arc=none smtp.client-ip=74.125.228.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W61Bo5gY"
Received: by mail-ej2-f41.google.com with SMTP id a640c23a62f3a-c2e3dcfe205so10444566b.0
        for <sparclinux@vger.kernel.org>; Fri, 02 Oct 2026 09:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790957749; x=1791562549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZtyEZmwj0f19Lpw83gnqEqbS3r4hbHydMWKTWR/TdRU=;
        b=W61Bo5gYLf5flTB6iLcAJdoKQXBqRVe69B5nIDefiy1t9DhIV8RpCeL+5g0IMk0Dmu
         kkhGXVQJIQP/jSghoZ2tQ1vs0VgAn6lsC1ywm5rfyQCyyvlJhoRKhETZhzhkcAcTHris
         Q+/IGn2FenLTCvGrjG+DCcmukmf4SKQKxNdaKOvi+cLnb7gobd+kHB/Nd4t3/wESAyiA
         nUs1Uwi8FMD/5Zt7Ir5p9aJaEwq7WDtWIDRjCWD1zQbjEecVTIxUTpyfBheUhCU0U1Hl
         WCWpss9VpHmbTzblxvU1+SQN/jrXj57PfsJsnNX/X+fk/z0wRj5qWEhar6YHKHXGWBKz
         CdQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790957749; x=1791562549;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZtyEZmwj0f19Lpw83gnqEqbS3r4hbHydMWKTWR/TdRU=;
        b=FqKnx4En7oULxRmStkQI8/vMvJs391tDkLR0WUwHoc7CabCdP1YEW+8IR43dNvGCyA
         N3BzyCcWgSf7pJphJfkyS9LnEOGqx4YfdBRqHH4/kdybUN3Cb4/DcD5IGitlM+Tnpb+o
         uXhzCpC5lGsvP8hxBhsusQKpEQrR+q/rZCkW6FpGdrW/l7qqGSSSmUEKopMw10lxKfxt
         +dUvF7lWNBnoxAICk/9u0+D2YDid9aOgTkPtNvngQ0A34EciMxTheN7IfKYUxV6eOorr
         xGrYwKLFZa9bNTj7dxa4B/d2IwcHGBVnJ1FJd609CEtaNodPvik6cy0Hst53CWTe57b6
         4laA==
X-Gm-Message-State: AFuF++lWttBHLkpVP9uELTnb4mS/TnP+UgCpkggp3MkeLjH6siiKrCM8
	l62IhPjCaUsLVtmR8TxaVhmCJv6n6piiP9QbDiXRF+BShnDgwCCEwMjnHUvq6j4W
X-Gm-Gg: AYBFou2VRmHAiL7F6M+fmnZJl/sjo1oyeBK7O70NZM1M8xqFjKtHR5CQ4dt8YKB5CbI
	flU0THyNOCZHPqJMwgcf4d9cLAmHsNZx0d5DjMSoiAsfWGM5B0gvpr4y4acgmR36aMSwvR2esb0
	LA+di2k4mwiHGn4PsAiHSdE3xwJuyZLX9pzQGXeZ/np4dOVH5/tGRPp4BIPFTnvCEggWXHC8Emu
	HrMB7194FXBH4+t46HyQBOZUXUCxEFdQb9Nmiu/Hm4Qof+OV38Erj1Q73OKCQ/8gcazMOFDINly
	rxyYwDqKUsaOtQ26Fc8e25k1vdaSOOnNg5Nt9r9371mhwveGDmvlnRiEZl7hbflagcq93Vgc7o8
	oqE56xlFf7645Mq98FIeSjxR7i+JddcsUUhxRj0pArWBTDYLfcwuQ5AIBHykPBCVq/GfGM/pBVS
	yKp2nL4zIHeoFAGQIj7dRjl3CHWfxh/jiv6hlEWrkH/SJWsDE8Y9xYdLyumXTjFmcHsTHXu9xQO
	NSb0lj5xBo7IrEvt7LylS69fAIat/jQLuf4IRtd
X-Received: by 2002:a17:907:d086:b0:c2d:d408:5da6 with SMTP id a640c23a62f3a-c2e4b2417b1mr256577366b.49.1790957749284;
        Fri, 02 Oct 2026 09:15:49 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2e4cf5f4e4sm106437166b.42.2026.10.02.09.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 09:15:46 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: sparclinux@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Cc: linux-kernel@vger.kernel.org,
	Magnus Lindholm <linmag7@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/7] sparc64: return from the generic clear_page implementation
Date: Fri,  2 Oct 2026 18:14:23 +0200
Message-ID: <20261002161515.932316-2-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261002161515.932316-1-linmag7@gmail.com>
References: <20261002161515.932316-1-linmag7@gmail.com>
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

