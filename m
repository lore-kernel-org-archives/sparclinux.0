Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3754D391838;
	Wed,  2 Sep 2026 11:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788348755; cv=none; b=fMVY38Y8b7853Rbg33wvgEmSIMltUcRPucPbGiOKtwLA/pN/CNlsTeq/2nKNkLjQXMAYvx7r036q4hitO/J9xcSmhocIsx489SfhHM37sMjxYmMBvRczXQetV7MzfflT60EnPvlmWmXmhQW5BbiOPtIf7bC04pB3WabhNyUp6SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788348755; c=relaxed/simple;
	bh=AQ2PpGVA8G7z3eoN6jVZRewlOLEsqsxhJKBZkIO6eXI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=evQ9i7jHbztsLAwK8IC2d+yjAB6CRf3OlnYEePde0sgX989vuVgpNmKZ0wdLv/8aNMKnqiRm+8fCuGcj8DRSdVIujUkxQVcHYoY8GflcN/nPqNE83zwTluYqq8TnpB8XszDfSe6+ujsfdwrmHCO0YXG0QOYYdWOdwc9IhEYA94E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=FAo7ezqR; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=mfBCQOvs; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="FAo7ezqR";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="mfBCQOvs"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4hZgZ05lZCzKvt9;
	Wed, 02 Sep 2026 13:32:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1788348744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CBncpdNxhT2wgrUbqZyWv/D9ykxvciWc6wNNNJJ/Ruc=;
	b=FAo7ezqRhW6c7wtw84oL2+WHijwmf/qTrYoK0hDjpW3pcHjvV2KxFa4QEx7UbsWdilHoZo
	eQk6BfnmXKJMtMLSmPQXUUzjrGdyN3Uy96SPqrEslAv9WrPGCnngpR86Puuy7cD338PdaF
	MvnuVzVwnarNTu/aSIDYw8X6/ERPZYIu1o7uhfJK1ts6TEEP/a/rdK+Kcb1W80XdJkgrYW
	1F5oowDelbps4zPRUpJg70O4xOFgESEAuJo/o9g3JKfKJISGV2MIMB6dTWa7OaI+hqnt15
	7Clc+lHIYuPB0lTJia3IkSGn4Ak7SXRRqk5GtUGrGiBboyaRMNFQuam9VklE5A==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=mfBCQOvs;
	spf=pass (outgoing_mbo_mout: domain of manuelebnerli@mailbox.org designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=manuelebnerli@mailbox.org
From: Manuel Ebner <manuelebnerli@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1788348743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CBncpdNxhT2wgrUbqZyWv/D9ykxvciWc6wNNNJJ/Ruc=;
	b=mfBCQOvs87KBUSMIs2+uS7Ey6q/sPzJVpHHkgJLXp1VN+0AtJfT28t8FqHdqPknTuYky6p
	LNUM+TCbd7NTKWW5HW88TGihOCjZbOzYtsJRSyH3RU13Ge9473taPbKVWJTvggmbmKHX3z
	Wqx8B2hBs7ordJeWDG0prx3trlTGaN4MevClku6ht/GISS+dY+PJfGCZgusi1TX5+RAkbD
	pn+aCmXHUBfjMj1M7CDq7Hu036wXxof8f+ZQtKKHMclQMnk8J08KXtMdbvM+8XfWRYgw/Z
	b9bFbP8dwlBUI8st4SzLT0q3852w2miCw77kItCkTIIUXoLRMCv/cBl6a9/tsg==
To: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Cc: Manuel Ebner <manuelebnerli@mailbox.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Bhaskar Chowdhury <unixbhaskar@gmail.com>,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] sparc: NMI: Remove obsolete comment
Date: Wed,  2 Sep 2026 13:30:08 +0200
Message-ID: <20260902113009.684977-2-manuelebnerli@mailbox.org>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 64zq6grwk8yq74kkmcgjzf8gb44n8op3
X-MBO-RS-ID: aed84a56e00241a64d5
X-Rspamd-Queue-Id: 4hZgZ05lZCzKvt9

OProfile has been discontinued as of commit 24880bef417f ("oprofile-removal")

Suggested-by: Randy Dunlap <rdunlap@infradead.org>
Reviewed-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>
---
Bhaskar Chowdhury review doesn't show up in the mailing list, but I got it.

[v2]
 fixed referenced commit
 + Suggested-by
 + Reviewed-by

[v1]
 https://lore.kernel.org/all/20260830125506.632168-2-manuelebnerli@mailbox.org/

prior discussion
 https://lore.kernel.org/all/875527abdf9df0393ade872c6df3612ae9945b44.camel@mailbox.org/
---
 arch/sparc/kernel/nmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/kernel/nmi.c b/arch/sparc/kernel/nmi.c
index 149adc094..1571d6298 100644
--- a/arch/sparc/kernel/nmi.c
+++ b/arch/sparc/kernel/nmi.c
@@ -41,7 +41,7 @@ static int panic_on_timeout;
  * <0: the NMI watchdog has not been set up, and cannot be enabled
  *  0: the NMI watchdog is disabled, but can be enabled
  */
-atomic_t nmi_active = ATOMIC_INIT(0);		/* oprofile uses this */
+atomic_t nmi_active = ATOMIC_INIT(0);
 EXPORT_SYMBOL(nmi_active);
 static int nmi_init_done;
 static unsigned int nmi_hz = HZ;
-- 
2.54.0

