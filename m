Received: from cmccmta1.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A69D51CD219;
	Fri,  6 Dec 2024 09:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733477072; cv=none; b=fEoe6A46V+TtNPdkluf+5dOYMQam5beQaDpKtM99onp9vgko1Svd0akwLO2znA5C4bEgKQDYCUVkyblra1efawAvfr3OOUkdDZL3jjgCLrUFpJTcKskG2b+o3NZovZWtFqMsfBfsyktMlIQtTttO8MHYe8JBnY+sHe4vUj2OlPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733477072; c=relaxed/simple;
	bh=Q6bSyJzSL0uJE++wBdTzO9vJM1Vw+medjL01wposyIA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NLdjgkmBiRc3qgFkQSdqyUXqUDqi9hMK0FdlWLm7ErJGiMRDQpWGzZAgb7c5uaELfdLgcyd+rrlVdpTEYHtZ59t3Uet/KLuJ0jCoAi6dgkA2yhXhyvb60NkD/WQgjyvq5TzZgQBvlJbsx1N1C5NzJaOsDH1X9CzgqUBSB+bgyqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee16752c2c6767-b007f;
	Fri, 06 Dec 2024 17:24:22 +0800 (CST)
X-RM-TRANSID:2ee16752c2c6767-b007f
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr04-12004 (RichMail) with SMTP id 2ee46752c2c4742-e2c30;
	Fri, 06 Dec 2024 17:24:22 +0800 (CST)
X-RM-TRANSID:2ee46752c2c4742-e2c30
From: liujing <liujing@cmss.chinamobile.com>
To: davem@davemloft.net,
	andreas@gaisler.com
Cc: sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	liujing <liujing@cmss.chinamobile.com>
Subject: [PATCH] sparc: Move va_end() before exit()
Date: Fri,  6 Dec 2024 17:23:46 +0800
Message-Id: <20241206092346.6003-1-liujing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a static checker warning, so move the va_end call before
exit(1). Since the exit(1) function terminates the program, any code
after exit(1) is unreachable thus notexecuted. Placing va_end() before
exit() ensures that the va_list is properly cleaned up.

Signed-off-by: liujing <liujing@cmss.chinamobile.com>
---
V1 -> V2: Modify the commit information and title description

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



