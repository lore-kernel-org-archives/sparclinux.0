Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794963086;
	b=HXum/R/25fjoCxJtB0KwwGd0mQ5bnV5jpB/Th33mNJ1YSk+pZG8Uz8eClqabetkC0Q/4
	 JE6HH/SuShk1b8Kpv9k1T21c51attuKS9GgACGPe2fywiFXq8w1zIhbs/aNdi/yBM9DbI
	 Uu3vsGHPm34tYDopmm4eG5AiUNCDyAYr0rX+vpsuWQtVR3RjxW2rHDN31HaUR5obDexeU
	 sPDYUqRCwVFQMucTHhOj5caIjipluHrNLeGI52Xl4aWTisUY2HsEyH+VPmQ8GhW/7mDHE
	 ej6JGxtvelZTz0Ys4Bp48UThiVtJ5fqZceBV/X7L0pYQ0fCZXI6ghleYIuvgf0hV9Dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794963086;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:X-Developer-Signature:X-Developer-Key:
	 Content-Transfer-Encoding;
	bh=07yxf6oBk4sJJx7FhZOvJw4oKG8QVBIrY1kuSJerDAs=;
	b=cct5YTCQ/UXi27abbJAHW37k9aB85U8fzu21J3PtsUDbQjvXwqdBddGwrEI3jeqIKke0
	 JoP7L0pFWx7Lkm9srMC0+okqFNrVN6OKkucKFyC3OobvhmhofkHHLWdhnEeM2poE3H2DD
	 5QAGYEC5l/f3LexiQf2wgbtyykvYjV7RGm/Lwo4q9oxS0d+ja5bT7NMRgxn4nGcfY0VRj
	 Xe3ieemJ6yTmbCgwIJgq1D1pE4nqK8Dt4jtyzxUcSVONMPV/Ga6ukWo4ZPDbDP87ZLJFP
	 baX2edgo0NcB2ctcLEb5JOPR+HI4+X1GTZ7a4brdu/S1123PULbRpNwnqG4liVPAk2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cW9By2QC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5053606A32C
	for <sparclinux@vger.kernel.org>; Wed, 18 Nov 2026 00:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cW9By2QC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EDC11F000C4;
	Wed, 18 Nov 2026 00:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794963086;
	bh=07yxf6oBk4sJJx7FhZOvJw4oKG8QVBIrY1kuSJerDAs=;
	h=From:To:Cc:Subject:Date;
	b=cW9By2QCyxuNUYck0mZxFzuFk5jR1AGxI/PXGs4DSUC42bYwGqDbXaBGd0SI9eqmX
	 tAAzMRGwN9BgEAQAANkdUxMMBT/QgWuIFNlbfDiSEf8fAVF3I1xNBdbN7S32rmUIr2
	 lwkZKdFk919pNHrQKKkCgU1bBI7/ZRBQodvSQIcfsuPQB8hVTpvS//dOhdknctoFFs
	 5M9Qt7jVG1lgxR4ylJdcPjiEXVAFTkivKANaa1EgO0/PvLcstf9B1BdHmO2ok/ugON
	 5KniQ3vR9bzeTFVJxzvVXSShd/a3F+Q8fKau5Qk9/VhSBGWQwfNMqLHtUjanStMX21
	 TI2dVSoKirjsQ==
From: Thorsten Blum <blum@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Magnus Lindholm <linmag7@gmail.com>,
	Sam Ravnborg <sam@ravnborg.org>
Cc: Thorsten Blum <blum@kernel.org>,
	sparclinux@vger.kernel.org
Subject: [PATCH] sparc/setup: Remove unused RAMDISK_* definitions
Date: Wed, 18 Nov 2026 01:51:02 +0100
Message-ID: <20261118005104.576267-2-blum@kernel.org>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Post: <mailto:sparclinux@vger.kernel.org>
List-Help: <mailto:sparclinux+help@vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:sparclinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1163; i=blum@kernel.org; h=from:subject; bh=ex02C4dovYc1RtmVxQk/NUPW6eepPfMtsJGQ+gcbSIk=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFl/vlWET1k265Za4ebHNwzymgyfVvKmGmx6G/1d91XIr 3X7ph+Q6ChlYRDjYpAVU2R5MOvHDN/SmspNJhE7YeawMoEMYeDiFICJrF7PyLDR5emy1zM7hEVe F1lMlb/Lc9dNJP2PAcvihs1Gy1bMVZvOyHBRRvKuQNc27gW/UtwiNvN7X20ze1V0LmPGNae78ef 28PECAA==
X-Developer-Key: i=blum@kernel.org; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit

RAMDISK_PROMPT_FLAG and RAMDISK_LOAD_FLAG are not used. Remove them.

Signed-off-by: Thorsten Blum <blum@kernel.org>
---
 arch/sparc/kernel/setup_32.c | 2 --
 arch/sparc/kernel/setup_64.c | 2 --
 2 files changed, 4 deletions(-)

diff --git a/arch/sparc/kernel/setup_32.c b/arch/sparc/kernel/setup_32.c
index 1b0db16cd37b..df16b82a54be 100644
--- a/arch/sparc/kernel/setup_32.c
+++ b/arch/sparc/kernel/setup_32.c
@@ -172,8 +172,6 @@ extern unsigned short root_flags;
 extern unsigned short root_dev;
 extern unsigned short ram_flags;
 #define RAMDISK_IMAGE_START_MASK	0x07FF
-#define RAMDISK_PROMPT_FLAG		0x8000
-#define RAMDISK_LOAD_FLAG		0x4000
 
 extern int root_mountflags;
 
diff --git a/arch/sparc/kernel/setup_64.c b/arch/sparc/kernel/setup_64.c
index 63615f5c99b4..f728f1b00aca 100644
--- a/arch/sparc/kernel/setup_64.c
+++ b/arch/sparc/kernel/setup_64.c
@@ -145,8 +145,6 @@ extern unsigned short root_flags;
 extern unsigned short root_dev;
 extern unsigned short ram_flags;
 #define RAMDISK_IMAGE_START_MASK	0x07FF
-#define RAMDISK_PROMPT_FLAG		0x8000
-#define RAMDISK_LOAD_FLAG		0x4000
 
 extern int root_mountflags;
 
