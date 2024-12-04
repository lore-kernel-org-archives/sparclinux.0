Received: from cmccmta1.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D1C19006B;
	Wed,  4 Dec 2024 11:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733311321; cv=none; b=bPigG1yJ2yCcJsF2KUaRRLH/nS1uwA7uhFi9YxtUI5gEC2ZDsGeOgUjIjY5dMVydgcwy16cQ8lA5A6TmZelI8+7PWS0LVJj0spiahTezv8WOudGMFowTh3H4BBNQqawEfiC/ZSq8yJEVkSVJyfGyK+JoW3LdKfQzh5pFSmYGJZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733311321; c=relaxed/simple;
	bh=AYbb+rF+ywLzQOVxrKLvkv9kw6zjIz8WUk0+2drTFno=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ESXqiZbjBKCTtXG+tWFiYeXemGJG5CjWf3r7t/WIu+A2oiRVBXYsa/wvXPAYu2F1U3DqQLFAqw2Q2FXVVMUJDZFT4u3QOBkDLeLXuAbUpLDTlXkEfVsRCR00xfzDPUUwwn93AfnDzwyUqAzf15By2ZE4k5D06mFevqmm+pYVico=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app02-12002 (RichMail) with SMTP id 2ee267503b4b52b-0354b;
	Wed, 04 Dec 2024 19:21:48 +0800 (CST)
X-RM-TRANSID:2ee267503b4b52b-0354b
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from 192.168.28.197 (unknown[10.55.1.72])
	by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee367503b4a0f5-6a24b;
	Wed, 04 Dec 2024 19:21:48 +0800 (CST)
X-RM-TRANSID:2ee367503b4a0f5-6a24b
From: liujing <liujing@cmss.chinamobile.com>
To: davem@davemloft.net,
	andreas@gaisler.com
Cc: sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	liujing <liujing@cmss.chinamobile.com>
Subject: [PATCH] sparc: Move va_end() before exit
Date: Wed,  4 Dec 2024 19:21:45 +0800
Message-Id: <20241204112145.6987-1-liujing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch makes a minor adjustment by moving the va_end call before
exit. Since the exit() function terminates the program, any code
after exit(1) is unreachable thus notexecuted. Placing va_end before
exit ensures that the va_list is properly cleaned up.

Signed-off-by: liujing <liujing@cmss.chinamobile.com>

diff --git a/arch/sparc/vdso/vdso2c.c b/arch/sparc/vdso/vdso2c.c
index dc81240aab6f..372e3330850a 100644
--- a/arch/sparc/vdso/vdso2c.c
+++ b/arch/sparc/vdso/vdso2c.c
@@ -90,8 +90,8 @@ static void fail(const char *format, ...)
 	vfprintf(stderr, format, ap);
 	if (outfilename)
 		unlink(outfilename);
-	exit(1);
 	va_end(ap);
+	exit(1);
 }
 
 /*
-- 
2.27.0



