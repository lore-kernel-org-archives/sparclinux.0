Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712EE127B56;
	Wed, 10 Jul 2024 09:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720604526; cv=none; b=k5RyUz6hUrTr57eMeTRbhAXQiwY097eWucjuG+XQ+kS9nRb/32iINVOiW2TymX49qXNUNBQoYqBNhLmE3zpKOPNUFbGGUFnVFsgxjL5qncaNiEVvXwlHJWE5v3Qutk0iUZZEDgdNiPNzLlm/YL8JT9U8bmLa+8twrOOaiMMOwWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720604526; c=relaxed/simple;
	bh=KS+qvAx1EoGG96GjQqClATf/z1pU9qcada1WDpqWhfY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=HJw/FoLf9WFcSLagfVHBwFm8drQYGMP1b4dshaJ86E2qsBvNnvHQABausD/UACtKC33DTqloycGh+7j+a9iSTsnkSQSjREp1Ag75njbhvLyZiI3BjQmDr3KDgSE1Y++gf4yLIJWrbgaMaBbKRiRF4zJrgzzCZ6htYoZZVFuJHI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=HyYVSSTE; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="HyYVSSTE"
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4WJtDS3jxPz1DPkM;
	Wed, 10 Jul 2024 11:42:00 +0200 (CEST)
Received: from andreas.got.gaisler.com (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	by smtp.simply.com (Simply.com) with ESMTPA id 4WJtDS1lmmz1DPky;
	Wed, 10 Jul 2024 11:42:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=unoeuro; t=1720604520;
	bh=0cD+Z41g0piXbmmhQwTaymP7pDZpu9QQXg7EeO0YG3Q=;
	h=From:To:Cc:Subject:Date;
	b=HyYVSSTEVFNoLaifc8XKta1f0GFxup19kLIm35T/wySoS47HFPy2iL54i7slHqPsU
	 C1yXf0e1uPiCml/ew6NPwBOz638ZDYerFuQsW1hR6wCIXGKEATuCV4pHoQMs+oSc7d
	 j1V6uf+9YpE+QxuHLJaQxona/aOMbVGJ1evmK7HQ=
From: Andreas Larsson <andreas@gaisler.com>
To: David Miller <davem@davemloft.net>,
	sparclinux@vger.kernel.org
Cc: Sam Ravnborg <sam@ravnborg.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] sparc64: Fix prototype warnings and out of sync function signature
Date: Wed, 10 Jul 2024 11:41:51 +0200
Message-Id: <20240710094155.458731-1-andreas@gaisler.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch series fixes a number of prototype warnings as well as fixes a
function signature that has become out of sync with its caller.

Andreas Larsson (4):
  sparc64: Fix prototype warnings for floppy_64.h
  sparc64: Fix incorrect function signature and add prototype for
    prom_cif_init
  sparc64: Fix prototype warning for prom_get_mmu_ihandle
  sparc64: Fix prototype warnings in hibernate.c

 arch/sparc/include/asm/floppy_64.h | 5 +++--
 arch/sparc/include/asm/oplib_64.h  | 1 +
 arch/sparc/power/hibernate.c       | 1 +
 arch/sparc/prom/init_64.c          | 3 ---
 arch/sparc/prom/misc_64.c          | 2 +-
 arch/sparc/prom/p1275.c            | 2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)

-- 
2.34.1

