Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA5E246763;
	Fri, 19 Sep 2025 18:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758305604; cv=none; b=a3fh078dkd1FmmxNidj5FnWBqy0FrpTNuWivrtAaC2ULrq8gmI9RBKMsNGcqAdxShXnZjMpA8nSaBBsmdizipup3PXQK150WLVFuYUyQwf16vMsYL5A2Q3vNE8HPJVM5cuiqcVcm13jmh1XJJVAuTAZpcQ7imxDfew8VNSHAxJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758305604; c=relaxed/simple;
	bh=53CY2CJytiIvSVffzkQNZCmuzLgeHbAjU7nGQR1uLqw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QCS5vROn9XW5CXLzSUhl55FtylwH/5NWlh0NGuC1pv79PR0P+14xF6MHAIFJKGUJ/vcB/TM0nXqzR4ZP17opHT2s3RzgPGI0gD0yhPVaVWv5ex+3xIZiHMauBqN8zy2lN3VMF/VjyLCOMvqt4YL4G71pW0bSDo5Ely6I1n8zPuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=FCXAZExy reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="FCXAZExy"
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4cT0xF0N86z1DDB7;
	Fri, 19 Sep 2025 20:13:21 +0200 (CEST)
Received: from [10.10.15.9] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4cT0xD306xz1DHWS;
	Fri, 19 Sep 2025 20:13:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1758305600;
	bh=gfXkTRKvzUkoqfK3h14i6FK1ywfHW8/8Amd0DBHRT+s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=FCXAZExy5OGEPe4RlBlBTRfZnQMHFgMHgCjuMPHlGVzbcdmtbcEQ8VnmskUjKvKGk
	 fxB4NqG4y9ODPUuwSiLGPeuVbl9QqPHsZoC6E2o3kUkbnLa6Fw07OyyV6UaUo60A9K
	 ZpUoqmpfio4Fo12AJWZWyYnfeqCnw9LN/jjrKcWpwfXsC1uKsK3fMwofNM5DjR8yWx
	 e2RfQU0fskfuCxE1JsaMjC33XNRhmeH268lkVcySRxXGf2t83qih6GmK9N58thzCuT
	 xllS9Tt5JYDMLkYRIWIlX9Z7H8mt2qt8IgDMYNiuAxDBru7esU/ihC+o4lBwwMqlIj
	 1qZrWbZlN2z5Q==
Message-ID: <d676606e-f448-434b-be26-c839dea4f5d1@gaisler.com>
Date: Fri, 19 Sep 2025 20:13:19 +0200
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] sparc: PCI: Replace deprecated strcpy() with
 strscpy()
To: Bjorn Helgaas <helgaas@kernel.org>,
 Thorsten Blum <thorsten.blum@linux.dev>
Cc: "David S. Miller" <davem@davemloft.net>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-hardening@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250917155038.GA1852582@bhelgaas>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20250917155038.GA1852582@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-09-17 17:50, Bjorn Helgaas wrote:
> On Wed, Sep 17, 2025 at 04:47:30PM +0200, Thorsten Blum wrote:
>> strcpy() is deprecated; use strscpy() instead.
>>
>> No functional changes intended.
>>
>> Link: https://github.com/KSPP/linux/issues/88
>> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> 
> No objection from me, but no particular PCI core issue and I don't
> maintain this file, so up to the sparc folks if they want it.
> 
> I would consider making a single patch to address this issue
> everywhere in arch/sparc so it can all be reviewed together.

Thank you and sorry for the late feedback. I agree with the above.
Thorsten, could you fix this for all occurrences of strcpy() in
arch/sparc?

Thanks,
Andreas

