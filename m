Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793539462;
	b=O5h1Bh2QLRJhQUjnpRdaU6uayrDVxIK+y7D85fkzuhKNqk0qR8iLLZqgPlSfbdJRmuYR
	 PLI2EI+N8M732vUBF904epLBGBaXcv1L3Oic8BhmaMXhlK3X/1zOjKaH4SIvz+teaAlQS
	 JQ2Od3viNiedbITFAVkgxXi7kh2ygI4wJOlIZdaQyG5DoScJj5ZLiQ6mLqOpVd2+fXpR6
	 icQ8A75CeBALaeKmcFjedrl9XaLJM+hmUxdUwZkP+Fs4D7U9X6dDXZbXXK2t5f5q32ll3
	 7bRBWd3GRZ9Bkn2cOAclS8k0aH3G3nSFkDKEarMvyEINepk9/I85uBtHxEP18HCiryQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793539462;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:X-Developer-Signature:X-Developer-Key:
	 Content-Transfer-Encoding;
	bh=+/8Axo8lEtoVfJEiWHfG9yUGCXzZAanwcuYlpbz8U9Y=;
	b=ezmCo+xPyn7XIHXR4/pgAEkPZuUA9yZGDQA2Kzi9qGyQIUhtT9jgMkYhRqk/11/Wo1Fz
	 rOYRafZKuMWerDfOuXMJ9TvDNe7yMmtvMNPi/Spq8tVhMLKdAP7OR/rtebfJWxVFVIUAs
	 RAVWKpFPfBzwrJ+Ep+dYmjy+xLsuV8e4DspkuzKzkFmx3vw3xgF2DoKncBpFNxEveBBlO
	 wik/pqia6Ce9UBZaEyVAhC0EWYvNsi7lehb/xV2c8FLGJcaMwgQeiTofevE2wbuofBqyc
	 dZisUaTPJpPHdAa8K2xk0XXNaHK6Ty4SU3t8ST7mpeY9ouR0cG3m8lUET7Y9YPVW8pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="k7IVN4/n";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13E1606A324;
	Sun,  1 Nov 2026 13:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k7IVN4/n
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4160D1F00919;
	Sun,  1 Nov 2026 13:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793539461;
	bh=+/8Axo8lEtoVfJEiWHfG9yUGCXzZAanwcuYlpbz8U9Y=;
	h=From:To:Cc:Subject:Date;
	b=k7IVN4/ntMQg1kQbhWGOnT4bIYlMFu1H9h7+Bn/lQMikfJVgCPtvQbyqfdPB3aPi6
	 1oHphWe6XlH4Gb05CdiyZjGvxD3OudIO5WaCujhRD63A05aPxmYpgMUsX3MDNNEIA2
	 0LmvZRoA912daNJW1vOcW+vMjH3HvgiN7aVBKX6sx6IKUuaHnzU0G7ub4Jhvbuc2KT
	 mO5hn6zCb3rhImfBDgW702f7A1vsjSCSHyKS/OWofxZ8P1H61zbMNAeeCmVYsxdmzT
	 tmkBLS027jPVaWUsJnKUxzrPKDRQArzpIeAuUho3CiRh2qsg8z9k+bjwAHPtRc6KGr
	 FRiTbQtPFXxAQ==
From: Thorsten Blum <blum@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Cc: Thorsten Blum <blum@kernel.org>,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] sparc: chmc: Use strscpy() for unknown DIMM labels
Date: Sun,  1 Nov 2026 14:24:06 +0100
Message-ID: <20261101132407.132460-3-blum@kernel.org>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Post: <mailto:sparclinux@vger.kernel.org>
List-Help: <mailto:sparclinux+help@vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:sparclinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1097; i=blum@kernel.org; h=from:subject; bh=eLEIIzTfXV1OlswHuAtMdJ3CdtEdF60kqhRjon+GfB4=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFnPbct3vfc5r5s90T8oN27CJ5fDeqbunKV/Ns0of917b PrRbzG2HaUsDGJcDLJiiiwPZv2Y4VtaU7nJJGInzBxWJpAhDFycAjCRM98ZGWZce5IqwjGZc87s rfVPP1/IX77D0ebZr8nGmguSI/Pvr8xl+M0+rUK79K3clueGN44H/GUTPKS8z2P5l5qTRxaHm5V K8DMAAA==
X-Developer-Key: i=blum@kernel.org; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit

Replace the manual writes of "???" in jbusmc_print_dimm() and
chmc_print_dimm() with strscpy() to simplify the code and to take the
buffer lengths into account.

Signed-off-by: Thorsten Blum <blum@kernel.org>
---
 arch/sparc/kernel/chmc.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/sparc/kernel/chmc.c b/arch/sparc/kernel/chmc.c
index d935177b6953..ef31625272fa 100644
--- a/arch/sparc/kernel/chmc.c
+++ b/arch/sparc/kernel/chmc.c
@@ -304,10 +304,7 @@ static int jbusmc_print_dimm(int syndrome_code,
 	if (dp == NULL ||
 	    syndrome_code < SYNDROME_MIN ||
 	    syndrome_code > SYNDROME_MAX) {
-		buf[0] = '?';
-		buf[1] = '?';
-		buf[2] = '?';
-		buf[3] = '\0';
+		strscpy(buf, "???", buflen);
 		return 0;
 	}
 	p = dp->controller;
@@ -549,10 +546,7 @@ static int chmc_print_dimm(int syndrome_code,
 	if (bp == NULL ||
 	    syndrome_code < SYNDROME_MIN ||
 	    syndrome_code > SYNDROME_MAX) {
-		buf[0] = '?';
-		buf[1] = '?';
-		buf[2] = '?';
-		buf[3] = '\0';
+		strscpy(buf, "???", buflen);
 		return 0;
 	}
 
