Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED022E427C;
	Fri, 29 Aug 2025 13:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756473911; cv=none; b=iV5ELoMLG3olZipZYYmq3lkNREi6JlvG0AdzhEvHa1tSsPTZ/k7BrdkiWN+72lWgkAh1MLTiJItZ5P56g6N8GV5Ue5632EbEglJ4i1MEF5CWP3PVrOjhwT2WGf/ygoVHg9ji6/9Wx04DijvHwXaHzXgvnxtYQHLgSYcQdBdQ3vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756473911; c=relaxed/simple;
	bh=Oxk0K1gCXVvzsc1tNeTdmdf4m8zbmkxaUdpomdC6IEc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pTmbU+cHCtqjyz6KcJ9m1Y58A41uv8lao7PZd5Vbug4SYJTmmvLWxmfvvGUkmjQv9kHU06/RORZvdYK7l1gMiqn58t+forXDDH66od5b7dToJmhkrv5WF2/xUy6BfdPmhXIoiWoZ8c2YggJz+0Jal9FT3lv3eyHjstthJw8wtFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mkarcher.dialup.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=IJ31p+s9; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mkarcher.dialup.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="IJ31p+s9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=Content-Transfer-Encoding:Content-Type:In-Reply-To
	:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:Reply-To:
	Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=gqQ9WFGEfYV5y3x3c0ilkKSEIBpjJDV/l10FbIt1tIo=; t=1756473908;
	x=1757078708; b=IJ31p+s9bfRhIZDRs1hk9VUGEg8Q+Yxne4L2kHAyQtjqb8bBq6ZdMtox90PqE
	G4apWF5EuOqs3OFcpcj/OSEVOGu795muB6UxCM/64jANseBYbAhmeO/3l9vFKOv/ubS4V6CjE3mhA
	wRxrc1jUIbdIyh3mnQmNnCsdjSjD1xOkNp9iUJccowS8tkyU5PZEh7m+6gJYk5uRTMEJ+WgB5Uk7H
	BftcNiYXBjaqHiTNp2rIyUEsmPoXUldrLknwghy9JNY4ryEAkA9L1dWTKK84BiIOUxgEgZV3kefqO
	UVBV/NrEkD9mti+mlA6OEL4R9lAUR8NkJC6+lbPIMas/MfFLsQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <mkarcher@zedat.fu-berlin.de>)
          id 1urz6B-00000001Xr0-0Fsj; Fri, 29 Aug 2025 15:24:59 +0200
Received: from [89.57.34.174] (helo=[192.168.179.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_128_GCM_SHA256
          (envelope-from <kernel@mkarcher.dialup.fu-berlin.de>)
          id 1urz6A-00000001a80-3WXK; Fri, 29 Aug 2025 15:24:59 +0200
Message-ID: <98cced9a-8bb2-4984-9db4-562bec9f462d@mkarcher.dialup.fu-berlin.de>
Date: Fri, 29 Aug 2025 15:24:58 +0200
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] sparc: fix accurate exception reporting in
 copy_{from_to}_user for Niagara 4
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 linux-kernel@vger.kernel.org
Cc: sparclinux@vger.kernel.org, Andreas Larsson <andreas@gaisler.com>,
 Anthony Yznaga <anthony.yznaga@oracle.com>
References: <20250826160312.2070-1-kernel@mkarcher.dialup.fu-berlin.de>
 <20250826160312.2070-5-kernel@mkarcher.dialup.fu-berlin.de>
 <4c827eba2ce2c501cb4e0b820653ae582ae87daf.camel@physik.fu-berlin.de>
From: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>
In-Reply-To: <4c827eba2ce2c501cb4e0b820653ae582ae87daf.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Original-Sender: kernel@mkarcher.dialup.fu-berlin.de
X-ZEDAT-Hint: PO

Am 28.08.2025 um 22:21 schrieb John Paul Adrian Glaubitz:
> On Tue, 2025-08-26 at 18:03 +0200, Michael Karcher wrote:
>>   	EX_ST(STORE(stx, %g1, %o0 + 0x00), memcpy_retl_o2_plus_o5_plus_32)
>>   	EX_ST(STORE(stx, %g2, %o0 + 0x08), memcpy_retl_o2_plus_o5_plus_24)
>> -	EX_ST(STORE(stx, GLOBAL_SPARE, %o0 + 0x10), memcpy_retl_o2_plus_o5_plus_24)
>> +	EX_ST(STORE(stx, GLOBAL_SPARE, %o0 + 0x10), memcpy_retl_o2_plus_o5_plus_16)
>>   	EX_ST(STORE(stx, %o4, %o0 + 0x18), memcpy_retl_o2_plus_o5_plus_8)
> Verified to not cause any regressions on SPARC T4. Whether it improved anything is
> hard to say. It might be that previously observed crashes after long uptimes are
> gone now.

I don't see how my patch will generate observable improvements. The patch is
"obviously correct", as it fixes the arithmetic progression 32/24/16/8, which
was originally interrupted, and also my test program agrees that the return
value is what it is "supposed to be" after applying the patch.

The old (likely unintended) code returns 8 more bytes left to copy than there
actually are left. This means that all bytes that are not indicated as "left
to copy" have actually been successfully copied, as well as 8 "hidden" bytes.
So the return value is kind-of valid.

Thus I think verifying that there are no regressions and reviewing the code
are the only quality assurance measures we can apply to this patch. I'm afraid
that this patch most likely will not fix the previously observed crashes, as
in this case, the return value was never too low (which could cause the kernel
to trust ouput bytes that have not been copied), and always less than the
amount requested to copy. Returning more bytes left than actually requested
can cause any kind of strange behaviour, as this is not expected by the callers
of this function, and can generate invalid states (like we observed with
negative file offsets in folio-enabled ext4 code with transparent huge pages
enabled on UltraSparc III).

Thanks for testing that there are indeed no regressions!

Kind regards,
   Michael Karcher

