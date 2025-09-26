Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507D71E573F;
	Fri, 26 Sep 2025 15:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758900738; cv=none; b=Wz3YqG0Zqd2ENKbrrdeXmFU5TmaNUCNvplmgod3NhxsGZ+N7nAWXOBSElCYVm6xGW/JWHVW5GQ6P1Ot0dV1nl26rFxIs1SloTK9wW/np/Mi1gIPGuhj2JwltP5PS9feABHe+1VDiDaTaNWNrlQQRna7MPd1KoKfXgZcVTljLc88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758900738; c=relaxed/simple;
	bh=eO0B+v6M/eNh3DuU5RpKBdPh66sor4Xjm0Yg+ev6U/Q=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=VY7Y/WqjcPwCqFdMypb/gx4/LK5Gqw4VfRasMhCjg+3Ubl4CZTZW9gjdpfI1H1cD27S+LOy4YJrvPbcpXy5UrximgxB4cLc8EW8N/ziuvdGjfAR6gDHjgZ45Iu75APEdGGVk8qvaClRCiu+AXesCj6e0YPgP96yf1hNGWOiubwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=TRnxadul reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="TRnxadul"
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4cYF254LpXz1FbZP;
	Fri, 26 Sep 2025 17:32:13 +0200 (CEST)
Received: from [10.10.15.8] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4cYF2522V7z1FbZk;
	Fri, 26 Sep 2025 17:32:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1758900733;
	bh=kMAOghaSlf/haDulwk4dYNLPJhvXyLFotJUOiNAZa2Y=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To;
	b=TRnxaduljc1Bj1P6Bvj0BD2v7c71W/qoKgdMebsAXx7fYUnmfUk2V+J+0MKObMgmw
	 9F51cGRietoCVgnhuyslHENWSkyql2+B9zDlIFqAme1vLQU21ugPtrKQ2zq2uapmSr
	 T5ouBkiYtkr79cYZL0noFN2DQSsLBiI/ekw/nMVSvqawsLTszHlBBi1VbpGfHbYuB+
	 pKearusdURcf4LTQbLj+hOeeVM3IO/LCVkdPzvnMLy/SR2j4yHdHnZJTD9x4FYnLUZ
	 gvAMtkG+42EYHmZNPwa9NVpRYtrK4DlP2iPmSb9tXsiCNo4JNjQ0K/RLRRvSZIOdTk
	 oXam3BhFg+ckg==
Message-ID: <00fedbfe-34ca-4ce3-8d7b-1ccfc86910b2@gaisler.com>
Date: Fri, 26 Sep 2025 17:32:12 +0200
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] sparc: PCI: Replace deprecated strcpy with strscpy
From: Andreas Larsson <andreas@gaisler.com>
To: Thorsten Blum <thorsten.blum@linux.dev>,
 "David S. Miller" <davem@davemloft.net>, Bjorn Helgaas
 <bhelgaas@google.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>
Cc: linux-hardening@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250922210408.1723452-1-thorsten.blum@linux.dev>
 <bdef00f9-4e66-4984-9b39-85b485bdc2cb@gaisler.com>
Content-Language: en-US
In-Reply-To: <bdef00f9-4e66-4984-9b39-85b485bdc2cb@gaisler.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-09-26 16:44, Andreas Larsson wrote:
> On 2025-09-22 23:03, Thorsten Blum wrote:
>> strcpy() is deprecated; use strscpy() instead.
>>
>> No functional changes intended.
>>
>> Link: https://github.com/KSPP/linux/issues/88
>> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> 
> For the series:
> 
> Reviewed-by: Andreas Larsson <andreas@gaisler.com>
> 
> Picking this up to my for-next.

...with some subject line clarifications.

Cheers,
Andreas
