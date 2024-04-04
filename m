Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CC4133426
	for <sparclinux@vger.kernel.org>; Thu,  4 Apr 2024 19:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712259034; cv=none; b=QOaWpj/vhZENBKTWHKqHR38EItAzPXqPjAb2v4tspkM9ijpVA8jXxAXwXNTq05+2AeNR+eghgNiTs98O5cvgSDQ1u+yy22oFMlYHCE9178z2kHOtgLQ43OvxrLi9VuQ9Lyh6k6J2M6dgt8bo81TZN2/e/WZ4Vs5xAepsZLN7OsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712259034; c=relaxed/simple;
	bh=dXY4VqV2dgu2W0tvqxrSc6CK/AEkg1qzMSsPoi4MjiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YO22bImibpJGjfWvwQlWQI8VnuBm+FAhVNmv3PM2iyGtxXJGsDulrAncw2yrEnBnVaddxDLC+KZuqxtc7U1dRlJZoV+cqydrYu2m1qsBieFzb3pvsoOPQHcfuVS9V5jSPkdwzGvjX5zClrQ0Ppg1QS7vqennjIDu1GucXeavpbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=l9DyFMpu; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="l9DyFMpu"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a4e40fad4fdso195264866b.2
        for <sparclinux@vger.kernel.org>; Thu, 04 Apr 2024 12:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1712259029; x=1712863829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YftQBH4K5k1eA4ljqzTyg0/24HcF6aTvgonFgjzZs9Q=;
        b=l9DyFMpuH5iZp8yRXD2IEjiJeCrlX2btyTYA5n84C+kCiWjreXcDNA/9kUdMZhBNSM
         3C3pRkikqkoPJbzOxLv1vn3qfOUdAAIF+GOxRBJywD3+hBk+SgPlAeSR5zmsAmhvIQ6g
         Ibdo4r9at/r3P7RgU8rGqQ9qNWpW6urB/ah0umZ2PALWUinZC8ixt9v8NOeww9Eev1lQ
         /lDRHDMlVRUm06EAAQT94cm4tJ+mntCp8XdV67eM6Dz1UToS4sbgi3nGFOAHtZVlSJPw
         oTW5j4z52ZLsx9Hwqx+rQ7M/rxSwZ5WqwwcjmUlqXgkCzqfKrlPRVRtZu3z/d9CZpBGW
         xx/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712259029; x=1712863829;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YftQBH4K5k1eA4ljqzTyg0/24HcF6aTvgonFgjzZs9Q=;
        b=lOY4laqoPGOIL+SVpMWFQEUh2AMKdb+XtGq3qJus2QTawepbs2mZKGjh2lj9pMUBHx
         gKmCW54pKRHg2pUK9CVvu/Mf9S2xCyLCRq89nEKfJ7qOsQDhq8hhjXUV5XNXfoqsyjU2
         YqKla2wwvEDXmxN9ePC1zrBs8xR6UauhEqyLZaFc+rdWRLBDTLV8xMVAFgKUHU+YWda+
         AedRwI/tJszR4KGlI55ONaEXzt84BRir0VCRFeNiXKyfZQ9Z0euvslloh50oHGdeMgkT
         mEwfdlsJMhHD9ez7S4iQrkvu+G0qCbEjqVdzljFSxiJ384SFbspNXItzOUqqRgtBWQmP
         0PuQ==
X-Gm-Message-State: AOJu0YwS7ezdJRmrxQSfrABQG4iuaCx4xaIaA0PEq5w+asrUgoSNrCYv
	16atqJqvDLWj5ZyuITbiARrnCDuzZTr+XnS9LlASfWw1wTmIzYEi0UCZVENOqb8=
X-Google-Smtp-Source: AGHT+IHCwoiLEcG6OP23A1J6qWX+Ltb1CEDPb6mHfowgHbsbwpZ3SH5Q1cIQNWi+cyWfm3Rk2qcrrQ==
X-Received: by 2002:a17:906:456:b0:a4e:2777:37c7 with SMTP id e22-20020a170906045600b00a4e277737c7mr385955eja.49.1712259029236;
        Thu, 04 Apr 2024 12:30:29 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-212.dynamic.mnet-online.de. [82.135.80.212])
        by smtp.gmail.com with ESMTPSA id t25-20020a170906269900b00a4c9b39b726sm9394909ejc.75.2024.04.04.12.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 12:30:28 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Cc: sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] sparc: Compare pointers to NULL instead of 0
Date: Thu,  4 Apr 2024 21:29:33 +0200
Message-ID: <20240404192932.13075-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes the following two Coccinelle/coccicheck warnings reported by
badzero.cocci:

	WARNING comparing pointer to 0
	WARNING comparing pointer to 0

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 arch/sparc/prom/tree_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/prom/tree_64.c b/arch/sparc/prom/tree_64.c
index 989e7992d629..88793e5b0ab5 100644
--- a/arch/sparc/prom/tree_64.c
+++ b/arch/sparc/prom/tree_64.c
@@ -332,7 +332,7 @@ prom_setprop(phandle node, const char *pname, char *value, int size)
 
 	if (size == 0)
 		return 0;
-	if ((pname == 0) || (value == 0))
+	if ((pname == NULL) || (value == NULL))
 		return 0;
 	
 #ifdef CONFIG_SUN_LDOMS
-- 
2.44.0

