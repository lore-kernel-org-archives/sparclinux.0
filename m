Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292A41BA86C;
	Fri,  6 Dec 2024 10:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733481933; cv=none; b=aL7U6wRCOSBDzYCktMgvu99dEjG9IPEq5SyoGffOQcOqMusUENH0bN0og9ogrJhmQ4Qmrys0aFa63MgpEoE4qv2dXMCZ/rJLKH9pGxpK7H3WqW4sOD4h7Ld5YisWzgSOOsdEhRnXENYR4/RHeuBUN24CqW8pOkqwoeWLxJLJQGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733481933; c=relaxed/simple;
	bh=5Dy1jTLXFSJaBk799Ng7fy2m+8bS1nl1M3gPnIGJAd8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N3J/n4Yx06iasV8FtMPwRXuc0yAxMcmgP0VW/invBZi7iczjRXsD0HEjxzaCT9SuPH6nGqheif0xgKvgiZMdSguoToZe23tgTYd/Hur8SHGHCRROAZGI1OfVMd+X/xhdd9VDFSrmFoCnbYcwxuB/yggTC7SAK0WfQSuYiU6TxbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=kzKExKI+; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="kzKExKI+"
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4Y4SZs5pSBz1DHWX;
	Fri,  6 Dec 2024 11:45:25 +0100 (CET)
Received: from [10.10.15.2] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4Y4SZs3qybz1DHXy;
	Fri,  6 Dec 2024 11:45:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=unoeuro; t=1733481925;
	bh=5Dy1jTLXFSJaBk799Ng7fy2m+8bS1nl1M3gPnIGJAd8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=kzKExKI+ox20WAUP5yDnpFmgHC1JHAdYpkoYBdjIU9zLCKtB7yVSO34SSs28H21l0
	 y6zdu8QnPPU10pTdXMaGFS5GwSpL/N9HvBjTvRI1olIcO2sLy6DW0YOOIDEB4alRmh
	 tnQwMkzwxq8h6j7N3s1BST5uSYcQqnSOGC3fUD1o=
Message-ID: <9a4f9898-f47d-4d62-880a-a0b1e9d5a925@gaisler.com>
Date: Fri, 6 Dec 2024 11:45:25 +0100
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sparc: Move va_end() before exit()
To: liujing <liujing@cmss.chinamobile.com>, davem@davemloft.net
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241206092346.6003-1-liujing@cmss.chinamobile.com>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20241206092346.6003-1-liujing@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-12-06 10:23, liujing wrote:
> [PATCH] sparc: Move va_end() before exit()

That this is version 2 of the patch should be indicated in the subject
line as [PATCH v2]. You can use -v <n> or --reroll-count=<n> with git
format-patch to do it for you. Make sure to do that for your v3.

The description line still doesn't indicate where under sparc this
change is happening. At least start with "sparc: vdso: ...".

Thanks,
Andreas
