Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDD8381E91
	for <sparclinux@vger.kernel.org>; Mon,  3 Aug 2026 23:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785800451; cv=none; b=P5yTiqtKaHs/P4cuASmeMnS/ZfB2aU7LPiGlUIgbe8T0EYTSZwmyyCA7YGb1uUXeA08ctJto2UdqsNkP7fpoL9NHMr6Z39ZIErrkYs5SNlFrLVzfNymw7CS1jJSzNGy86FylOTGKCSxVBg2UupBsVmRyQJ5sxIlf1PrCTtFvHr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785800451; c=relaxed/simple;
	bh=xmWuIF3gvmbx4DiLSNyVNuxpNp9mTMt+/4AKY0oZYD0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=obngh+lQenppgkihW7UUa+OjKuh+aNWIqzQAcMXBY35o9H0iy8vPzEScqRLLO0RZoL6xojY6FwYLs+CEvJi7xwijijD1BOURfbSO7dlrblqyLm06EGVs/hKRVwxKL2zluY3sb99HL1jTUhkn2dpOABF6L7tOk3cziGuAr0leZnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LJqzHwRr; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJqzHwRr"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-668432fe416so5083335d50.0
        for <sparclinux@vger.kernel.org>; Mon, 03 Aug 2026 16:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785800448; x=1786405248; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=U+7Ru6jZFSxz7ibFdQEbmpjCAkPd7K+3B96IxICOxK8=;
        b=LJqzHwRr7gEY9qMY/x/cI42n0OwdoPFXgRESTQ97I2VdoFtzXbrmZSPJaOUyZ2fuTv
         Ei2oFFCfMIBsvyPXpu+DyAm3x67V7slOIcW1z2njG6Qf1AcFaaDraIMTiCy2wC7u51Lk
         Ypg+CG2tfZOcvajkhdeetluhMfGpUs0k/mF+21AmLvYWxGCNBQDnqtmZOEuDwbMPHapc
         2g/7VXvApzJRTMzjT3kF/yjt79JL1cXQjclqecc9oloCPHNOusewSzMFHOZH8wQqW3na
         wFpJlUDfNYAWjNvDSuIoVyLBLPWZf9vm3ToxDPPYL8Ne912bYEr5utodA0oZD5gI18mG
         2j3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785800448; x=1786405248;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=U+7Ru6jZFSxz7ibFdQEbmpjCAkPd7K+3B96IxICOxK8=;
        b=K2CqevcEhe2iKiv8hcZqRYNFtqFpU6v0+osxOxGv3G061eFlVuft9NV7ZNc01S2TVx
         I24CQVE3MH5wWkGmCvXqxPqEzFfHwWbTUMC/O3oSZZ39Hw5X6l7jYWb2pnNAct7ONLFh
         OI27WgC9oG+EIug15ycMvImX+KB2bKTboLjnfut9Gkq3SwlxOKycxusnvgoXZYwnztRU
         s69rmpnxS4VlLcNf9Vd8OAzl5qqHR4vUo8xWHHMHF91QyA90AKMaPqh4epLWxwdOKgY7
         stVmnH3/weX13+s1bJLZ9yRk2W2zZkrcB+fRBe32wtcKYV25ZzAxbpbrXEVr3Sw+0T4j
         FExA==
X-Forwarded-Encrypted: i=1; AHgh+RrfxCbz6BE1SnOqlMBlxy4xcX6vfS23XOfbGxQV63h3cY2ZnMdAOFPEdFY7W1I+3zQ0Bugis7Iy50nt@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu8Vix9hvwKgE+usHgMNmiwj+pmpVjbbExkfCymk4y5lHvEXFz
	2NdWYdZvUiJEFISdITMedQiZDB7PIePBRpLu38K43M4QFedp/yWojDjj
X-Gm-Gg: AR+sD11QDqYEXx/PDsMoNhxI9oid9JbMATpZxJFtF69R8Z33yfUlMomLZbTfRuEwUyD
	L4dzJgbdX6ABIZPbm3FwXF6+1hMYwJZIPOWNyDjwxHGq8UIV6pO5WNWSu/yWkA9CYNjnFWLfLqK
	f5FazZn0dinEYgboY0DZ3slnNFYZefLZrfhMQaUsUwN2BZczbQlThcaLfjLCRBeRWIhdqLkS8rO
	wcV2T7EFBE9FOHKNg7R9NwGylbJ8I5HITtfapSISMNKC/wgy0Rqzk5s7C8vZjOftQC9gIaZk0bP
	ZQunodCwfPFSwiDynQRB+eXPlYQr2bv9D4s6xkGnmTKiF8FBZCczHvZxbfIi33rx1sviMBcWFag
	VR1psUR6Sli/2uCata75k5fa6+lxR6my5uBlPK7/4qgYpTCSTGVyH4WqzRrHpZcthGDXQx1Jj+y
	mSdrEMpXloTXC8y9moXhwYAFSkm/sIXwfWdmYyt3ydU81KNKiOlOY6dKvdk1XAKPOzCmvd5Z25
X-Received: by 2002:a53:c745:0:b0:668:43a3:9db2 with SMTP id 956f58d0204a3-6694f17d897mr10635045d50.32.1785800447478;
        Mon, 03 Aug 2026 16:40:47 -0700 (PDT)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66948b98babsm6681654d50.0.2026.08.03.16.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 16:40:45 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
Subject: [PATCH 0/3] alpha: fix floating-point exception state handling
Date: Mon, 03 Aug 2026 19:40:44 -0400
Message-Id: <20260803-alpha-fp-exceptions-v1-0-c99d75608e60@gmail.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MQQqAIBAAvxJ7bsGKsvpKdBBbcyFMNEIQ/550H
 JiZDJECU4S1yRDo5ci3q9C1DWir3EnIR2XoRT+JWQyoLm8VGo+UNPmn6hFHLeWxkBilGqCWPpD
 h9F+3vZQP4EcgZ2UAAAA=
X-Change-ID: 20260803-alpha-fp-exceptions-5c77d9e057a3
To: Richard Henderson <richard.henderson@linaro.org>, 
 Matt Turner <mattst88@gmail.com>, Magnus Lindholm <linmag7@gmail.com>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
 sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-sh@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3

Three fixes to floating-point exception handling on Alpha.  The first two
are a pair and should be applied and backported together; each commit
message explains why taking one alone is worse than taking neither.

The first fixes ieee_swcr_to_fpcr() setting FPCR_DNOD unconditionally,
which disabled denormal operand traps for every process using the default
FPU settings.  Instructions built with the software completion suffix
never reached the kernel emulator, and the hardware silently substituted
zero for denormal operands.  This affects anything built with -mieee,
glibc included.

The second stops hardware-fabricated exception bits from reaching user
space.  On EV6 and later the hardware writes exception status into the
FPCR before delivering a software completion trap, and those bits can be
wrong for the instruction that trapped.  alpha_fp_emul() only wrote the
FPCR back when soft-fp raised something, so whenever it found the
instruction exact the fabricated bits stayed visible to fetestexcept().
The exception summary register is now passed down so the handler can tell
which exceptions the hardware attributed to the trapping instruction.

The third makes the emulation determine tininess after rounding, as the
hardware does.  soft-fp had no notion of the distinction and always
determined it before rounding, so an operation that trapped for software
completion could report an underflow the same operation would not report
when it did not trap.  The two paths disagreed on the same machine, which
IEEE 754 does not allow.  This adds _FP_TININESS_AFTER_ROUNDING to the
shared soft-fp code, as glibc's copy already has, and sets it for Alpha
only.  It defaults to zero, so powerpc, sh and sparc are unchanged.

Measured with the glibc testsuite on an UP1500 (EV67), with
CONFIG_MATHEMU=y.  Without that option alpha_fp_emul() is not built at
all and roughly 830 math tests fail on their own, so it is a prerequisite
for any of this being reachable.

  glibc make check subdirs=math

  before                              831 failures
  after patch 1                        48 failures
  after patch 2                        28 failures
  after patch 3 (and glibc fixes)       3 failures

The three that remain are a GCC bug: a long double to float cast on Alpha
is lowered as quad to double to float, but C requires it to round once,
and the intermediate can land on a float halfway point.  Two glibc fixes
are being posted separately to libc-alpha.

stdlib/tst-tininess passes, which confirms the hardware determines
tininess after rounding for the results it produces itself.

The shared soft-fp change was compile tested on sparc32, sparc64 and
ppc32 in addition to alpha.  Only Alpha was tested at runtime; elsewhere
the new code is unreachable by default.

---
Matt Turner (3):
      alpha: fix ieee_swcr_to_fpcr setting FPCR_DNOD unconditionally
      alpha: don't leak hardware-fabricated FP exception bits to user space
      alpha: determine tininess after rounding in the FP emulation

 arch/alpha/include/asm/sfp-machine.h |  4 ++
 arch/alpha/include/uapi/asm/fpu.h    |  8 +++-
 arch/alpha/kernel/traps.c            |  6 +--
 arch/alpha/math-emu/math.c           | 88 +++++++++++++++++++++++++++++++-----
 include/math-emu/op-common.h         | 23 +++++++++-
 include/math-emu/soft-fp.h           |  8 ++++
 6 files changed, 119 insertions(+), 18 deletions(-)
---
base-commit: 8cdeaa50eae8dad34885515f62559ee83e7e8dda
change-id: 20260803-alpha-fp-exceptions-5c77d9e057a3

Best regards,
-- 
Matt Turner <mattst88@gmail.com>

