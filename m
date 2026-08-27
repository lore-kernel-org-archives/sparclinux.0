Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67072BEFFD
	for <sparclinux@vger.kernel.org>; Thu, 27 Aug 2026 14:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787842497; cv=none; b=SyLDT/Vs4C32eoKnw/d7rtu8HQCsqrcm1WTYXa+YEySC1TXAduzLywu0oopGs3GnzHd7T6PA+pLRnLgaXvKN23KVOd38KCgRkrykTIyl+CzbLtfRK8CxCYmN/k7IckGAEi49oCqQN6m+rSHyquX40pI9fLgss3GW23owl6t5+tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787842497; c=relaxed/simple;
	bh=hS8kZLzke/hWnngzBIU+zb54LbfdhiEhmPlegZFkQ+0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iQ8c94y5fZ7+3tBjaVe0calXjbl0wvIV1gUimBGQ4p2ocqR5rJPBTxt2lHD+OS/lSRjHgBZIdK1PBbk0pGb/aW9FpJk06lauKoBVg24EpH3v43Js2r2djqSGOrZiICg+3YJtF5UVOpKefJdt9cHG2VNeD5yaBio0zX6foo/xZ2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PzOG1SGD; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PzOG1SGD"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2d71ae3455aso23116945ad.1
        for <sparclinux@vger.kernel.org>; Thu, 27 Aug 2026 07:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787842488; x=1788447288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=E8woUSV97warbSE8lybgrVZFJY5N1nQOSji8VKScgrU=;
        b=PzOG1SGDeY9lvzYQXUJg4UnDzP67zjdkNyPcA2L2Oi6ffbWIMDXegqnMzO5MTEQ3+m
         FJIFezdUB1K/zA56IzzbPhTJOQ/ep+U3P38h2E/mYW5Hk/wUr77BDbFHIsJ5V3VeZWHq
         LiTvPeRhu/akPIpXDjsjoiHXbNGldpi2nuZv70OzzAeJXMve/huzWXRVDG+Bwsrxl4dU
         tEu94U3ipkJmJx6w/kYNlryrPsJlfD2GVwJQEWbjiXltoIxvRzkrZ1zuHOeJ+7xQ3Jol
         tCQVICH6ql5Uy1iyfFqh+KziTO5+wscaH3UppetZQ8JiOu5pIjZWO2B5Fg3Uj2KbyldM
         o09w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787842488; x=1788447288;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E8woUSV97warbSE8lybgrVZFJY5N1nQOSji8VKScgrU=;
        b=g51fLhC8pmtPw58Ocp4QzyCIOurp0Or6eRMsF8wbG/81tpgvQW7avuQgdq4CyRl3Nb
         ULof8eES/bmWLMok4je8xfZkdkGls57FxOPzuIg0d11qAoQy8w7bhTUfSSU/UaDpKXS7
         7iyUxFugUo1CBGQFkTRnws7lpNxp8+CSAKB6/DFvwuBTOQYnpM4w6swoMDjpSDuHYDSA
         z3q2yJ2kp9nPSgQGkGlldSWFxYqp5OoQMIpyqYqZvR9KuO6iU6nkuvMAg/RAr4u89+DJ
         rEKmPlhxVYaiJ9+TceCG7NtHFvm51sI9kfPkkPL722j86HPopqDGjN10FBfHdy339sPS
         GWGA==
X-Forwarded-Encrypted: i=1; AHgh+Rq7ldDu3TTDx9S0ji5rFoFJk6umVgBoaWqX8jzdoG23SI/DD2nSuMhmDz2CUO5itVgDsH0MoE3hrk6Y@vger.kernel.org
X-Gm-Message-State: AFuF++llzq7MiT2MqpPWSz1I24Sn43d9PrRrX5NnP7e9nXUNO8SYI8yD
	/KnOHk3CHf1KY4hbEsx6jR2mQdszai6GV1eFFyXaF2MMgVq5bxqkQPBw
X-Gm-Gg: AR+sD1301uVlfVPcmFTVEh/FEZlHm9iMbCxDTO9ZT28QzrZ4XSQtzTGQUpeI9F8f/15
	pQ51zVAPE218AopXYSmAG5H33+yGgTdun9jNq13KFbd01wbL9yKVBVA9kEYU1r6qVhvEsBlztcf
	/HiYe+jQncXAH9wKWh7ACfwyzX/IJj8WOx2etfGq2KWuDSjdaOQJBzabfm2KSK9CoYmBxU2ww/t
	/5LHxa5W3VqCznFgS5z325G645AabsTRyZ7V3E05Au7lL6FbMLSbJRQNu3hCtcBIoXq5/OwHfKO
	5lDHGQ6ptQAWsonOKNwt8wDd6MSwm81iQY7RdW7IHd4UwulPPIrruFwk98975DYF8bv7TzfegRJ
	5uk5oeFuC1HV8HnHn7hwJHjB9LD6YjSwOQKgpGLFnk0m/FolBmgLCGYqLNMPxpOiDqJtBTcQfGa
	lQ274tE/9HwxZoqt5g4cV74zz0VnGRWUvHjgE4TCwYMxZMiOiCH/JuNkw=
X-Received: by 2002:a17:903:230d:b0:2d7:1e07:4859 with SMTP id d9443c01a7336-2d71e074bf5mr165600495ad.2.1787842488539;
        Thu, 27 Aug 2026 07:54:48 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d704b9f555sm18725405ad.40.2026.08.27.07.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 07:54:47 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: Andreas Larsson <andreas@gaisler.com>,
	"David S. Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org,
	sparclinux@vger.kernel.org
Subject: [PATCH 0/2] sparc32: remove redundant memsets after memblock allocations
Date: Thu, 27 Aug 2026 23:54:32 +0900
Message-ID: <20260827145437.490605-1-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

memblock_alloc() and memblock_alloc_or_panic() return zeroed memory,
so the memsets after the allocations are redundant.

Sang-Heon Jeon (2):
  sparc32: remove redundant memset in arch_mm_preinit()
  sparc32: remove redundant memset in srmmu_nocache_init()

 arch/sparc/mm/init_32.c | 1 -
 arch/sparc/mm/srmmu.c   | 1 -
 2 files changed, 2 deletions(-)

-- 
2.43.0

