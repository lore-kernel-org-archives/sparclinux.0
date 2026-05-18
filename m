Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1503533ADB9
	for <sparclinux@vger.kernel.org>; Mon, 18 May 2026 23:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779148610; cv=none; b=VluyTQZAtsKGR/VMN/A7Uly9xBweiYOJV3fxDr4DKGoxbMQnWG6089y7G1BSEBr0qLcmZuRqkS3lnYWami9p/exWwXXbkTJZjoxR+n1xp8scHMjxV8QEs/I16O3ox2LC8eVGLWl/R8xYqqOSadtlBPFJQlkbuAjNVUhUi8aTdyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779148610; c=relaxed/simple;
	bh=GaS4Ko50/fcvGwi7jfjzVijI3Xzh0Js36JrNYZOR7To=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VgatcxpmHxGMUopTMFbJ0IoQeI4/arFm/fIcgED66xoZncRWrzvNEFUc4jZhaGwitB62tm4aURapdqivLDnE2GLBZxQA0IIkwRH7pRn2sgQbGFmh9EH9kYpxvLkajZ3pqVEL8MJmop3h57oo9mgFWLFuMPWQL63ynj8VA3ojyGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T475WZHo; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T475WZHo"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1334825de43so2671079c88.0
        for <sparclinux@vger.kernel.org>; Mon, 18 May 2026 16:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779148608; x=1779753408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I/re5UGXJXnbUiTOLP9irqWGJnT3W7803B73Ky28WmY=;
        b=T475WZHo7ikkIl4D7JX+StlEbKo29Kb2vDZx1nLrpjQFpH75Cn/3dXP7zs8eIwz3CO
         V+VxpssK0Nb1rcbJBBVN3Ttvy3Cgr4VRpQM43bD2A9GszpBVqWKF8RwfOUOGQO7DamfJ
         VtpDVFbh9JAKqUbTQ1S9/iLFh7ud9q18O9O+mx+Cv+s7ip+z2hgdPRicpBWSG7q+yXaV
         0Jy5zzGH561N/40/Y2N1+J6HB91rkMyljFELGjHtwOAM9LxBx2g52g6dAFc8ghP0NcX8
         nJUP4c47VwjF8uEeJai2wZn7WLllh8aIQ+Xpfc/tZDhU6gmHMODNgx94XTe3D2hNQ0lQ
         OR2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779148608; x=1779753408;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I/re5UGXJXnbUiTOLP9irqWGJnT3W7803B73Ky28WmY=;
        b=kzvCv3hUQw6pApLnZ3BIbeMxuAKGPsF4odqzjOV3NANW11VXJRJohTfPaLo8sjnYQl
         5y7UFNYiPPaLHF6ibdj+Fd3889jXHRP1Oyr0rrdBMiUMdXOUsYg0wVqAtorDoFzvGYIC
         6GQwFE95onNw5ZeV+Oc+hTdZMj957REjyNuKV8VFnD69orMwR3uOUpZqfLMDzfuEevdg
         FTts3XDiPFJ5ATUrISc5OmR92ZCG9m8g85p++FK+I1uo1LuOWuxnnMCPhXJwr2MrjaAY
         Jr7OZZ9b9tJLBj275HikHBFt/o6kpUSevjNj2HtmCd2drlaKmQULMmYHV/JN5sdyurJy
         VHxg==
X-Forwarded-Encrypted: i=1; AFNElJ81JY4eWQf2zxUb1qMa0AgLrA5w7TJfgimQvDAgeCfP/h1Z/KEaKx8XBs+u37kLrJcLWra4QnGu6Na/@vger.kernel.org
X-Gm-Message-State: AOJu0Yzfatws7/FR+PbvuleYLeuyYOdSAGFOowEh78Gj8f7+AMUHnWEz
	NPIGT3zWDUA7awL2s/1yiwPAtBxffgU/TaOEkCI9j0LaiTbFOsKmcXxj
X-Gm-Gg: Acq92OGi4V3ePUFijMdDl6rOf/mcswaaXQH4PBBN+OXlooToZXTO0vb8BDSAqSdpcSG
	xNJXpz9pGTsPgPV1m/mSR+34lTEu3vaF8BPzddcNkHitnZmJh0QeqOlbCl2vWY3jE5mYI0n7Rbb
	P+Kw8higjIp1mE4y7qrI03tNfXhAZ/mVNRwByeCQro5qfBWov3ltNB9+b2k9K3E95NDuJwRsi9h
	++Ravowk14Rn7/DrH+Srwp09CHTc0exAP2oSfAM5hiLaTFYN2tCOeSg7zNU+ss7b2rK4EyFK3eb
	TcCbp9AqFlwvz61tXhUlr/dziXwKeuLlG19O+5l1MV40m85hx1UvgTjDtD7PMQ+mWkdn1VYu3gu
	x1H7MM8xyFt8M/DzAScitGDoPZ2MrazOjBvyZEpkk0P2IWHlcoZuR+FcW009Ybes3/qVgMy1txs
	S2VebBNH12gM+cFRMYrqCM+LEnuyAUVqnYjJO9
X-Received: by 2002:a05:7300:a94b:b0:2ed:a64:a457 with SMTP id 5a478bee46e88-303986552f6mr7440960eec.20.1779148608109;
        Mon, 18 May 2026 16:56:48 -0700 (PDT)
Received: from s7t7-debian-test.local ([67.170.89.46])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30294500726sm14141408eec.10.2026.05.18.16.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 16:56:47 -0700 (PDT)
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
Subject: [PATCH 1/1] sparc64: Fix tick/stick comparator equal-compare hazard
Date: Mon, 18 May 2026 16:56:03 -0700
Message-ID: <20260518235632.5122-2-unixpro1970@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260518235632.5122-1-unixpro1970@gmail.com>
References: <20260518235632.5122-1-unixpro1970@gmail.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On SPARC64 the timer interrupt is generated only when the counter
equals the comparator (tick == tick_cmpr). There is a latency between
writing the comparator register and the comparator becoming active.
If the counter reaches the comparator value before the comparator is
armed, the equality moment can be missed and the hardware may not
generate the interrupt.

Previously the helper treated equality as success:

    return ((long)(new_tick - (orig_tick + adj))) > 0L;

Here `exp` is the expected comparator value (orig_tick + adj). If
new_tick == exp the code considered the event scheduled, but the
hardware may already have missed the equality window. Treat equality
as failure so the caller will retry with a later expiration:

    return ((long)(new_tick - (orig_tick + adj))) >= 0L;

This prevents missed timer interrupts and stalled hrtimers on affected
SPARC64 systems.

Signed-off-by: Tony Rodriguez <unixpro1970@gmail.com>
---
 arch/sparc/kernel/time_64.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/kernel/time_64.c b/arch/sparc/kernel/time_64.c
index 87b267043ccd..783b60e547c4 100644
--- a/arch/sparc/kernel/time_64.c
+++ b/arch/sparc/kernel/time_64.c
@@ -146,7 +146,7 @@ static int tick_add_compare(unsigned long adj)
 			     : "=r" (new_tick));
 	new_tick &= ~TICKCMP_IRQ_BIT;

-	return ((long)(new_tick - (orig_tick+adj))) > 0L;
+	return ((long)(new_tick - (orig_tick+adj))) >= 0L;
 }

 static unsigned long tick_add_tick(unsigned long adj)
@@ -277,7 +277,7 @@ static int stick_add_compare(unsigned long adj)
 			     : "=r" (new_tick));
 	new_tick &= ~TICKCMP_IRQ_BIT;

-	return ((long)(new_tick - (orig_tick+adj))) > 0L;
+	return ((long)(new_tick - (orig_tick+adj))) >= 0L;
 }

 static unsigned long stick_get_frequency(void)
@@ -411,7 +411,7 @@ static int hbtick_add_compare(unsigned long adj)

 	val2 = __hbird_read_stick() & ~TICKCMP_IRQ_BIT;

-	return ((long)(val2 - val)) > 0L;
+	return ((long)(val2 - val)) >= 0L;
 }

 static unsigned long hbtick_get_frequency(void)
--
2.53.0

