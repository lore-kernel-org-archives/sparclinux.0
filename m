Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64358314A95
	for <sparclinux@vger.kernel.org>; Tue, 19 May 2026 02:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779157468; cv=none; b=j2g4Ptc2XqUCGz8YGxZd7m5QoxyC3lrCGB6QXLpKJACr5s88kW+5/svTUqx/+i6fUV85B4p0MvJbrSXGqpkIYTbl2gIraOj/ADvDxTgDHXUrjmuDtON3/ZEw4EeVw9oBQDokkzfeTcGsbt1maoKGmGiDknHSd/ls8QZ5UtNqP3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779157468; c=relaxed/simple;
	bh=Ycp8qjO/PfRK7m2ntTo/IEVUWNXQB9mhil572m7SDNk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NVMdFMa5hXpVMi0Nk6Zj9j2+NQHepKs4YPLX50+wLzbavOFns5fgXkVLSgjx+sJdo5aP7q0zWxzFvDYdGtFJ96Mfle4f7BxAbb0ECrB4CacsQOqIPEj2qrwGxx2kBcGGew7uBywWxJfOqe80Zd95+EU/mCpCw53ffY46TuIFVPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MJyr+pW6; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJyr+pW6"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-12c19d23b19so4126678c88.0
        for <sparclinux@vger.kernel.org>; Mon, 18 May 2026 19:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779157466; x=1779762266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=McykzsXvEssTvn0E09J8JSZwHaEDmP0RB4n+c5Q/cuI=;
        b=MJyr+pW6VpH7nEfLFK9I1nnTL+97DXNtORpWXiVDe/+2PwpauYvAaTrhGzFP/ZMgcz
         TRVtkvCGOXiqFgfkvtgYGQOZRkDl/6vzJ2sJq/6pSZuM1Omn/e5+rwvdyG2L2jopOcSO
         NS1OoXOsgUiLiuRSf9oxW2/q+ENOhKkRXHBWAKmMh7z6kO00wzudbE+2b6G40Hb8PSY+
         gQg8K1v6RqBi6AG///3qHKW2VQzkSG7TpvfwMt1+ABIavxGLb+TxLo8ckcp5ha4ztIzF
         aGM0cH1pAcTOzeUXVjkUTHeHOg9/w2GzZ/RFscEoLDEOo20vrYvmYZ7zK+4wxoIAoB6X
         gRFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779157466; x=1779762266;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=McykzsXvEssTvn0E09J8JSZwHaEDmP0RB4n+c5Q/cuI=;
        b=O8LLbZBQLFWlj/bdbo3MSNUDdUjb+RHnnSaNWy+3arliwFqCDT8YBf7xwEWqDyuOft
         grZK/K+8tKcTI+v3JvjFFDCQEGcygQmMkBwAuZNmcv6JPLxRndSGsM36hRW2sIovIglR
         4frJDeNjhcQ6GMA1S0Vz5NViXBM1Gi8h/SpqGGEwKTul0MTo6JkGdCcq+9idO66hr9nA
         Hj9yj/xlrWz2/GywXwRT+IYdvfhL+c6yuc/DqgfXLyVdzJmFX7b7Wcs45QJ1g67SqnUT
         vxPKUlVLofO1n4ZUGvsMrdTahgRmVo9dohex8jm3kqXkmWXSulHPRoVlEecxMXqMXMCn
         EePg==
X-Forwarded-Encrypted: i=1; AFNElJ+rH+cRtCfRGKF6rf/mKU0FsqDguFWU5AXwAtwdrJa0Tpld4/IG+vT1BQzF7mMHMuCknyy3E/Zvsu+b@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf7suao2oGI6jAXPS+kWEX57EPdJ5P9BrPMsKzT/78SutQSVic
	weou0RxNz0ZcSSlyfE3msMea+LhmJ8Ia9CGO5L5AaU8cPsBWLtc/9diH
X-Gm-Gg: Acq92OEvNwREjwpM6z0PUJ8s8+ZSFI5gMOAKSTQ/m9S4O0eDKQ+ojmQlznSF4uB3fMD
	nDyxPTCBtyzYHGfBoALqooUbLh/XBs1c+Aj2ijn0ut1IXhTLECCCk4URE2BhY9wG4LZEyeRXyM6
	P4sA2X6gqk1IPpfRPqE4H2SIdLUN0dHpAGKq06jtj8aAuNaSJDKgc2GBe7zlqy5R+C3U8HnwLpd
	ViuOtu350BvnD7LTaGygeeh6Zvbltqp63BSILfysmfcU4qhj6AtKZf1QIVXw9BqMrtV/PseoDxf
	5yi66exOJDZdH8aHKCaGx0JhSeTGxWh5VHqQu62BUsapqVOjVdFWaTEo1LTotOHaMHBafESOsjK
	t9JLRumeSr3+tWdhqhm0FQN0IzCxcnt6f/n3uRmvhb6HCz1OxZI9QeCl2UrTSZBhYFqgA+GvBgv
	DchssQ0wnfevJtcEtegq7/dUQBM4pyrfG/YGr9
X-Received: by 2002:a05:7022:7a2:b0:130:c9cc:3384 with SMTP id a92af1059eb24-13504840a80mr6837676c88.30.1779157466235;
        Mon, 18 May 2026 19:24:26 -0700 (PDT)
Received: from s7t7-debian-test.local ([67.170.89.46])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30294adddaasm15104386eec.13.2026.05.18.19.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 19:24:25 -0700 (PDT)
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
Subject: [PATCH v2 1/1] sparc64: Fix comparator problem with timer interrupts
Date: Mon, 18 May 2026 19:24:08 -0700
Message-ID: <20260519022421.5978-1-unixpro1970@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sparc64: Fix comparator problem with timer interrupts

This patch fixes SPARC64 tick/stick comparator logic that can cause missed
timer interrupts

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
  sparc64: Fix comparator problem with timer interrupts

 arch/sparc/kernel/time_64.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--
2.53.0

