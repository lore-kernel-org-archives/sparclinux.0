Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1D82EBDCA;
	Thu,  4 Sep 2025 14:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756995264; cv=none; b=Xb43r5wlXRJY/IF5MLDLKlVZnpx5l9TUXaGfyt3JKZ4yEg4+ET5RbN7Oay1j00ISlD5CzCwk3qrH5BCaLpkvKvtwFqYkns9Ancq4zwuVGfMsng2q6LBGJ1/inWkG5PZ02TWM592I5k7xGt9yobn76IheA7xQndZCyx1yWVnbLzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756995264; c=relaxed/simple;
	bh=FhTdXIaBQCU6Q68h7sv0jDnLrax/XaudLHmL1DeOxzI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=WWklDBRUkgD5hgQ90ajZ0dcXPT0DBpuyKSaw9X6o2ldoh/d1xhlc+QX+49AJeni78am7tn8u0G1oQ9L2Vpo28AUDjNzEtUxl4RP5Jw+zjwT9xCcCoPPu+LsDybGsblR9YtOJt8x+vnLEOy5S1W3ECaJTkVWuKr+kEt67iX437Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mkarcher.dialup.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=FdESnBTl; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mkarcher.dialup.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="FdESnBTl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=Content-Transfer-Encoding:Content-Type:In-Reply-To
	:References:Cc:To:Subject:From:MIME-Version:Date:Message-ID:From:Reply-To:
	Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=YzG5W1s80ebmb7PswHz7RU4tZyKa/eKiXqvToJN8x+8=; t=1756995262;
	x=1757600062; b=FdESnBTluKZmlkpsiS4FYoG3m3qJeX0MAKdRYiaEnh0FatpSrjCeTzdB8V2vi
	5Fohlb7zZfjULVh2SReRBzyVLcCkW+XLoqv+0nkRAJXgJxW8Dygwtrvv3StJAKYl5HD5k/wVrYFy1
	FyVytPD0cn05KGIu03NL/YSLVYEwl+AGJv0AK46CCzstS9K/K2CEVh38Db84W9SHmmG3TphTxlb0z
	jW8Gq2Q55Z7ape07NwPRjCXnH0y+agU6I+5zYLucUr9BO421zxs5M6W8lnPqHV+Q37okatRbHstQh
	QYcgR3NKzvREnV9uzwz/+cWOXO5uX+g/MzaUNkfbFqv6xRJqIw==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <mkarcher@zedat.fu-berlin.de>)
          id 1uuAjD-000000038mE-3FZm; Thu, 04 Sep 2025 16:14:19 +0200
Received: from 89-103-142-46.pool.kielnet.net ([46.142.103.89] helo=[192.168.0.39])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_128_GCM_SHA256
          (envelope-from <kernel@mkarcher.dialup.fu-berlin.de>)
          id 1uuAjD-00000000Vr1-2Rm0; Thu, 04 Sep 2025 16:14:19 +0200
Message-ID: <5dff8bff-4b36-4766-9da5-385aeb304474@mkarcher.dialup.fu-berlin.de>
Date: Thu, 4 Sep 2025 16:14:18 +0200
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>
Subject: Re: [PATCH 2/4] sparc: fix accurate exception reporting in
 copy_{from_to}_user for UltraSPARC III
To: Andreas Larsson <andreas@gaisler.com>,
 Anthony Yznaga <anthony.yznaga@oracle.com>, linux-kernel@vger.kernel.org
Cc: sparclinux@vger.kernel.org,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
References: <20250826160312.2070-1-kernel@mkarcher.dialup.fu-berlin.de>
 <20250826160312.2070-3-kernel@mkarcher.dialup.fu-berlin.de>
 <528a5d4b-1e07-4379-afd6-7e58d423e713@oracle.com>
 <C90C7694-C913-499B-8426-8DEC42137066@mkarcher.dialup.fu-berlin.de>
 <8403ac15-bb3a-4e88-97ef-6eaff26cc8db@gaisler.com>
In-Reply-To: <8403ac15-bb3a-4e88-97ef-6eaff26cc8db@gaisler.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Original-Sender: kernel@mkarcher.dialup.fu-berlin.de
X-ZEDAT-Hint: PO

Am 04.09.2025 um 16:05 schrieb Andreas Larsson:
> On 2025-08-30 10:35, Michael Karcher wrote:
>>> I think there should be a little more text about the nature of the failure. Maybe:
>> I will add something like that in v2 of the series.
>> Do you think it is useful to add the message ID
>> b14f55642207e63e907965e209f6323a0df6dcee.camel@physik.fu-berlin.de
>> as well, or an abbreviated backtrace from that message?
>> I suppose, that is the BUG_ON you are referring to.
> If that is the message referred to, I think it is a good idea to refer
> to it, in addition to a description. If so, please do it on the form of
> a lore link, like this:
>
> https://lore.kernel.org/r/<message-id>

My current draft for v2 has this text, including the link.

> Anthony Yznaga tracked down that a BUG_ON in ext4 code with large folios
> enabled resulted from copy_from_user() returning impossibly large values
> greater than the size to be copied. This lead to __copy_from_iter()
> returning impossible values instead of the actual number of bytes it was
> able to copy.
>
> The BUG_ON has been reported in
> https://lore.kernel.org/r/b14f55642207e63e907965e209f6323a0df6dcee.camel@physik.fu-berlin.de
>
> Fixes: ee841d0aff64 ("sparc64: Convert U3copy_{from,to}_user to accurate exception reporting.")
> Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Reviewed-by: Anthony Yznaga <anthony.yznaga@oracle.com>
> Tested-by: René Rebe <rene@exactcode.com> # UltraSparc III+ and UltraSparc IIIi
> Signed-off-by: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>

I will add a short explanation to the other commits, possibly this text

> copy_from_user and copy_to_user use exception handlers on user-space access
> instructions that return from the respective function and calculate the
> remaining bytes left to copy from the current register contents. This commit
> fixes a couple of bad calculations. This will fix the return value of
> copy_from_user and copy_to_user in the faulting case. The behaviour of
> memcpy stays unchanged.

That text will be pasted into all the commits, and if only loads or only stores
need to be fixed, it will only mention copy_from_user or copy_to_user.

Thanks for your feedback and kind regards
   Michael Karcher

