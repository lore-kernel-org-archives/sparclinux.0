Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963143358AC
	for <sparclinux@vger.kernel.org>; Thu, 30 Oct 2025 07:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761808934; cv=none; b=DoLqwPsEE8DSv4/ttn8D3YpPC3xTc+SRpI4B3UOcB6SE498oCz6DSfgahkS99N8wrakJTpri5/Rbzp2QYbm1jwkwwdlspxysKgb5KzN8QQe6ytc+vsu71omIxxxuEXH0KPIcvFpq3VcLvI7DDEkqiF4pZ+fj8aD5sJ/qwaSJJao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761808934; c=relaxed/simple;
	bh=BK9QyNasA/qNf+VmxCdQRMf4FU+qlzDQIVRA+LFxeLs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eCN3Jm8N8Oo2sQgdtkjamUCmx5Vmbfxvf8JWL664QxEgU4FIXsgEJyC7M8/GImHVicaK5BqFxR7BRimpFa290m5LUAKBRT7qt79Am8Le5rvg8eWgAM7eZXxbE8e5ObFDhfeCrdNYPTgBqrqOXeX/3lZPHydrZ4Se2mUgzMGw4+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VeIBdFMO; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VeIBdFMO"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-292fd52d527so6931045ad.2
        for <sparclinux@vger.kernel.org>; Thu, 30 Oct 2025 00:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761808932; x=1762413732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N97xtuGiZGCwUUKE2UkiFj9jfFMfd7Q45BsFB44dQRc=;
        b=VeIBdFMOyNnzytW6z7wmEMpo4U4u9D3bbb02YciQYyYJBuMx8RZ0Xhedz1pVJEKtx5
         S+1t+qYNEwqQDDU1c65q7nZO1LAXELE8Qwl1eC5AYHqGy2C0qed4+T4FI+bIFxe7N/6X
         1mNGM/dMf5GWt108wPWBf9R+oXxpCDhK24/LPT3YEBeR/88Zc59pK0cjbaLpa1yIEqit
         q7OqYvv6fQbf+7a3RHVEA7OazvTxP4sPUnOSfAWP+BpzhN1xXJR3Rd7HpyQEU62XzYrt
         qlSR36qicwNVp84yhm4sLbGlJrreqNy+TGz8r5eXBWWX6byMXPfJv5/PgFfGbe5riOkf
         JPSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761808932; x=1762413732;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N97xtuGiZGCwUUKE2UkiFj9jfFMfd7Q45BsFB44dQRc=;
        b=TK7irg5U5pheu9SEQEo6I2Soj4yEp04eL6w5hdBf1ae5PmQK9g4wd5R9oDruCJfwjg
         n9ARyrs+R5LargLQZqSB9gzlSH1jdT7X6pKRu+USfO90+LzYqTF1SRfzNkL4nggqkTvt
         DlBD0C7nMeGQjSf/HkGLled1I9yRTsfCqg2pAMST7/IvwyB2zsiu8PTaITup+dZHcOxP
         PHyS81MB+jVOeTmWOwUBKYo3miOldU7uuWYpkVpcdqKA/qLcO/+2a2CK/WzHyU1oNPjC
         wI7fqwlDI287AwVvTy2w3OUQ6Vs8+xy+W/nXyWl54R3UZQuErNIp1U+mAQlu3ltxw6JJ
         NecQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRGsOW/dxmchLoDo1rHroNAWmdt+N0IC9kJquBpbTLptqcHpVcyLY5u7PY2ilpUKbuHZqCCq6yF3GL@vger.kernel.org
X-Gm-Message-State: AOJu0YxePBy/U4S5ADEKUWxbFrrtFaeHsJDvKMjiqC7mgRIYjNClk+sv
	YNHFZ0/ShVMnymWW+iBPetdumgAi0xmlpaPI+Af1kjm0XxbpFPHiUz3HN5RKeppDqVhp/A==
X-Gm-Gg: ASbGnctifUDa9GuweuUnnjseVimgZnknnbEjn6pOtSrS3OdN4OM2ki8KWAQ9rcRggjZ
	0oEf6R5oLgT0KfkfBSlZi14uXBj2KaPmGMIJN1XC24XQcahdXL7l6KlH2zM8Vd66Wxc8H+hG0mZ
	h5zAcGSAW0o5rW7xzohKelNQTf8vjuo2mPqNGH31YAk0I5ZI35ZAfAHejZ3iBGnhHhSoVqG+hK6
	d9PK8S4Y1LwZT2bkK2fgN6XwGeQgqq4A3FglSYmqMdjqZik7JJJpln9XnWvxqO0K4u9LwJQuTHV
	VAzHfhpRKt/grZfbZvOz3oHfGA7Bq/FUNt81fXjaqMLBefRFpdWf4tcjRKriguKKiU0dqYY+ld9
	+qR+2vZObLAnJaWtsH1+Kwe9Mli1Y/OdKMzCOA1BQRlSTJKDK/dmgfDI0zo463OKEyITFiHWRWE
	rafObeLhXDP9plpbJTjJ/37Q==
X-Google-Smtp-Source: AGHT+IEJzjadnlIxV5ulJGWrPrx9myLqREBJf1yyP0HpGFqWQhdbyL5hCkrJAnTltkMImoRPFo5a0Q==
X-Received: by 2002:a17:902:db07:b0:28d:195a:7d79 with SMTP id d9443c01a7336-294dedf4305mr67171885ad.5.1761808931687;
        Thu, 30 Oct 2025 00:22:11 -0700 (PDT)
Received: from localhost.localdomain ([124.77.218.104])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-29498d23218sm173814695ad.51.2025.10.30.00.22.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 30 Oct 2025 00:22:11 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Lars Kotthoff <metalhead@metalhead.ws>,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linmq006@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] sparc/led: prevent buffer underflow on zero-length write
Date: Thu, 30 Oct 2025 15:21:53 +0800
Message-Id: <20251030072156.30656-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix out-of-bounds access in led_proc_write() when count is 0.
Accessing buf[count - 1] with count=0 reads/writes buf[-1].

Check for count==0 and return -EINVAL early to fix this.

Found via static analysis and code review.

Fixes: ee1858d3122d ("[SPARC]: Add sun4m LED driver.")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 arch/sparc/kernel/led.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/sparc/kernel/led.c b/arch/sparc/kernel/led.c
index f4fb82b019bb..aa0ca0d8d0e2 100644
--- a/arch/sparc/kernel/led.c
+++ b/arch/sparc/kernel/led.c
@@ -70,6 +70,9 @@ static ssize_t led_proc_write(struct file *file, const char __user *buffer,
 {
 	char *buf = NULL;
 
+	if (count == 0)
+		return -EINVAL;
+
 	if (count > LED_MAX_LENGTH)
 		count = LED_MAX_LENGTH;
 
-- 
2.39.5 (Apple Git-154)

