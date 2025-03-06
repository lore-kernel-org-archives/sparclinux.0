Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D6ACA6B;
	Thu,  6 Mar 2025 14:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741270057; cv=none; b=Zr/qvZWueujHLGh8tHdWb05MWO39XMCkfvuDk5xtGvm+Yrlybdll1px+cvjObxd7+uDMYC2p6GszaCG4vMVertZstrZaLZNOpqTLfJ4l9xaIf/Jch2dx4LYUrJIxajcV0FLS6Inup7uHGKRpYpJaUiV4KDbnqNobjRg4yPFV21o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741270057; c=relaxed/simple;
	bh=05Q57GZIQsaILHZFtFYbGWsUqYD9H04DKWT6zCZ6tC4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=N1ux2CiDlxg+Gulfcft3Q7S+8MHlxhmbfwtOQx8no1hkwzb9WUbPTdX6TxQUktcflN8fWavF1VTrqL22Lf//R4hwfJ2jyyoRqc0JzPi3LrfqejSjRKLTu/J8m+q+TM/EvuW+L6xDdQZGK/2xZp5ttg7zMnVjwEk7DuUsl7SOm7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qN+tD22I; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=a23wYMM0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qN+tD22I";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a23wYMM0"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741270052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4roY6sd9l3rnXS4rlQK6Zm1P1m6G0H0w5zUodBkTb04=;
	b=qN+tD22ILNw0B2/H02ziEDSSDqLdT9vOBn97s/xcy2BEilRT4S+C/Uqr1mJgUr9qtRdumv
	Fe730/23QUuLirMcOB8H6sCJzFC7goj/q2HKvVbIoheUf3mVvA29BrEdXWXWtSfI+cshXV
	cWRYp/WILlx5/DWp6znWQ13PhpoLZ15xizWBvyhdRnqa/BcL3coxacZmZTMjBnlyxrGmdG
	S8++Ipsyn5CNP/1C4Y0VV2sOtN/XJxCgtpLOketAC7ssnqkrkcugJcNhtpJpFvPrMQ1aA0
	8ExFWlP06PQpap2yjOTySR+b3aSKi87Pufkq/J4d8jlCIMcyWzoi1miSbEQOfg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741270052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4roY6sd9l3rnXS4rlQK6Zm1P1m6G0H0w5zUodBkTb04=;
	b=a23wYMM0frKAs4VWfQJHkTCfPuURp8jBdeOMnyl0+MQ4MEYPWNJWGrToA+g+gC4u5OY86y
	dsj/zbSLKAbHmrAA==
Subject: [PATCH v2 0/2] vDSO: Always reject undefined references during
 linking
Date: Thu, 06 Mar 2025 15:07:19 +0100
Message-Id: <20250306-vdso-checkundef-v2-0-a26cc315fd73@linutronix.de>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIABesyWcC/3WNwQ6CMBBEf4Xs2ZpuBQ6e/A/DAbtb2Wha00IDI
 f13K3ePbybzZofEUTjBtdkhcpYkwVcwpwbsNPonK6HKYLRpUSOqTCkoO7F9LZ7YKdcT6R5r3z2
 grj6RnayH8T5UniTNIW7HQcZf+t+VUWmFY9uzvnSGjL69xS9zDF7WMzEMpZQvYyzFNrIAAAA=
X-Change-ID: 20241011-vdso-checkundef-f6dd0612025b
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741270050; l=1161;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=05Q57GZIQsaILHZFtFYbGWsUqYD9H04DKWT6zCZ6tC4=;
 b=qmBvMmFdkjrk5kS4vCqKu9VtaChJX4ixCRB1TTy9l9gpYny8YDcrwal0ul6dyz95X5bxLnlAL
 bVr3p5rQtoNCexfTSOFLAj07HMzrzZhjJrGHReznGNaFIO6CvcVLBfE
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Instead of using a custom script to detect and fail on undefined
references, use --no-undefined for all VDSO linker invocations.

Drop the now unused checkundef.sh scripts.

These patches can be picked up by the architecture maintainers.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
Changes in v2:
- Rebase unto current torvalds/master
- Drop already applied patch for UM
- Drop spurious "in" from patch subjects
- Link to v1: https://lore.kernel.org/r/20241011-vdso-checkundef-v1-0-1a46e0352d20@linutronix.de

---
Thomas Weißschuh (2):
      x86: vdso: Always reject undefined references during linking
      sparc: vdso: Always reject undefined references during linking

 arch/sparc/vdso/Makefile          |  7 +++----
 arch/sparc/vdso/checkundef.sh     | 10 ----------
 arch/x86/entry/vdso/Makefile      |  7 +++----
 arch/x86/entry/vdso/checkundef.sh | 10 ----------
 4 files changed, 6 insertions(+), 28 deletions(-)
---
base-commit: 848e076317446f9c663771ddec142d7c2eb4cb43
change-id: 20241011-vdso-checkundef-f6dd0612025b

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>

