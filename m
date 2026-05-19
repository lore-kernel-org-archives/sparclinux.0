Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9997130C15F
	for <sparclinux@vger.kernel.org>; Tue, 19 May 2026 02:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779157473; cv=none; b=AczuJ3qGleMvLaSTK3plgqFnoElpsQqiZkpNl2zO7JBNnA+U0bhfaj/fquwOjT7jH7todzOUBGowsQ4ogpI4HqfFxNHf9rqwNzLTq4FFpbIHFjhgjvFUxV0284fgNHPyxsu4a2yrh1mEpVOM+ZXrfAW+52Xu0JtpP7fIJnZTtGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779157473; c=relaxed/simple;
	bh=NADwrGOVcc4FjQYywWuWugOChYFB0Dkz+W/ArfLZ0PY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qnmJzdpVCj8Ap+Z/zYzwqBn8aq4/CnVGD6E9dgXWEU98pEZzva0iP19vUwB4KuyrnaGYAqOvWPBUACwD4u9SH2qrLMObMOQs5jfjs08mq9cdi/SY07La9NAZnxOmQic7fD4Er+eEzokkoz+nhmbPBG82lWrfZqFjof7Qqp/thf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MIafeVGi; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MIafeVGi"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-3025d725a05so8543802eec.1
        for <sparclinux@vger.kernel.org>; Mon, 18 May 2026 19:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779157472; x=1779762272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eqlrn3+hTvrRB6nPsNJHnq1yi6Gz0E9UU0IYHYA6w/k=;
        b=MIafeVGip0alPPvE/EmE9nbdJfkQp4rxxxZ7hdPG0/Lx+QWw8KsQG1Dhzrb3bA8ep5
         KqfMa/U2GNaC7vs73ml6YgYcz7sa+m46MKnrszkIEHLuyl5D26yN9WSOFj98bir9P7Uw
         HtHnyFSLXr7Lv/BtD1e1QqtB3tC7BVtW7ryiPcQ6KGHdc+DnZi28J/Jx4Fgbq6V3NIPT
         0j/01zIq1ZUb+HWebnL4f5VKGEEBc40sK8AGgWBg0lK4V373fvRt+aei9HYpHd91Sv/U
         jyurh9O0DeCvRrzx4pw+Zb8oI7weXWX+DRwcGq0o8PQqAR/I57+WCXiOTHnL+yrBzE3B
         q31Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779157472; x=1779762272;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eqlrn3+hTvrRB6nPsNJHnq1yi6Gz0E9UU0IYHYA6w/k=;
        b=LOicwPxwHoVDFGmHuKDet/coXZLYz0XIZ96SoTPhQvU5k3OfCjB8k0nNKPNd9z022n
         k9Ny9iPTXQ1+B7Vt7UqnTBrovmmPkyaBqKRJbNxJArGqmpbs4BgKgwhBdFO+Wu3UpftR
         4005ZrMDBC3JtD0s2fqGPxGU7Qv8KNAn4qI4tyLIEY2D7lp5pnhwBhsHuLiwRCXQFKfL
         ffdXNsBcgnFvaHeLSfJEe9RurMSgVrO22tjp/zFa2qPCAntBs4hHE3xrWzez5m/A5sXp
         Uz6EURH54/2Kk7C4x04CwswRAEhRZrtX6AxN3D41W1HakBMeXxz8h2HVqtxs+EqbfEkg
         vuzQ==
X-Forwarded-Encrypted: i=1; AFNElJ+ByovJG5lYO4EdV2qRzX73+cEjTl+fIFbHQsZ6orvspT2dutGerf5UhvOlTO4NT8Qv0fQOon0A3fZ0@vger.kernel.org
X-Gm-Message-State: AOJu0YyK1qHWpZGxczWjUup45nWYQ6MEwFWL7kBY3y/SwYQZuKzshRok
	LQa32Ladv7+09V4DWBGThramxWh/wa2h+3zTZLYtWXYwO/oVgH9Ig6moJYMdoARcXTM=
X-Gm-Gg: Acq92OGTfHGJj1KtPfD2i7sS5lCEzcyyeGME+R0tjSx/JjCSWnCdQFO8n9iHRIXZg7C
	pvUURCAHORpIon8BZULfEYhwajHuRGbHYkaRoo22+d47MBg+UxQxQWQWlhnlylBp6lEax8CFMt8
	cmQiLwf5RSrwYZmdaqdcWnM8Jf+a4HzOv3QvEPl/5BlZnKKJcS456hw51xpwiRRuOXdAHlTrUGI
	PvSp9CT9AIMs4Rt0QbdbHoeIF6iQxVH/Updr6qRKtC39VOEkxsPSuxTezlgSdekA4Oh751xSiyv
	jNoOxwZSZ2hu4a0jb2zjwvgSIYEx4ZMlyvYgtnhYlumr236CZEws5IOA0/Nacw1QN5GlzGrUokO
	82uIZjGlKE5t0vZM8Dr1xupvgP85cEpwYp7TtqT5BMVoaXeUaaQQHAmUKhVDGhdDbyJyd3Zzn21
	9kR6Y25TvrdDlrjk4CK/tQ/oGLhKF5xWzeMeN89lntCbRVUBI=
X-Received: by 2002:a05:7301:2c8a:b0:2f2:32bc:787d with SMTP id 5a478bee46e88-30398637044mr7365399eec.23.1779157471451;
        Mon, 18 May 2026 19:24:31 -0700 (PDT)
Received: from s7t7-debian-test.local ([67.170.89.46])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30294adddaasm15104386eec.13.2026.05.18.19.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 19:24:31 -0700 (PDT)
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
Date: Mon, 18 May 2026 19:24:09 -0700
Message-ID: <20260519022421.5978-2-unixpro1970@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260519022421.5978-1-unixpro1970@gmail.com>
References: <20260519022421.5978-1-unixpro1970@gmail.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


On SPARC64 the check:

    return ((long)(new_tick - (orig_tick + adj))) > 0L;

Is safe only if retries make forward progress. The comparator can
take effect with a latency, so the moment when counter == comparator
may be missed, which can cause delays or hangs on some SPARC64 systems.

For clarity:
    exp = orig_tick + adj   /* expected comparator value */

The current check requires new_tick to be strictly greater than exp;
equality (new_tick == exp) is treated as not yet passed and the caller
will retry.

By contrast, using:

    return ((long)(new_tick - (orig_tick + adj))) >= 0L;

causes the caller to stop retrying and assume the timer is scheduled;
both equality and greater-than are accepted (new_tick == exp or
new_tick > exp).

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

