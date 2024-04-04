Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CDC8286A
	for <sparclinux@vger.kernel.org>; Thu,  4 Apr 2024 11:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712229829; cv=none; b=jpkQg/Ue1QyfSXxafbHjWRrCkQQIVq2H9GmSPnbA70zm3O6aGLP/5wD0ugU5+JR9af6s9zltfvkQakIMDT2cL0LdeoEiU5aczE44bzYPu6YvDqx20v5+jlGOVcYLeGjMyrpayZiEnq+b0aNyCngnFd5tcFIdgfpPRwR8FGct8o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712229829; c=relaxed/simple;
	bh=KedSSz3/IrCa1VpTRibBfxMxza6Zzrin2mfQ1u9MHtA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bOfWOGYfQVqo0zcAgDuAbSKffmM4MuYV+yPqnjm66uH2h6/oaCKchbnHhzo55fbGXJIFtx4+DxJJOCXEq5uneqGdyysPdnC38GDd+eEZUqHIVXT7P3VJx9hplX6C3A2t/DmVi3uqVbICyNIoy8noRzTx4fT3dgAk5uy8BnEAGco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=RMvN4s6u; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="RMvN4s6u"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a517a492055so127939166b.1
        for <sparclinux@vger.kernel.org>; Thu, 04 Apr 2024 04:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1712229825; x=1712834625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pkYU619QNOAcumaNgRtOFKm08inQ9YEczozqDufhPwE=;
        b=RMvN4s6u/eGVLoA6ghv5c+8SE26TvwTwC89IipK9evb6MvNRO3UGbXpQ0ncxE3jAkK
         1yLAYUm+LmLyznpCo8mh1R4vG7dkIyAN/zZ9tFpTSQiX4HObYNEx/Gu2KvsK4HLBLb2a
         O+45dDbRDGGqz5f9/7Ntn2Z1Oo86Eo12WR+lNdmYU8kNdLvvHFb4XGTnCsJvMLTfrraK
         8/75r7Gku+IJor6Nh6ViQXBhVEB9yz2PUquMBcbdw/ewsSj+vBdIurlWEHTOFla7Q8pq
         tgl6JHzPJm3EWZYICLa3l8RBu1aIZ5a6oq7gF6D/lQo9l8lp1L1ACWSaEjLTx59hqTT2
         rPXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712229825; x=1712834625;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pkYU619QNOAcumaNgRtOFKm08inQ9YEczozqDufhPwE=;
        b=SbWnRGL7t8kaEq5iAK3OjxJwoOXiiCC8NMI/rKcH9zd0Fy/1fgzzdthHLBz7srO1Dd
         QIcDBNCIJ2rKbMLmI5ElFm45h7qohE9tCs3kAisb7fGjhLaa2JL7HwMgDswdrGW4Aj/J
         W5RrpK/1w6LQ600RJ3P8Pf3cp0rGmLC/dwANz9/Ir4Q7p+D+nQxeAZgU0jj6zQjL9Gf+
         5ZPWLwFekk8yTs5V4Q2wvVnKZlBTX40k6RX3wlgvoE3qd3ZbVI5KiDJn8Kk1TvXotpo4
         P1OpcOjvnUZZEfEGj3J574GJnSpQBftaf5hzFSeK1UWEIvT4CoptE9lqNZl5N8tn7Vt4
         jOdA==
X-Forwarded-Encrypted: i=1; AJvYcCXRQcZYIh9YDut+c4RpnK7UmXJrE2ddvFBWhLmA7LCMxtFn5FddV0f6hgI6Y+tewTkAIQP6c+8D2oG1lK1gGNrWqw/knkLtz/454g==
X-Gm-Message-State: AOJu0YzrQb3hsoHY7/HG8ovCB6DdV0wdRHXAd7/w0Sz+jaHL7ITtsxkk
	8wS4FR86/KebEC6b3iCDq/8gi+MSYoiltBm6Ndqk5qE2KNL+KVj5wV4ylJKvkzE=
X-Google-Smtp-Source: AGHT+IFK8jr37Yvi1onGXTMfiS4hACEokH0HQITqdKdAKcYVNNcSynsV9ZUFQOqjrDeb97MoSUaPgQ==
X-Received: by 2002:a17:906:30d9:b0:a47:52ff:194d with SMTP id b25-20020a17090630d900b00a4752ff194dmr1338735ejb.35.1712229825255;
        Thu, 04 Apr 2024 04:23:45 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-212.dynamic.mnet-online.de. [82.135.80.212])
        by smtp.gmail.com with ESMTPSA id os26-20020a170906af7a00b00a465b72a1f3sm8943302ejb.85.2024.04.04.04.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 04:23:44 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Cc: Rob Herring <robh@kernel.org>,
	Sam Ravnborg <sam@ravnborg.org>,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] sparc: Use swap() to fix Coccinelle warning
Date: Thu,  4 Apr 2024 13:23:14 +0200
Message-ID: <20240404112313.11898-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes the following Coccinelle/coccicheck warning reported by
swap.cocci:

	WARNING opportunity for swap()

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 arch/sparc/include/asm/floppy_64.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/sparc/include/asm/floppy_64.h b/arch/sparc/include/asm/floppy_64.h
index 6efeb24b0a92..83decacd0a2d 100644
--- a/arch/sparc/include/asm/floppy_64.h
+++ b/arch/sparc/include/asm/floppy_64.h
@@ -704,9 +704,7 @@ static unsigned long __init sun_floppy_init(void)
 			ns87303_modify(config, ASC, ASC_DRV2_SEL, 0);
 			ns87303_modify(config, FCR, 0, FCR_LDE);
 
-			config = sun_floppy_types[0];
-			sun_floppy_types[0] = sun_floppy_types[1];
-			sun_floppy_types[1] = config;
+			swap(sun_floppy_types[0], sun_floppy_types[1]);
 
 			if (sun_pci_broken_drive != -1) {
 				sun_pci_broken_drive = 1 - sun_pci_broken_drive;
-- 
2.44.0

