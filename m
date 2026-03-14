Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C998342538;
	Sat, 14 Mar 2026 12:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773490678; cv=none; b=JnXzXnbhtLauNklCOLyopbd21p15HNHLEXdawc9AF3tBgWTPL6uZCFRaZJUrIDHmzMPr9OS9kHSA6GzH/rDJau818XL/awQAaMH03SMt8FhhhNntruOWO1SU5wE2EiuNSIU0fam5kd6jcv8j7ag3n1HeKbK2BPVI65y45Vq25UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773490678; c=relaxed/simple;
	bh=rHbvrpMB09EIKcrHOHB7l/K1N11JPzLnC5vzrgZPpHI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Bvv1ko5wqrgu5BB01HExfokwpEF4/RhujETF9vRz2nyhmW2odmu76xGQAiEYKD3Jr911j91CqmHnQSkwMmCxvPYHRWCt8nuivA9tuYKcmAMM2yB6fpeRlYj9RY8zhVwdpRiwywZdvVUzxaQTpMHcy/WaBsGO5cjThQkY2uJfhpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=NDxQzYn6; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="NDxQzYn6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1773490673;
	bh=rHbvrpMB09EIKcrHOHB7l/K1N11JPzLnC5vzrgZPpHI=;
	h=From:Date:Subject:To:Cc:From;
	b=NDxQzYn61lb/ygLX8VDuM9mLFnZuEg6pQqRSF0aDeti6Gt/VQLLIrZxmz8CM1vYaH
	 iyYEK7dR01w+BrIdgmRPewoFzd7SqZUw5FBuLZjo/LgGHsLdhZG88lHDVZRzctRWy4
	 KLwp5oSrp4rlV52wPV4u5/ef6kn3MAZ+2GDbVAS4=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sat, 14 Mar 2026 13:17:49 +0100
Subject: [PATCH] sparc: uapi: Add ucontext.h
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260314-uapi-ucontext-sparc-v1-1-7dd5f8dd8845@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MywqAIBBA0V+JWTegZQ/6lWghOtVsTHyEEP170
 vIs7n0gUmCKsDQPBLo58uUqZNuAObU7CNlWQye6UfRSYdaeMZvLJSoJo9fBoBymWSorpllpqKU
 PtHP5r+v2vh9Qi0nfZQAAAA==
X-Change-ID: 20260314-uapi-ucontext-sparc-157814d0784a
To: "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773490673; l=753;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=rHbvrpMB09EIKcrHOHB7l/K1N11JPzLnC5vzrgZPpHI=;
 b=JkLx88auDozl2LbizZln+EUkuxEdro+bEuHa1IPrmRNBSv+afhicMRmOJkYGcqODYtN2LDpXx
 zVIM8RyMW8KBxD9p15dDwd2nF9/Ug4G1Y92FaIChtfPlS0cFPUtTQm7
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

On SPARC the standard ucontext.h UAPI header is named 'uctx.h'.

Add an alias for the standard name.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 arch/sparc/include/uapi/asm/ucontext.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/sparc/include/uapi/asm/ucontext.h b/arch/sparc/include/uapi/asm/ucontext.h
new file mode 100644
index 000000000000..e9b5dbbedefb
--- /dev/null
+++ b/arch/sparc/include/uapi/asm/ucontext.h
@@ -0,0 +1,3 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+
+#include <asm/uctx.h>

---
base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
change-id: 20260314-uapi-ucontext-sparc-157814d0784a

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

