Received: from mail.thinkmo.de (s3.thinkmo.de [162.55.237.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E92343D75;
	Thu, 18 Jun 2026 16:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.55.237.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781799176; cv=none; b=pSlc94pDftIh2DgnsETMekMlzgWuSw8zLEcYuOPa5bcZjii9V1iV9z5opzpXvu0vHdR2/hw8//T4Ts5nrwHnP9EQDeKF/ilXFiOmn7l3zQ0f5c5h/MZAk34Nkj62arzhNabfrl+w5TXmVhOF/yRwazjYT7FQfR4Cr1G0hhBbuXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781799176; c=relaxed/simple;
	bh=PJgPpwJ8RhmzTcUzdpmAVjXMWbWyBAG7PflHkzhwRYE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rkQviTFo9/J1gYC+OTTkAatI/C4DfV3zwhEtoOBXpzo8JEs4oeOPKYn0JmrFbNIB4lusTYPMOXhu0R1WE1V2dxz+w4isgt/sih8OfeQT4GRLo2p13Qedo3xwISW8bzKNhCAxdQ55kWM5+84Bh/cbAKnisSy6sBPf/6UXdeKBfs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=fail smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=YtmX/J7o; arc=none smtp.client-ip=162.55.237.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="YtmX/J7o"
Received: from localhost (localhost [127.0.0.1])
	by mail.thinkmo.de (Postfix) with ESMTP id 4gh5Nh6hzkz10BB;
	Thu, 18 Jun 2026 16:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=debian.org; h=
	content-disposition:content-type:content-type:mime-version
	:message-id:subject:subject:from:from:date:date:received
	:received; s=mail202007.waldi.user; t=1781799172; bh=/knFi6cXS3E
	4FCwMwrW3cLzetoO+AAwxBXtNd8xlssU=; b=YtmX/J7onvnU5Razu9S7faXP//H
	lvNedVfsvyN921gHaSn2cvWPt41cZdU21yxTbY/7K0KKX+z2qsNvXg9WXDROKDHI
	BcMARXdPE3JqyeZ7PZTu/9m5SAzZKkuG4+UU2BC5k4rLpJpeyHhlw9dWfGx3JCOz
	NlWpgqIOkOIdbGbtoqwwKKRUkI6MEq9/19zkHv9Cp/gT+k8YJUjaWLxjbX7u8j7e
	Ws3S+qNbCi5syFJGPVCyiAx1uDi+mpIwqDhbi+56AS7kdjCMfIPH5FqhxiQtpIWY
	ajG2YqTAN5s5piWjpPxeNLgLrIvyx7CYAQ3HV8Wa38IZEz08CVONeivqIqg==
X-Virus-Scanned: Debian amavis at 
Received: from mail.thinkmo.de ([127.0.0.1])
 by localhost (mail.thinkmo.de [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A2uw52EC26lq; Thu, 18 Jun 2026 16:12:52 +0000 (UTC)
Received: from steamhammer.waldi.eu.org (unknown [IPv6:2a02:8071:5af1:6518:ad11:fa76:980a:620e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1) server-digest SHA384)
	(No client certificate requested)
	by mail.thinkmo.de (Postfix) with ESMTPSA id 4gh5Nh5PRqzyqB;
	Thu, 18 Jun 2026 16:12:52 +0000 (UTC)
Date: Thu, 18 Jun 2026 18:12:51 +0200
From: Bastian Blank <waldi@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] sparc: Add build salt to the vDSO
Message-ID: <ajQZA3HSaOxvDHy1@steamhammer.waldi.eu.org>
Mail-Followup-To: Bastian Blank <waldi@debian.org>, 
	"David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
	sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

The vDSO needs to have a unique build id in a similar manner
to the kernel and modules. Use the build salt macro.

Signed-off-by: Bastian Blank <waldi@debian.org>
---
I was not able to properly test this change, due to unavailable
toolchain.

 arch/sparc/vdso/vdso-note.S        | 3 +++
 arch/sparc/vdso/vdso32/vdso-note.S | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/arch/sparc/vdso/vdso-note.S b/arch/sparc/vdso/vdso-note.S
index 79a071e4357e..79423170118f 100644
--- a/arch/sparc/vdso/vdso-note.S
+++ b/arch/sparc/vdso/vdso-note.S
@@ -3,6 +3,7 @@
  * Here we can supply some information useful to userland.
  */
 
+#include <linux/build-salt.h>
 #include <linux/uts.h>
 #include <linux/version.h>
 #include <linux/elfnote.h>
@@ -10,3 +11,5 @@
 ELFNOTE_START(Linux, 0, "a")
 	.long LINUX_VERSION_CODE
 ELFNOTE_END
+
+BUILD_SALT
diff --git a/arch/sparc/vdso/vdso32/vdso-note.S b/arch/sparc/vdso/vdso32/vdso-note.S
index e234983cf0d8..ac0ac0d13e4f 100644
--- a/arch/sparc/vdso/vdso32/vdso-note.S
+++ b/arch/sparc/vdso/vdso32/vdso-note.S
@@ -3,6 +3,7 @@
  * text. Here we can supply some information useful to userland.
  */
 
+#include <linux/build-salt.h>
 #include <linux/uts.h>
 #include <linux/version.h>
 #include <linux/elfnote.h>
@@ -10,3 +11,5 @@
 ELFNOTE_START(Linux, 0, "a")
 	.long	LINUX_VERSION_CODE
 ELFNOTE_END
+
+BUILD_SALT
-- 
2.53.0
