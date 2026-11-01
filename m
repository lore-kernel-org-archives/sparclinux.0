Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793539465;
	b=H8jC0xHY2iIyp4t/NXe/GOQletlE/JcyCzjfAGVMBHFhPG340Eh13Wl41gZyS3K8I084
	 U61otFMmk1fj+In54b6puILjaP5nDRCCm+VmpspqPhUZ9sjTZ7H6BLHVeZYgm7Y2nhhiB
	 6+er8c7URn+mJ0GQvKnf3kUTBZeehU5g08jQ9i4Q7tufIH5ShVzneLJgXuWoBo2TAYKOq
	 px8KcvhYckE10BUTtdCjv9yyScK7LsdYAuDMp9A5ZBHp18gAHh8T6O5D9kwAoeqVpRv2b
	 sblt6UBku08rYzotxgQn9TV87bhIWoYM31Pt1EjIBSayjoOpeq3JiVHnGkudu9xa2hA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793539465;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:X-Developer-Signature:
	 X-Developer-Key:Content-Transfer-Encoding;
	bh=pG9nbbbJ412FTb+EjzQs+7pZkndD10bTjaBxJRv9ivk=;
	b=MHhoNJWCeJnDdnet7CSAz/uhpSp5P3NZGMQkIQalcGOQYXaCQIQrMHSbFkMH8eFbbwQe
	 I3z2701gcb5RzDc1dKfIngkdMSI4X7wSuQoeiUHI4twqqJ/5jm5p2XJlq3/EGQ7kly6V1
	 eWhb4NwxC47C1l9YbkLuFIM+nzQ99sb6f42F+QNxzZEUjZLYRvSN6U/7SArpb4ilC2cbw
	 k704BSwRUGXQkmW7T61jiBc2dKVDdTbGKqEj23OAZ+wyW4CMZ9SUoA8NJn9J9YAo3UxR0
	 Cr++JseBKCmfaACbtZww15vEKcRV2sc8xvjvpUKw1svg9XqO+Hber9lwcRkjEY6eZiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K1DvobgA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6033A606A327;
	Sun,  1 Nov 2026 13:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K1DvobgA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A13D11F000C1;
	Sun,  1 Nov 2026 13:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793539465;
	bh=pG9nbbbJ412FTb+EjzQs+7pZkndD10bTjaBxJRv9ivk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K1DvobgA9nBS3T0LBRP79BgkkQYPyqlT81sR+L8pXPURc6oGtENvLh15DYE5G8Eyi
	 KbWXh98dMQDB51ygRWq2pPwoqqiBBkCrxe9WH+wliZ4LsSO+Fa2umjcSO2QmZ12pI/
	 8D8pYuRIrKoP8tmU55ZAW6btH0TaatYBlCw9vxSyluL+7z9eyElgEiDVT4lVMPyhEm
	 ywjlUmL49YxtJKtgKdpzHUBL0rQwqflT/yBMuAdIX6Y27wq/aUXom7+c/ZVAVaHvcR
	 WU5LC1rYJmNoTv1Dh4JMwp73ce8z8eD1wZXJbmSMltd+D33msz/MjDI6Oom2RqpEA8
	 ltQxKd8vJgauQ==
From: Thorsten Blum <blum@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Cc: Thorsten Blum <blum@kernel.org>,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] sparc: chmc: Use buffer lengths when formatting DIMM labels
Date: Sun,  1 Nov 2026 14:24:07 +0100
Message-ID: <20261101132407.132460-4-blum@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261101132407.132460-3-blum@kernel.org>
References: <20261101132407.132460-3-blum@kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Post: <mailto:sparclinux@vger.kernel.org>
List-Help: <mailto:sparclinux+help@vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:sparclinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2005; i=blum@kernel.org; h=from:subject; bh=OUR/w4jjoKTbjzdCN5/b1bs9V5NlFJVgje3MxcQawJU=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFnPbStm/GD57CK8Q+7TzLjrKUerpn5zn7gt4HysAR/zz GD/iZ8fdZSyMIhxMciKKbI8mPVjhm9pTeUmk4idMHNYmUCGMHBxCsBE5u9iZDil0T/Zii3KhcF3 4uJfy3b9PNe3WaLwntCqlQdk4sK27+dm+Gd4SrX+44cLD0Sdz+rWJ7aq2jd4rW+cX76bwXwS92H eXYwA
X-Developer-Key: i=blum@kernel.org; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit

Replace unbounded sprintf() calls with the safer snprintf() and
scnprintf() to take the buffer lengths into account. When appending
multiple labels, use scnprintf()'s return value instead of manually
calling strlen().

Signed-off-by: Thorsten Blum <blum@kernel.org>
---
 arch/sparc/kernel/chmc.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/arch/sparc/kernel/chmc.c b/arch/sparc/kernel/chmc.c
index ef31625272fa..9d7d8f791133 100644
--- a/arch/sparc/kernel/chmc.c
+++ b/arch/sparc/kernel/chmc.c
@@ -318,17 +318,18 @@ static int jbusmc_print_dimm(int syndrome_code,
 
 		get_pin_and_dimm_str(syndrome_code, phys_addr, &pin,
 				     &dimm_str, prop, first_dimm);
-		sprintf(buf, "%s, pin %3d", dimm_str, pin);
+		snprintf(buf, buflen, "%s, pin %3d", dimm_str, pin);
 	} else {
-		int dimm;
+		int dimm, len;
 
 		/* Multi-bit error, we just dump out all the
 		 * dimm labels associated with this dimm group.
 		 */
 		for (dimm = 0; dimm < JB_NUM_DIMMS_PER_GROUP; dimm++) {
-			sprintf(buf, "%s ",
-				prop->dimm_labels[first_dimm + dimm]);
-			buf += strlen(buf);
+			len = scnprintf(buf, buflen, "%s ",
+					prop->dimm_labels[first_dimm + dimm]);
+			buf += len;
+			buflen -= len;
 		}
 	}
 
@@ -561,17 +562,18 @@ static int chmc_print_dimm(int syndrome_code,
 
 		get_pin_and_dimm_str(syndrome_code, phys_addr, &pin,
 				     &dimm_str, prop, first_dimm);
-		sprintf(buf, "%s, pin %3d", dimm_str, pin);
+		snprintf(buf, buflen, "%s, pin %3d", dimm_str, pin);
 	} else {
-		int dimm;
+		int dimm, len;
 
 		/* Multi-bit error, we just dump out all the
 		 * dimm labels associated with this bank.
 		 */
 		for (dimm = 0; dimm < CHMCTRL_NDIMMS; dimm++) {
-			sprintf(buf, "%s ",
-				prop->dimm_labels[first_dimm + dimm]);
-			buf += strlen(buf);
+			len = scnprintf(buf, buflen, "%s ",
+					prop->dimm_labels[first_dimm + dimm]);
+			buf += len;
+			buflen -= len;
 		}
 	}
 	return 0;
