Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAE51BD4FF;
	Thu, 20 Jun 2024 17:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718906250; cv=none; b=CWdDY97+Ja3uIVM1k9SemCpQeDLdFK8Psri4xhSbmRvjZ+QNq63gCKU70KbKlP52QQkfgGKvSlyyL7EPLUD8up6eh7DK0JKZeKDe3N65kxauO0XLxF+xDt7gXc5e3Bh9sV2OZPYHSjKkEzMJYyCOFgU9GeLlHTwCuxPxTC/sSnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718906250; c=relaxed/simple;
	bh=T5HCBT7hE6rw7jOLllKCodQDT8hDNoNna7/UPL4o8E4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jeWH/AXrGuJBZiz6PRDZWRVdL2G2iXjpVwKRHFgrgFMaxmqmytyJHyp6JI0Z/Ub+CXmYI0Z2GoN5+mibs09fnj54UDYs9+kgVAPlqO5H7dnGPwwQ2CxaBWKrdUFxD6ylxfHO8H/dgsAQi1iSwfQhUKbxMs7h7DHyjKPnzysqYYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ghrW6QSi; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ghrW6QSi"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1f992388bbbso10601075ad.3;
        Thu, 20 Jun 2024 10:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718906249; x=1719511049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SVPa52iej7DfypFk891Jp8gHmdO7ancy2F0FLVrhULs=;
        b=ghrW6QSiVcTFkuuMhy3wm8wpmT3MYIFHpftOn5GF6apmEKE/lKfBDatQPc1mhnpmJF
         Qd6Ri5vCgY8NluWR9Gn1rQLmPEp6ITAqNCAoRGzVX+HehBSWKO6bjL//zvGNzL4XPbsv
         oddsGJWjL12O+GGYocWJffP1o4N3gnyaIPyKrX6jrbNmLiHJpn1S+6BOCZKeBBmc1jdM
         wYIL4xncGABED2J8ETuh42esGPrq6tDuRUkDzkKVwx4TygAyZF08Gycdr4HKrF/3mSsj
         2tHkumZZIoB5du2OIWOkHmpXznaoHPJSi1cH45V+jeDdSWDHt34S9/ujx8lr044bOZC9
         Jm4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718906249; x=1719511049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SVPa52iej7DfypFk891Jp8gHmdO7ancy2F0FLVrhULs=;
        b=Cw86/myhN7YC0kWqbr/c30XQBlYhpCsPLVUukCkLIok43fMbpGXFclKKJVo+W7TDOQ
         1jCJXDw7iSRQSnUsacbzMaGRnRj6Jy6r4oDWO6SBeaVMNBpYw+Af31+2rxe1JRjCsPnz
         NikTzgvbFBhafsEjMIFP9BdYto9v2GiJcw41Q7uzII7R3mZkf6NacaEEd0UCgdOMHoI7
         X1WytKlGy6Xzj/7P+gI849I5vH1M96F2Gci5tBsd/5sGqw2isf0iXFJgHa1qVQ7fGRp0
         K6mhAOtV4wg8E3vnOREGQUBRB8w9DqRtgrl1l/NiAoAEtgh7caeoH1FrDod6xgqwX/2H
         /L6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVvl/xhTP8FW9TBK0pjRlM0GQHGSRdF3PYMpKy5HUeETvhwGWrqQ2/zWYtzofBAkG7oxC2ePuXbO5W28yYmPDPghXf/QFa308LzYQ==
X-Gm-Message-State: AOJu0YzXuMw+0F/z3briAzNR+YQ5xi4YpQv3t2blDFYM0eeUkeMpWMHk
	q1a77A2X00qFLMgPuuJwpr9u3YwsYfpiBDnXGGwEAZAKaaLoVCV3N9Cl1CCTG1o=
X-Google-Smtp-Source: AGHT+IHCdI+iyTAhfn6J/fOToFnwrUzAO2Rfv2J8npjgxO3dQFprACFEqiP5ctWW4UyOi6jtP+LZKA==
X-Received: by 2002:a17:902:f545:b0:1f6:f96c:2f06 with SMTP id d9443c01a7336-1f9aa473e32mr63554035ad.44.1718906248643;
        Thu, 20 Jun 2024 10:57:28 -0700 (PDT)
Received: from localhost ([216.228.127.128])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e5b85bsm140398935ad.32.2024.06.20.10.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 10:57:28 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
To: linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Rob Herring <robh@kernel.org>,
	Sam Ravnborg <sam@ravnborg.org>,
	Yury Norov <yury.norov@gmail.com>,
	sparclinux@vger.kernel.org
Cc: Alexey Klimov <alexey.klimov@linaro.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH v4 07/40] sparc: optimize alloc_msi() by using find_and_set_bit()
Date: Thu, 20 Jun 2024 10:56:30 -0700
Message-ID: <20240620175703.605111-8-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240620175703.605111-1-yury.norov@gmail.com>
References: <20240620175703.605111-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

alloc_msi() opencodes find_and_set_bit(). Simplify it by using the
dedicated function, and make a nice one-liner.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 arch/sparc/kernel/pci_msi.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/sparc/kernel/pci_msi.c b/arch/sparc/kernel/pci_msi.c
index acb2f83a1d5c..55ff78a8f37c 100644
--- a/arch/sparc/kernel/pci_msi.c
+++ b/arch/sparc/kernel/pci_msi.c
@@ -3,6 +3,7 @@
  *
  * Copyright (C) 2007 David S. Miller (davem@davemloft.net)
  */
+#include <linux/find_atomic.h>
 #include <linux/kernel.h>
 #include <linux/interrupt.h>
 #include <linux/of.h>
@@ -96,14 +97,9 @@ static u32 pick_msiq(struct pci_pbm_info *pbm)
 
 static int alloc_msi(struct pci_pbm_info *pbm)
 {
-	int i;
-
-	for (i = 0; i < pbm->msi_num; i++) {
-		if (!test_and_set_bit(i, pbm->msi_bitmap))
-			return i + pbm->msi_first;
-	}
+	int i = find_and_set_bit(pbm->msi_bitmap, pbm->msi_num);
 
-	return -ENOENT;
+	return i < pbm->msi_num ? i + pbm->msi_first : -ENOENT;
 }
 
 static void free_msi(struct pci_pbm_info *pbm, int msi_num)
-- 
2.43.0

