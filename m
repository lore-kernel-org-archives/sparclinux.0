Received: from weierstrass.telenet-ops.be (weierstrass.telenet-ops.be [195.130.137.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA49B657
	for <sparclinux@vger.kernel.org>; Mon, 19 Aug 2024 07:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724052645; cv=none; b=lSJJGAk3wZsGCgDeUI7QKiPIclq0dbaUx0NdzsoGNuS53LB8STlE5hw9P9lCt0v8Dnmtlck8HJt6rAtHNvdM3DFWKxKnt/TR4TFVmhZ9AWJ3udnVgUUBJVvwACmYFQwcAj4MuN2b/BTj3PEGdxkauQ7h+Azp4Z8v1HChgnC/SEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724052645; c=relaxed/simple;
	bh=/l9Fe0LFSP8Uuq7JyblD2xXOoporNaiQ/sYhswItljc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=pQlv241L6Kbs4nO3Q0FL0JaMUlABJx6TokZSZ9dn6DB6s24FHg9WjYoiv+cXQWCDFmFFonO6os7TZxC+47BPfehvPXRWBkhSpEl6tQBfd1a+EYX3vIL9sr2a5LZKlkN5phjme62UExHVbx7/EjN8YAPN7sccThLKdnBZ2FE2/Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
	by weierstrass.telenet-ops.be (Postfix) with ESMTPS id 4WnPQR4wgqz4xVSp
	for <sparclinux@vger.kernel.org>; Mon, 19 Aug 2024 09:30:39 +0200 (CEST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:7674:86dc:e300:ce10])
	by laurent.telenet-ops.be with bizsmtp
	id 1jWY2D0052ltMuT01jWYrk; Mon, 19 Aug 2024 09:30:32 +0200
Received: from geert (helo=localhost)
	by ramsan.of.borg with local-esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sfwqW-000Hig-1Z;
	Mon, 19 Aug 2024 09:30:32 +0200
Date: Mon, 19 Aug 2024 09:30:32 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: linux-kernel@vger.kernel.org
cc: sparclinux@vger.kernel.org, intel-xe@lists.freedesktop.org, 
    dri-devel@lists.freedesktop.org
Subject: Re: Build regressions/improvements in v6.11-rc4
In-Reply-To: <20240819070639.2558629-1-geert@linux-m68k.org>
Message-ID: <e43d6c-90df-32d2-c7ac-2991e8c5672f@linux-m68k.org>
References: <CAHk-=wgP=qzODR60Xxzem5LQi6sH+6EFCDMOApAgBy37SQ59hA@mail.gmail.com> <20240819070639.2558629-1-geert@linux-m68k.org>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 19 Aug 2024, Geert Uytterhoeven wrote:
> JFYI, when comparing v6.11-rc4[1] to v6.11-rc3[3], the summaries are:
>  - build errors: +6/-4

   + /kisskb/src/arch/sparc/vdso/vdso32/../vclock_gettime.c: error: no previous prototype for '__vdso_clock_gettime' [-Werror=missing-prototypes]:  => 254:1
   + /kisskb/src/arch/sparc/vdso/vdso32/../vclock_gettime.c: error: no previous prototype for '__vdso_clock_gettime_stick' [-Werror=missing-prototypes]:  => 282:1
   + /kisskb/src/arch/sparc/vdso/vdso32/../vclock_gettime.c: error: no previous prototype for '__vdso_gettimeofday' [-Werror=missing-prototypes]:  => 307:1
   + /kisskb/src/arch/sparc/vdso/vdso32/../vclock_gettime.c: error: no previous prototype for '__vdso_gettimeofday_stick' [-Werror=missing-prototypes]:  => 343:1

sparc64-gcc13/sparc64-allmodconfig
(pre-existing, but now emitted twice in this config only?)

   + /kisskb/src/include/linux/compiler_types.h: error: call to '__compiletime_assert_952' declared with attribute error: FIELD_GET: mask is not constant:  => 510:38
   + /kisskb/src/include/linux/compiler_types.h: error: call to '__compiletime_assert_953' declared with attribute error: FIELD_GET: mask is not constant:  => 510:38

powerpc-gcc5/powerpc-all{mod,yes}config

In function 'decode_oa_format.isra.26',
     inlined from 'xe_oa_set_prop_oa_format' at drivers/gpu/drm/xe/xe_oa.c:1664:6:
drivers/gpu/drm/xe/xe_oa.c:1573:18: note: in expansion of macro 'FIELD_GET'
   u32 bc_report = FIELD_GET(DRM_XE_OA_FORMAT_MASK_BC_REPORT, fmt);
                   ^
Seen before, patch available.

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    - Linus Torvalds
