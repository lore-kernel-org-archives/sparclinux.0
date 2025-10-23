Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8509730C603
	for <sparclinux@vger.kernel.org>; Thu, 23 Oct 2025 13:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761226792; cv=none; b=Fkn6fyE+9kN2zojkwxvWTlduvSMZprn7UQ+jZhTHJqANs1EiiiMgStmFQnAHLTOn5Wt6nWBn1ECiQ3YCgIaLgEq87IlpQcihqz27sQoVcf6rzyPXH55Nt176mDkO39uLtr+/cK3aQZR2JV4TFrhJB3qt0Z24vEjOjfofal4kOCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761226792; c=relaxed/simple;
	bh=VlZWQP2vRd5Et2IXN3Y2jcp3joaOd6hd/WT2Ydflim0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JdceRJ0y4K/ATnmpOB0Fo0M0M2XjwUXOVIRINtvn0MPKLcnVaJ6uRVFycztDBZbk4B9iEpxFOsKXIi6P9wVe128g8QzkbpmwwYqn34u6VayfnAKq+Gr103yWiHRUXhDTJ6xiKa/HdX1Ew7jCoGLw6k+iXGjE4JFhT6Q7YmoeFlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=draconx.ca; spf=none smtp.mailfrom=draconx.ca; dkim=pass (2048-bit key) header.d=draconx-ca.20230601.gappssmtp.com header.i=@draconx-ca.20230601.gappssmtp.com header.b=ZlVecIt1; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=draconx.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=draconx.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=draconx-ca.20230601.gappssmtp.com header.i=@draconx-ca.20230601.gappssmtp.com header.b="ZlVecIt1"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8608f72582eso44473385a.2
        for <sparclinux@vger.kernel.org>; Thu, 23 Oct 2025 06:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=draconx-ca.20230601.gappssmtp.com; s=20230601; t=1761226789; x=1761831589; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OTdirufWMbJmlgZU7Yrv6nTsTJjgQ9dqEPOTcrYAzcQ=;
        b=ZlVecIt1Va3KLH2xbaLHmrQQIxECKYgoUf2jDlJZxy8YVi3leweiFOghBeFkCoofae
         bH0TOmoqf3fvT0+xJAJarpfPJ57PMPM4Dhe6dofB0JXc7a8OcUG2Un6bsSN+CTEBeXXl
         HqcKF08VnXs2nsdPVxKuJ2j8tRSEpuP3OcsmahZCPPLDJ8JUlIokljyy+kHOI4FpTlzN
         U9BD43Ey5Ntlv5DL3CsV9VuonKNE3hqMnX3vtlKJx6dD2pov1aSvrYCUg3uoEPLo2G77
         +iDf+BkLUbWGWgYPDL9TclwSQLPkuH94dz/J7q51pM2rZWKsSdj2sl0zoXiq+rl1sfAh
         b12Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761226789; x=1761831589;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OTdirufWMbJmlgZU7Yrv6nTsTJjgQ9dqEPOTcrYAzcQ=;
        b=BE+WjegbswgxaPhvX4bXhxcZHJtD6jYqM4JqTkuyPDdw5FNe7XkoRbTbKde0upFGEr
         RtIXhpvBfOIoo6y5Sz/tgT7kfS5wjfYjufI6DrVyGeZVVKsU9J9nb6yPEuC6GCAr/BqO
         Yba6rr3fAzetlHx8HIT3uLZ7syAWykTptT8Z+wbToqI21wTYC9lGPYzBn/VC5LGZ+apw
         Aqc/gvZiPYoAbgvAlgVmAGrWrSRrA5vnIc3OmEpqlBuSlpkinAXPl2fVCcWBRn656RR8
         E8r3Sb+gBQIrqzJUXLcxKUFyOG7lRUjaHt9BnzLgfx2RyjMc9T/xG8m8dNg4ORuwMgkS
         Vf9w==
X-Forwarded-Encrypted: i=1; AJvYcCXjbqbr2039z+5pnCLc/7L0qW6XXW8+IEBmogxcNQ/oXhhRClP8d+J4rFVuYksb3U1j2/jrgyBLlfBG@vger.kernel.org
X-Gm-Message-State: AOJu0YzyhdpVmZR8DsEo9bCN+6msalCamVPagW4A0sfUCs4sVUGi//0f
	N8lHy5IppofWyjgpqJ7pHVgOa/NbZgtcdr1aQ2w1sednm352NO6EYi8hjeSSaBzaBXo=
X-Gm-Gg: ASbGncvI9KTat+Z1Rr9R8f7ADRkAccJTO1WEOLSjMJOQCjOnScLd+4gHVfMMkvPXKQN
	re1mlmEerq03Bvv4f0U/d184Z44BXYUmwj2w2X5xNwqEzHrfpm/P+R6ruIfYVI9cY7keMGosJ9M
	U7RMx14zwWqPpe/BrzMPRjIhkDKyVmAhmGhgQPaiy8t/e8500c2ET8yz/cCAcPcaZbzOfQly3oj
	ewYQG9Uf/FQU3L7G0tefF8RkB0z+SbmeWI8bNPH3kMGiVzFp8lsSkHsJkyc+jMUxN6lpCDMQZAa
	eThIAZthGa480mnJh4pxyk7mrvrl40TfwiD70wG4NNpasd/OMSHYX27McTyGNv8IhA0S1nczaSw
	GGRCWH0hGMysURkehCgI3ZjydnC6RNFiIvqngIyOQN2Fb1CA3BTRM0xFSDcp6bfT/rFCrw/NxzP
	351Ej0aKcXBIzSvIJRrTSpYJz9Fa70bw==
X-Google-Smtp-Source: AGHT+IHv+2FoyHtgNqF1DBafNAWsqVheVNr/d4qFGe2fvEd3Bm7iU47UHmaCg3qy/u+cwC/1tQZFTA==
X-Received: by 2002:a05:620a:2a0b:b0:892:dff8:2961 with SMTP id af79cd13be357-892dff8325amr2309221685a.50.1761226789166;
        Thu, 23 Oct 2025 06:39:49 -0700 (PDT)
Received: from localhost (ip-24-156-181-135.user.start.ca. [24.156.181.135])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-89c0e97efa6sm160831585a.24.2025.10.23.06.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 06:39:48 -0700 (PDT)
Date: Thu, 23 Oct 2025 09:39:47 -0400
From: Nick Bowler <nbowler@draconx.ca>
To: Esben Haabendal <esben@geanix.com>
Cc: linux-kernel@vger.kernel.org, regressions@lists.linux.dev, 
	linux-rtc@vger.kernel.org, stable@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: PROBLEM: hwclock busted w/ M48T59 RTC (regression)
Message-ID: <ni6gdeax2itvzagwbqkw6oj5xsbx6vqsidop6cbj2oqneovjib@mrwzqakbla35>
References: <krmiwpwogrvpehlqdrugb5glcmsu54qpw3mteonqeqymrvzz37@dzt7mes7qgxt>
 <DmLaDrfp-izPBqLjB9SAGPy3WVKOPNgg9FInsykhNO3WPEWgltKF5GoDknld3l5xoJxovduV8xn8ygSupvyIFOCCZl0Q0aTXwKT2XhPM1n8=@geanix.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DmLaDrfp-izPBqLjB9SAGPy3WVKOPNgg9FInsykhNO3WPEWgltKF5GoDknld3l5xoJxovduV8xn8ygSupvyIFOCCZl0Q0aTXwKT2XhPM1n8=@geanix.com>

On Thu, Oct 23, 2025 at 07:21:21AM +0000, Esben Haabendal wrote:
> On Thursday, 23 October 2025 at 06:45, Nick Bowler <nbowler@draconx.ca> wrote:
> 
> > After a stable kernel update, the hwclock command seems no longer
> > functional on my SPARC system with an ST M48T59Y-70PC1 RTC:
> > 
> > # hwclock
> > [...long delay...]
> 
> I assume this is 10 seconds long.

Yeah, about that.

> > hwclock: select() to /dev/rtc0 to wait for clock tick timed out
> 
> And this is 100% reproducible, or does it sometimes work and sometimes fail?

It fails every time.

> Are you using the util-linux hwclock command? Which version?

hwclock from util-linux 2.40.2

> Do you have CONFIG_RTC_INTF_DEV_UIE_EMUL enabled?

No, this option is not enabled.

> Can you run `hwclock --verbose`, both with and without the reverted commit,
> and send the output from that?

6.18-rc2 (broken):

  # hwclock --verbose
  hwclock from util-linux 2.40.2
  System Time: 1761226454.799573
  Trying to open: /dev/rtc0
  Using the rtc interface to the clock.
  Last drift adjustment done at 1657523820 seconds after 1969
  Last calibration done at 1657523820 seconds after 1969
  Hardware clock is on UTC time
  Assuming hardware clock is kept in UTC time.
  Waiting for clock tick...
  hwclock: select() to /dev/rtc0 to wait for clock tick timed out
  ...synchronization failed

6.18-rc2 w/ revert (working):

  # hwclock --verbose
  hwclock from util-linux 2.40.2
  System Time: 1761226685.238753
  Trying to open: /dev/rtc0
  Using the rtc interface to the clock.
  Last drift adjustment done at 1657523820 seconds after 1969
  Last calibration done at 1657523820 seconds after 1969
  Hardware clock is on UTC time
  Assuming hardware clock is kept in UTC time.
  Waiting for clock tick...
  ioctl(3, RTC_UIE_ON, 0): Input/output error
  Waiting in loop for time from /dev/rtc0 to change
  ...got clock tick
  Time read from Hardware Clock: 2025/10/23 13:38:06
  Hw clock time : 2025/10/23 13:38:06 = 1761226686 seconds since 1969
  Time since last adjustment is 103702866 seconds
  Calculated Hardware Clock drift is 0.000000 seconds
  2025-10-23 09:38:05.239100-04:00

Thanks,
  Nick
