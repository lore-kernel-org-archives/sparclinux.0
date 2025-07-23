Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1057B1C27;
	Wed, 23 Jul 2025 04:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753243678; cv=none; b=dx2A1A/qNSW2XloWJOlyVWziwiSXC89VEUQbBc/jkjp1OaTz1dQEE31TdOwjE3J/OflQC1TFwboE7S+FHJg0JqARi0siMdJ4G/twv6yxhM6r6Z3CxSzV/EBd0Lv4z3L5QLKJwS44rmBBJDfNOZGQBx/dvhuZEolfUPY0V4kE+Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753243678; c=relaxed/simple;
	bh=xZHtZS0JckMad7+tFzFfQDSUjXaD/A+MUSklKtRyldo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fY1lYweYPfg9oRC3XAYpwQPfZYDQQhaKf60K3t9NCsJQsXDA1+mKHr7cYIgnaCPU1sDsVtALSesvC5S4+v3Vola6bhp9cxOVC9+G0TyeDGwyglMKpPq1fyU512rYIhM2hR1ez2amD1EP7TeP95KdS+nAHnR+hrXQ3IVTocEa++g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TD1GRqZI; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TD1GRqZI"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7e35e27e267so7898485a.3;
        Tue, 22 Jul 2025 21:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753243676; x=1753848476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=12KLNYivQhpv7pZYZE9iq+e3zjxifQmuArDFwUaOqvU=;
        b=TD1GRqZIse3j+xHT9N/vR7A1+NZiYta1K8battLJduXIBYFx2HNPsbMl3LXIBa6eYc
         VvP6wjgDbCUpHGzMI4d1AYJ4f1vN5mw/iIAcju5SKoHidhoMSz/oWPTfct0Tu9JkH+Mp
         6sFe2QnTlu1Uzd2U0hJ9mnznFh/l7O66HMIamVpiePBvutdsfcZrw8QmuTD87i4DWS3f
         pB/LIfrvM4WrLa5Tynp4PXBm2MS9B/FUro63dJ3lCZBFIW69T71X2lRSjVP9KPev7XZW
         LlB7y7E2l4srZvMjhlPYUph8dPpECM2cZhRJvCBPdwCSps7xQe09vAO7wttDpmP7nInQ
         aQcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753243676; x=1753848476;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=12KLNYivQhpv7pZYZE9iq+e3zjxifQmuArDFwUaOqvU=;
        b=PNm1CCN+xVqWqu194zY0Ek7jBo7wQEB9IeaTM2c3Im51cf6Sirw0FKQWcD3I/98ftp
         Qdus0jtqSEbiBo1x/eHXIOQQAAy7p/5MRGw8+CIHLA7xlEGKcWJH6Zqhvum+eiAyQ4Nm
         nBZlOFK5+e9OB08PYgouvZYSEKw5qIB83VMfOpD9P0nf/byr+Nvbs8tfevnk4/h+UHES
         BpM0cSCNdare+sVm8LyZoCqjd62Sd4NOuv9haQrzrzyGNHyEAOUr9I3J/Gy7kcboDTC5
         Qaultql/XTcOf1VT+r6TjBeNQXAelg57xdqvBy+sbrIFSvhmCRhYQYhVGLfu/SA8JRDS
         0XmA==
X-Forwarded-Encrypted: i=1; AJvYcCVGlz812TotzLyTu7hApGX54wck8eZyPUgRK2V5xMM2nWDtOfUqY3oSvda5r8TobVjhKC+TaC+xM9DLQVY=@vger.kernel.org
X-Gm-Message-State: AOJu0YytIl8gbb2gMt39la0ma4XUqiPDYrkn0dKrzH86ryekXR8JMhRw
	2XMxFX3gdaJ93GIBrsavCpaHn08FW1y2dXYn+7aj5uo4o5ZQCMDcc8ma7VUj
X-Gm-Gg: ASbGncvFbek8psoUQxwct6foSfQVAvEmAlq8EEMPuc94YPuhJTLJZr7kaQfNlmFRALp
	nP+XR65S1aFHDPmiSNVGQFOulPOEL/Kxe+s0Y0ar8DcD1DvhhBMHXMhkgcJRSztPPdkEg0iFj65
	LnKHYt2S0MRk3L2ky3GOCffkSRhjJbs8Ues+VwkHGmnt+NeP2waVTbMpzebNV+/NS8B0qIkzGr+
	fy1juuuomne0PP9bYLHWLjAj5T6/kHLH4HM0VFOtwz7wUExYWH8fcxZxO1kfM32dD9zrvY8xPe9
	iffYwN4zetm7vr3Jqc1BEs6NDNar78wUNHg/C89xV/k+sLCcr2993C1EhaSNZbKH5FpT7XUAz5N
	5FjgkpaBb2Gevy1TeNHQ=
X-Google-Smtp-Source: AGHT+IEhxDJMCBPzYGGpHwWdwqeKk1lNjyn0zvXa+5lV6PJ+QiuUtIUfdX6Qlu2Mm9SFdzxNeHvrgQ==
X-Received: by 2002:a05:620a:1010:b0:7e2:ee89:2059 with SMTP id af79cd13be357-7e62a161c98mr79327285a.4.1753243675760;
        Tue, 22 Jul 2025 21:07:55 -0700 (PDT)
Received: from ise-alpha.. ([2620:0:e00:550a:642:1aff:fee8:511b])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e356cbfad9sm609270085a.110.2025.07.22.21.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 21:07:55 -0700 (PDT)
From: Chenyuan Yang <chenyuan0y@gmail.com>
To: davem@davemloft.net,
	andreas@gaisler.com,
	viro@zeniv.linux.org.uk,
	chenyuan0y@gmail.com
Cc: sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] openprom: Add NULL check for pdev in oprompci2node()
Date: Tue, 22 Jul 2025 23:07:53 -0500
Message-Id: <20250723040753.3231242-1-chenyuan0y@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since pci_get_domain_bus_and_slot() can return NULL,
add NULL check for pdev in oprompci2node().

This change is similar to the fix implemented in commit 9af152dcf1a0
("drm/gma500: Add NULL check for pci_gfx_root in mid_get_vbt_data()").

Signed-off-by: Chenyuan Yang <chenyuan0y@gmail.com>
---
 drivers/sbus/char/openprom.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/sbus/char/openprom.c b/drivers/sbus/char/openprom.c
index 8643947fee8e..e6f3082569fc 100644
--- a/drivers/sbus/char/openprom.c
+++ b/drivers/sbus/char/openprom.c
@@ -241,6 +241,8 @@ static int oprompci2node(void __user *argp, struct device_node *dp, struct openp
 		pdev = pci_get_domain_bus_and_slot(0,
 						((int *) op->oprom_array)[0],
 						((int *) op->oprom_array)[1]);
+		if (!pdev)
+			return -ENODEV;
 
 		dp = pci_device_to_OF_node(pdev);
 		data->current_node = dp;
-- 
2.34.1

