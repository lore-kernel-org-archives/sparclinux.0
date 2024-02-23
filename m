Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E070B1292C6
	for <sparclinux@vger.kernel.org>; Fri, 23 Feb 2024 16:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708707591; cv=none; b=sO49nvwQcSIeldkhrjjs4XiUahz/x4wPZGe7igUgekpMljIGbHsdJojkCCTUWK1W7q9VRJhJbn9g99AsI9LB7wumYH/u+3wf5HK1Uj6/okzU/Tb3gadcSOJokwNQe0XVqzaPrx1O9EmTMvOjaMTJrN/oQ3Gn4uynPIqw04alFy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708707591; c=relaxed/simple;
	bh=GFnd+uRgcZ5JE6+yaYSUeEigjBZZ5ehiRJbCdQFjMSg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IRbjgjD+xQ1IYYDxhDWpLqlSXMRu0PyPnENe4InMjK7ZIOEXSS52t9l1ellMT0zqR/ZoduGF1djlHQiJmLKyC4pXecBsypYfP25tudCdmzjYUeWBTTdOfWny09/cOXyByPKyX5stuhqL8jsP5PDZFXCLDWa/YNN3/aAY4xVYep8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nitAuW0n; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nitAuW0n"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6e34d12404eso389520b3a.2
        for <sparclinux@vger.kernel.org>; Fri, 23 Feb 2024 08:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708707588; x=1709312388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FDMzDk/lBMFwiZnh7jtuEycU3dW7wec2i4CrQjkGJo4=;
        b=nitAuW0nEJXqcuwrvok8CkVkbfn2pnfOCTGqhqgni0qOUhvTAhltyrpkmRwSRrbh0B
         98mW8FxQhTkRddbNuvjY1OlR4EehYdeL0eARCJG8gW0y3gsHiuUVmVyOiDl/jLh1TF5D
         j58bfHK882zi2L5G6JAhTPLzgzIjkBqHE0PuQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708707588; x=1709312388;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FDMzDk/lBMFwiZnh7jtuEycU3dW7wec2i4CrQjkGJo4=;
        b=OObfA8blnvpdJm66m/U+0eyTO+5EEHdij/0HrKFLIib84jC2aSW7E/wu+L4//QNbHV
         /vla3p4cuHuRte7cRz+Tg90U4+VK3BhMKpxgLCCQKySomXhDyAQTtdjMsGhQniVwpQZ1
         rbt/lP4rIEG5PLXTabRDttua7F0FFoTMNPPdGviqd6ocsJqRd92217NMjrzvKglO5yoy
         ncB1ZBHHz/nrbNdCpvmWGpKBuWt7NYleJMjNR5A5+FK7BlGD8JmXRd5UlXPFF+AAP51m
         UeeGkHDygF9avQHN1aFIzSTawmgrGILIuGEjBZcyjfuJMKs7jcjvwN/EdQJnHUVWqm9x
         sxow==
X-Forwarded-Encrypted: i=1; AJvYcCV+kAfvrZfyuM1pB/9FIsQtZvhPyeSyIPmEUuv1PvXN/nW+vQZuJszJ0w9TBIGYdXvQ7Z4irCJZVNOMWpSbiDR4cAHyz4HUwzz2ow==
X-Gm-Message-State: AOJu0YxNWgRHCdW46m6f61jBgELJ3aQB33vbOIMxUHHHvOd7XbPsF3E0
	9F6DNaEjHvKjIAz9mFUs4xYA2e5Obfc5ZZE38l7M5j4murlhuhIKHzeUQXnrcg==
X-Google-Smtp-Source: AGHT+IHX/Yc4T9nL5wRR/DYkhblZDpzp2THzLbdrmdP4IR1mBZ1kcT2liaypJSpebHmorYbeiH+inw==
X-Received: by 2002:aa7:9d82:0:b0:6e3:636b:dd99 with SMTP id f2-20020aa79d82000000b006e3636bdd99mr331864pfq.24.1708707588228;
        Fri, 23 Feb 2024 08:59:48 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id o74-20020a62cd4d000000b006e3f09fd6a7sm11865200pfg.85.2024.02.23.08.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 08:59:47 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: Kees Cook <keescook@chromium.org>,
	Andreas Larsson <andreas@gaisler.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Sam Ravnborg <sam@ravnborg.org>,
	Helge Deller <deller@gmx.de>,
	Guo Ren <guoren@kernel.org>,
	sparclinux@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] sparc: vdso: Disable UBSAN instrumentation
Date: Fri, 23 Feb 2024 08:59:45 -0800
Message-Id: <20240223165942.work.950-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=997; i=keescook@chromium.org;
 h=from:subject:message-id; bh=GFnd+uRgcZ5JE6+yaYSUeEigjBZZ5ehiRJbCdQFjMSg=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBl2M8BVTkPTYzeAtIdjSlijqw9uZvhDwrdnLvn9
 blIHXwVpeGJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZdjPAQAKCRCJcvTf3G3A
 JoCwEACKVFAmUO4no0Qaxq8qbED2OYobHjEx8UJ+OGsvTvGLxdH8D7zH1Jm07MIB5qteNWszAPW
 mmeZi2C8ojqf8QZCcqjRXQJWlCBUm6nET1lK20B7bHNNenRsAU3f+oq4vdh143ne09ThQL0vycD
 GkDx6xhb0cdwF/fuoUugrYKfxI242MeUa/lIkLQMoxXyJ+uQvBLKYtshUKKs/AdBkdZ56fsAR6W
 WK/+Q26n6BKUSxtMnNvhGt+AiOe0ElsbAbAPLSAf/+ACWu34JMXSe6b3o6WbemF7w6zZSFfxx3L
 aiWCjVpYB49at5XwwkPh4ZiViM11V4RJIIV8Wq2Lj3Wn2SfL+xAfohSXysGvuiAxtXG7wgnWXCl
 YkaEHux6vs5pt1/gsv6WKr+/UpXZvWQJkqpYBmRJY502AnAbYg00exgRnJoCpHC2bgyAS+cb9Zu
 YqnvktgImg3XSAhBvOhxXMf/40ggBFstPwm6YOucNM1IdW4aKRktYWll8E0i3M54hNRCm8eREdF
 7CUN7Wo3pISsoJ5iWpsP3QdnuKVtUTXyu7XI5CcS33ZzxMMFpWTwMH1yZcEwM7e5+h4a4tSFsuK
 jSEdGEu1KEwGh3gepDThUCJTuVkHMRQLz80mbbn4/SrwStrx23fql2KEfgBMP0h30pfMsV78289
 Q67U30eW 2zupgVA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

The UBSAN instrumentation cannot work in the vDSO since it is executing
in userspace, so disable it in the Makefile. Fixes the build failures
such as:

arch/sparc/vdso/vclock_gettime.c:217: undefined reference to `__ubsan_handle_shift_out_of_bounds'

Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Andreas Larsson <andreas@gaisler.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Helge Deller <deller@gmx.de>
Cc: Guo Ren <guoren@kernel.org>
Cc: sparclinux@vger.kernel.org
---
 arch/sparc/vdso/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sparc/vdso/Makefile b/arch/sparc/vdso/Makefile
index 7f5eedf1f5e0..e8aef2c8ae99 100644
--- a/arch/sparc/vdso/Makefile
+++ b/arch/sparc/vdso/Makefile
@@ -2,6 +2,7 @@
 #
 # Building vDSO images for sparc.
 #
+UBSAN_SANITIZE := n
 
 # files to link into the vdso
 vobjs-y := vdso-note.o vclock_gettime.o
-- 
2.34.1

