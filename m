Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F406313E2B;
	Tue, 26 Aug 2025 16:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756224215; cv=none; b=K6pENE3wP8EZPpHPrlrGhxl27SAIgIulJDCMn7ufNJwI8GDCe+9hN+4pDhjO+xlQwYgEYlT7xNUxY1ENnn9+nfcvrP3MsAbcYM5KRvWz6VCiQGPBHoPjUKmdcdJ7UlC4Vxg5FQyZLHJwr3+sU1fhgao4bTTONr7845nHL0qPZf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756224215; c=relaxed/simple;
	bh=wcv7knq4PA1KSCMtNch0UJfW3K2AWGn8q0NFryhCUns=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D2zayfaycgoXv325/416aoLxHG+M9rPzOlapA3//agvbk8Ll7v0XC0lva4LlL3g/65pT6YC4dP0nRaGx2p/7ByujQgim0XQGbmnPts42W3V7bqL65uvMzpCShu1zBm1HSMxkT0zQrPNVzkPW6TgpsnLnVOkb93RdGphn5WJ525Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mkarcher.dialup.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=OJSmEXgJ; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mkarcher.dialup.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="OJSmEXgJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:From:Reply-To:Subject:Date:Message-ID:To:Cc:
	MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=VyCZxsBbdNQ7yBiAHXgXD7zZcdaNhFfGu6xm7ym9Ph0=; t=1756224210; x=1756829010; 
	b=OJSmEXgJ2jXh3KiAmBaWwtpieT6/tDuBteMMnnFRpFI5E5efpowAJCgRmkV5pz3XNxwJY+L8DmD
	V9DF3OiZleoVBFMCoEKjb+iSagfZVNZQumnLPYTxz0WlME93rfc47WWojN5DnWS/V/o2S5oq4ExYR
	WH4nxWRPu6kuZBQZ5sQFYC8O2s6a4sY2Q/qvJrnZql97E48pfpBRuqCoJDfuic1KAJ9fUt7pSFfaH
	67rFxSl376+4UWJIyCYxiGmOk6Nvkd/wYPA3qzAZJ+2YYu2b2umtP3C0E1PtKmxE8K4ow3lNt3qS4
	oG/PUUtUowG0bFNLNnMZ0G1pU9Ly+e9YbMeA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <mkarcher@zedat.fu-berlin.de>)
          id 1uqw8o-00000000x4I-48UU; Tue, 26 Aug 2025 18:03:23 +0200
Received: from [89.57.34.174] (helo=Geist14)
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <kernel@mkarcher.dialup.fu-berlin.de>)
          id 1uqw8o-00000000c5y-38mo; Tue, 26 Aug 2025 18:03:22 +0200
From: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>
To: linux-kernel@vger.kernel.org
Cc: sparclinux@vger.kernel.org,
	Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>,
	Andreas Larsson <andreas@gaisler.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Anthony Yznaga <anthony.yznaga@oracle.com>
Subject: Fix accurate exception reporting in SPARC assembly
Date: Tue, 26 Aug 2025 18:03:02 +0200
Message-ID: <20250826160312.2070-1-kernel@mkarcher.dialup.fu-berlin.de>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Original-Sender: kernel@mkarcher.dialup.fu-berlin.de
X-ZEDAT-Hint: PO

In 2018, David Miller implemented accurate exception reporting in
copy_from_user and copy_to_user by handling exceptions on each load
or store instruction that accesses userspace memory and calculating
the remaining bytes from the processor context. As issues with
transparent huge page support and folio support in ext4 were due
to a bogus return value from copy_from_user, I wrote a comprehensive
testsuite for the generic variant, and the machine-specific variants
for UltraSPARC I/II, UltraSPARC III, Niagara, Niagara 2/3 and
Niagara 4, see

https://github.com/karcherm/sparc-cfu-bug-reproducer

despite the name of the project, it does not only test copy_from_user,
but also copy_to_user, and it also contains fixes to a very small amount
of exception handler references that were calculating the result in
a wrong way.

For UltraSPARC III, I chose to adjust the memcpy code itself instead of
adding complexity to multiple exception handlers. That fix has already
been tested to fix stability issues observed by Adrian Glaubitz which
kicked of the investigation. On all other architectures, the changes
are just to the exception handlers.

Kind regards,
  Michael Karcher
