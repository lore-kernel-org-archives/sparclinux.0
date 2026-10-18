Received: from a3.inai.de (a3.inai.de [144.76.212.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9DE449EB8
	for <sparclinux@vger.kernel.org>; Sun, 18 Oct 2026 22:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.212.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792362271; cv=none; b=cGQZNKzqvnpRI2BmuE+IPiryKqQFv7EUdfwM0g7K0tIqGY0rQPh+x2InfZmUnoP3rHNMDEK+vRRB9VyDarsJbte2PRexMM63SN1PGiS54gcU3ClFcPKLo/dlhW3+02OYgCkNaIXpJxAw47T9gthD4OOXLCyXQ0obIF/DNqEqFzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792362271; c=relaxed/simple;
	bh=ktXzU0XEnWQG61HP0771budoM7y02E35GLeszlywFms=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hi1btzkjShBXxbZWmTG69JzYfNX4L4vJvbBTNUNfTJP/WmVAF6Fa1a55Z2kV+uTVsOvKhmWcJ9JR7yxyH9I2D3xtwwpmHyxNzRkLUxP5d1tN0lYhOgN7XabIF+og8qGENnsFdKJspSVUkFYT4hPKuxyFhXCGlmv77tKr3i3jrUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=inai.de; spf=pass smtp.mailfrom=inai.de; arc=none smtp.client-ip=144.76.212.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=inai.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inai.de
Received: by a3.inai.de (Postfix, from userid 65534)
	id 280301003DD446; Mon, 19 Oct 2026 00:24:20 +0200 (CEST)
X-Spam-Level: 
Received: from a4.inai.de (a4.inai.de [IPv6:2a01:4f8:202:600a::a4])
	by a3.inai.de (Postfix) with ESMTP id 08A6D1003BF4B4;
	Mon, 19 Oct 2026 00:24:20 +0200 (CEST)
From: Jan Engelhardt <jengelh@inai.de>
To: sparclinux@vger.kernel.org
Cc: davem@davemloft.net
Subject: [PATCH] sparc: add function comment explaining different thread groupings on SPARC T
Date: Mon, 19 Oct 2026 00:24:18 +0200
Message-ID: <20261018222418.43335-1-jengelh@inai.de>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Jan Engelhardt <jengelh@inai.de>
---
 arch/sparc/kernel/mdesc.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/sparc/kernel/mdesc.c b/arch/sparc/kernel/mdesc.c
index ecd6c8ae49c7..23b51a32e96e 100644
--- a/arch/sparc/kernel/mdesc.c
+++ b/arch/sparc/kernel/mdesc.c
@@ -1027,6 +1027,15 @@ static void mark_proc_ids(struct mdesc_handle *hp, u64 mp, int proc_id)
 	}
 }
 
+/**
+ * This functions groups threads into cores by looking at which Integer Unit
+ * is used by each thread. This can make Linux report different core/thread
+ * counts than the hardware description. E.g. the T5240 machine (8Cx8T) is
+ * reported as 16Cx4T, and that benefits scheduling when >8 integer-focused
+ * processes like compressors run simultaneously. (Other properties like
+ * type="fp" or cpuinfo_sparc::core_id can be matched to get different
+ * groupings.)
+ */
 static void __set_proc_ids(struct mdesc_handle *hp, const char *exec_unit_name)
 {
 	int idx;
-- 
2.56.0

