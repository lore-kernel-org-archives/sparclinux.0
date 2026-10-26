Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793003934;
	b=5WrJjqTxRjwypBfwbQIAMEiHNxtwjOd0aqDpT0VvFe8DD8eJCNRftkGfBSl52zhLX/jC
	 UaLGkYElZx18PsRYvK5oxtgcYEI+MCKZV4LdHqCaRHXHegmf9v25T9rxRDOsrqpPEz7mB
	 0kBihSJCqREplst8fMYNQIkJuJn4DdkfqbTyPFG5MUn9m+ZbLbyNuIerOyAttxXXRIcy5
	 cqCtIM/XTCXMUoeCAvzlFx0CDvVvLFd8ZUnmgECKBjkPIzWjATx2erSAu2K3sT4UgmtoF
	 aCtVbFk+aFifUeuTDqYX5vTgMQpxLoAa+Evy8qQTwolo+FQfcmB0PXOFDyzgHuUSyzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793003934;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=v2TXdy77yZs6lhjkghwXzLiUq+CTx5G8/xzkyCr4Phw=;
	b=wn0Jjf5WLHpwW9ktk1lW7tOJKuYU2WCzExR5PZhg73CmUMwG9Y7xhajDsHDMHYFrUW+W
	 4DNbXGPIyYa2IGp4k9jiyoBJdYy9NhO7XK6sIHwpdmxUVcSkQ2q4ob+JRvOWHEZOYv6g4
	 goKxE1hn1vhDv2bb+oj1HMHoTLDNtTR+JaH379QQg2mKNVGYg/nbkM6Z7TN9x5RWZjrJC
	 VnBuYdDAFFNY9Sjxw+WHSDEn2MkVaI/e8zezaTAEL+7ne6abneWZdCwLovACf1Y1zDevJ
	 GrqiK5ckRfcUjSc/OPSojsndpN9os31AzKGD9z29+P30YNlMrM01Jk0xbpvHWaqliRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fcZWPz7v;
	arc=none smtp.remote-ip=209.85.208.43
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82210606A31D
	for <sparclinux@vger.kernel.org>; Mon, 26 Oct 2026 08:38:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82210606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fcZWPz7v
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6b1dae0febeso3803110a12.2
        for <sparclinux@vger.kernel.org>; Mon, 26 Oct 2026 01:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793003933; x=1793608733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=v2TXdy77yZs6lhjkghwXzLiUq+CTx5G8/xzkyCr4Phw=;
        b=fcZWPz7vQX7V6cHygER9FjxsXztyRH6iisu9upb8RWrU9QYXfF/v7Hpo71QO/j5teu
         R26DH/1A9DyQv5jzuI64n8MDX2gV9HCiAoV0zdOPMtmPYqlW9R4VgnxtWy6CNM64xdNw
         H677G+9869pV6U+xakZfixIPEYVZx1EkiZHNNZj7ckBeBKi/gJlTIuI4PeXgv9rTemfz
         2CTVFYXEYDfVr8LXLt4IzeNSaqCNIpN4xYydMltpH7xDC+vxpbJjNSh1LdOvCHFGnZKX
         TUnM1r5UKiyxFfu6bbmvR9NMcVSaoYR2kDZPUuKgy1K4+dPvaaB1nRb1kDoqaYu/o/8b
         AmdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793003933; x=1793608733;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v2TXdy77yZs6lhjkghwXzLiUq+CTx5G8/xzkyCr4Phw=;
        b=IRVJX6//qLWIK+GBUir6rNA4vURwXR1+YejaTL1uRs4Uel+VZ2aMaoVkZg9H07Rm+a
         X0aGosl/FlOoHQLY/Nj8aUmIhNUF3QSZ66wY87zsVIARe8sFs+BNupJhk+IKtgrsnF/G
         EKRYwQleHtCy8fMj1eP+AmJ7IG54lT7kRE6rMLSSFCTPeDDDzZ63wIWo7tM+2c+94E9X
         AIQdO+AcMTjl9Cf2KS+aQ4Ly+pLjcLo0cEWT4l7bHr0RUTExXRkmHJL9NRGrKSP3KUde
         usj9TzLanTdMbH/4MVCtOK68ao7gDlIn3qcJugbELdUHVbeZXTMxd1zvvsjSLQ9dTUIu
         13oQ==
X-Gm-Message-State: AFq9FYI0vYYyTDEETvwk4zD0trGzQSkEwc1SXEKTKF3naaMqQNH8Q1I8
	iGcKGuBEnTbcVaYEeR6nqqo1TnMCBi4BI10yS5Q7hR1xZmsU+nofwm5a
X-Gm-Gg: AYBFou3hCte9+fuVFBdUhr/GcuOrZeYRHYI6RlG0Wkpv1xn/JsLfX7CSH5b88zsWt8d
	HfCSNHvhuYTVYX1YmV4Z2Tq1VzzxFQsDrrHby6M4uGw6s6g/lICx+Ca5w5XPzQFhMIHqkjHlK76
	Dm/VPNWKfqwGtP+jsoYnGZ0qut65zof58G8tP4vd4D3vXPW52K3qU2c8cDVKjJ+dCyBNycM8TaL
	2ssKMbOB41c2MbTsjdg+5CNzpjLibNAoh6Foythq/NIp3tNPug9GJvPVJmXOe/w+dtocqC00YC6
	KufZh87iGZjC3MeCZleSr5i23GNHqDKU1bgH+nLUfL7MHhyybhS1XdnLW6HRu/tVLZEmjk6TGLV
	TID6sU+LOaZk6k+SvswzGzc9eJIrv+eD7ECaALniARv73THW3fgKSyCSSu+Kzra6KhNkZOkkda2
	eYPx1SsfKjqzw068rwJSGWEY0kwZN670pAk34Rv+RpwZVN3o4P0fLsEdgtAfj7wKKzDfT4Jm6L7
	mmrwlTwlkYeRUHZ4GhHSOKNY75+WzCAWkTt3AwOyGtyxU2zczOlLkEGuUxRd9xKvsDEIyL2kNsm
	UX9CrifHHHI21Zqhsel/alcNTddcJMT2AOcm3sfY3l8=
X-Received: by 2002:a17:907:6ea4:b0:c41:b94c:4539 with SMTP id a640c23a62f3a-c46bdaa7f8dmr744588766b.6.1793003932600;
        Mon, 26 Oct 2026 01:38:52 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46c59c063csm249655166b.34.2026.10.26.01.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 01:38:52 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: davem@davemloft.net,
	andreas@gaisler.com
Cc: sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linmag7@gmail.com
Subject: [PATCH 0/1] sparc32: prevent stale writes by failed bit-lock waiters
Date: Mon, 26 Oct 2026 09:36:55 +0100
Message-ID: <20261026083837.1055953-1-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Post: <mailto:sparclinux@vger.kernel.org>
List-Help: <mailto:sparclinux+help@vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:sparclinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I traced an SMP HyperSPARC pathname-lookup livelock to a failed bit-lock
waiter restoring an unlinked dentry. Skip unchanged stores in the SPARC32
emulated atomics and bit helpers, without changing generic bitops or ABI.

For background, PA-RISC made test-and-set/clear conditional in 2006
(af5917f0cd60). The 2018 generic rewrite (84c6591103db) routed bit locks
through atomic_fetch_*(), which needs the same unchanged-store rule.
I keep this fix within arch/sparc; PA-RISC's fetch helpers need separate
review and are outside this patch's scope. The SPARC32 fetch helpers,
including fetch-add, gain a comparison; I claim no performance improvement.

The forced-interleaving host test reproduces the old lost update and
checks the corrected generic acquisition path. SMP and UP builds and
QEMU smoke tests passed for the architecture-only implementation.

I completed a native GDB 18.1 build on a dual-CPU HyperSPARC RT626
SPARCstation 20 with 512 MB RAM and a native SPARC32 SMP kernel containing
the combined fixes and optimizations, plus separate platform prerequisites.
I observed no core dumps, livelock or new kernel messages during the run.
This validates the combined integration, not each patch in isolation.

Magnus Lindholm (1):
  sparc32: do not write back unchanged values in emulated atomics

 arch/sparc/lib/atomic32.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)


base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
-- 
2.43.0

