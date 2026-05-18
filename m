Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805CB33AD99
	for <sparclinux@vger.kernel.org>; Mon, 18 May 2026 23:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779148606; cv=none; b=AX7FsoeNiid90rGZNJQU+tz3ikMFIr/ArA7Q87i0Cnu6tbnjpZcHVhuv7PLBihUWvdikme1/pNAoqs10/DoApv4rNa+22J1MoCgyB1NSj1wNL1uNjiuSfYckkAzQp5zlKGmPF7l+Ovv58mNIcdo7K2un7U1gnDVQX8MlKE6e/TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779148606; c=relaxed/simple;
	bh=ETAPReuH7XXyRe6R3ZhrkUS4h9qrbkx5IonWV1VnUVs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RL0ddYN7sl4gAvO2rtNEwiDJ/Ph8o2yFYVUYzqRnWGY/pbVYSpiCcSL0asoEf01MJX9v5d7HjCf4HR/AOsdX2Ksz+S5UQN/UgfS+fWrKuE7D43+APxdrjnzStOUPSaVTSWlHikvquoj1cT9LLN7bVOF4DvT+zzZKfTDcq9muYM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Te3cdoQE; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Te3cdoQE"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2f36da5c8fbso2637149eec.0
        for <sparclinux@vger.kernel.org>; Mon, 18 May 2026 16:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779148603; x=1779753403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cl1a+XGpLPxspGSZgdM+QSxe+cRFXtFKMQbqP89OpSE=;
        b=Te3cdoQEX6iET2xl+CKzUFwM613W4vfHvjOuF4Ed+WnkIjw4c5p4TSSqQUU85LgPvU
         w5x5Nxf4xN3SoTW/W9NAmj+VRymHF6UgeueXvNcL5kdp6JPeJA6eMAZUx0pWs9LADqu3
         hqHNIJgvS1d02tEoYgNijvX8qvn7QUaLpmf6cl8MJ9sxd5K7jl6ffvpO+2F+2Edzh3Yo
         wN6M542krfMVkScSfEhd1xCZ3CHuNk8xFEd0pQahFZZCgC/IBu5ODCgyU/ydghtDndpH
         ELmibeDVuWmF6Yhwz8HXHt3FVJ3HtRDcT8efwc97WdeDKm84wZzZWxPqfpVvqcwxtAPU
         KLxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779148603; x=1779753403;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cl1a+XGpLPxspGSZgdM+QSxe+cRFXtFKMQbqP89OpSE=;
        b=tF6dVrlHYUruZtvsD+VKsF1okmPs5BPiD3j874SQa3jv7gJ05tqSFuFK/UEcHhU4+p
         E1DJZxBYbkNnBMmDfRHzQ/SzlTrtMvd7H1mcedGPWTSKemc/nGcvQf41ZUg+BNZaYCFz
         Yx8f3RxWCZ3d6oj12uupuabFfE7q4QcvU5LPIH5Kh9z15D+FrMU15/D8G52Sxy9DYLKA
         H5UEL/QlXv3H1byxOOdWspJXxCJmifr7PLTOgDuQrmSHnhzpWCHp3+vNaSq6OOUDJary
         RCDKk6H/ooBe2W4OgMX0Hcp2R71FlNuV4rd23ljI9SesRACoagHnBLkbTw2pE5HZiUwB
         KGAg==
X-Forwarded-Encrypted: i=1; AFNElJ/fResEAotCoXcs2kQOcIpedQsAHqR2oUdSs4toHPxU2Z7oqDDN63RWcSNBnWbhg4fZKWOV0J5DEvnp@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6HizZtlAkuuu+GqB5Fb3mmPBcgcBlEBhHJXnZMBixNzJtUDjx
	rQLq+xZBKQhFJgurB66BUb/cweGXg29dCaZPaUqaIB4Gt9+H6x79Yd65
X-Gm-Gg: Acq92OG+hupaagho483AbvVIYR5j0fiQIrla+QbxCODmY+pg7NSRgchrLlUDF8yo9AQ
	yQyu6a5/79iJrhIIVlOuRSjtiusgCutWiihHlCXu142tNEHIA/Ti4kwAwBiJDjF/leBS7PjvvMw
	p4AQnUVH4wzJ9oEMXhvh4elcToqYnqYF1qu3bWi0l+1dSVmrr6cw6bXwNIKnAA6FLiTlG0klsaG
	zlE2BbEY7jeCbRT8QiClTsMEM/H+ucZ8b7gmY+hhWGzW3aNgrOFp9yzIkLjGO8ji8xQodkYCXYN
	6BE1iwxT0oY0dRXydskFWrKPGnwxLkhrf8qODmqzPXiYG4HjhG2lBaMzjzIBh4uhLTAHEEpeUk3
	3B641q4w7CGhJSTNq/FCL8WbrzeFVpZ2Mc8prc003M/00I8i7LVeWI73MW0KHIDC40TVWo4tbOB
	HkcKwIFkMFeiocdnuims7zEUi213tbShVrKC+S
X-Received: by 2002:a05:7301:608a:b0:2be:833c:149d with SMTP id 5a478bee46e88-3039869d771mr7418455eec.28.1779148603497;
        Mon, 18 May 2026 16:56:43 -0700 (PDT)
Received: from s7t7-debian-test.local ([67.170.89.46])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30294500726sm14141408eec.10.2026.05.18.16.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 16:56:43 -0700 (PDT)
From: Tony Rodriguez <unixpro1970@gmail.com>
To: davem@davemloft.net,
	sparclinux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	andreas@gaisler.com,
	tglx@kernel.org,
	thomas.weissschuh@linutronix.de,
	regressions@lists.linux.dev,
	glaubitz@physik.fu-berlin.de,
	linux@leemhuis.info,
	torvalds@linux-foundation.org,
	Tony Rodriguez <unixpro1970@gmail.com>
Subject: [PATCH 0/1] sparc64: Fix tick/stick comparator equal-compare hazard
Date: Mon, 18 May 2026 16:56:02 -0700
Message-ID: <20260518235632.5122-1-unixpro1970@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

sparc64: avoid missed timer interrupts when comparator equals counter

This patch fixes an equal‑compare hazard in the SPARC64 tick/stick comparator
logic that can cause missed timer interrupts and stalled hrtimers.

Full dmesg and crash dumps:
https://github.com/unixpro1970/Sparc64-Kernel-Debugging-Dumps/blob/main/s7-2-05122026-dump.tar.gz

Debugging discussion:
https://lore.kernel.org/all/87tssb6olo.ffs@tglx/
https://lore.kernel.org/all/871pfcznw0.ffs@tglx/

Short dmesg excerpt:
[   48.632215] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
[   48.676018] rcu: rcu_sched kthread timer wakeup didn't happen for 5259 jiffies!
[   48.743621] rcu:     Possible timer handling issue on cpu=100 timer-softirq=15

Test summary:
After applying this patch, S7-2 and T7-1 systems no longer hang on v7 and v7.1 kernels.

Tony Rodriguez (1):
  sparc64: Fix tick/stick comparator equal-compare hazard

 arch/sparc/kernel/time_64.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--
2.53.0

