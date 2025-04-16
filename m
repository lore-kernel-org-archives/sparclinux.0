Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08902DFA49;
	Wed, 16 Apr 2025 12:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744807495; cv=none; b=QRhhOQOuP+cGsqEc94gqNbsJ8prV82exRpdjsEmIj8KTtBCDhYME1VYQRChmp0NgVS01OIA9K75iqTm+oLG12cIcWyJAiDMAfw/wBPgWn4r2OB9NNmhCwHJSajV9JkK1CbZQEKBGNDHz5MNZNnWnj9YXCB2t7ax0YESomuZ95h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744807495; c=relaxed/simple;
	bh=PnVxcRWARIPdy3zD0wzUXGo7haIXrfNVtzFl9rL6PHg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=b4E/D5Pc8rhoHJIt/jg0I3OTolSfZJDhwf+ciWALsDbsp3/5pxZrMF/efpet6TroQwEOB40PSB2X137Ptr1aFp6atYv0nFPrT7aYjwhE50pwh95zs2dol/EGDjofPazmGmHIHU+Ys4AFlvnbCS/+BxBmMCzToSWYYUsmHTJJcHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fn6Gr3YR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CqpTkjC6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fn6Gr3YR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CqpTkjC6"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744807491;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0V2tltp7rLoJJI5D+sEpJCOe8NF2uU3qehp4Rd/tkvk=;
	b=fn6Gr3YRcGoz4EadUMjr/47qOVtQEYivNqqxhqBlXsnaMbjGvF6EaWU3+ERmBxYszL4jKB
	EKLnrMbML277hS9oAoxAC1cRjwagexrsC0kPlXUAA/D687UZ6mAse+OF/8iAg6EHbc9KCY
	s5Z56NLYJXzWs1hWBzVtoF2pwyxjy8KIi7c+mx8je1K9bvtTSLTFBwXTWFVvT6ws1kbks/
	rOiYO5tNj5M1scDOR/nnZqtIMuHOvioynRlRDVA7vSIdS7smyD4tgrnylgEux5OyuhCJAh
	yJ7s4X9OtHjQsl0atCAdEDuFprtVHwcpgNCH8EHlZ7w5JuQ0HFwfPIHdPv8wUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744807491;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0V2tltp7rLoJJI5D+sEpJCOe8NF2uU3qehp4Rd/tkvk=;
	b=CqpTkjC6WVXhzuAWgRFEURp/8zZINmmLZL3aIpG2BT79CPP5H0UMuRoVl+gMRNaCsQCVDA
	+wd1TuktMTgq8HCQ==
Date: Wed, 16 Apr 2025 14:44:19 +0200
Subject: [PATCH] kunit/usercopy: Disable u64 test on 32-bit SPARC
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250416-kunit-sparc-usercopy-v1-1-a772054db3af@linutronix.de>
X-B4-Tracking: v=1; b=H4sIACKm/2cC/x3MTQqAIBBA4avErBvoxyK6SrSQaawhMNGKQrx70
 vItvhchsBcOMBYRPN8S5LA56rIA2rRdGWXJDU3VdJWqe9wvKycGpz3hlTEd7kVq+4Vb0orNAJk
 6z0aefzvNKX1FB4EYZgAAAA==
X-Change-ID: 20250416-kunit-sparc-usercopy-c36de3ca4ef8
To: Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Gow <davidgow@google.com>, "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, sparclinux@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744807489; l=1347;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=PnVxcRWARIPdy3zD0wzUXGo7haIXrfNVtzFl9rL6PHg=;
 b=hbTu3XkiauW7qvM9lT33V8rEaBO+LzJYP9U7fAzLZdtF5l/eJzGOIxeyVWfPzEsKlRoKvnqYG
 MnTeF7MuDpIBXgPEiKMGbz7Wv7vhv0Bo2Fryrz7yoEsq2oOpP11Noie
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

usercopy of 64 bit values does not work on 32-bit SPARC:

    # usercopy_test_valid: EXPECTATION FAILED at lib/tests/usercopy_kunit.c:209
    Expected val_u64 == 0x5a5b5c5d6a6b6c6d, but
        val_u64 == 1515936861 (0x5a5b5c5d)
        0x5a5b5c5d6a6b6c6d == 6510899242581322861 (0x5a5b5c5d6a6b6c6d)

Disable the test.

Fixes: 4c5d7bc63775 ("usercopy: Add tests for all get_user() sizes")
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
To be honest I think sparc32 wants to support usercopy of 64 bit values.
But it does seem to be broken.

(+Cc SPARC maintainers)
---
 lib/tests/usercopy_kunit.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/tests/usercopy_kunit.c b/lib/tests/usercopy_kunit.c
index 77fa00a13df775074a19772bfbc9120ef33634bb..80f8abe10968c1d91c61006f1eaa63858c633872 100644
--- a/lib/tests/usercopy_kunit.c
+++ b/lib/tests/usercopy_kunit.c
@@ -27,6 +27,7 @@
 			    !defined(CONFIG_MICROBLAZE) &&	\
 			    !defined(CONFIG_NIOS2) &&		\
 			    !defined(CONFIG_PPC32) &&		\
+			    !defined(CONFIG_SPARC32) &&		\
 			    !defined(CONFIG_SUPERH))
 # define TEST_U64
 #endif

---
base-commit: 1a1d569a75f3ab2923cb62daf356d102e4df2b86
change-id: 20250416-kunit-sparc-usercopy-c36de3ca4ef8

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>

