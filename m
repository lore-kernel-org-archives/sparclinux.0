Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.189.121.228
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795002948;
	b=eZ22xaFVEmlRfdy4f5AgRPUodVYr1iQWOfYUt0GSnffovEBp9EZAwh3V0umtI1sSt5p6
	 2h/cxcSjnCqUqJpYqn2jyqdxupiLaGf6iQOIkZSpUyV3PsZIZFmUvIWnn2L21UthlsWlz
	 xa9UiRNedx79+cLsiyVF1EhP6Ac9OUxQQN8AviaAk8OKdwtxh1YLnHciZlXtwEHD4aocs
	 KL/IU2DHb0bNWhi91IssT+r8aRySbA5NdXw5JSDYmE7KLaWTgIqSgOTgk6abZOdMlnNDY
	 DTzxyCpC+hedXmGmTRMTshSA4Co38PRJGeCmLhv5x/U4amFOQmvCu0WfYMM6QnEEcDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795002948;
	h=DMARC-Filter:From:DKIM-Signature:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=64GxpCKk75iYt37yA+OLbKHSvISiemtcWyONRarURzI=;
	b=Kp4HLZ+sZOFMa4ZYQUzKD7RPwkDb+IkcuB5mKBm0A1XX6vlVRy+GpX2V3z0pUbQjrGPE
	 fJ+52Vu72vo1bg87EzVa/23A+HsDKh6QxK8wOVD9R0AlrmuC+4yxwmHRu2f5hE2p1IlVJ
	 0m1JoY6Jidy8ZONLVwgM/FXgaFodDXp8DujilVyRT12spS1I5BqDAol1jXH3Hn0Q7EiHx
	 d26VJDkzJFfhhBySujIh1DTfMSEl6ZIl6XzANLMPRSB+tXAz7mGpR3n+AlhbKODP3WOc3
	 mUg2YSb9oORdJgIQOAnbpLwmKOwENWzBOZ2WBrpxKOCqem2AUHj9xwcA6qQIJ+gCDZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=itx.no;
	spf=pass smtp.mailfrom=itx.no;
	dkim=pass header.d=itx.no header.i=@itx.no header.a=rsa-sha256 header.s=mx.itx.no header.b=JZ6cXVx9;
	arc=none smtp.remote-ip=91.189.121.228
Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4F1606A325;
	Wed, 18 Nov 2026 11:55:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE4F1606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.a=rsa-sha256 header.s=mx.itx.no header.b=JZ6cXVx9
From: Stian Halseth <stian@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1795002945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=64GxpCKk75iYt37yA+OLbKHSvISiemtcWyONRarURzI=;
	b=JZ6cXVx9gaBOJVILyi6m4l0ZHxYWy/3LiP8eHzEX2edLtRytL1OeTgvhUnOiPe6kjc+W8/
	PZYpAYzw1GT4EbI4t14gLVPOefVFClclWr3h/nZtZXYzo5HDAx8Wnw3T0hJiJujy0XNRq9
	c4ciVqpmcNssHEjU3QH2q7CmNHYSXsI=
To: sparclinux@vger.kernel.org
Cc: Andreas Larsson <andreas@gaisler.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Biggers <ebiggers@kernel.org>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	linux-kernel@vger.kernel.org,
	Stian Halseth <stian@itx.no>
Subject: [PATCH v2 1/2] sparc64: Stop the hwcap-list parser at an unterminated entry
Date: Wed, 18 Nov 2026 12:55:36 +0100
Message-ID: <20261118115537.160675-2-stian@itx.no>
In-Reply-To: <20261118115537.160675-1-stian@itx.no>
References: <20261118115537.160675-1-stian@itx.no>
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

mdesc_cpu_hwcap_list() walks the hwcap-list strings with strlen() and
strcmp(). If the last entry has no NUL within the property, both read
past its end. len then goes negative, and while (len) does not stop.

Measure each entry with strnlen() first, and stop at one that does not
fit, as of_property_read_string_helper() does.

Signed-off-by: Stian Halseth <stian@itx.no>
---
 arch/sparc/kernel/setup_64.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/sparc/kernel/setup_64.c b/arch/sparc/kernel/setup_64.c
index 63615f5c99b47..96de9fe84cd44 100644
--- a/arch/sparc/kernel/setup_64.c
+++ b/arch/sparc/kernel/setup_64.c
@@ -489,6 +489,10 @@ static unsigned long __init mdesc_cpu_hwcap_list(void)
 	while (len) {
 		int i, plen;
 
+		plen = strnlen(prop, len) + 1;
+		if (plen > len)
+			break;
+
 		for (i = 0; i < ARRAY_SIZE(hwcaps); i++) {
 			unsigned long bit = 1UL << i;
 
@@ -502,7 +506,6 @@ static unsigned long __init mdesc_cpu_hwcap_list(void)
 				caps |= HWCAP_SPARC_CRYPTO;
 		}
 
-		plen = strlen(prop) + 1;
 		prop += plen;
 		len -= plen;
 	}
-- 
2.43.0

