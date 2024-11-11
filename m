Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC3B14F9F9
	for <sparclinux@vger.kernel.org>; Mon, 11 Nov 2024 20:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731357975; cv=none; b=cGgXUVoSNJN00dFMKeVcGrSuesxjd5dX2n6sxj0UmRT5V6ExrciyoElQ4mU8YZmLl7x9EXfgFzg3kwLXPw95AeJ7uVoleEwYiUNcGoUTHqPuzp9JSO1yOV9FaG9WG9AdXDYLI+F5llhRZVGe5f89Xp9xxlgDDCJmdj2gmXGFluI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731357975; c=relaxed/simple;
	bh=d1WjlRWC2HjFBoUqR+WxupbhC0i5CdNfScC+iOpBSpU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=sqR5tyNWKOcZCfWbp4CNPSmgbse0aELZOectnKMU622TZBBVFIeFAgM0CwNPFZZDnkg7fU+rSW96XRFhH6cgd8YgbmclqFd48g9iS98kbhz+bfFpgTqi1YUSLpkWhL86LvI7REIT9wrV2ucjCdwAdj0F/30vA0UVeoPc6vYMZ9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DjUKYA1p; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DjUKYA1p"
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731357971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+IKrn757bzVDVKFEBdSAVFF37vPhDgDtCOyudYDcT1o=;
	b=DjUKYA1pMZHERK1bhUDlEjJnJev8F0bDABvEeT3jxVd4AniHMR4TbYTqpFOsUBorhOjcnt
	vvfxxd463eg/9wVBZKMwMcX2ME5upu5NtwVG9Pn5lo8CbivNkRxnJB4YizVREb0WPgoaib
	CmzDkb+LVr3N2Xyjar5qcXw0HrmtGag=
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: [PATCH] sparc: Replace one-element array with flexible array
 member
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <83a95dfe-533b-468c-8dd4-439157c0e1cf@embeddedor.com>
Date: Mon, 11 Nov 2024 21:45:56 +0100
Cc: "David S. Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>,
 Sam Ravnborg <sam@ravnborg.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>,
 linux-hardening@vger.kernel.org,
 sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <7F05D8B9-E13A-4331-895A-65D92649B42B@linux.dev>
References: <20241111200155.164621-3-thorsten.blum@linux.dev>
 <83a95dfe-533b-468c-8dd4-439157c0e1cf@embeddedor.com>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
X-Migadu-Flow: FLOW_OUT

On 11. Nov 2024, at 21:20, Gustavo A. R. Silva wrote:
> On 11/11/24 14:01, Thorsten Blum wrote:
>> Replace the deprecated one-element array with a modern flexible array
>> member in the struct hvtramp_descr.
>> Additionally, 15 unnecessary bytes are allocated for hdesc, but =
instead
>=20
> 15? unnecessary?

hvtramp_mapping is 16 bytes and the size is calculated as follows:

  (16 * num_kernel_image_mappings - 1)

which is 15 bytes too many for any number of mappings because hdesc
includes the first map. It probably should have been:

  16 * (num_kernel_image_mappings - 1)

unless I'm missing something.

> It seems this struct is a candidate for `__counted_by()`

Yes, but sparc doesn't seem to support it?

> Now the code is broken because it's allocating =
`num_kernel_image_mappings - 1`
> elements instead of `num_kernel_image_mappings`.

Ah sorry, missed that and will fix in v2 shortly.

Thanks,
Thorsten
