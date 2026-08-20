Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DFD446848;
	Thu, 20 Aug 2026 13:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787231588; cv=none; b=PTvI5U6w1EzBctsyApJcJwpFRiy52/H0Evs1HtCD9vaCDPJISOOu8ELPe6rAcre2Oid6pSKw0LP/m1v06rIVT4HMPtHXRs4OZk+v5SwkM+Yw7IDNjIiJqRPASO9kH3Dkjl1pe+3ny6NT65lmUHnsFVP+xlwGO7nLEpGyBewnPvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787231588; c=relaxed/simple;
	bh=3l8cRnpuhhq2LVvryRL2Ki8VGrsKQzNMkQDoYJd80Z8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jhR4oI8ysl4BtA+G9vb3ckZulz93KfMNPOUZN02C0EYobg3FEkDZRPky/rjG5L22j/8GyJ/99G2qGYigY9rZF+I3JUXjhSwTP2bToCAPepaRCQ++GwJkYLj5/kOt8+QyJUKusj7EtfWPta8q6iOQYs40bCUMtd9h+R1XkT2naXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=T5T0ChIs; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=utLJMpHy; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="T5T0ChIs";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="utLJMpHy"
Received: from kunlun.suse.cz (unknown [IPv6:2a07:de40:b306:2000::2])
	by smtp-out1.suse.de (Postfix) with ESMTP id E1846850E9;
	Thu, 20 Aug 2026 13:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1787231581; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=vySf7KrT2a3wld91VZWstproeitrSHO8sc9IEDhMisI=;
	b=T5T0ChIssDpgKoE2Ko0v7+hSXKDwXCfE9uYi2wZRRpxvRrqnldQICFgi2N0qOoahIU9RNv
	jLNSCQ2v8fPBNu37S1xe4QoWDxLnhS4Lzif37IG6ZW9sb9c2C8zIJ7Eo7wh59LnHUgDLc/
	ux0dtl7CSLqjcYH5zUR4BFGjb3mMwpo=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=utLJMpHy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1787231576; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=vySf7KrT2a3wld91VZWstproeitrSHO8sc9IEDhMisI=;
	b=utLJMpHypAgaSPsCcE9b9LIu38q02dxjjDjMIUufFWHXkrQZhvTO4mWYvQUBZbaC5cmKa1
	uOk7ZwxudAtBc0LYveOBVgUjugVXwvWb7LLgkJGmAUIq/Bm2wCaBQsmBHfYbGbrEwd7H+H
	+a4IEW1Uuw0BZgRSCiPfXeO/ZahgmMI=
From: Anthony Iliopoulos <ailiop@suse.com>
To: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Cc: sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] sparc: remove unused profile.h includes
Date: Thu, 20 Aug 2026 15:12:45 +0200
Message-ID: <20260820131249.13915-1-ailiop@suse.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [16.64 / 50.00];
	SPAM_FLAG(5.00)[];
	NEURAL_SPAM_LONG(3.50)[1.000];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_SPAM_SHORT(2.95)[0.985];
	HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	RDNS_NONE(2.00)[];
	ONCE_RECEIVED(1.20)[];
	HFILTER_HELO_IP_A(1.00)[kunlun.suse.cz];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	HFILTER_HELO_NORES_A_OR_MX(0.30)[kunlun.suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b306:2000::2:from];
	DIRECT_TO_MX(0.00)[git-send-email 2.55.0];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,suse.com:dkim,kunlun.suse.cz:helo];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_COUNT_ZERO(0.00)[0]
X-Spamd-Bar: ++++++++++++++++
X-Rspamd-Queue-Id: E1846850E9
X-Rspamd-Action: add header
X-Spam-Flag: YES
X-Spam-Score: 16.64
X-Spam-Level: ****************
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam: Yes

None of the code in these files uses declarations provided by profile.h.
Remove the unnecessary header includes across the various files to clean
up dependencies and reduce include bloat.

Signed-off-by: Anthony Iliopoulos <ailiop@suse.com>
---
 arch/sparc/kernel/leon_smp.c  | 1 -
 arch/sparc/kernel/smp_32.c    | 1 -
 arch/sparc/kernel/smp_64.c    | 1 -
 arch/sparc/kernel/sun4d_smp.c | 1 -
 arch/sparc/kernel/sun4m_smp.c | 1 -
 arch/sparc/kernel/time_32.c   | 1 -
 arch/sparc/kernel/time_64.c   | 1 -
 7 files changed, 7 deletions(-)

diff --git a/arch/sparc/kernel/leon_smp.c b/arch/sparc/kernel/leon_smp.c
index 1ee393abc463..e3dcb899896b 100644
--- a/arch/sparc/kernel/leon_smp.c
+++ b/arch/sparc/kernel/leon_smp.c
@@ -20,7 +20,6 @@
 #include <linux/spinlock.h>
 #include <linux/mm.h>
 #include <linux/swap.h>
-#include <linux/profile.h>
 #include <linux/pm.h>
 #include <linux/delay.h>
 #include <linux/gfp.h>
diff --git a/arch/sparc/kernel/smp_32.c b/arch/sparc/kernel/smp_32.c
index 87eaa7719fa2..a2f16d24aaa3 100644
--- a/arch/sparc/kernel/smp_32.c
+++ b/arch/sparc/kernel/smp_32.c
@@ -21,7 +21,6 @@
 #include <linux/seq_file.h>
 #include <linux/cache.h>
 #include <linux/delay.h>
-#include <linux/profile.h>
 #include <linux/cpu.h>
 
 #include <asm/ptrace.h>
diff --git a/arch/sparc/kernel/smp_64.c b/arch/sparc/kernel/smp_64.c
index 371460e34484..99626621f799 100644
--- a/arch/sparc/kernel/smp_64.c
+++ b/arch/sparc/kernel/smp_64.c
@@ -21,7 +21,6 @@
 #include <linux/seq_file.h>
 #include <linux/cache.h>
 #include <linux/jiffies.h>
-#include <linux/profile.h>
 #include <linux/memblock.h>
 #include <linux/vmalloc.h>
 #include <linux/ftrace.h>
diff --git a/arch/sparc/kernel/sun4d_smp.c b/arch/sparc/kernel/sun4d_smp.c
index 9a62a5cf3337..11bd73367f5a 100644
--- a/arch/sparc/kernel/sun4d_smp.c
+++ b/arch/sparc/kernel/sun4d_smp.c
@@ -9,7 +9,6 @@
 
 #include <linux/clockchips.h>
 #include <linux/interrupt.h>
-#include <linux/profile.h>
 #include <linux/delay.h>
 #include <linux/sched/mm.h>
 #include <linux/cpu.h>
diff --git a/arch/sparc/kernel/sun4m_smp.c b/arch/sparc/kernel/sun4m_smp.c
index 056df034e79e..3c459a1224e6 100644
--- a/arch/sparc/kernel/sun4m_smp.c
+++ b/arch/sparc/kernel/sun4m_smp.c
@@ -7,7 +7,6 @@
 
 #include <linux/clockchips.h>
 #include <linux/interrupt.h>
-#include <linux/profile.h>
 #include <linux/delay.h>
 #include <linux/sched/mm.h>
 #include <linux/cpu.h>
diff --git a/arch/sparc/kernel/time_32.c b/arch/sparc/kernel/time_32.c
index 578fd0d49f30..b28b86be644d 100644
--- a/arch/sparc/kernel/time_32.c
+++ b/arch/sparc/kernel/time_32.c
@@ -31,7 +31,6 @@
 #include <linux/init.h>
 #include <linux/pci.h>
 #include <linux/ioport.h>
-#include <linux/profile.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
 
diff --git a/arch/sparc/kernel/time_64.c b/arch/sparc/kernel/time_64.c
index b1c54ab4b15b..c791d18ec0d4 100644
--- a/arch/sparc/kernel/time_64.c
+++ b/arch/sparc/kernel/time_64.c
@@ -23,7 +23,6 @@
 #include <linux/ioport.h>
 #include <linux/mc146818rtc.h>
 #include <linux/delay.h>
-#include <linux/profile.h>
 #include <linux/bcd.h>
 #include <linux/jiffies.h>
 #include <linux/cpufreq.h>
-- 
2.55.0

