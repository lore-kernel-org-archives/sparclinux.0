Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D715330DD0E
	for <sparclinux@vger.kernel.org>; Wed, 26 Nov 2025 03:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764127095; cv=none; b=OCuD+AyImhK1WotHJ2D+SGmY7jxH9qLrJ7F0GncBKAb4p/858vKm1fWny+FnAl/MRZqMQciGznHgkIfx+3K43wMq2u5obgylyQMYV4SMP+ZSEPGUSjjYuIJ+/vMoXtbgQnLw0qAPePMak9+MSc1GAGRNq3KGod+UpDes1+7kBHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764127095; c=relaxed/simple;
	bh=MebXQ/i/4CXGFSpTUvGXKnO4bK1YiUe6DcpTQoQ/VGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ck/pNoi++hdFizA4vmkwKmnKHiuMjTQhXyAwV5ukCm+tjjakIBF2MS1isOShrAjheEkL7pi1Ev6OauYPlIm1B6DakpYDhQEl6Ge+uZrxUe5voP5S6tNsBQaLdyztOXjYTX2fMYgJTTO685K2UObFRMHIydj5zcVk+ys/9HKf1Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=draconx.ca; spf=none smtp.mailfrom=draconx.ca; dkim=pass (2048-bit key) header.d=draconx-ca.20230601.gappssmtp.com header.i=@draconx-ca.20230601.gappssmtp.com header.b=QZDePy1B; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=draconx.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=draconx.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=draconx-ca.20230601.gappssmtp.com header.i=@draconx-ca.20230601.gappssmtp.com header.b="QZDePy1B"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4ee1e18fb37so64996421cf.0
        for <sparclinux@vger.kernel.org>; Tue, 25 Nov 2025 19:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=draconx-ca.20230601.gappssmtp.com; s=20230601; t=1764127093; x=1764731893; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cvs0VVC0mcv4NgOGijtzLsQWvxXXKQp640I94GmhkA8=;
        b=QZDePy1BQK7nrhF5my/7UsIFIUbHAKuC1dIVqNpFMrlAlNKOf+8jqdINeehVA6sbhO
         G4u5OeAiry1/XeS5XF9Fd+ARzW/ZbZUIn/7ev9ZZaNSOLiM5bc1cVetA49Luqt1vaPAQ
         56v7mzD8Eaw6HZuJknAQj+uP2sh4hB3TG/RuUB29vDr8zZQkK7ZGa5Evs7voMPiWYd9J
         knDDiD+QbtuiDTkN0OnlX8gQC1FwU3/b4bV+HWJZS6Kx04DXMnL99r5LqxiQfIBbvVBA
         QSkX2N4xYpTckY+63WFdTR6YRja49EEtM7sGqfCrhdiPle7ZnxgE3XKbpSlPPE3l3ERE
         R3PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764127093; x=1764731893;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cvs0VVC0mcv4NgOGijtzLsQWvxXXKQp640I94GmhkA8=;
        b=Ou3uvC6H26H7N/hov8NWFYmOJfSQM1haVOvZ3kPaX1OFeS0q1GpH2711eT2BTIcNlL
         mIFe52Q0tl8H1J5SBAcpot2Na+Shj+6P19wucw/rvoJ1QOo67tmu0YZ0FW6cMYFU6fAn
         vgrrxFvbYMPjX3A89nWyLrlO6WQjHLeldbSBANdr6wxlljvRxW6oNjbKikZ6dRrAKnCA
         IKpBg5untW3FzJQf/6cdBHRP+Ti4q15J8KafNbGhuoZ8NqEnz1dHNJge66WsGdXcSJqb
         L30Tr9EKG+sJyLDSOqSIkq3I0u+l6B8d/7FuBFECfWgMaULcO1/mboergTuWjrqRup1N
         qpZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmiEdAjcH6v0YeqiLq7drfFgyc6RUTWKAeOQKculoTmoIxK5ISVZkt6vOR2b7Ej0DsbAmfPCdwb0YP@vger.kernel.org
X-Gm-Message-State: AOJu0YzWfjk6J4TZFddf6cTSwxuOjVs/upsbPBS2dAwmm3ySN6P2NLby
	7SMuykDpWaiMIAeVJ25DQ/Yl07d15Cx15UtTiqYRg7iXnJWmTYmWoqchXhnGbJe1fxTIgxaGNpm
	ppG7ybR0IAA==
X-Gm-Gg: ASbGncv3Nx1lDyjWl2EYjE5TvGRn9ea6yKYb2nSdQev9rX0dD6i6RrE52mV1xILxsGm
	vA2DtcwVHyTFBMI7LpRqzpsAptjgMC8eMeQ/nZfUGzsDtjA4AQb9FDeJZ0+zUKzyf+IpkvIVzD8
	fdb3PzdnsBS3Ibh5PQ1kJ6BQMf/wR91sz4IdrI+20woMNmDBWaTgNy0FMnNCFIoXwg5QX8ZiWcf
	j7IWv6OksCtFtZisDzeHA/H+NQR4YhC+E5On8Dz0Tq8rLzl9lQ7xXVLBew26ENC/24yEtDipaLq
	5JwnzLKARZCQkVw19DgQvuz4Oqd/lUvqjkxy8ExHDM6rDirbAOKdVFI6k+IDBRQngT3jgmuMc/X
	yucZGfvSEWUvw69CIIg7S6in40bcyST4VD31naTAH+tMclmXjfOSITCDxWNdW/q/uJbyb775eiU
	SxdemUNMAq3mAH9QugU7mfviS5FipRaNI56umsGtTxnVDgCeph8zs=
X-Google-Smtp-Source: AGHT+IFVPZAvlFu8nDpWWVLI1C6FD2IyTsqdkG4yg1n+X5k0lKqQqgf0T0rJLMz2wOCW390Qqgh8pg==
X-Received: by 2002:ac8:5f84:0:b0:4ee:2c3c:6e with SMTP id d75a77b69052e-4efbda49e09mr73391871cf.30.1764127092631;
        Tue, 25 Nov 2025 19:18:12 -0800 (PST)
Received: from localhost (ip-24-156-181-135.user.start.ca. [24.156.181.135])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4ee48d3a041sm115728681cf.1.2025.11.25.19.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 19:18:11 -0800 (PST)
Date: Tue, 25 Nov 2025 22:18:10 -0500
From: Nick Bowler <nbowler@draconx.ca>
To: linux-kernel@vger.kernel.org, regressions@lists.linux.dev, 
	linux-rtc@vger.kernel.org
Cc: Esben Haabendal <esben@geanix.com>, stable@vger.kernel.org, 
	sparclinux@vger.kernel.org
Subject: Re: PROBLEM: hwclock busted w/ M48T59 RTC (regression)
Message-ID: <gfwdg244bcmkv7l44fknfi4osd2b23unwaos7rnlirkdy2rrrt@yovd2vewdviv>
References: <krmiwpwogrvpehlqdrugb5glcmsu54qpw3mteonqeqymrvzz37@dzt7mes7qgxt>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <krmiwpwogrvpehlqdrugb5glcmsu54qpw3mteonqeqymrvzz37@dzt7mes7qgxt>

Any thoughts?

The problem is still present in 6.18-rc7 and reverting the commit
indicated below still fixes it.

I am also seeing the same failure on a totally different system with
Dallas DS1286 RTC, which is also fixed by reverting this commit.

Since the initial report this regression has been further backported
to all the remaining longterm kernel series.

Thanks,
  Nick

On Thu, Oct 23, 2025 at 12:45:13AM -0400, Nick Bowler wrote:
> Hi,
> 
> After a stable kernel update, the hwclock command seems no longer
> functional on my SPARC system with an ST M48T59Y-70PC1 RTC:
> 
>   # hwclock
>   [...long delay...]
>   hwclock: select() to /dev/rtc0 to wait for clock tick timed out
> 
> On prior kernels, there is no problem:
> 
>   # hwclock
>   2025-10-22 22:21:04.806992-04:00
> 
> I reproduced the same failure on 6.18-rc2 and bisected to this commit:
> 
>   commit 795cda8338eab036013314dbc0b04aae728880ab
>   Author: Esben Haabendal <esben@geanix.com>
>   Date:   Fri May 16 09:23:35 2025 +0200
>   
>       rtc: interface: Fix long-standing race when setting alarm
> 
> This commit was backported to all current 6.x stable branches,
> as well as 5.15.x, so they all have the same regression.
> 
> Reverting this commit on top of 6.18-rc2 corrects the problem.
> 
> Let me know if you need any more info!
> 
> Thanks,
>   Nick
