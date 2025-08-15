Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55512F83CE;
	Fri, 15 Aug 2025 09:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755250672; cv=none; b=g2c2Qkas8ybQgzoOZqVuRG6wRAGZS1nJrRirMRQflNX3u0K9mdHtZ5zGWvOItngoq6QUrR1mem/FtUIuf+3JCtuf6LcuwpB7TAnfO2KR9ilHh/QlJ9KmN08XAtaXsM7612vuSVMGdLjFYjUX7CH65+lmE+akrBu6fM+kdqn5DIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755250672; c=relaxed/simple;
	bh=ApXyXHLbQ3tcC5N6+9z/v/iwGkOKQNttPRNU+NSsDM0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f0kJgc2IL1w20g+ZO+ezQgngeK5Hy9LatF5awxDA9mCNH8e2x3rYDDS0dP4aJLnGy29hc2j8torcycUeuzNJqzL7/8s/1k7a7evA5Efhu9tHNHURJbGgQvmREE+L4K8edb2uQzyoAUpoppxMvFi/KVJQuRvXkJ+KTD49iLE+Ijs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=hVpo3PQ5 reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="hVpo3PQ5"
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4c3H0c2RBvz1Fb3K;
	Fri, 15 Aug 2025 11:30:56 +0200 (CEST)
Received: from [10.10.15.8] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4c3H0b6KJ6z1FQVj;
	Fri, 15 Aug 2025 11:30:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1755250256;
	bh=MKLXb3cozyKshQ54syx5HAD/w/DtV7m50LPvkaXRjLQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=hVpo3PQ5YHrYSmloGQOJZ0AiGQ4D9q1eHt45I2XkH2IbZfaO/xNt/sNsu3pPqJn7C
	 Du+Z7BC6S6QIJqLQiAJTXvE8vnuybAHvPKsIp2n2ykW+d9qN+pa3HRQFLfkQ5PN/ws
	 KbYNCyPaatVre4CCs0kUGEHHGuV1MWQhLu/KzdOFKN0pNxS1JJW3Dnv/EGoKCnBwFr
	 A5ZiFq2rY94NX5DJL36lRMErRuxGHr4YcrYB58xjppHXhbaBNLpwWqdnLIVuDYFNZI
	 TV1aTRnsDNVT/R0iwjlKWw4kcJYlsoOTrOGj/XTiPHKasJiU/HTQ+fGWdpO11qbkec
	 wK2VFtBiazqHQ==
Message-ID: <9aa26a87-40f0-44fc-b7d5-fcf7d30525c7@gaisler.com>
Date: Fri, 15 Aug 2025 11:30:55 +0200
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] sparc/module: Add R_SPARC_UA64 relocation handling
To: Nathan Chancellor <nathan@kernel.org>, Koakuma <koachan@protonmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev
References: <20250609-b4-sparc-relocs-v1-0-aa52631735af@protonmail.com>
 <20250609-b4-sparc-relocs-v1-1-aa52631735af@protonmail.com>
 <L-bOu33R0ouNodufTRVlvyqOoz0SGuskQ_bqQ4X_xBkw91w4XmezvmkG0p6Ith-rsFIKYSkQWHUdMJ_G0lyYJhtg18c-mfWWjPKiI_Or6cE=@protonmail.com>
 <20250814224009.GA2217114@ax162>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20250814224009.GA2217114@ax162>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-08-15 00:40, Nathan Chancellor wrote:
>> Ping. Is there anything else I should do for this?
>>
> 
> This seems reasonable to me, sorry for the delay in commenting. I would
> expect this to go via the SPARC tree but if they are too busy or
> unavailable to pick this up, we would try to route it via Andrew Morton.
> Is there more work needed for the integrated assembler other than this
> series?
I'll take it through the SPARC tree.

Cheers,
Andreas
