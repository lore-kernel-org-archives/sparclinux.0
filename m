Received: from mail-pj2-f4.google.com (mail-pj2-f4.google.com [74.125.227.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A326F1FECCD
	for <sparclinux@vger.kernel.org>; Fri, 18 Sep 2026 03:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789702424; cv=none; b=bESPxv086zHWQYGSSuEUtdTxLO9Le6Lo6KD9L6fw+Mx7giWIKTSAxZRzJ/t/FVBpncWDSdSccp8De99tEUPQZmmlhGcFCHlR3zoE8I/WzTrd19miD0xZ3vEXWkVUAlX2QQEtMIgZbygCb78nhJox46f8Nt+eNneykA433oMJzXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789702424; c=relaxed/simple;
	bh=2emAoDVm8zTylpklrxSJ7rpLT1InGL0rnzuBdAmG5nM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SKM7PKJBpEVP2TnX7VWmT43FJHDJqhbDAYvrMhKVFjzrLLyvsWpaudYWIF/2q2tgygO7/giQ0J4ZrIqsBx2hRbVBQyUd6nANKlg93UXWaDk+2s8yb4uu5qd0+35iAYmWqBjSm/mksxI7P5CBjIPl8yeVrq8+xOpwv7oMF3hg8TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KVoNH+/t; arc=none smtp.client-ip=74.125.227.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KVoNH+/t"
Received: by mail-pj2-f4.google.com with SMTP id 98e67ed59e1d1-3896ccc93b5so79872a91.1
        for <sparclinux@vger.kernel.org>; Thu, 17 Sep 2026 20:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789702423; x=1790307223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QSDJ6V6BBcF6J0/fAse8ZdSMIwz3a+5DHeGeQs0erxI=;
        b=KVoNH+/tp1kS3fh79ExSaIoWoOwC+3/QTU6zutOe8kCe1xzrYF68gGkE2EZ6EhC6q6
         oRgVKCBV9S/pzpwr5BswFjO8pLtGxa3AukZVkoyyLRWzucqNFl1Jh9SOXZNj763SaWfE
         2OK2BUffmOZAagJG5CKBiFoPaO2xNbmisFXq288S9dxHVI+6etdq6Un0d2c9bup+lKHe
         e6mrZrrAVaNH2W6Rs3QmU6sLcfcUhqi3/UdOVeWfOIdv7iEmoGf8aIGttSp/Mwhrjkms
         nL+1XFKumwsO7Re/LkA80HoeKo+waJzUO8iF2BtOsCWaiOra1gzXpcGh33Sfu4UhdfJQ
         20Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789702423; x=1790307223;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QSDJ6V6BBcF6J0/fAse8ZdSMIwz3a+5DHeGeQs0erxI=;
        b=grOPn6UK2jjExM3cQPzQlhxUkEJ0FFK6V++3kk4qrR7NlcaShvMKQbqdv0Uy1elbR+
         mspnX4Tt96CDAoDV7i5S1o7nZyim5difO/T1ySgFcQE0cIL4CkJJPP1YZRkKBl0O85nE
         QsK69VzhKQLS0FuNyiRLyr0ozxNziycbmClTunRgZXFjZ2QAUkp4u2Gwi2frMXHiP3iz
         L03fxxclUvFzb9EFxfY720IxrpXFXAH4KkB0zUKLovMWGP6R3e7aeT5n9Fla06hqdVFz
         CEw8ZiU1Mk8qUlAb0AqFwDgq2zBqVf2yeFoGZMG4D6eYUzK43ntUKUnSEtHHd4EVfrXy
         SNwg==
X-Gm-Message-State: AFuF++m58hNaoCyP/ky3y56cLSgFVoYlAn3hmLwVJ4sXxZHj0S6ahcHi
	gQRwPA9m5okHt5RdeofQ9Xf1/CaGPy3y3VRxoNgk9BYkJFrgoy0dFg2Z4DrvKR54Xv8=
X-Gm-Gg: AYBFou1Zu2PbEZb9IH6mC897sKf+YYuauFwwIPr2JxeTsodY56yeEkIAWkYY8taYMEr
	68zYSTGLC5ZQxxlWioavdKV6XScTsavuh+jUljBS86nt/CGrzO6gtaYA7ihv/PN3QGsfM+FOq/M
	rz1OxHwiDmi9rq9dfFpkfVO9q+PNHbM+EUTCgU5fLSL5BGUF4IZqiB4HKFNGMtHtEZ5CgK4XHkV
	ME7z6u4k5d9PKHU9N0tlMZcAM8vFiGCMwvYYbs4y7t2EWoqpYtSv3oZtaEyg4ksAg4mNUb/xyqD
	rbfUm2xgZa1KkC8YhcXhORZIrIGwMFVey3GE5GOaq/2ZA8jUIRBrCoqwOiFmfiSuR66Qz2DUpac
	Os1zZsjHaarQfQsgPY/+2kcomuTlyEyErWJumOt54vYPeCWHG2ArbmEReayxN7ZnSKaY97vJ/O4
	GcG7WmM7qvHrP6jMWJ7cm27yi8WDOn5sUzcSi68w/PHhZlty067aGHJ20QdHU0O2Moq222kg4H6
	4eaJsOLenRBJ5dk0rnklkoLim7wKEkTTOqdnUbl/37xhiNkLyyXv5SWjwNagN8sUZVILN6cpNpr
	uRO9WrpCpd3dMnMT6C4OaZlPryhNnHcplJIajnrUjveLjU3tOo7D7v/2MUQ4JnxxTg==
X-Received: by 2002:a17:90a:2ca7:b0:39e:58e4:dc0f with SMTP id 98e67ed59e1d1-39e58e4ddfdmr1140062a91.10.1789702422805;
        Thu, 17 Sep 2026 20:33:42 -0700 (PDT)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c2876965dsm712388eec.19.2026.09.17.20.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 20:33:42 -0700 (PDT)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: sparclinux@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Subject: [PATCH] sparc: remove unused empty <asm/eeprom.h> header
Date: Thu, 17 Sep 2026 20:32:22 -0700
Message-ID: <20260918033228.491680-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

arch/sparc/include/asm/eeprom.h has been unused and empty (except for
comments) since at least Linux 2.6.12-rc2. Remove it.

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 arch/sparc/include/asm/eeprom.h | 9 ---------
 1 file changed, 9 deletions(-)
 delete mode 100644 arch/sparc/include/asm/eeprom.h

diff --git a/arch/sparc/include/asm/eeprom.h b/arch/sparc/include/asm/eeprom.h
deleted file mode 100644
index e17beeceb405..000000000000
--- a/arch/sparc/include/asm/eeprom.h
+++ /dev/null
@@ -1,9 +0,0 @@
-/*
- * eeprom.h:  Definitions for the Sun eeprom.
- *
- * Copyright (C) 1995 David S. Miller (davem@caip.rutgers.edu)
- */
-
-/* The EEPROM and the Mostek Mk48t02 use the same IO address space
- * for their registers/data areas.  The IDPROM lives here too.
- */
-- 
2.43.0

