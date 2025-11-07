Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD204227563
	for <sparclinux@vger.kernel.org>; Fri,  7 Nov 2025 03:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762484777; cv=none; b=uHOe2NKJvIFl5mtO/26AQlTVY2ypzJIVNsoqh3oKmTXqzUvLFFVpSZBnwqloCYBUXYs+6meMtxLHS8spOF+PA/xhebKVCShoiy0TK50Okoo/vLO4s+bCN8QTNC/4TLWfqoQEkKerLnUS28J8+Deh3jBEvYKEnH+lKKsqeamd8kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762484777; c=relaxed/simple;
	bh=SqF6cjAe5fIGfKljFwR84iVXlUipV5ARm6YRakF57pM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kQSL5ImdhcjrT1inkJTDXukg55qxTh0xo6QeBhewbbhDLiNjVi1pk45U2QKuIChSQbqoT5TwF1kTxGgMeEkhDYfDdHXFIYpqmha5DivicCJ4xaBKUHM/5mcUglCxJTgyXPNyc43xiAkt1kWqflHhO4FfPxoalDB0LTKKSDB7GJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=draconx.ca; spf=none smtp.mailfrom=draconx.ca; dkim=pass (2048-bit key) header.d=draconx-ca.20230601.gappssmtp.com header.i=@draconx-ca.20230601.gappssmtp.com header.b=cn57xZ0o; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=draconx.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=draconx.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=draconx-ca.20230601.gappssmtp.com header.i=@draconx-ca.20230601.gappssmtp.com header.b="cn57xZ0o"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-88051279e87so3348826d6.3
        for <sparclinux@vger.kernel.org>; Thu, 06 Nov 2025 19:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=draconx-ca.20230601.gappssmtp.com; s=20230601; t=1762484775; x=1763089575; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E56miCz2ucyW7p5RTNikjLhgl4gC4pK61qcfT2Qpt0U=;
        b=cn57xZ0oPlgAD+CBSKMswSkoX9xKQS1HixdXW5ECEdl1/YgEelftUJw1DUcEfh+duA
         CqyX7f9UdS2NaP2m4VEwp/qSKjRqSQDW17RbaRWRXGTqnivMrDDO91IRo5di4cHofFo4
         dDmQShLEs015pKEKpL5+2L1UsNOF0CCOCELwr7VtTZodwebonazUVnNh52D0rcis0esS
         z9KV+2j1vbSwr3RhKOGq0fn9HINj478kHnk0DOEWVuwsrTs0VH637mEM4F+1mdG3XZr6
         s+cYsLKU+BMUC+arbyjobnJQiPwtQZS8rT7DMBjEc8kNkXUA+YVqrxCLg6UDZ1dBhD6f
         oIeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762484775; x=1763089575;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E56miCz2ucyW7p5RTNikjLhgl4gC4pK61qcfT2Qpt0U=;
        b=YruoId7p+bKUsrswyp9LURh659k52NzY0GKtB8sxWj8OLBIjZAGetI3m7L3jgHqSZe
         A8T0wepTSMDgWOtFmHG57vZvBqbVuYOHV+6vhuU1SadPMO9d6Bzz66R/x11ur2oXo6YC
         mgOxhqUv+OFFRX0nXc9pJWGYUSArKGw8E2fYR0Pqq8T2VaTBlazlhnoRaMf0WJ9HuEON
         VUPP7bCIT9HltTYugHqXw8DTUiLQEkMc6g9BKQ4iIh9/9UVNN66B6P++kPBvEozSsBbh
         6O8MSJ2nGqrdy0OIrkSDDg3byEZ49lUB05fxIF/BKS36g6L0D/fc5sMMPgcZKHcrkrqx
         grdw==
X-Forwarded-Encrypted: i=1; AJvYcCVzhVJexzFttzA1ILm1M6fsnI6gJ0qoAGOrX9sxStwvnu+cfxkIFHlA8/5OsgNWEEm2ijwe4+VujXy7@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe+wGeV8QD0+LWYyUAaQZpesU1AjbWicBwSClWtngbrHf/5eQf
	ew3Kwf5Y8q4OsS+Y/Q219nJZt9+xzB8YJUGmDLl6uLqU7fflZ2z/v+xNhV5qnbQQQF8=
X-Gm-Gg: ASbGncs92o1kXashcAHeGWJgYSYhecJHnIDJIv82gNq5/5OPvV2P2p0kIQ15+qK+cfX
	ULs/WClJCArP6kVXUGn/EpbpiabNON2N74VNH5pqRIT8omG+CmybGrNv6v7j4gBlwvzS83ojR+r
	1J7NojeeIW+zpAU2gEkvxfY7UqwYjwQXosEqR0d90ydFtXbcwuo8IZrqP2khW37Ar6cKYpz/DFg
	aZRD4FMYnUqmUPP6jHxM+4L4VpK2SuAuAV4dfxWzinHxQBKsycwxTGIg5uDSUINhGfXYRxFAiX6
	hWQOs9BRL2l39bKfSFlBVyC/yTeQrOxuIsdiQI+SRCB2x+7naFEqCOaHdNhe2ts1V8/mt8tU4h5
	S7i+q4PxnAlMYV5yRV/OLfuOmc6zrdb3ICXmhu25rLO0mI1qULQRlY0v3kaPufgwGwp7vcEB9Ar
	xElMaaLEszbodHAZdNyExloIyxZB7Y3VrROTGvcv1x
X-Google-Smtp-Source: AGHT+IEwrtDh+N2RU8TdlIkL8MsNx2X7a1H9tD28kPSplx5JFVcsb0223J9Fj+vOzbjZ1jDImx6R0g==
X-Received: by 2002:a05:6214:4004:b0:87c:108f:676c with SMTP id 6a1803df08f44-88167b17ed2mr26261796d6.25.1762484774711;
        Thu, 06 Nov 2025 19:06:14 -0800 (PST)
Received: from localhost (ip-24-156-181-135.user.start.ca. [24.156.181.135])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-88082a38210sm30548476d6.55.2025.11.06.19.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 19:06:14 -0800 (PST)
Date: Thu, 6 Nov 2025 22:06:12 -0500
From: Nick Bowler <nbowler@draconx.ca>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Esben Haabendal <esben@geanix.com>, linux-kernel@vger.kernel.org, 
	regressions@lists.linux.dev, linux-rtc@vger.kernel.org, stable@vger.kernel.org, 
	sparclinux@vger.kernel.org
Subject: Re: PROBLEM: hwclock busted w/ M48T59 RTC (regression)
Message-ID: <e7ezfmqnbduq7jdc7osicqp4rnztu466gpbcxaoj54jfigsvvp@iroscsnamy3c>
References: <krmiwpwogrvpehlqdrugb5glcmsu54qpw3mteonqeqymrvzz37@dzt7mes7qgxt>
 <DmLaDrfp-izPBqLjB9SAGPy3WVKOPNgg9FInsykhNO3WPEWgltKF5GoDknld3l5xoJxovduV8xn8ygSupvyIFOCCZl0Q0aTXwKT2XhPM1n8=@geanix.com>
 <ni6gdeax2itvzagwbqkw6oj5xsbx6vqsidop6cbj2oqneovjib@mrwzqakbla35>
 <35bd11bf-23fa-4ce9-96fb-d10ad6cd546e@leemhuis.info>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35bd11bf-23fa-4ce9-96fb-d10ad6cd546e@leemhuis.info>

On Thu, Nov 06, 2025 at 11:25:55AM +0100, Thorsten Leemhuis wrote:
> Just wondering: was this fixed in between? Just asking, as I noticed the
> culprit was backported to various stable/longterm series recently

I am not aware of any fix.  I just retested both 6.18-rc4 and 6.17.7 and
there is no change in behaviour.

Thanks,
  Nick
