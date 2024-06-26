Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0AD1849C1;
	Wed, 26 Jun 2024 13:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719409114; cv=none; b=VA3X2K7+KZ2eAFT5NrWcoW3Qjg7A0vpVI+T/B8IeekDye9L8Z3UfMZGEAU1SYaOPNljcaTt0Wqn+Ir6mpM9WawDDBkrZ+q/x0dHKZBuAWn8/9LxIHCVHxbN81B1XIfzpm4fEc+J+ru2JleWGaXZ7oUT61EUkHEl/d/eZYv9ygIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719409114; c=relaxed/simple;
	bh=0GBxfrcHHTAQoKsHFH/S0ZP6WsOUz+LOET6DcgRPCwc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B0nncT/9RKu509nvHUZES1UjV7ONw7M7+G8lubcPkDf73Tq5vRbIZOI1r7azLezlDzhOd2DJZhb+/Y+r2vHiO+L+HwQASbIZySc8CiwNdX8V0AUFu/PQVC+pdOlJXfEDkZOXIzbWpysSIL4HAToY5WKu2TM3KvCJIBLo2MbfPvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OXF+hvJ9; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OXF+hvJ9"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52cd628f21cso6069299e87.3;
        Wed, 26 Jun 2024 06:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719409111; x=1720013911; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xcG7knP1Gs0T4Jv/tUigyPx9nzWz8ywBIZJPbRtn4wg=;
        b=OXF+hvJ9bxkmAXbA+YEfcEbE0rr8pAb0NOho70gXab06EapKABxPV+oZJ6ajBfuzFr
         gBCFZcFYwvc6lFqzDk+pxU889bmaq+Ay5ZS4x+S8O1jHGaEgMBcsshM6JZHoQ0BeDZZM
         H5Lx3FYB+5tyM9wmTzGfvuZ39oFpLeQ/DglJr7TM++1tJkG2YrOi4Hxtl0S2jlI4Fzbs
         ZCWQfuSERnFvJOd0tro0UDUlzo2zokbMAOGywnadc8RNmKCkrcd8/uqbhSbk25/jOQAJ
         R13nFMClPHMST6XN6A4PXXh7JnEsNnslf6tfp3HpZ3aCFJSN/TbQCubTPtl585Z5CRH4
         67OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719409111; x=1720013911;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xcG7knP1Gs0T4Jv/tUigyPx9nzWz8ywBIZJPbRtn4wg=;
        b=lmbU8znyqypD1KSQY6wE96nhxNicwlgD+qHtSc+ijeo6/vKyGZST9k1DJw42vnKeQr
         A6PMKzutEFb0QnEgeQXE/YY61UJ9pLTgbSw14UaS+Bu9IY35f1MHUSWPSiSIjgIZg8q4
         UY9lpDvz3SfR6ZUrcaKSi6zI3An7V25wfAJLZowsEvwQAhdYEpb7GseYfwemy7VK2ZgF
         HrQWveXP+tfwpx+cyP/Mgk8A+39Hp/zyHFbUgfKVeW7mO55LtQiMRgzlLUGxEQO0RzBI
         tzd+f6UEXw6CdTg9UzZC+60kDTWeu7cVKVbI4cuDUzPKhvVqRFPa4XFLbnRQehgKZaXk
         MKOQ==
X-Forwarded-Encrypted: i=1; AJvYcCX70a3b85BZdzPSg1V3QuZ7CUiP4M4UIT3YdfLvBEBA1E2P4V0oqWcULvewrauUBulZq7tlILD7C/vsl+2ouayn9RVqje6+cIg3/r7h3VW5jEZM3z15oxtySneFmBZbuxmQHouYh0+z3g==
X-Gm-Message-State: AOJu0YzdOCvEKPp7cYD6M5a0igU1aLS3KaLvVvYDRvnSCRS5I/jyu/c2
	T8nSlS4dAJa2BIvY36B2ZcYUGhJ6lzypyH4Dhk9jTWEgCugZ1IXhUqhIRQ==
X-Google-Smtp-Source: AGHT+IE+5sPbVuM267cG5j/0wGO3vAZT1hiCp+Z+H5L32tjwN8f+2LxiC6ZgFtSIQl/ZAqA/xW72Sw==
X-Received: by 2002:a05:6512:34c5:b0:52c:a88b:9994 with SMTP id 2adb3069b0e04-52ce185eca9mr6076090e87.44.1719409111184;
        Wed, 26 Jun 2024 06:38:31 -0700 (PDT)
Received: from pc636 (host-90-233-219-252.mobileonline.telia.com. [90.233.219.252])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52cd63b49e7sm1566340e87.34.2024.06.26.06.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 06:38:30 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Wed, 26 Jun 2024 15:38:28 +0200
To: Nick Bowler <nbowler@draconx.ca>
Cc: Uladzislau Rezki <urezki@gmail.com>, Baoquan He <bhe@redhat.com>,
	linux-kernel@vger.kernel.org,
	Linux regressions mailing list <regressions@lists.linux.dev>,
	linux-mm@kvack.org, sparclinux@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Hailong Liu <hailong.liu@oppo.com>
Subject: Re: PROBLEM: kernel crashes when running xfsdump since ~6.4
Message-ID: <ZnwZ1EL54DzsGf9E@pc636>
References: <Znq/8/HAc/0p6Ja0@MiWiFi-R3L-srv>
 <ZnrjZRq5-_hemrbD@pc636>
 <ZnrnADHvOiNcZv9t@MiWiFi-R3L-srv>
 <Znr1IQ1mssdNNXbv@pc638.lan>
 <ZnsjIB2byIxSgbjc@pc636>
 <20240626051206.mx2r4iy3wpexykay@oppo.com>
 <ZnvcToH1h-sVtikh@pc636>
 <20240626100342.2dudj6fjjx6srban@oppo.com>
 <Znvyvof4CnFETJ-v@pc636>
 <cc70c1e7-aa1b-45a7-8edf-20dc4f3b75ad@draconx.ca>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc70c1e7-aa1b-45a7-8edf-20dc4f3b75ad@draconx.ca>

> On 2024-06-26 06:51, Uladzislau Rezki wrote:
> [...]
> > Thank you for pointing this. Below is updated version with extra comment:
> 
> I checked that I can still reproduce the problem on 6.10-rc5 and with
> this patch applied on top, xfsdump doesn't crash anymore.
> 
Thank you for helping and testing. I appreciate it!

--
Uladzislau Rezki
