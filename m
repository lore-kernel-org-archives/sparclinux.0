Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3E0207A36;
	Fri, 11 Oct 2024 09:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728638335; cv=none; b=c95Eo5gYL0qDD9ISzTcUvMj+2GWhHZy+3f1WP1XWP3Qbb/i6o6/rxrtqmkSBn154A6s+wNkA8XPX00nhNDhlYqTv9GEaVDaSiHaM5mKUe0PJdKp1OrKzxWG+mzKHPG0NOIsG8FsyWZrtFgTsdqGeVy5D0p/uhxfGt0mLmou75e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728638335; c=relaxed/simple;
	bh=DE0pG8qy796JfazzXbj8HDmCD79cEMob0SgGKor7rNQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GofH3SK2RQcXIGetjQnM4bhGf1r2Xb1T/l+L3F6TwyFW/oF5e2UR2i5Ob2JiDeR5EksoYzkBgYIHMBMb8o9s5WU4iO4YoC7xWadAD5Z+ClZ6357IP2d+rpJYjLg9cAdMdA8RIleOVXPCcvPP3aYE9AijZbWbFX5XjwZSL4Vq4CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=R2WafV0V; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=i1RVVRAS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R2WafV0V";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i1RVVRAS"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728638332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3i7xaHn/k9QwPofJE1RoXQFyFWsHwRALXQe60ECIRXY=;
	b=R2WafV0VyDY+G/s5bQiCBhEpkfyyRPa0OTxbmIgxSju2NwU4urikb0Yo0s08rBmqUKKsOK
	er2kvM26UAf3o2UPr2XvL96y1i3H6Art8U+orNzGnWCy33fCgYDLBzMLBCRV1vJj7udljO
	XfInwY+Zecp615bGyqewPJCsmnxaGd4p9OOaMNp8ld/rb9KSQrPkOs1mU3Dd0C7WBzMJNy
	Ksw2Xi0+bH0kHYobnvqp5OPu5eUiZu++Aw3gbISmF4Ak2ZaaWMV3/nWBgoDcHJii8NC5Bo
	JHFsBGyOTwV77L9d3KET0tE1Jg7Lo/Kedl4vVKfE2AfW1h+WoKXkbrZl5PCioQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728638332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3i7xaHn/k9QwPofJE1RoXQFyFWsHwRALXQe60ECIRXY=;
	b=i1RVVRASk+dqTdw4l1tDjEYFtAjHpqyGFWD3Gb/4Po8mrHSX5XJxy4HvTzxAh+vW5szKLr
	+GCntqAKeRsTJKDw==
Subject: [PATCH 0/3] vdso: Always reject undefined references in during
 linking
Date: Fri, 11 Oct 2024 11:18:24 +0200
Message-Id: <20241011-vdso-checkundef-v1-0-1a46e0352d20@linutronix.de>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAGDtCGcC/x2MQQqAMAzAviI9O1iHevAr4kHXToswZcMhyP5u8
 RhC8kLmJJxhbF5IXCTLGRWwbcDvS9zYCCmDs65Di2gK5dP4nf1xR+JgwkBkB1Tfr6DVlTjI8x+
 nudYP0burmGEAAAA=
X-Change-ID: 20241011-vdso-checkundef-f6dd0612025b
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>
Cc: linux-kernel@vger.kernel.org, linux-um@lists.infradead.org, 
 sparclinux@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728638330; l=1098;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=DE0pG8qy796JfazzXbj8HDmCD79cEMob0SgGKor7rNQ=;
 b=raDEJsQlC+84uF9OuE2kfi/uFlSzdPtmawc5XYRTJY+fkZ/0tvmuae5IfCdVxNrMG7sHYAc6q
 hRCkuoBfeByD3FzXWbj+IODdF96IOaqz2YqgprNN+cmg7+fTm6x5wc0
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Instead of using a custom script to detect and fail on undefined
references, use --no-undefined for all VDSO linker invocations.

Drop the now unused checkundef.sh scripts.

These patches can be picked up by the architecture maintainers.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
Thomas Weißschuh (3):
      x86: vdso: Always reject undefined references in during linking
      um: vdso: Always reject undefined references in during linking
      sparc: vdso: Always reject undefined references in during linking

 arch/sparc/vdso/Makefile          |  7 +++----
 arch/sparc/vdso/checkundef.sh     | 10 ----------
 arch/x86/entry/vdso/Makefile      |  7 +++----
 arch/x86/entry/vdso/checkundef.sh | 10 ----------
 arch/x86/um/vdso/Makefile         |  5 ++---
 arch/x86/um/vdso/checkundef.sh    | 11 -----------
 6 files changed, 8 insertions(+), 42 deletions(-)
---
base-commit: 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b
change-id: 20241011-vdso-checkundef-f6dd0612025b

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>

