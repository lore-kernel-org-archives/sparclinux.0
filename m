Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795685488;
	b=MilPtsCVv2AuhOjwbo56Kzgzrc3gAKXD6S86sBb0Gq8BstPv5JcW7XXn1UVeXhutjKgR
	 rVCk1FnMpWPM8Qb2AT9AIck9h1k5RYgTMEL7LZC7mBE2/lCyAsCwrlzF4mmsIqw864+nc
	 9CWDlez2tQKPTMoPssoy80+ZD0arh/aXaIwAuK5K2E6AEWHqaSHOgxLpZMPKb9UlA8GzC
	 PpMvtW83CX3XHo4aZHdbMtttUnM/tIsF8/BrZ0HRhz8jzce9BZiEP7s6HPQrfEDesMkYo
	 hJNrb4AfzdBkuoMqtgLg55DgUbbVFTPvhIgkVhplE+S+CLc5b/rz2c4/ogvTkkoYfNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795685488;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=fTfPWmjdXcR29q4OjFYAuSBZvUxhoQbc+hR0Ja7uEF4=;
	b=vAz/RBGmTjk8pJ20GE9yrnK+2RfXTxfhK7UhnR91JcUDY+7ZLCWMbDOWCV4teS3s8HpQ
	 EuEeFF8/q3Ek2Qr7HbMJMNbT7oYCGV0VDPsHDI1oWdxuUmzla87ISsJBXeNflW1fHZRg6
	 Sy2Mc7xz2FGrhyZ3CckR2vbIz/1xlPH44n8lNVvtNz6V/WWFDh/ztkLC27J7nKmvrYYkx
	 W2Nn7Cc1NiU5Ox7vV3qWXxrQC62ymAli1gFDjC7/mm3Mk8OvpytcFkCXirAb1ecFSHtix
	 lya7wHLjJM7t7lZVHbG5Yc/RfW+jTIlnKF1nI4wUcnf9B5oOPVN1KL5+QhQbzgUtEPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AorVr+io;
	arc=none smtp.remote-ip=209.85.218.52
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122F8606A68B
	for <sparclinux@vger.kernel.org>; Thu, 26 Nov 2026 09:31:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 122F8606A68B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AorVr+io
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c516a192844so681674266b.1
        for <sparclinux@vger.kernel.org>; Thu, 26 Nov 2026 01:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795685486; x=1796290286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fTfPWmjdXcR29q4OjFYAuSBZvUxhoQbc+hR0Ja7uEF4=;
        b=AorVr+io/iVoZGf0WuIbZnbRTh8K9Mjy577xNhiHemTOtUdfqxvG8R0gxb2bruBW5w
         hAfdNq56amrf2kABnfwjiKl8uvHt1tl3DepaOUKRVq4K6KKXuk5rUoSH7TP1ib/B00pQ
         zPPvuGF1gG4crsGZZWonpt9ELxAywmeSTrQTnQvTQpCBT016ZBreEyY9Dqz+2CaR20XB
         NFXId2jK9YzyfZBFrr2gdxdF+0C6fk/XBmj9T8gIkziR8a3+Xg2+9FcOaAHQW1pXMSWa
         ZULX8qfIV8wqL1Pu7DYgCNuV0AG4PXTUK1mhCLBuHf+sg8bJigGASttHUaHI+yflse6n
         Bk2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795685486; x=1796290286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fTfPWmjdXcR29q4OjFYAuSBZvUxhoQbc+hR0Ja7uEF4=;
        b=CoFMlT9oW89aX1lKdj5N/sVgsu9c9qtwzQfwoY0FK4wASpiLmaJy6VWOfeDwxeD2c9
         QI7QMTyiraDaSEDjNaSsE8B7vCMns6+3t61j45q5k+ocSH4cN3WD7IYl85aamtsVgobk
         GGtxaZZYydD1lIPbkce48BzO9e012MJqt8tFpYMIPXCteafiS4GfDovGjefuThYtik8c
         FnpHFbOVSBqfRvpJLkfKbLE4c60WJd2KWqKYQuOu9QqciIYJtfLBr2LVYfN8Q4HVM4qp
         men5iBjxXa6uNuF91Pzp3dohXBFycp7la0t/xuXSiK10cBhHQyEpUFaB6S0hUJpjK8ZR
         CpQQ==
X-Forwarded-Encrypted: i=1; AL+hErHdz01OWFVpkZ/crDqq+FQicpj3ZT5JqGUIfCucN71QBVGKTlQbody5Kc7FIjf6tsIPUC8FGhjz8l/w@vger.kernel.org
X-Gm-Message-State: APuU4Z+zCjT8qavQ1XqyU1/Vv5rg5Se4gfcz0LW4ATG1XSq1/a2aYZCY
	QC7an7H53a5h5+i9WinBTJLsnuhmJkgBEk2NDoTvulp8G2B5PYPhDNI0
X-Gm-Gg: AZFdTZeFx1H3+CaYR/NxbN64G7ekXNl4iNPVwQXhcO1j4xt02XsW5tVkZhxP5X1UDRV
	MUfvV+lIh/atUq3UzzM8CuooBd1AIwi6LwjitgWsmxRFd4pf+ETObQxjoFKU1hnKzFui5j3UnrU
	m6uQXj4undS6iXjmmtBS4zh52XDO2FYJ4NxBfsLhuLHPcVYpbsMK3pkSaepx1wHvzPbV0yK38Ui
	sMEIvdzwfz9rFJdBEmEKYfJYUONmPK45cEdOzTUmLCEdZAnafPT3EUYC705AjGqnAmjoACybNJ/
	TEUrm6rLBMp+qLNC5rcGBpsuxDV8c6EVD8cWDCvOxPlRMWySI3YcWcjehdQzgCsLkDMjHKOKc7x
	oTIMIpkR9RIxjmLCYqFo/bwWrUyjIf3oZv4E2VTKqgroeuCeuhIXIBIaLPDF0XL/HrRj9mZqE6Z
	vjBO/1k/74L0s0jOnlGksqIsJWwbrS1rwY6wy9P55MBaQbVNlrbJp1AAD9T8LPstrAtihRiJrCY
	3li8UXXKfOwXX2YPPkjNwpsUlMrNl0iORzN/X0Tn92aQWFL0D7c7Q4ers9z6UX4rNKQ4VMVSkSn
	AUH0KMewJ3TJaL6XkdmGgPX4FTZaaNksEWLdqJE/uBjz1Ojfyr1wReDFB2yuPyh6UpzZ3d4=
X-Received: by 2002:a17:907:3f96:b0:c50:4a70:b7f5 with SMTP id a640c23a62f3a-c51961803f5mr605032266b.17.1795685486472;
        Thu, 26 Nov 2026 01:31:26 -0800 (PST)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513afdee82sm597090066b.66.2026.11.26.01.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 01:31:26 -0800 (PST)
From: Magnus Lindholm <linmag7@gmail.com>
To: davem@davemloft.net,
	andreas@gaisler.com
Cc: sam@ravnborg.org,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linmag7@gmail.com
Subject: [PATCH 07/18] sparc32: skip unavailable PROM V0 console metadata
Date: Thu, 26 Nov 2026 10:30:12 +0100
Message-ID: <20261126093106.1345825-8-linmag7@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261126093106.1345825-1-linmag7@gmail.com>
References: <20261126093106.1345825-1-linmag7@gmail.com>
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Post: <mailto:sparclinux@vger.kernel.org>
List-Help: <mailto:sparclinux+help@vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:sparclinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The factory LEON PROM has a character callback but no pv_stdout.
Skip V0 console discovery when that pointer is absent, leaving explicit
kernel console selection and other PROM versions unchanged.

Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/sparc/kernel/prom_32.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/sparc/kernel/prom_32.c b/arch/sparc/kernel/prom_32.c
index 804ca0b2a5b5..29da4e682acc 100644
--- a/arch/sparc/kernel/prom_32.c
+++ b/arch/sparc/kernel/prom_32.c
@@ -223,6 +223,12 @@ void __init of_console_init(void)
 	phandle node;
 	int skip, tmp, fd;
 
+	/* Legacy LEON PROMs provide output callbacks but no console metadata. */
+	if (prom_vers == PROM_V0 && !romvec->pv_stdout) {
+		pr_info("OF stdout unavailable; using kernel console selection\n");
+		return;
+	}
+
 	of_console_path = prom_early_alloc(of_console_path_sz);
 
 	switch (prom_vers) {
-- 
2.43.0

