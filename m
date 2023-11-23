Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dlnqU4Ip"
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2AE498;
	Thu, 23 Nov 2023 03:48:20 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-548ce28fd23so1059813a12.3;
        Thu, 23 Nov 2023 03:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700740099; x=1701344899; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=18T4h+PgamAj+KI6bp/QSD69CdQrdRYfbgvXoI1RLic=;
        b=dlnqU4IpSvNUob3equ3CpY631Ljrg1tYvtolF//pMDerL2mOgfcuJaqfcUoZ8w6YYJ
         xU0ANitdpt+SsuHnBXlPj2G1Wob+U8e3gcBdkamn4wDrzG7cdvyWpKouDYqQrBSsy9MK
         VCnfgOz1EonSKAFrbK4GlxGjp0MAe37HzDr/qCrRF71pxCLk8a45PWC8dApEztxVtdqv
         9RljQGXOs4UKVt8StrFvjJShlbduW1rZp1fbmWdE+dkPolpmWHllfIgiQs3zEroS5QAp
         m0hMtHF0PpmjcumrYvwWeK54CpyvU4kSLU7ypyXWhiuMx90XQ53lD3YBxfi4HFSFJ1Nw
         tGLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700740099; x=1701344899;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=18T4h+PgamAj+KI6bp/QSD69CdQrdRYfbgvXoI1RLic=;
        b=Jj6lWue7d4iwFm71MtMezGIquaZ5whtuc43SY6PEaLo2NueQ9CL39LU7kB6voI84Iz
         0CRWLA8ifPwwX40GfhO/WgIxKPawkeOwf94P6fsifk9m49PWn2Ypu7mRjCdVX+Gr1tC+
         fd/UsJITJWJKgNd21lCX/I+ItjbkARXZ+ALfI7pEBZpy5ES/LloIZtaPPRjEgnFN1MtK
         11tDojMSTNtlPZ6pFr/iN+65VkwP6pJFw3x9pxf3Jvkff6gDCLClXUoPJ3Xi2Ix8Er7z
         psEH//22OLgNwkwiHvjDbE1C0ByrvSuelW/RL58mbAGeIKmzyIpQ8khJuUrfKr5xkvlu
         mMXw==
X-Gm-Message-State: AOJu0Yx2wymRg+ulhnnpiHSmisKRAm8uZrO6AI/i2ZcjOGXehdX/WPUJ
	ZF9oBrch+yqHMhFFGHtEmZ/ulEqEv2/gyA==
X-Google-Smtp-Source: AGHT+IEbYAuGtC0y0bBEXSgDdMN9HKIUv8FGPxeyOmqBlLAHorj8Ux7M+9oPlUH3ZjoMcro6j2/wHw==
X-Received: by 2002:a50:aadc:0:b0:540:77f8:240 with SMTP id r28-20020a50aadc000000b0054077f80240mr3939890edc.14.1700740099123;
        Thu, 23 Nov 2023 03:48:19 -0800 (PST)
Received: from felia.fritz.box ([2a02:810d:7e40:14b0:d183:a5d9:39a9:cd13])
        by smtp.gmail.com with ESMTPSA id c3-20020a056402120300b00530bc7cf377sm563779edw.12.2023.11.23.03.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 03:48:18 -0800 (PST)
From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
To: Christoph Hellwig <hch@lst.de>,
	"David S . Miller" <davem@davemloft.net>,
	sparclinux@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH RESEND] sparc: remove obsolete config ARCH_ATU
Date: Thu, 23 Nov 2023 12:48:15 +0100
Message-Id: <20231123114815.819-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>

Before consolidation of commit 4965a68780c5 ("arch: define the
ARCH_DMA_ADDR_T_64BIT config symbol in lib/Kconfig"), the config ARCH_ATU
was used to control the state of the config ARCH_DMA_ADDR_T_64BIT. After
this consolidation, the config ARCH_ATU has been without use and effect.

Remove this obsolete config.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---

 arch/sparc/Kconfig | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 49849790e66d..6b4d3182baae 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -112,10 +112,6 @@ config ARCH_PROC_KCORE_TEXT
 config CPU_BIG_ENDIAN
 	def_bool y
 
-config ARCH_ATU
-	bool
-	default y if SPARC64
-
 config STACKTRACE_SUPPORT
 	bool
 	default y if SPARC64
-- 
2.17.1

