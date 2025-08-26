Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4518A3148BC;
	Tue, 26 Aug 2025 16:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756224215; cv=none; b=cLo3dMkn0GI8WGRRiHRrfvp2rKrjbCc7kfQqICIUMsxQbJoiwUr49TYXhcPU+cA93zfn6xTP5IJtPNIYl27QovMntPeXCa5NQozycG+jhpyLRtrrPscZlKQfGpK52oVTt0uATi0CyTmz8afGRSHdhAjVGko33Bt3rn6ibzgd1kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756224215; c=relaxed/simple;
	bh=NiTFgKts+OzxyqckaQgevOdQhUBdNqFPc2x/Mxh6NfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nlqz0S+pEZG5fpO06QzhWhaediBiicgoKGcP1h3LJzQLGeCGu3sD0GtxD1GNzK+5Euh4g3paOtE4YQEh9737QPLtQlwHTDfd9wzJF3WOmGSmJWMzf7lrVgUsBCWkF3mBJDedpr84x7yPvvPd1y4yQiaeZ+/A9yL7rpFv6Wm7tVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mkarcher.dialup.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=h2v20o3Y; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mkarcher.dialup.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="h2v20o3Y"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Reply-To:Subject:Date:
	Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=WjMXoJ83htl5QSXDt1jQ7BqUofeuTW4zLLdLLR7BkOg=; t=1756224211; x=1756829011; 
	b=h2v20o3YBqESsw8TxOCgTFcJOluPG+vMnGVOz/4WFLpqvqTK0XiWbEu8dme6766oWRWSvZJEAoV
	VnO3PewCmsYvQ7mO36L/wjkeOh/jFgl8mgAlytEAqErWUTMfpcIyUAzPnHpFm/mEbqTfnTLd3aDIO
	Lj0mzEievQdWbRdGgq8f+wUFM46ZN2ohzTafKZ3EH2rOvc+WyKW5PApn936/m2k63NRWgQW2SKH9v
	GyOYUgUTyNhBJ/Wrrc5t1kh8wYLBaE672066STtttEl0v+hzjHfhIjGjLG38g3yKRwUvqEell4bXJ
	ZAqkiHEMs6jPWBFB23eCoLHwPLmfr3uS/QSQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <mkarcher@zedat.fu-berlin.de>)
          id 1uqw8q-00000000x6W-2Sd6; Tue, 26 Aug 2025 18:03:24 +0200
Received: from [89.57.34.174] (helo=Geist14)
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <kernel@mkarcher.dialup.fu-berlin.de>)
          id 1uqw8q-00000000c5y-1VnN; Tue, 26 Aug 2025 18:03:24 +0200
From: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>
To: linux-kernel@vger.kernel.org
Cc: sparclinux@vger.kernel.org,
	Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>,
	Andreas Larsson <andreas@gaisler.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Anthony Yznaga <anthony.yznaga@oracle.com>
Subject: [PATCH 4/4] sparc: fix accurate exception reporting in copy_{from_to}_user for Niagara 4
Date: Tue, 26 Aug 2025 18:03:06 +0200
Message-ID: <20250826160312.2070-5-kernel@mkarcher.dialup.fu-berlin.de>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826160312.2070-1-kernel@mkarcher.dialup.fu-berlin.de>
References: <20250826160312.2070-1-kernel@mkarcher.dialup.fu-berlin.de>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Original-Sender: kernel@mkarcher.dialup.fu-berlin.de
X-ZEDAT-Hint: PO

Fixes: 957077048009 ("sparc64: Convert NG4copy_{from,to}_user to accurate exception reporting.")
Signed-off-by: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>
---
 arch/sparc/lib/NG4memcpy.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/lib/NG4memcpy.S b/arch/sparc/lib/NG4memcpy.S
index 7ad58ebe0d00..df0ec1bd1948 100644
--- a/arch/sparc/lib/NG4memcpy.S
+++ b/arch/sparc/lib/NG4memcpy.S
@@ -281,7 +281,7 @@ FUNC_NAME:	/* %o0=dst, %o1=src, %o2=len */
 	subcc		%o5, 0x20, %o5
 	EX_ST(STORE(stx, %g1, %o0 + 0x00), memcpy_retl_o2_plus_o5_plus_32)
 	EX_ST(STORE(stx, %g2, %o0 + 0x08), memcpy_retl_o2_plus_o5_plus_24)
-	EX_ST(STORE(stx, GLOBAL_SPARE, %o0 + 0x10), memcpy_retl_o2_plus_o5_plus_24)
+	EX_ST(STORE(stx, GLOBAL_SPARE, %o0 + 0x10), memcpy_retl_o2_plus_o5_plus_16)
 	EX_ST(STORE(stx, %o4, %o0 + 0x18), memcpy_retl_o2_plus_o5_plus_8)
 	bne,pt		%icc, 1b
 	 add		%o0, 0x20, %o0
-- 
2.50.1

