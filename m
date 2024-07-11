Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF7C15CD42;
	Thu, 11 Jul 2024 12:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720699861; cv=none; b=TaXh0I6x7/+pzlnFG0Qpbq/KCBD8yDbCowjKGcL/lpFbyzOv4a/B/Fy4amYD3vBniTXBq5qLr0aZ9Rkr6FAq6Y/hKRezQxK98w5B5/X+d3RJYR4dcbWAoX+m5UeE61BDhyjRRe2uI1IPoepSKZ4Lmu249Iu9FbhPD5LOKOwkkmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720699861; c=relaxed/simple;
	bh=Z20/sCF5g3WtCr9/UKphITxI8tzAAYNyK+hrlF3OdIE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CBJZKD/gTcikO0iPAEkX0M536SuluquMdCso3dgV2S57NxZr6G72OjFeBeNY0TEcf685+mWT8Dv+F+4FH7bhh6aoNRpsd+eJ2FH2+VCSuTpcJCKS1IQ7EJIt2XcMnFpmtm2dyrqW7XNo+y1Px4kLsWLMi3wZGaiZrJJC+zuZlgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=Owb2RnTI; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="Owb2RnTI"
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4WKYTg6vNSz1DPkZ;
	Thu, 11 Jul 2024 14:10:47 +0200 (CEST)
Received: from [192.168.0.25] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4WKYTg4L2Cz1DPkS;
	Thu, 11 Jul 2024 14:10:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=unoeuro; t=1720699847;
	bh=ZhVrQsILYydXW0I2ququWpuLnNjaS/9rHPIQZwxhGVg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Owb2RnTI4WtlRVyr6Ifmq2UuJsDQ0Jy/+UHIK1DEPPc6T8Ur+snybV/lYlHfnj2+i
	 5gLSAbx00ic+HOv9w8TcC5cyn7mTu/OixRbiLP1JZlg46Pw6Ypdry63CLW+CIlqc+h
	 /E0N/7a6Z8OxZoQS/gdJEEcKhB9xw1W02wzS4NqA=
Message-ID: <5aa81417-9fe3-41e5-ac75-8dac52d02c64@gaisler.com>
Date: Thu, 11 Jul 2024 14:10:47 +0200
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sbus: add missing MODULE_DESCRIPTION() macros
To: Jeff Johnson <quic_jjohnson@quicinc.com>,
 "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <20240619-md-sparc-drivers-sbus-char-v1-1-85acadb8f789@quicinc.com>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20240619-md-sparc-drivers-sbus-char-v1-1-85acadb8f789@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-06-19 16:07, Jeff Johnson wrote:
> With ARCH=sparc, make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/sbus/char/envctrl.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/sbus/char/flash.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/sbus/char/uctrl.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/sbus/char/bbc.o
> 
> Add the missing invocations of the MODULE_DESCRIPTION() macro.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
>  drivers/sbus/char/bbc_i2c.c | 1 +
>  drivers/sbus/char/envctrl.c | 1 +
>  drivers/sbus/char/flash.c   | 1 +
>  drivers/sbus/char/uctrl.c   | 1 +
>  4 files changed, 4 insertions(+)


Reviewed-by: Andreas Larsson <andreas@gaisler.com>

Picking this up to my for-next.

Thanks,
Andreas

