Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B8B29D281
	for <sparclinux@vger.kernel.org>; Sun, 27 Sep 2026 00:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790470784; cv=none; b=Yfj7y2eeLZ5GLQ/3Ev1QXZePo1DUC7B21B6bxMCFtK/EJZJz9W/fEfskDxWnA8quWB3LuXGBkOIFsHy7vodpItjc8+eisw0DM+47p4vAcMzAmTMc0tKLijQ/UGs7N/At6nY7pTDUpXEl8dcKaj9bMM66Tc2+1+JKVTj/A5FnbLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790470784; c=relaxed/simple;
	bh=T+7RCrS9qZzBRBjjw1FNIxPyPfUIA4sYoVzNtvCusnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uggkrd3CPrvLh8D8Ee37zaXB2c59IthiDGT1g8ii3pk1KoTJG/JC8JPv8qnABpxrurvixvCCYxgOZkiF0ZVHdWY7qhmngxtfrMw63ruucn7nzthEkd0g/zL742BaVlRhm/n5Z7rO2HRoa+G7Ea4Tn6mkcjfFRbG1WCBLFH69aJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=afoIpiz7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="afoIpiz7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0396C1F000FF;
	Sun, 27 Sep 2026 00:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790470783;
	bh=HmVwWw9sYtO/LTRLE0BPqAsZu4M/a5Xl9IS9DWyFhng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=afoIpiz77wsj/ywstti2cEGdaxeMxC8mH+KxJ6Fge9ebcOp8+ahkX/KJNtf0w5dAq
	 wI5UzLE363hxbNtsRG2GYAxal2NVFCGYJj7pIOrPvHYZbuD+EF3L5v5846hFxV74EC
	 lR6kxVaHh2M+Pmg94rRyRxChy1uJIbhY+MyDhlY+1+6lfbhAwmyfGT2rvdmWrSAFgd
	 21fp2xAHZrpKDl309a20FTOEgLKJvV23JoHc2pQQLIE1c1BEx7U9ThUSjFZkCYKA2y
	 w8Qhq8vRIN+ZhjZWwHldigtbNM+LNKt/qWzU3TQAKd9yMSAv3fErjjyxZXXge36Dlg
	 iPdQEX+rxOLdw==
From: Imre Kaloz <kaloz@kernel.org>
To: Andreas Larsson <andreas@gaisler.com>,
	sparclinux@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 2/2] sparc64: make 32-bit userland support configurable
Date: Sun, 27 Sep 2026 02:58:37 +0200
Message-ID: <20260927005837.8402-3-kaloz@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260927005837.8402-1-kaloz@kernel.org>
References: <20260927005837.8402-1-kaloz@kernel.org>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CONFIG_COMPAT has no prompt on sparc64, so a kernel that will only ever
run 64-bit binaries still carries the 32-bit system call table and entry
path and the compat signal, ptrace, ioctl and System V IPC translation
layers. Give it a prompt, keeping the default, so it can be left out;
in a sparc64_defconfig build that makes the kernel about 88 KiB smaller.

Signed-off-by: Imre Kaloz <kaloz@kernel.org>
---
 arch/sparc/Kconfig | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index ab77d3f2536e..3779fb3169ab 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -447,13 +447,19 @@ config SPARC64_PCI_MSI
 endmenu
 
 config COMPAT
-	bool
+	bool "Kernel support for 32-bit SPARC binaries"
 	depends on SPARC64
 	depends on !LD_IS_LLD
 	default y
 	select HAVE_UID16
 	select ARCH_WANT_OLD_COMPAT_IPC
 	select COMPAT_OLD_SIGACTION
+	help
+	  Run 32-bit SPARC binaries on a 64-bit kernel. This builds the
+	  32-bit system call table and entry path, and the compat signal,
+	  ptrace, ioctl and System V IPC translation layers.
+
+	  If unsure, say Y.
 
 config ARCH_CC_CAN_LINK
 	bool
-- 
2.47.3

