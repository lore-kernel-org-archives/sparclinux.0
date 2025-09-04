Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE208259C92;
	Thu,  4 Sep 2025 18:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757012061; cv=none; b=BiwOYQuHKVrbvjSdY0pjKzGN05G/X6JGZXC30DJsHMg0Y7IYBsjQRbG73SUpKGgL9CLXvve6EnuR9hGrcBadE/wCtLpuDTAK1e9+xznvQCe5Bef95U7S/YYuSgR2RoY45jB9voABBueoPqveHvs/v+IB9PQmSAXLnEQjzBimCkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757012061; c=relaxed/simple;
	bh=/GExO+uNhSS3dT9GTfmaQw96F8horD7/lF9BiE1tV/I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M6wUKoYFITIdznUUtBgQS8KLNQdOb/TlRO5nw9UJKvwOsEE13OVczOXrQiXgECZUMot/YHdeDfEp/BqKboqM6y+LQyNeMOxyHYqWRhcumToaospvq09iwhX/7YzfWY8a6EJAzEVmZKXQ5SY86VhqUaUTGz8+RiX7CglzBLSzChc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mkarcher.dialup.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=AgKoOCT4; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mkarcher.dialup.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="AgKoOCT4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=daaD2srAb6QUNXd9ZMoyV8rMPej3k7DuoKu3FHwUaJg=; t=1757012057;
	x=1757616857; b=AgKoOCT4MLSbf6GQ0SnSHVqcqt66/wQeJv0HmPp+jv8IE6bSnzha861Yh4MmU
	eAPnKAgD+V5QtIRxfndf3sMQcqvlnW/47M3yHWSVg8oTgbr7iQcDGUtPkZ38l35JRw+3RTrdmPr5n
	cL16SXVyqWABAN11UuEPfY5QZtfEF4LWyRFs1BSPRx8XC8pys6kE+dfHSrm0i3lxBlg76i+qBHFVC
	m3K1lv5zSw1JEkPpLGN/yTVlMmIATiwHNyCIeENwCQWYhyGKNezzZ2cCRbpSDmAeyH1t+SuddljRW
	LqKSzxfYkDLIlM/LC3O3SfFJbaNecDD/E+rYqIlj858DUNBLfA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <mkarcher@zedat.fu-berlin.de>)
          id 1uuF67-00000000Lxk-0gIU; Thu, 04 Sep 2025 20:54:15 +0200
Received: from 89-103-142-46.pool.kielnet.net ([46.142.103.89] helo=Geist14.)
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <kernel@mkarcher.dialup.fu-berlin.de>)
          id 1uuF66-00000001W6v-40x8; Thu, 04 Sep 2025 20:54:15 +0200
From: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>
Date: Thu, 04 Sep 2025 20:53:52 +0200
Subject: [PATCH v2 2/5] sparc: fix accurate exception reporting in
 copy_{from_to}_user for UltraSPARC III
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250904-memcpy_series-v2-2-9806dd1784e7@mkarcher.dialup.fu-berlin.de>
References: <20250904-memcpy_series-v2-0-9806dd1784e7@mkarcher.dialup.fu-berlin.de>
In-Reply-To: <20250904-memcpy_series-v2-0-9806dd1784e7@mkarcher.dialup.fu-berlin.de>
To: Andreas Larsson <andreas@gaisler.com>, 
 Babu Moger <babu.moger@oracle.com>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 Anthony Yznaga <anthony.yznaga@oracle.com>, 
 =?utf-8?q?Ren=C3=A9_Rebe?= <rene@exactcode.com>
X-Mailer: b4 0.14.2
X-Original-Sender: kernel@mkarcher.dialup.fu-berlin.de
X-ZEDAT-Hint: PO

Anthony Yznaga tracked down that a BUG_ON in ext4 code with large folios
enabled resulted from copy_from_user() returning impossibly large values
greater than the size to be copied. This lead to __copy_from_iter()
returning impossible values instead of the actual number of bytes it was
able to copy.

The BUG_ON has been reported in
https://lore.kernel.org/r/b14f55642207e63e907965e209f6323a0df6dcee.camel@physik.fu-berlin.de

The referenced commit introduced exception handlers on user-space memory
references in copy_from_user and copy_to_user. These handlers return from                                               the respective function and calculate the remaining bytes left to copy
using the current register contents. The exception handlers expect that
%o2 has already been masked during the bulk copy loop, but the masking was
performed after that loop. This will fix the return value of copy_from_user
and copy_to_user in the faulting case. The behaviour of memcpy stays
unchanged.

Fixes: ee841d0aff64 ("sparc64: Convert U3copy_{from,to}_user to accurate exception reporting.")
Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Reviewed-by: Anthony Yznaga <anthony.yznaga@oracle.com>
Tested-by: René Rebe <rene@exactcode.com> # UltraSparc III+ and UltraSparc IIIi
Signed-off-by: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>
---
 arch/sparc/lib/U3memcpy.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/lib/U3memcpy.S b/arch/sparc/lib/U3memcpy.S
index 9248d59c734ce200f1f55e6d9913277f18715a87..bace3a18f836f1428ae0ed72b27aa1e00374089e 100644
--- a/arch/sparc/lib/U3memcpy.S
+++ b/arch/sparc/lib/U3memcpy.S
@@ -267,6 +267,7 @@ FUNC_NAME:	/* %o0=dst, %o1=src, %o2=len */
 	faligndata	%f10, %f12, %f26
 	EX_LD_FP(LOAD(ldd, %o1 + 0x040, %f0), U3_retl_o2)
 
+	and		%o2, 0x3f, %o2
 	subcc		GLOBAL_SPARE, 0x80, GLOBAL_SPARE
 	add		%o1, 0x40, %o1
 	bgu,pt		%XCC, 1f
@@ -336,7 +337,6 @@ FUNC_NAME:	/* %o0=dst, %o1=src, %o2=len */
 	 * Also notice how this code is careful not to perform a
 	 * load past the end of the src buffer.
 	 */
-	and		%o2, 0x3f, %o2
 	andcc		%o2, 0x38, %g2
 	be,pn		%XCC, 2f
 	 subcc		%g2, 0x8, %g2

-- 
2.50.1

