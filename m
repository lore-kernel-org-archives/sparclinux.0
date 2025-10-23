Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9B42580D7
	for <sparclinux@vger.kernel.org>; Thu, 23 Oct 2025 04:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761194718; cv=none; b=KXybzTSLZG6dSJMcD7sr/KMyYObD0V5E9X65tDNlEl6hPxnXxSBYYpygW/nOrIxQLz2LUV160rNKPPMJn+0hyzBQdPofyiD0R6pF0Y3j4r0qi5+rW80R7RbVSzEUReP0tGLNj2Bn0nQBZpVR4LnJqVSzBaR7gvSLFyOjhaBjxDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761194718; c=relaxed/simple;
	bh=dDXZ4wlWh0zWE73CQei9SNb/wNKyNyNkdvTY21hhmRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KtC0MuUiOTdj8slxCb8519dULUr9Z+8DfD3kEO9xaEa8jvDA2Kx99psV++YakvunaRPpziHj3zIAP1Lf7fE5EAkSKX2Iq//EbL8vm8GnJ5hk/km7etslcyGPcbWyvjDHJrW32FMlf1H3990VKEuO4p43yOAoSqrxx7eA9KeCsa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=draconx.ca; spf=none smtp.mailfrom=draconx.ca; dkim=pass (2048-bit key) header.d=draconx-ca.20230601.gappssmtp.com header.i=@draconx-ca.20230601.gappssmtp.com header.b=Dyt2IWPg; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=draconx.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=draconx.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=draconx-ca.20230601.gappssmtp.com header.i=@draconx-ca.20230601.gappssmtp.com header.b="Dyt2IWPg"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4e8b334bff3so3685841cf.2
        for <sparclinux@vger.kernel.org>; Wed, 22 Oct 2025 21:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=draconx-ca.20230601.gappssmtp.com; s=20230601; t=1761194715; x=1761799515; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SxAw5CcaNyJRUdL9g50f2nQhs9yBUN9LI3kQV7R+EXE=;
        b=Dyt2IWPg0y/LKwDvPqfaV9Xtam35tvueaP+OP11DwK6jU/oWLjgKA4JStUxKiXWhXI
         mN9R2jUP62evu/BI9IqnT3obgVXIYRL6wBx90qrdlZsM7HttlcRrfAKGhjyuj3jhJdDp
         2uBL+XRCQ58eAExxWgdfjk3eoqSow2TEf01btZVuPqArM/gAVPnR6USX8wA5FNket3mb
         rO4R3RTF7vA5AjJNeuNlBRhOpZcwahpKqcm5rdrMc1s8DWNw4SD5I0pEYtv8dtZomriV
         4tr6QhNFo8cvAkvdtg7CcsCs7tncNRF0OZBMp+Q5emdB6euthCM9gqJlKJyaEB7hhpme
         lqbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761194715; x=1761799515;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SxAw5CcaNyJRUdL9g50f2nQhs9yBUN9LI3kQV7R+EXE=;
        b=xC8FTo1FYIDgo28cPOZ4YVlgGiT3Y2RHz8qjkaTEM5fnBu0rtRH4JxU/iC3vpJqEYB
         UkOe8jZOFbe8d6gR1Ge9WKQtij+U+/pTsfS/K5GMt9p1w62l5hEco9qtqpFBUiNOG6xa
         cVjSahNrr26LcRTX2p4xmYhBFhxQHV9bGnYQzi8IPJzNtjO0bac8SdGS5snRrQG0GVSm
         OPEi1wnbLWc/ckMCg8uO46G8DmmUTW22NTD0UnzD/EKXuEV+DtH7rCydva2njkLUM1ay
         oS8YXoOss7DMYlKOZflQs1EgMp8xKnw5bz5W3M+ETpKT/MzZy34vUSCfavLW39S4E0za
         N+Ig==
X-Forwarded-Encrypted: i=1; AJvYcCXoZhJdDgB/Y1qE0yT7vyzKzLJb37kBcAEIkNU3r8ptBBk+YcY1fWgMHW8nfcvPdN59eCk8DqBuIQLt@vger.kernel.org
X-Gm-Message-State: AOJu0YyOSpd8uh1/BdiAHLe62oOdOHcYcR4xrLc9JJA6TilWzUskLjTW
	GUjS30h/m9sNZ+Yr49NuVgyOOpxgRyyIJOTUCSOIVYU918LuwJUgRLdm5+5mPoHSRGk=
X-Gm-Gg: ASbGncu7WlFlBMuWnz1mlkNXD9FW3j/juWOInXLDjAGRH7wkpG+Stlg20AQ6bGOSRqM
	glXM2bfV5JjkrN5S/8I65Ls9V1CZ9+fA8jj6mTBuArDn4ScoZG3i9RR1rJR4/gHXhuSgMxNrFjr
	BTjBIiStuHhs5LCo5V7s0X2ACMSSGETDuhqlfk2x6wEkKFel02qDhMkQzOVaURDEvu5xCWPUMtv
	OTfFa+BwD8BxOUc8d9oVHLqrY98R2iG+p4v0/vcrjHjisuSAba7QJ4+pVjs2RJKehsaF4aqBEra
	r7km9wso3VoOqlMpcpu4SjMJ7wFJzNSCvSkpJyR35a87tRHPN2P5ZC2rTAy8keb2u3lo1I9lsrG
	REVgpGSYT2UVNqqKDrpp18jl2idjLiuRyhuyzV3XYL3yFaXB2ywKTIqY1a4CLNlzdYSEoFFfQi+
	2spatdXxdsufcIvN2JMQ41eq2PyP+jyA==
X-Google-Smtp-Source: AGHT+IHAxwX1q4xENozHdVwqKqZ7TDRt7Gbja+SgOkIQM2H6Yykm4zUm83IbTesCfNfk5IdGOKlPzg==
X-Received: by 2002:a05:622a:138a:b0:4c3:a0ef:9060 with SMTP id d75a77b69052e-4e89d27666dmr281053671cf.26.1761194714911;
        Wed, 22 Oct 2025 21:45:14 -0700 (PDT)
Received: from localhost (ip-24-156-181-135.user.start.ca. [24.156.181.135])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-89c0e688d64sm87480285a.21.2025.10.22.21.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 21:45:14 -0700 (PDT)
Date: Thu, 23 Oct 2025 00:45:13 -0400
From: Nick Bowler <nbowler@draconx.ca>
To: linux-kernel@vger.kernel.org, regressions@lists.linux.dev, 
	linux-rtc@vger.kernel.org
Cc: Esben Haabendal <esben@geanix.com>, stable@vger.kernel.org, 
	sparclinux@vger.kernel.org
Subject: PROBLEM: hwclock busted w/ M48T59 RTC (regression)
Message-ID: <krmiwpwogrvpehlqdrugb5glcmsu54qpw3mteonqeqymrvzz37@dzt7mes7qgxt>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

After a stable kernel update, the hwclock command seems no longer
functional on my SPARC system with an ST M48T59Y-70PC1 RTC:

  # hwclock
  [...long delay...]
  hwclock: select() to /dev/rtc0 to wait for clock tick timed out

On prior kernels, there is no problem:

  # hwclock
  2025-10-22 22:21:04.806992-04:00

I reproduced the same failure on 6.18-rc2 and bisected to this commit:

  commit 795cda8338eab036013314dbc0b04aae728880ab
  Author: Esben Haabendal <esben@geanix.com>
  Date:   Fri May 16 09:23:35 2025 +0200
  
      rtc: interface: Fix long-standing race when setting alarm

This commit was backported to all current 6.x stable branches,
as well as 5.15.x, so they all have the same regression.

Reverting this commit on top of 6.18-rc2 corrects the problem.

Let me know if you need any more info!

Thanks,
  Nick
