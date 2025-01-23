Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08138156F21;
	Thu, 23 Jan 2025 20:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737663563; cv=none; b=YJWqhr0pKZOMACVHN6eAKvVWV2beE3MLMs5D7C9gSQ6V7vx27Y5Sp0Dre/EnjvcPRcPguz1eJgh//7OxQJuT0+fmkSyVgn+xdxi62setMf5OZxPve4rrKSC6SvZmtaq9Q41AsQ/1FxbfoihVVFqJ1Y6Qawxi6Qf2r/4E4w5njvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737663563; c=relaxed/simple;
	bh=8qr2JXxfBXhrCbEGsUgvJxXsWruy8hUVJSoItKMB2X4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CbXnDu1R/vzR9hgiEXRx18g9DIkWwIea6Kg30/CL/B/jHsTsXaqVbk4CmNnupV03jxgpjH8uxpkK+wqCnoyxkuuWmDZqEuk2scQAvSMVNK1zZMfx0ggiKz8cAbqY1yZU0G98CLYOvvIijPl23ywa1QQTb6FeYkZSueod13ojoQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=krxGgqNt; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="krxGgqNt"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aaecf50578eso309989966b.2;
        Thu, 23 Jan 2025 12:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737663560; x=1738268360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r2aAj7wLdaZqYBmKdafu2HzpDkVVAkZP8K22bLqeobU=;
        b=krxGgqNtvC0ghgzcnqjEkoAnlmBvWOQIcyS3Jw+hixbBj1rT65H/hbsqo/SRlQXJ7I
         mdStGNLlDD3BHv/QV1QjMz/WFaDlLAPF7SmSj5L3zLdKm9OAhTlmCQ7E1gS/k2egaDlD
         ohp4QIpjg0NgqKgqlT+YfA4j0313E7yacTuSAKFdy0t52y2Brkxo6+rLSqA7s95FbM5Y
         in42dlIRF12pRspSR6S0DGI0dEcxWcYJvmLzbA2UBiUQQCcz5g6Q7yniFIyJ2tP4g/Br
         xwAiMHAHehCdhXLi/w2DSU5j7jNk4czVC0Cc45SZL5kZmejNUB/dqab4puUnk+BgPJMv
         f0Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737663560; x=1738268360;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r2aAj7wLdaZqYBmKdafu2HzpDkVVAkZP8K22bLqeobU=;
        b=CTMHO9emL97WoieqzTPJCnn7M5bxn+xA3fSIbslojvv4eEpJhQFc5AKr72Z3o8gFQ5
         55E62fMJT2d89rvBH4HrysvZHTygHLncLhHaaP+Sy25mVsvtS7LqB1aqaErM0AXoVSeZ
         ocMMgKfn6FGpKyMXvH12SQJam+zDcvUVAnoWtKF3rzJvyxVGUNK3KhXw80Xc+8TiIVA1
         lIY8YEEcseIIN5LqIA22g/3s36IqCwLMk2S8jiLKuqUC/R6FP/UEpWX2N6PEHW2iqjYD
         D49uqK26O4eBd6TzalIuVuMYo3vzB0mmKbGykn5jLeXGn69WNiWohtHvhYBHyGSXnLaJ
         UiRQ==
X-Forwarded-Encrypted: i=1; AJvYcCULM/a6wQX1fjTCO+4i3zYW6l/9scJpFY0zpVaKP8Vmu0iyUeci6b2f8j8diM6TEgXvoDp1VP6QLmfNB4q0HEw=@vger.kernel.org, AJvYcCWI4tz03+b5jg+e1OFifLhKtkAiFTX5TuWro6wDS5YGUGBWZgk3nFCxHmnxh3KKjyvYAq+YCY6Bf/zwyL5J@vger.kernel.org
X-Gm-Message-State: AOJu0YwEdKGj2iNLM6t2sBug5CoNaQW/wDU27k6Moo2F3PG8DIxZAGRG
	GcjYEGmXwoHBPUDaLbfajmI3nGT8O4WUKjlWDy7aQxk3VuzffkrV
X-Gm-Gg: ASbGncvjjoqq6mZ3tWCR95rQZPPJZ6SppUB7sMLRLW2VyLiMeF62KH7n4ttUHoYzqv9
	ummNBFUvNGE7KZFYVV6rT6qjVcIaPLnvuLmE5NPXLMOkXKq4VQf4IIFHjsBgv2RK6aP4bO3tpHZ
	PgujYYFwXfajbkQWPhl4+oIj+bm1qwnWREtvpH30vVJiUdHMr28fp/6Db1c6qNng1IPg4oVE6DP
	LNaPjQ4lRN/NAtnGfKDo42t3EpxLpkwZcvg7zVmqT8XlYpTDTIk74eUvbiO41hOdV0TIeigUFji
	Eqm0ug==
X-Google-Smtp-Source: AGHT+IFDBfcF3CmLGTVMjy5ifYEK4WPnyRILWMzNMfKZbcTDNuMRdlGfP43bYx5Rc0m5yRtqIcduYA==
X-Received: by 2002:a17:907:d1b:b0:aa6:6e02:e885 with SMTP id a640c23a62f3a-ab38b3cdcd3mr2468383066b.47.1737663559929;
        Thu, 23 Jan 2025 12:19:19 -0800 (PST)
Received: from void.cudy.net ([46.210.241.120])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6760ab2b8sm11630066b.123.2025.01.23.12.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 12:19:19 -0800 (PST)
From: Andrew Kreimer <algonell@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Cc: sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Andrew Kreimer <algonell@gmail.com>
Subject: [PATCH] oradax: fix typo in dax_dbg message
Date: Thu, 23 Jan 2025 22:17:47 +0200
Message-ID: <20250123201909.15469-1-algonell@gmail.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a typo in a printk message: copyin -> copying.

Fix it via codespell.

Signed-off-by: Andrew Kreimer <algonell@gmail.com>
---
 drivers/sbus/char/oradax.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/sbus/char/oradax.c b/drivers/sbus/char/oradax.c
index a536dd6f4f7c..3f93208b616a 100644
--- a/drivers/sbus/char/oradax.c
+++ b/drivers/sbus/char/oradax.c
@@ -874,7 +874,7 @@ static int dax_ccb_exec(struct dax_ctx *ctx, const char __user *buf,
 	 * user in between validation and submission.
 	 */
 	if (copy_from_user(ctx->ccb_buf, buf, count)) {
-		dax_dbg("copyin of user CCB buffer failed");
+		dax_dbg("copying of user CCB buffer failed");
 		ctx->result.exec.status = DAX_SUBMIT_ERR_CCB_ARR_MMU_MISS;
 		return 0;
 	}
-- 
2.47.2

