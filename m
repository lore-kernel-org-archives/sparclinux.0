Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E011B4247;
	Thu, 20 Feb 2025 21:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740086189; cv=none; b=bMmg9yLPdq0XZ+BqN7zCBQqFFqQWW3zQ0fT96CTNZPQLmGjPRc0lupVCzlZW3qy/40IWoe7CcyGVa5e1N2B+0zaIUgMRnr5XSDzRj7jgvJnDCxx3ikbfqTzCHuBeSjhjykSYENWECjq9kuFi7BwlS3UrJfw6yO1qwM4ZF/CEG/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740086189; c=relaxed/simple;
	bh=7GGLIIkYslbO8zRGVnXkb3WYURsjoiGi39cJNZNjmYI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VZVAsXJizqpNb7TxIwfhTXhSXSSFBETLOKoEOKhW3KLMz6gfQEUWmT3L0IAHjH5Bl8F2aegqDWaf8HEjaIqGW8I8+03FxvEq+j4ignqI7cnq0bVi+cEkLkSVv3GjqyLzRC3gXUqwIiCdh8u3bHnQCkAlpQDdd8f1d/cwAYjlKx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hCpHWCUG; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hCpHWCUG"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-abb9709b5b5so272204666b.2;
        Thu, 20 Feb 2025 13:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740086186; x=1740690986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=srsd8MylrS8GZUhwfYa6y0G3qneboWaJc/Tcu8jhTJ8=;
        b=hCpHWCUGSbf/5FjWqfrHGJJ9nRvI4dpHFdJZaCcCe6K80ZhthuxzGtFbE1TIvglQCJ
         KFIH/neEC49lcWP8pvUJh1AZtQ8fS8I+AKwaUr5HQKG2UVVTgAhJ/TAuGYkv9CbzLO0Y
         ogGkIWbBrdYx8vOmrUCvdeNaRJ+d6Q2IJLSEDlXYYE5lnvaLz06G7hBX0baH+BWJImhA
         jCPkvpEYc114xLAqCYXoDhD97SNaVzY8GflQvpTFpAVopsKeEVlRb6mPzEUbmYulgwIC
         bQdf6wd5q/KtlAQce6wEpPq10ZX5EM5lcmS9H3die4+UALpzJs1vEUbXP7mMzwhhTf19
         iyKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740086186; x=1740690986;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=srsd8MylrS8GZUhwfYa6y0G3qneboWaJc/Tcu8jhTJ8=;
        b=MJMzLdunrPdUfV7vJThoipQvoJf4C2EO0suDv5+wG9YKFHzJB9SVZfvjELJnY7zArF
         4xnkMlQBcqXhri7q76WPu+R/Lb6ISrQ89rg4z+ZQ+WgpQ3Sn1/ku/ZczoCi7rzAQW4Ix
         xT+8LGqdg8ckwMwImPWJXaHV60X9EPRf0pLkoHN3mLK+vVutAzQw1IwD6WBnKCek7+nY
         vXsWflbd+6AB2325My0G4nmfmHCOx4UbnzbJeDx4ddwfzWzFUJuZ6Cgxd9bSJHDEKlX2
         6RpS2ptDdbIX87JZA2CzT7U3WwDClb2pUGW99E41lbeutMC47QN6tcn54AYWdjKzorXn
         pytQ==
X-Forwarded-Encrypted: i=1; AJvYcCWN/LrWD4tXj6/S27lVkIV2AL1fTbseo72W5OAoKa0Y1gYIuTiYpjHsfqYKANClq6hAscjjwtVCyb/9UX4=@vger.kernel.org, AJvYcCWlwHvLwFmod9r9JlbpytmrBAZCEngqaNi0NWhZzA64byDPNJYjaue2hqKc3L2p2YGVFSmurgSz8p1aKg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzXFq5l+8uTi+KVx1AFnexKrmhbOgOI1vkNczzYxwYDUERqxQoR
	JyyapK35z64DzI04Me/lXJiRpD/UqogrK5p2d5x4XqIZ4Qi09tV3
X-Gm-Gg: ASbGncvlEKdQRlgJ/f6UD89ejWMHzkYd4X05jIU0iZtUvFPeMBtXtcIH9tCi3nZur2z
	ZcxrAvm3jBWF8mDwvFT15ZMwboyolv4bm7vES6ig1z1YlSo0I5s97noFtBArdYMqiHMakKJzyx6
	kZe0XOHnASxHnJw5OIxMuzQapXOBZbvGkhR6I+U6PqX1es7U/ydjFmGr202ILKKdf2DNTgCwwV1
	klNxhARXZuJdStNsg0WIg13ZZrjgvKCPsMOFl8WfErABNe86Nsd8RbeK1XWL1PF/bsreiGdspcn
	h2FVf3CAToc3scLXDAUNyznTEw5Qyl5X
X-Google-Smtp-Source: AGHT+IEUj/CgiGoiOl99Nkn1c8Zgw6wRPk7lBZ22xdnEjPyHKJGvYm7Scg5HRoMZw+0zfk1k1QFBHg==
X-Received: by 2002:a17:907:6e8b:b0:abb:cbc8:81fa with SMTP id a640c23a62f3a-abc09c11056mr97957566b.42.1740086185413;
        Thu, 20 Feb 2025 13:16:25 -0800 (PST)
Received: from localhost.localdomain ([196.235.105.135])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb9acb9acdsm855914466b.66.2025.02.20.13.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 13:16:24 -0800 (PST)
From: Salah Triki <salah.triki@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Salah Triki <salah.triki@gmail.com>
Subject: [PATCH] sparc: pci: Fix memory leak in pci_bus_slot_names()
Date: Thu, 20 Feb 2025 22:00:19 +0100
Message-Id: <20250220210019.138218-1-salah.triki@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

prop is a local pointer in pci_bus_slot_names(). It is initialized
by calling of_get_property() so the caller must free prop when done
using it.

Signed-off-by: Salah Triki <salah.triki@gmail.com>
---
 arch/sparc/kernel/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
index ddac216a2aff..fa0da8f45723 100644
--- a/arch/sparc/kernel/pci.c
+++ b/arch/sparc/kernel/pci.c
@@ -971,6 +971,8 @@ static void pci_bus_slot_names(struct device_node *node, struct pci_bus *bus)
 		mask &= ~this_bit;
 		i++;
 	}
+
+	kfree(prop);
 }
 
 static int __init of_pci_slot_init(void)
-- 
2.34.1

