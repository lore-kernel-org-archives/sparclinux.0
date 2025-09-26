Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435F817C91;
	Fri, 26 Sep 2025 14:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758897855; cv=none; b=Im2n4Wtz7mJXszw5iSNpXDkWbySrCnj4UfvmoyhAc5cHVDvFlE6CpeWZ1rhP9F913Z0baFByHgPOgjonSgxysoVF8tzfmrTbfH/FfdJ9AwVnP+6x7DHDAn9RM/99Ig2UQT13i6I06LnlnTQIRKA7nKkxf3glc0jAs/fBwTi3FDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758897855; c=relaxed/simple;
	bh=HSWJflFPq0ZJXddpxJ1cqQJdD0fmGT6QikMmTInWsoo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eNghooux9FvBQgrclFlUJVImMLzsm56Ozl6Nr3Rv77H1TSFNmIobJAR+GtBCX1mMcOYiEbqNRyqqomq1XXIPP1TGvff0yT/D4irIaYwIhZHk7WWM+bj7Y7F+wNq8GrAri7aNMPITKQb5v4MPyDTXHXDT4YhtaGq6SIcvn5GO7mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=k8JwW+dM reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="k8JwW+dM"
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4cYCyf2fr1z1DDXm;
	Fri, 26 Sep 2025 16:44:10 +0200 (CEST)
Received: from [10.10.15.8] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4cYCyd5pVPz1Fb3H;
	Fri, 26 Sep 2025 16:44:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1758897850;
	bh=2TwWMw8BjVD8YDqkUs/EeU0vmgN0/aEnq1P+0Mdle20=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=k8JwW+dMt/Clee0N3IiJ68ITv8UqWAxn2FyCYVbvBfsg9eks/4rn7sOrAtG4StCES
	 qDRvsAaL9XnkeZVgFV1ezfPdO1q0r9JydVAGIJUHVdkAInErFHK5Ho/KQK08uo5iZN
	 gN5xk/h776eFMDJvq0dcw/3lifPgbXP37mGVxUsADS3/LIkz19xQHoGJOMyBHvnK3m
	 u/y+6zU0VdNWDdVuQ3wvf33oX7BiRrAg9qA83E/U2QjwL8EcPEmFM4HSnb+nP5oOQh
	 o15JPTGiMZnKHye95Mdoe1YGLqzIF+pc6iII5UjXabaKxPKgvG78r4qThAYg0/72cQ
	 i3CYboTeYkZHg==
Message-ID: <bdef00f9-4e66-4984-9b39-85b485bdc2cb@gaisler.com>
Date: Fri, 26 Sep 2025 16:44:09 +0200
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] sparc: PCI: Replace deprecated strcpy with strscpy
To: Thorsten Blum <thorsten.blum@linux.dev>,
 "David S. Miller" <davem@davemloft.net>, Bjorn Helgaas
 <bhelgaas@google.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>
Cc: linux-hardening@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250922210408.1723452-1-thorsten.blum@linux.dev>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20250922210408.1723452-1-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-09-22 23:03, Thorsten Blum wrote:
> strcpy() is deprecated; use strscpy() instead.
> 
> No functional changes intended.
> 
> Link: https://github.com/KSPP/linux/issues/88
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

For the series:

Reviewed-by: Andreas Larsson <andreas@gaisler.com>

Picking this up to my for-next.

Thanks,
Andreas

