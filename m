Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.189.121.228
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795002949;
	b=x83u0VY64IGBOlwhNYdp30ScQNHgqd6cMBYWuV1FAo8GubiM6CjA7//bbk1BoHaoyGEb
	 on5gpIEx3LfRdCrZH2wIj+iFFl51R7Y3+JXojg1ppwO+s22lYTxJU0K29QARs8jbwBEKE
	 25IA2WfK6quc/b73otu7pabAIFv0OnnoC0fMsJ4cN+L3JpCDzlQZMoOQwh2bAuFvuYQm/
	 zqkxwib9bADQyMzt0Rtrrrh0etRP8EnfYebd4YKDDHlo+af9JGXvSDI4wABVTJ37h6Y+d
	 F6K67Zu7rpCW+C40/GQ0MQbDxrrDpGk5eAYivg6THijwWrRP8ZTmoRAV/7XyJkzlMCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795002949;
	h=DMARC-Filter:From:DKIM-Signature:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ktDRFEd3cHMhVFB21yzeutgeNHmAtQl6TM+AH+W9ESc=;
	b=a13PpGkZtO+K+fcKR8zLEJVJSXThZUm7LnHia0MnibWXWRcRYTE0Tvhn/YTkVqzI41nL
	 GQD8F5/oFdCJgidZ4Zvg617C+CYpsddHFC57NHqqaLkuz9bYtL1CWMUbLuXcvjQl2AW2Y
	 SS+qyv9SUyiBFzgrd4+YWvmr7w+PoCF1EjJDN2pKazfgdbZypNrgPQSuFLnjfgyZ0pY9C
	 9TO1lx88QKbiZB33I/Ln7XhbupU7BDBRD1jkkoQkqiAO3EgtLcp/eemTQjb2BzHGHPo9t
	 HiXoF/6T8BtgFTl5cQWA58buVvWHh5BDq/o0zSBT17dD7GI1L8FmwwEIsRy7zL3kjKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=itx.no;
	spf=pass smtp.mailfrom=itx.no;
	dkim=pass header.d=itx.no header.i=@itx.no header.a=rsa-sha256 header.s=mx.itx.no header.b=LdFCu6+p;
	arc=none smtp.remote-ip=91.189.121.228
Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE584606A32A;
	Wed, 18 Nov 2026 11:55:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE584606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.a=rsa-sha256 header.s=mx.itx.no header.b=LdFCu6+p
From: Stian Halseth <stian@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1795002945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ktDRFEd3cHMhVFB21yzeutgeNHmAtQl6TM+AH+W9ESc=;
	b=LdFCu6+p3W/pi8CC929VIrPGgeg+ABoBluELvt+zneTnpKjxhmaeWX7CQLXcLnQ6lM7S7D
	y+tJUisCBoZ7XyQ2h+BrT4H2GjADIysi55vRBsCvBNOWG0A0m2w6RQV1wGqdCrtT5G4bjj
	iQ3DXmPPl+pOK3ezkRG6PuPEdOqO1pM=
To: sparclinux@vger.kernel.org
Cc: Andreas Larsson <andreas@gaisler.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Biggers <ebiggers@kernel.org>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	linux-kernel@vger.kernel.org,
	Stian Halseth <stian@itx.no>
Subject: [PATCH v2 0/2] sparc64: Read qemu,hwcap-list on sun4u
Date: Wed, 18 Nov 2026 12:55:35 +0100
Message-ID: <20261118115537.160675-1-stian@itx.no>
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Post: <mailto:sparclinux@vger.kernel.org>
List-Help: <mailto:sparclinux+help@vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:sparclinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

QEMU's default sparc64 machine is sun4u. With -cpu ...,+crypto it
emulates the SPARC crypto opcodes and passes the hwcap-list to
OpenBIOS. OpenBIOS puts the list on the cpu node as qemu,hwcap-list.
Patch 2 reads it there. The crypto KUnit tests then run the sparc64
code under QEMU.

Patch 1 is new. Sashiko found that the hwcap-list parser reads past an
entry that has no NUL. The machine description parser has the same
bug, so patch 1 fixes it before patch 2 moves the code.

On sun4u, the ecb-, cbc- and ctr-aes-sparc64 glue loses its round keys
in skcipher_walk_done(). Under QEMU with +crypto, their self-tests
fail. No real sun4u CPU has the crypto opcodes. Eric's series moves
these modes into lib/crypto and fixes it:
https://lore.kernel.org/linux-crypto/20261118041033.50014-1-ebiggers@kernel.org/
It is planned for 7.5 via libcrypto-next.

The QEMU side is in master for 11.2, commit a1eb9a1720 ("hw/sparc64:
Pass hwcap-list to OpenBIOS via fw_cfg"). The OpenBIOS side is on the
OpenBIOS list:
https://mail.coreboot.org/archives/list/openbios@openbios.org/thread/3XVXVLHWT2T63IYWR67WPOHFSJGLP3NP/
Until QEMU ships an OpenBIOS with it, nvramrc can set the property:

NV='" /SUNW,UltraSPARC-IIi" find-device " vis" encode-string " vis2" encode-string encode+ " vis3" encode-string encode+ " aes" encode-string encode+ " sha1" encode-string encode+ " sha256" encode-string encode+ " sha512" encode-string encode+ " crc32c" encode-string encode+ " qemu,hwcap-list" property device-end'
./tools/testing/kunit/kunit.py run --arch=sparc64 \
	--kunitconfig=lib/crypto/.kunitconfig \
	--kunitconfig=lib/crc/.kunitconfig \
	--qemu_args='-cpu TI-UltraSparc-IIi,+vis3,+crypto' \
	--qemu_args='-prom-env use-nvramrc?=true' \
	--qemu_args="-prom-env 'nvramrc=$NV'"

Changes in v2:
- New patch 1: stop the parser at an entry without a NUL (Sashiko).
- Patch 2: Eric's Tested-by. No other change.
- Dropped the lib/crypto question from the notes. Eric's series
  answers it.

v1: https://lore.kernel.org/all/20261117112914.2300417-1-stian@itx.no/

Stian Halseth (2):
  sparc64: Stop the hwcap-list parser at an unterminated entry
  sparc64: Read qemu,hwcap-list from the OF cpu node on sun4u

 arch/sparc/kernel/setup_64.c | 68 ++++++++++++++++++++++++++----------
 1 file changed, 50 insertions(+), 18 deletions(-)


base-commit: 666539eecdf4db623f5e3c3e55cf9f2dfad24aa4
-- 
2.43.0

