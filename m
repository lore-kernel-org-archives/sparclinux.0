Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C521E487;
	Mon, 23 Sep 2024 11:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727092689; cv=none; b=h65u1ypLOETtOiNQ3STBGCy0JQmj3DydNvRn2cp47TYr5PLlwA0VL/sNZUt2O05UVFOH0ckwXOK73oTGEaHUJEPHqMLuAJ/TJOkxnPtU4M7a0GIgxEgVkmFGAsCfyOthzrENdhCgkuwAYy6CFHcmOMJO2ggjKpuJ2S+cJsvZQmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727092689; c=relaxed/simple;
	bh=L3zeoFmAIIXDXWSfU1tSlP2ph85oqLVyrbsXzLRnnZ4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=De4wm0uUqQ56BmnnTlr4o07abv5DOvHaTefB3JlZvVKXmWJO2Bbr8sF92UP2wI+JheBld8aZKYKcOVVi2QgPc3rdnbaDKPzkoXoLTvDPw6zgYA1fNzpwdLqrt0oiffIwseYjcb4kdlicSQmesBFNgz1Z6tdxNvzYdS+RQXw8pzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OjH68SXd; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OjH68SXd"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a8d6ac24a3bso15309666b.1;
        Mon, 23 Sep 2024 04:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727092686; x=1727697486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Gx23M8paYAJhY6HQhk7rOEMPFOSG2hreLD2XyM5Mz1I=;
        b=OjH68SXdaE3ncgOJN1xVtTwIJxxVrZ3Mmms4qkJPs0bAlauhoZ6qmZWgDFbRQio8mE
         6fD5cgzl7KWvw3eM2QCVPpVl8jqY6Fmlaiv4TqTQR4/CQkOeSTgf8adAfvRteX0Rqq5Q
         AFX8XMz5aZboGVeC/eKJ7vrouzd7KwFd/05FBehC/oc0FmkoeI2Y8JrhQ4nu4yGiaUyI
         Js777AKPP6Wu+J4d4yqasyo8VcMBv3OuyToIMyOK8pNqHo4eFZ93Xdlw743FEywnBY0u
         LlRISP27QPthe6ffSxx9zcB0MvFkrviBPo87ADRwjiAPTJPAIRWBssLP5HRrtgDtRxOR
         DtsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727092686; x=1727697486;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gx23M8paYAJhY6HQhk7rOEMPFOSG2hreLD2XyM5Mz1I=;
        b=oJqaWnuUCqIv+wDp7XAOMXZeQTq9kLl4T5OrSIKgBBJSjFb0lMe4XtlREJMRggNp98
         1aQihvmp2qb8KawbCQNHFZXwfPeKoNLhVWUUeNkEHkMHnTBotQ/F0Tsa3jXW1ziJlJpW
         030iw9N8POr6MN5uhVCqv33/MWrywSgQ8HJoLvCQseBVWXDZYJ3KmXcg+qukiy13FhZY
         vwclToTiOdRRj+KXqzezAzwfbeGPvuaK3shwFKP9VSNRUwGJ/4A1enSgiP88iLaqlwjG
         m/0lYaMNBTWbc05WmlCIUAwrtK2kpLug4UNCqhfHzxLi+Qt12cnbilEJep7ep+sq1SvQ
         RfBw==
X-Forwarded-Encrypted: i=1; AJvYcCUV4tzrrrYSeibmGyvdmXiBiTGUC5atokakNWBUdZYU199+PT6JHt3EKjKXLNN9bbtzPlR3TNRKih9neO0=@vger.kernel.org, AJvYcCUX6JqPrZDNBedoA1EnvLXVKh5dlj4pA7J1VWs7TTtzkzSr0mPlp7Lp6zhBVFU1uOYjXrJ6zJAG1srZJw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwovX4gU9xg2whAWG2FuFvmfnEr31ZkwnI74AgljHtb+8XQRhlj
	r8CCx13gPx+XWupKHDKACiiXInL8hlrIDRaPyMvCX//iGvAaYuW5
X-Google-Smtp-Source: AGHT+IHAm/Nn+89z+Op4B2/Etymkgok5/SWK+WDNKeN9yfOL3atld/KjLQBYFWWMLDgxXcvUw3pCWA==
X-Received: by 2002:a17:907:268e:b0:a8a:754a:e1c1 with SMTP id a640c23a62f3a-a90c1c73fabmr1622152666b.8.1727092685579;
        Mon, 23 Sep 2024 04:58:05 -0700 (PDT)
Received: from localhost (craw-09-b2-v4wan-169726-cust2117.vm24.cable.virginm.net. [92.238.24.70])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9061331b7csm1208179566b.225.2024.09.23.04.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 04:58:05 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	sparclinux@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] sparc: leon: Fix spelling mistake "wont" -> "won't"
Date: Mon, 23 Sep 2024 12:58:04 +0100
Message-Id: <20240923115804.836547-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in a prom_printf. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 arch/sparc/kernel/leon_smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/kernel/leon_smp.c b/arch/sparc/kernel/leon_smp.c
index 1ee393abc463..0a33db5e35bf 100644
--- a/arch/sparc/kernel/leon_smp.c
+++ b/arch/sparc/kernel/leon_smp.c
@@ -135,7 +135,7 @@ static void leon_smp_setbroadcast(unsigned int mask)
 	    ((LEON3_BYPASS_LOAD_PA(&(leon3_irqctrl_regs->mpstatus)) >>
 	      LEON3_IRQMPSTATUS_BROADCAST) & 1);
 	if (!broadcast) {
-		prom_printf("######## !!!! The irqmp-ctrl must have broadcast enabled, smp wont work !!!!! ####### nr cpus: %d\n",
+		prom_printf("######## !!!! The irqmp-ctrl must have broadcast enabled, smp won't work !!!!! ####### nr cpus: %d\n",
 		     leon_smp_nrcpus());
 		if (leon_smp_nrcpus() > 1) {
 			BUG();
-- 
2.39.2

