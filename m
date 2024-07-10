Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086F718FA10;
	Wed, 10 Jul 2024 09:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720604525; cv=none; b=qIFktZyDvnEYTRhAjOMLG4Ibg8KT6iXPXpaDgR9yGdwJtlW4zbOQ9KVHuNAhp5Sr+nSI8HTVURI7g3JK25Ng4uwfxm4wDSVRPiho7+6YPnGFSScH/FEQplOvAkA6P07l6v9e2jurMZcKeb/ftRMXcjJkTdQzPlrxanp/QO6T+GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720604525; c=relaxed/simple;
	bh=noBYTgg81ZU8cu0/+c0Q/0EfJggIqOPLTcc8Qq/l6Ck=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZonD4YWdvNCcDSpRZI/8cKnzHk0vpIfmafrTrG70rY8qwEQGidNTg6dBI8pYMsehT43+dIQ8QMFurnOUXtCKktLkrz7DcgowpkHFUrzMijjtG58luK2URht3jhedaoo3JnPjs39WixWIR3EYj6nA4muSp4PmZ3VduHcEdhZguDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=JiE0Oj3A; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="JiE0Oj3A"
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4WJtDT28Pdz1DPkr;
	Wed, 10 Jul 2024 11:42:01 +0200 (CEST)
Received: from andreas.got.gaisler.com (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	by smtp.simply.com (Simply.com) with ESMTPA id 4WJtDS6yYGz1DPkh;
	Wed, 10 Jul 2024 11:42:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=unoeuro; t=1720604521;
	bh=CBlJ5z2MKq7rgo7HzbdN4LVE4I3xLgtSKjY4UTWkJLg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JiE0Oj3AO9NT3Bx8EmOqbq+smItHF6gMIALGpTe4c9o29U+rM7vIM7AeGyffK9Hu3
	 VmEijsJWDWahExt+hfmzZbwVDRepphC8ca1qy/jhMLV7WjMxMP4TMNPy/Iju78Cm7X
	 w42gcqFWn8HZxkk2clGZUF3GH94DpJYRkyOXEx6I=
From: Andreas Larsson <andreas@gaisler.com>
To: David Miller <davem@davemloft.net>,
	sparclinux@vger.kernel.org
Cc: Sam Ravnborg <sam@ravnborg.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] sparc64: Fix incorrect function signature and add prototype for prom_cif_init
Date: Wed, 10 Jul 2024 11:41:53 +0200
Message-Id: <20240710094155.458731-3-andreas@gaisler.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240710094155.458731-1-andreas@gaisler.com>
References: <20240710094155.458731-1-andreas@gaisler.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Remove the unused cif_stack argument and add a protype in oplib_64.h
Commit ef3e035c3a9b ("sparc64: Fix register corruption in top-most
kernel stack frame during boot.") removed the cif_stack argument to
prom_cif init in the declaration at the caller site and the usage of it
within prom_cif_init, but not in the function signature of the function
itself.

This also fixes the following warning:
arch/sparc/prom/p1275.c:52:6: warning: no previous prototype for ‘prom_cif_init’

Fixes: ef3e035c3a9b ("sparc64: Fix register corruption in top-most kernel stack frame during boot.")
Signed-off-by: Andreas Larsson <andreas@gaisler.com>
---
 arch/sparc/include/asm/oplib_64.h | 1 +
 arch/sparc/prom/init_64.c         | 3 ---
 arch/sparc/prom/p1275.c           | 2 +-
 3 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/include/asm/oplib_64.h b/arch/sparc/include/asm/oplib_64.h
index a67abebd43592..1b86d02a84556 100644
--- a/arch/sparc/include/asm/oplib_64.h
+++ b/arch/sparc/include/asm/oplib_64.h
@@ -247,6 +247,7 @@ void prom_sun4v_guest_soft_state(void);
 int prom_ihandle2path(int handle, char *buffer, int bufsize);
 
 /* Client interface level routines. */
+void prom_cif_init(void *cif_handler);
 void p1275_cmd_direct(unsigned long *);
 
 #endif /* !(__SPARC64_OPLIB_H) */
diff --git a/arch/sparc/prom/init_64.c b/arch/sparc/prom/init_64.c
index 103aa91043185..f7b8a1a865b8f 100644
--- a/arch/sparc/prom/init_64.c
+++ b/arch/sparc/prom/init_64.c
@@ -26,9 +26,6 @@ phandle prom_chosen_node;
  * routines in the prom library.
  * It gets passed the pointer to the PROM vector.
  */
-
-extern void prom_cif_init(void *);
-
 void __init prom_init(void *cif_handler)
 {
 	phandle node;
diff --git a/arch/sparc/prom/p1275.c b/arch/sparc/prom/p1275.c
index 889aa602f8d86..51c3f984bbf72 100644
--- a/arch/sparc/prom/p1275.c
+++ b/arch/sparc/prom/p1275.c
@@ -49,7 +49,7 @@ void p1275_cmd_direct(unsigned long *args)
 	local_irq_restore(flags);
 }
 
-void prom_cif_init(void *cif_handler, void *cif_stack)
+void prom_cif_init(void *cif_handler)
 {
 	p1275buf.prom_cif_handler = (void (*)(long *))cif_handler;
 }
-- 
2.34.1

