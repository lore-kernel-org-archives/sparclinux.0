Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924AC395ADA
	for <sparclinux@vger.kernel.org>; Mon,  3 Aug 2026 23:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785800452; cv=none; b=XAEJU0UBi+KEX2rLQMvtf3kw0c4nlfCuHlhS0Qu1rggTuyKqSdbGHcTGd8MMY/P5M6NuikB7pXAm4PwV8ukgIXSbTe1BJxIfbm4fZQpG2l2dwf0+chS3SNRTXOY5gLpJwDGkSDE10vfhEZmPqnI1AqzVpgPHMsFv2wymUUkzhGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785800452; c=relaxed/simple;
	bh=YZg1odxiWek0UxsP57a8f13DBqPUmymS1YIGamKZW+Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nR0XH8Qu3Yy2ZSH08jU/T75QRdh57tJdWsqyuoDHkkWVs7F9mxuSidQXCxP2DfGhYWlouONRV9MlNJVfpDLzFYh84B4aktkmn1pjHwucWm3Up3DWGQpq0bf7RN2o+k16Tgi+HIeWocYnf1TWKJNh5fFL2RWfnB9kdzHK67nC2dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B06zjzZI; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B06zjzZI"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-664db84f074so5755756d50.0
        for <sparclinux@vger.kernel.org>; Mon, 03 Aug 2026 16:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785800449; x=1786405249; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iXt2lHl6V6DYOxKrsChpRVwvJNwCDOvF3knLtupIoSg=;
        b=B06zjzZIb4DrxrL4KvqLlHDn9RGSsjwqhOhkwKhmOUr9TLQKClY+YqrK7vqY70jjEJ
         PwgsgeL7uh2DbOLRXvkOgG1AwXVmafNqOf7G1692yDq4+UHUuOeNnisRffLMVcmfE6QC
         LLGxOaqZUWJDebuW0nkJKWitu7udF1/8aPzTjtBPkCbymJ/Hxp1FEOumvUBBj/OE8dOT
         u/2iwVKLoECCOPnyy0E+vV8pKFBdbGJnhreHvqGYuX0BFucddECVDaCwsyw2z6oobVsu
         lNn/1muTrj3YbiRuvVBLIm9IkZIqAH+VHQ3PBfvD9oW7FU3LvpIBG4t0xbZl6UpNtexw
         CVBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785800449; x=1786405249;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iXt2lHl6V6DYOxKrsChpRVwvJNwCDOvF3knLtupIoSg=;
        b=Fm0pdeEqMME50m0oT92DIlRcpzmWrBtCTIaDa8NZ8zaBYcNFcXBnhjQCx3aX1OMkG9
         LzANxXuausNfG4j5GMez9/fUmZs7XId8RUzZ5oDI+XA5VWhysCg543RCnbNAo3nHWb5y
         B406xV3S6eUphnTLoCLsRvj8NiMRdjOR6V1K5Dqt/1h8+BP32xDkKz8Ic/fyVHl92NrD
         ZoxFatFxitcVaNP5qz7PrdpWV9DKa+YQBYWx1pd2n5WxNju5lPy1Z/oqf9o1DWznBTHq
         h2ou6M0MtuZaF934dTY9PGBjxF/0t8kpc73JwCZFqAS1sz8XEs9i8ujWhRaz13T9/qoe
         FNVg==
X-Forwarded-Encrypted: i=1; AHgh+Rpuwq2A8GPe2vIExT2+/BWey7jUaNkHJLdE1uGHZDKCoZhL7eRdQEs19qVyiXDtN8wP0vr3dTx95Az0@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9NCHglIF65xc0V38oy2YFAUqT1sGiKvGPwUANCVPveOkVYjqu
	r0CW5qbHM9zZmf/+LSqL0V3xI0BNm/7+Qgo3+GJbO6nC+294J1HBtfqn
X-Gm-Gg: AR+sD111Fde9U31uq1bgurI0AA52zsO7/qwELZOWZBqXb5w0PvzusMXDNCfaDXevFV0
	kToLknENQfiidpMLNS4Y0gazY7vrbiZ4GW4IT7qcUzRIgL7u4Kq4l0X9bjlsLlzo+gpSZUJkgNi
	r8oVEI/X7TxMxwFmaEA/pTYUMASVmqHqSzsNA6O0j1ge4yjyOHHE8+2vj1xvcYv5KXyv9jN+sh9
	j88tbtNAoSYG8NLBQIu3Rm0oVBcjmioDf3Hcfbo5qnh/lOnZhcS/lqZVYA+6/ivy+A6sU6LR89V
	s7HZfmamiqKaCM4Znf4YeJDwiWNQznt3TtB9GTxRDvkL8VjBLv+3hkR0gP74PgyqzOnVCSE7lxV
	AqSXoYJZDQ8jeWJNanvoCx30xbwGDCpAca9HfBvQoAW6nlUxGDXcXEprjMQKOvoAKR/k1LliASH
	q7aWibWFuWiEW58O1UCVZG05gL7HFTtodc32r3g4EqRYeX2pmVmv+uCyLink5G3aaZYoi9DGc=
X-Received: by 2002:a05:690e:480a:b0:668:8f89:762 with SMTP id 956f58d0204a3-6694efd03bamr9722268d50.1.1785800449430;
        Mon, 03 Aug 2026 16:40:49 -0700 (PDT)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66948b98babsm6681712d50.0.2026.08.03.16.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 16:40:48 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
Date: Mon, 03 Aug 2026 19:40:45 -0400
Subject: [PATCH 1/3] alpha: fix ieee_swcr_to_fpcr setting FPCR_DNOD
 unconditionally
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-alpha-fp-exceptions-v1-1-c99d75608e60@gmail.com>
References: <20260803-alpha-fp-exceptions-v1-0-c99d75608e60@gmail.com>
In-Reply-To: <20260803-alpha-fp-exceptions-v1-0-c99d75608e60@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>, 
 Matt Turner <mattst88@gmail.com>, Magnus Lindholm <linmag7@gmail.com>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
 sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-sh@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3

ieee_swcr_to_fpcr() converts the software IEEE trap-enable and status
bits kept in thread_info.ieee_state into the hardware FPCR format.  It
contained:

	fp |= (~sw & IEEE_TRAP_ENABLE_DNO) << 41;

FPCR_DNOD (bit 47) disables denormal operand traps: with it set the
hardware handles a denormal operand itself, treating it as zero, instead
of trapping for software completion.  The intent was to set DNOD when the
user has not asked for SIGFPE on denormal operands, but
IEEE_TRAP_ENABLE_DNO is clear by default, so ieee_swcr_to_fpcr(0) always
set DNOD.

Instructions built with the software completion suffix therefore never
trapped on a denormal operand.  The hardware silently substituted zero
and produced wrong results, affecting every program compiled with -mieee
and default FPU settings, glibc included.

Set FPCR_DNOD only when IEEE_MAP_DMZ is requested, which is exactly the
case where flushing denormal inputs to zero is what the user asked for.
DNOD then encodes MAP_DMZ, which ieee_fpcr_to_swcr() already recovers
from FPCR_DNZ, so drop its attempt to recover IEEE_TRAP_ENABLE_DNO from
DNOD; the DNO trap enable lives solely in ieee_state.

Both functions are in a uapi header, so the encoding change is visible to
userspace, but nothing outside the kernel is known to depend on DNOD
carrying the DNO trap enable, and the kernel is the only writer of the
FPCR.

This must not be backported on its own.  Re-enabling denormal operand
traps exposes a second bug, fixed in the following patch: those traps
usually find an exact result, and for an exact result the emulator did
not write the FPCR back, leaving hardware-fabricated exception bits
visible to user space.  Taken alone this change would make spurious
exception flags more common.

The bug predates the git history, so there is no commit to reference in a
Fixes tag.

Cc: stable@vger.kernel.org # 5.15+
Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 arch/alpha/include/uapi/asm/fpu.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/alpha/include/uapi/asm/fpu.h b/arch/alpha/include/uapi/asm/fpu.h
index cea9eafa056f..d28dc36786e2 100644
--- a/arch/alpha/include/uapi/asm/fpu.h
+++ b/arch/alpha/include/uapi/asm/fpu.h
@@ -101,7 +101,12 @@ ieee_swcr_to_fpcr(unsigned long sw)
 		      | IEEE_TRAP_ENABLE_OVF)) << 48;
 	fp |= (~sw & (IEEE_TRAP_ENABLE_UNF | IEEE_TRAP_ENABLE_INE)) << 57;
 	fp |= (sw & IEEE_MAP_UMZ ? FPCR_UNDZ | FPCR_UNFD : 0);
-	fp |= (~sw & IEEE_TRAP_ENABLE_DNO) << 41;
+	/*
+	 * Disable denormal operand traps only when denormal inputs are to be
+	 * flushed to zero.  Otherwise they must keep trapping, so that /S
+	 * instructions reach the kernel emulation handler.
+	 */
+	fp |= (sw & IEEE_MAP_DMZ ? FPCR_DNOD : 0);
 	return fp;
 }
 
@@ -116,7 +121,6 @@ ieee_fpcr_to_swcr(unsigned long fp)
 			     | IEEE_TRAP_ENABLE_OVF);
 	sw |= (~fp >> 57) & (IEEE_TRAP_ENABLE_UNF | IEEE_TRAP_ENABLE_INE);
 	sw |= (fp >> 47) & IEEE_MAP_UMZ;
-	sw |= (~fp >> 41) & IEEE_TRAP_ENABLE_DNO;
 	return sw;
 }
 

-- 
2.54.0

