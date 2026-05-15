Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40F53090D7
	for <sparclinux@vger.kernel.org>; Fri, 15 May 2026 04:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778820447; cv=none; b=AhBNyzY2EZ1aT2aAs7XRnS2W28MrWdto9fyRYnZUsPMezeFqI0PiT11HuILGSVwLZPkxJzlffrDy876EHF9CebRr1gH8Lxi1J1qXN9Y1KFNYvRCpOBKpYEyM4Ru9yXZjDsH+DRkpN35A8lR0T7p6ybe3cJ34wdJyiQOz4RnG2yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778820447; c=relaxed/simple;
	bh=NijvWsrsHsPGHfADGjxWbC+hgUsKNBW5ghHkDQqiP8c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O0Vu/SKbn6/c6zNwVDX5KklRCZEX/TcKd7KUlH/dCGf2Lp63hfS6znbTC57Vrny13NkZ07elmVr0qK/925v60Kh1WhSz1tEkAIpov1HRaTjCp+rHmJPCznvMbsZ2W4MaYCPZnlm/6lwA7oLZkC8IskHof2rZR2nq1A8beJDKzjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mWh67mZW; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mWh67mZW"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2ff5472f263so5129010eec.1
        for <sparclinux@vger.kernel.org>; Thu, 14 May 2026 21:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778820445; x=1779425245; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WvZB5T4clNth7fcajE013KijBJD905/lgIzRhBekpSE=;
        b=mWh67mZW0wm3j0pe4F7U0hDQRy5z2h6ndI2Z8hLgZrZLqJZpw9og9wKjwc04ZVv9OS
         hnjlVBVXTQiW2+fWusBF0N64D9wlME6EjU+xxKYJsZ+lfyJBN8QXsk2gcX1hKy6qa5zJ
         vguRoRZhIq53AOnwZODogtoYUSdWQyHEz1k6tLLLlcwjOaHdpon5XJPfIOw90Od3tRCX
         FWj2Ejn7wlXNKgU9O+y6g3c6cHFKg3gVEZLJvWTjDBPWFaAmhQYQOxiziSyjIn4ZGtCp
         z8NGF6NifrFxikK3UVPoHcPjdU7IhAPw/5KrBdHpcX5kFlSsaxfSSGKRl5PQdv1HhmzQ
         RRnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778820445; x=1779425245;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WvZB5T4clNth7fcajE013KijBJD905/lgIzRhBekpSE=;
        b=UnnlMWmYV6wfm1hMHpcOgxGG3OAHg8gxpD5PNBu0nTf2IXXctjNHEmoBCd2IenCjye
         RA8ixl5nb/ICvq8tkKIChvLqunojRR0PnDrP6Nu/XKSq3hlTfdASr4U+iikQoN8APZwo
         96xlHQ1CJ1bwn3UuSsezeAGinim1uFmza1+U0IZmjrZ+1cMQTvRtZdh1smCK3aCQyUIM
         LCbRo8Li/NkrVybnZGj/lQjkTUlbhqPQ5wQPLwf5vvTUITWCmzAYg+/iAAePGvcS94WE
         7ArZGztaXMEXeXCEwXvjDZJEfk0foQYwDX91DFfGzxTDpkKab3fj5gw5QZVSeEo9sm/U
         ViXQ==
X-Forwarded-Encrypted: i=1; AFNElJ9bLBhlJEAnl3A/vqYiT9BFdHCaaD+upTMOG7sd9YKIEhNPS4v7vr5vmSMewL8DRypiNvlQD8SMJ0Qy@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5yHOj2OCk9P9WHe/Bm3OZgfqO58TNzhpmZlJ9Mv5auzY5g19g
	bGxcJA04kJtElcT7AKWU7txNpMa0dpBKFLv+O9bxhtvKAOnz3N3Oe0WANmTCiq1R
X-Gm-Gg: Acq92OEjOUw8Cq87VbmN/kcd6y6b4IeX5Pv9VqKdVTBjsTn9qHYmO8TCpe/bjLLSjYa
	Q0Lra9zaEZR8it1MZMWebr9tsdeRl5jglMvLqtyfirjWwPVOhJ4M7c/f/Dx8pNl5XhmQLlBXENM
	BlkaNFFgCg/oTyyAhJ6TYcdT7eNpWfzplL6SXa3UZ32M6rji5qLXJH/wOiRFQLQ9iJaVCvvEUw7
	G4jTanH9LdKKl6xtBkCp6+7EMLThYhwrUZsM2iWo7kPLfJitkC4efef1sTkay910D7aTHQwYbNY
	z8GgKRyGewNfWffgMsqvsZi61khsIhO3q3xzBUNWmLZiVi78Y0y+WwIiStI19i+5udYLO7UOu6P
	WRihBECsI8N4m56nA20xNEcuAKOLX/L013EbuMVJagkp6eCPXKZ5KE/fL0AgJJwc1gD6PTDki+9
	APMWTxZ9OYmWdklB1q2Avd3P7qEx32RQ==
X-Received: by 2002:a05:7301:1983:b0:2d3:f3fc:bb6b with SMTP id 5a478bee46e88-3039818ee3dmr1245826eec.1.1778820444974;
        Thu, 14 May 2026 21:47:24 -0700 (PDT)
Received: from [192.168.21.192] ([67.170.89.46])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-302973bc9d4sm5528796eec.23.2026.05.14.21.47.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2026 21:47:24 -0700 (PDT)
Message-ID: <0669f754-a313-4aa3-9923-0c374d49feb3@gmail.com>
Date: Thu, 14 May 2026 21:47:23 -0700
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: the stuttering regression in 7.0: should I have done something
 different
Content-Language: en-US
To: Thomas Gleixner <tglx@kernel.org>
Cc: Linux kernel regressions list <regressions@lists.linux.dev>,
 LKML <linux-kernel@vger.kernel.org>, sparclinux@vger.kernel.org,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Thorsten Leemhuis <regressions@leemhuis.info>,
 Linus Torvalds <torvalds@linux-foundation.org>
References: <ffb44522-f01c-4be3-849d-27dc17fbca7f@leemhuis.info>
 <D5D19776-C809-4284-9417-F9A860877B98@gmail.com>
 <1c165caf-36b4-4673-97fd-ed86bef17b88@leemhuis.info>
 <3332123b-9e11-4895-9ab3-1707fba5815c@gmail.com> <871pfj9cmj.ffs@tglx>
 <a7a0d78b-435e-43c8-b436-5e7f4dd39dee@gmail.com>
 <088e6cfa-0167-4748-af6c-458ade2f303a@gmail.com> <878q9p82je.ffs@tglx>
 <64f465ca-6117-4375-9c4b-af771b8205fd@gmail.com> <87tssb6olo.ffs@tglx>
 <e45438e7-8501-4c10-95ee-07f118de8a51@gmail.com> <87qznez3tf.ffs@tglx>
From: Tony Rodriguez <unixpro1970@gmail.com>
In-Reply-To: <87qznez3tf.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Thomas,

I’ve completed validation with the v7.0.7 release and v7.1‑rc3 on both 
S7‑2 and T7‑1 systems. Everything looks good.

Thank you again for the debugging guidance and for the feedback on my 
original patch addressing the timer starvation issue. It was a pleasure 
contributing to the resolution.

PS: I agree that the second patch we discussed isn’t needed—the systems 
run correctly without it. The following patch alone is sufficient:

Best regards,
Tony Rodriguez

--- linux-7.1-rc1/arch/sparc/kernel/time_64.c.orig
+++ linux-7.1-rc1/arch/sparc/kernel/time_64.c
@@ -146,7 +146,7 @@
                   : "=r" (new_tick));
      new_tick &= ~TICKCMP_IRQ_BIT;

-    return ((long)(new_tick - (orig_tick+adj))) > 0L;
+    return ((long)(new_tick - (orig_tick+adj))) >= 0L;
  }

  static unsigned long tick_add_tick(unsigned long adj)
@@ -277,7 +277,7 @@
                   : "=r" (new_tick));
      new_tick &= ~TICKCMP_IRQ_BIT;

-    return ((long)(new_tick - (orig_tick+adj))) > 0L;
+    return ((long)(new_tick - (orig_tick+adj))) >= 0L;
  }

  static unsigned long stick_get_frequency(void)
@@ -411,7 +411,7 @@

      val2 = __hbird_read_stick() & ~TICKCMP_IRQ_BIT;

-    return ((long)(val2 - val)) > 0L;
+    return ((long)(val2 - val)) >= 0L;
  }

  static unsigned long hbtick_get_frequency(void)

