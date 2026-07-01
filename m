Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757DE38D406
	for <sparclinux@vger.kernel.org>; Wed,  1 Jul 2026 17:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782926351; cv=none; b=ToJA6BsaaEBkMlXQF3+RqVna04DaP8o3O6+ZeH1Br3EGZocd/qNUbrxUsEouG+2UTClHkDwFckerNdO8V/xqzVy9hfHmYFQK49WWT32YPSdX6qA1AuYsKw8ha9Th320bDauja4TNkNafkFAVUP5PCII/WZckO5hlbYEkjmy4DE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782926351; c=relaxed/simple;
	bh=ahyPZsMst/9tfuL+16OnxAWbslN1zw6+ly9UaAsXotk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PeVNBVhH3jCjFLBWNfE8oyaQ9Py4AM+bIEkflgIATSZZPDbSr1oIph8OVXgQF4BcoIyTQtEh7jUDExRm9sXkRxB/RhV4h/Z8LOJMgtZ/ctaqWeU4VysbW0BkWUyOlRD3nmIfsNG5ipknLtwnGrI9yTtpU2BJT5jNtp+PuVynB20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UttZ3Pir; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UttZ3Pir"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-845ea8924a2so473741b3a.1
        for <sparclinux@vger.kernel.org>; Wed, 01 Jul 2026 10:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782926350; x=1783531150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MDuqDP6jfkHa+poyWLUCQVCh41lLbreNnwDZhuoCFhY=;
        b=UttZ3Pirz8UKOtZ9jt4H1hh7RcuzBlJmrbqs6HdphTiWqUOoLiS0R9APtt0p2j96b6
         bj3pnJeT7c7FADuJ4t8gPl0IltjwSWbSbi6MlcaQ3WaAJMUaj9wLRhGEptcroSUN98XF
         sSGLqpnmUxUZd9ebxwElIHzDOHY8mG8znfEK6sSdetgtZ421Pk53RgSojud7L/HL8yKR
         sepz+LinsG8RN5flwQzfkFNHTRmxeeHInIIAqe8qMmF1mg0AuTVP74JGcNCIV4TGF+vq
         5X3DTPLGif2coJ2G9rE4GjY3+VqZXOQwU30Sfeho1j5QFymzOEMkX9EwLtfK8tjx8Foc
         D0VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782926350; x=1783531150;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MDuqDP6jfkHa+poyWLUCQVCh41lLbreNnwDZhuoCFhY=;
        b=ZOJqSp1oU5YONjnXnPWifWNUJaVi/ImetCmIh3raOWSENvXO5LXCXtgCWfWXPJKX+d
         t2E27pd3MuwwGmg/j1H20+iAHCjXlRHMcK1KKImRbwAET2aS0wzNRWPxBy3dnDyY3283
         MGOHoqD3cbtMw8e2gUh5rhj+TUVv/IAPCnGXlmXvi40SutGn9YjBA1+g0vHJ/xFes5w0
         f1lmJwEqT7Eep7nJL0QV4F/BpHspbstM6/dK5EAXvtnu+wf5lzcFkuGy0BoftSJhhHzz
         hMXI8cu2ihfe8kMtxOjVeyXd6SfXqhJVAedIj8js8Lc2g62wlM1d/13WXTe1cj9MhIkr
         rVPQ==
X-Forwarded-Encrypted: i=1; AFNElJ+iFAyt3wGWjgDT5ivqtFMBccrGWOmiG30wjNsblQGtahc4n0s0qRyCDHIMym0UEbZbHc5dpWJ4oByH@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr0rTNlKoHH5BbTz3ERaDMjR1UDABJuuDslGRLjOCsF1Cnc4PG
	guGeMHgcw3AkfFhLqEI2agYZbtJ2o0hrYWAvUJ8Rzalu1ayXX3YPvjar
X-Gm-Gg: AfdE7clrme352svGL4KsQ9PVlEbWxZK1NHDaYEoBerYbWGN6VBjZTWeBx309ioBcfSl
	47qmPH/ppKQKpldeWSbUlTQFwoBGtQJjPh7gownszc7qgHRkPwGymaBh1Yqtjw27X8Xzq7HvWju
	4WTRhJnIjITxZAI6zcMyy8Vbc6tDLJUxwS9g3DJSXDGUfI6ZxegaFsEXHS4semyuW7LMYMLz3lq
	90/j6tQFotQCEiJ85tcFKBrKZ3M4TPDqTXBgz3ky9pzlhdJbVVN8C/6f8ZCYe3Cxk/CZwiwVPVz
	mSIc7JtNt3OdY/lsHpOiy4yxf7wnyynrISGi6SAzBx051URNvv1RQz3ViWTGrGxEPh3KD0nuV8m
	mRBMC7+dyts2W6ZrCWQGV+Jeclcq07PJQgrLPZ8gyDyANmkAkA6od1zLKTSrtmvV/g54vAmKBaR
	oxqbe4+uE=
X-Received: by 2002:a05:6a00:4b04:b0:845:e97d:447e with SMTP id d2e1a72fcca58-847c07449a7mr2509329b3a.26.1782926349508;
        Wed, 01 Jul 2026 10:19:09 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847cb94ab79sm105719b3a.31.2026.07.01.10.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 10:19:09 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: akpm@linux-foundation.org,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Cc: linux-mm@kvack.org,
	Sang-Heon Jeon <ekffu200098@gmail.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	linux-kernel@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Rich Felker <dalias@libc.org>,
	sparclinux@vger.kernel.org,
	Vlastimil Babka <vbabka@kernel.org>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Yury Norov <yury.norov@gmail.com>
Subject: [PATCH 1/4] sparc64: set node_possible_map in bootmem_init_numa()
Date: Thu,  2 Jul 2026 02:18:48 +0900
Message-ID: <20260701171851.2447626-2-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260701171851.2447626-1-ekffu200098@gmail.com>
References: <20260701171851.2447626-1-ekffu200098@gmail.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unlike other NUMA architectures, sparc64 never sets node_possible_map.
bootmem_init_numa() marks all nodes online and node_online_map does not
change afterwards, so set node_possible_map from node_online_map.

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
 arch/sparc/mm/init_64.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 103db4683b16..a749f63568b7 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -1559,6 +1559,8 @@ static int __init bootmem_init_numa(void)
 		else
 			err = numa_parse_sun4u();
 	}
+	if (!err)
+		node_possible_map = node_online_map;
 	return err;
 }
 
-- 
2.43.0

