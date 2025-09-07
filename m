Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D125414A0B5;
	Sun,  7 Sep 2025 17:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757267864; cv=none; b=dYMy30fWqjyoo/ui22ILV6IyqWEn4oeBx/FsE7qfCjOm2bMuV6rDosbRVZD8buN7mdUWI3Ko6b/bTuCcDg4VaLeRelTBeLPDK8n/RNPelzEq0tiCpPfyITsSStYc49gtjwiY7ycyFDHUEJaDGX1NdnarTcwed84tn5y7Ehlsogc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757267864; c=relaxed/simple;
	bh=OTCzNhi4py6u0lUt39mvx7CQKbEtv8hcWJ/IXtbhC1E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m8jGNB1xAvsOKRPdeaqvApR8aPIsh+sXu4lMn8zhfdh6YRZ4vzwqVtJb+yoXNCCaBvoRc2wg+FHo5VQU7j8jVFeZ37Q2michSVFNvYEdymy9pCmmiVXgfCJRP2peAPsJM8IT/pfE81Xc+FNXAsNtS5p6mQlAIxBvORr0MSdXENk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=Oy3+XnUn; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="Oy3+XnUn"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=Z0VrCIQMfbKGrs0yxee16A+wHWcE+QKfInmg7svF34Q=; t=1757267860;
	x=1757872660; b=Oy3+XnUn/cTcsBRCjYgA1SJ6Z7FgNV7DzK3SftO56+xy/anJeJ183cRTWzuzm
	8MbW4n6FHrOZS3iWMNBokmVjFKiH8yhQmUhVfbUtmEBeFV/XUMgyEYeFI2HZi5TAF7zhbaTkN3zZT
	kvbnjcWfHrfPZ9y+LsZfruRywAWOlTr5rOi4fb0ftwezF0DattEn8tNqgGfvY/4sHHmPqtuRoPqnw
	M9kWXO+WwZeOzRiRXEXPsIvT5/a8pXvFz7MDyDsV2Xdw0B5YqDwC+FOfy/VV7uwRqtLEG6VFD4KM0
	MqmvH8S2u+Vf7BsN7hp0NzDNAwDQeWSrTa6ORopGIoAe5ZV4tw==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1uvJdy-00000002JVA-2rEx; Sun, 07 Sep 2025 19:57:38 +0200
Received: from dynamic-089-012-071-066.89.12.pool.telefonica.de ([89.12.71.66] helo=[192.168.178.50])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1uvJdy-00000003E7H-1x7f; Sun, 07 Sep 2025 19:57:38 +0200
Message-ID: <35a07d38d6d59b79d28543bb4a862f14af1fa713.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v4 2/5] sparc: fix accurate exception reporting in
 copy_{from_to}_user for UltraSPARC III
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: =?ISO-8859-1?Q?Ren=E9?= Rebe <rene@exactco.de>
Cc: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>, Andreas Larsson	
 <andreas@gaisler.com>, sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org,  Anthony Yznaga <anthony.yznaga@oracle.com>
Date: Sun, 07 Sep 2025 19:57:37 +0200
In-Reply-To: <E6D1F756-419D-448A-AF35-387FDA16AC00@exactco.de>
References: 
	<20250905-memcpy_series-v4-0-1ca72dda195b@mkarcher.dialup.fu-berlin.de>
	 <20250905-memcpy_series-v4-2-1ca72dda195b@mkarcher.dialup.fu-berlin.de>
	 <326c98bf3adf52da64bc606741770c638409b938.camel@physik.fu-berlin.de>
	 <E6D1F756-419D-448A-AF35-387FDA16AC00@exactco.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Rene,

On Sun, 2025-09-07 at 19:32 +0200, Ren=C3=A9 Rebe wrote:
> It is probably a good time to mention that there are likely some other ma=
jor
> TLB (or so) bug on U3. For example, I could never boot any Linux kernel
> (probably ever) with 8GB installed in my Sun Blade 1000 - it would NULL p=
tr
> deref very early:

Have a look at arch/sparc/kernel/head_64.S:

	/* Patch copy/page operations to cheetah optimized versions. */
	call	cheetah_patch_copyops
	 nop
	call	cheetah_patch_copy_page
	 nop
	call	cheetah_patch_cachetlbops
	 nop

These patch in UltraSPARC-III-optimized versions of copy_{to,from}_user
and copy_page and TLB operations. Replacing these calls with "nop" might
tell us whether any of those is broken.

I have already replaced cheetah_patch_copyops with generic_patch_copyops
and was able to verify that the recently discovered OOPS is not related
to copy_{to,from}_user, so Michael's UltraSPARC III may still be correct
and complete.

I am testing the other two now as I think that these are good candidates.

Adrian


--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
