Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83020282F1;
	Sun, 26 Jan 2025 18:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737914837; cv=none; b=rxOOEdK7HxVCOFr9jKjzOWFASB0BVgxoNNCYv9elCLI9i7ofwk+6mRjQh9qaI1rfHC32b80vOt8Jyl1txEZ2SWT4SVfTvEh+EAg8PYjLutXBVpnCuGY6aQvwPRVxVbSSTRgvEymFqohMlnNIfH8qewNqsE+gpsGkR2o0fAcDtUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737914837; c=relaxed/simple;
	bh=4o9P+R2HyJ+dAiTklrmuRER/4DoOz8qk68XOoumYvPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cv821x3ELPYvLoOz8DOJHcwNE/Sn3Bg6pEWiXyx7YU+eKHqLr1dPXlsgGEEqvCKGZDl4figwubK9lLv5dMo8Bgb5/hXI5/D/s7Y4rLD7HSkW8WPX+N0EUB+6Kg9VRNC0HZcjVtupcraIdyPN8XHOPHLjyzCrUfthycSucvYjO00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LeIMRC6e; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LeIMRC6e"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-438a39e659cso23482855e9.2;
        Sun, 26 Jan 2025 10:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737914834; x=1738519634; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4o9P+R2HyJ+dAiTklrmuRER/4DoOz8qk68XOoumYvPg=;
        b=LeIMRC6ewuw1TYt+tL2eRGr6kaw750rTdKVk7owK8uVBgWTa/vvs/idRwyjMChgjz3
         ijMDdnKkr3bIEquUkZbH2fm7IQvdaWZKUMyn11eAanINN+qLctlk4cNthFXf0HkqcU/8
         zq0xvVx1S3R+VxJQe9zi4Q5e2KpIGHpBUmT5RhpKL4VzxFILERQ2LLR2M35+Es8EY0LZ
         VIRxk/6Sc/ZJasg4tdf08Nrgh7SNHiGp3FyjfRj59bMf5JLo9eRoQg9Lm/+tyIui1KiK
         j35xYcOLzPGhHm1oWbW0fMxOOby8iR47Ar4X+5LiVAmIlknJE0ZTINf1y3WXCp919HdU
         N9Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737914834; x=1738519634;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4o9P+R2HyJ+dAiTklrmuRER/4DoOz8qk68XOoumYvPg=;
        b=cTC7u0Fp6D6oL3MP0xGdqNehmXD7Ku8VkZHIue1KiYZcZ1tImA+ilWh9r93kcjwaEU
         zZy/EW2leA4iAx92QIZ9JFL+2ljYN271ntWn1xv3SsYXNZKDIwjiEi4rXEMzYHk0lUQi
         YxpV+VAVwCu5VHBAPkXAq2F0FYADr65ZL0Ziqczfk/YCUxraD7UMFnEWhOrTx+HZNjos
         5jdxgDNjxvp77T5qVrb6cTv9g/+Tjp5NMGAidVjjazQ+rUWW+bB/Wtr61mOC1hDN+jti
         XKzIwfYwC/Rr9vBvd+jIupK5nk0DVWM7uOc48b4aEfUc8XMWlj4HJIUGDaqmfp23BF7C
         f2Nw==
X-Forwarded-Encrypted: i=1; AJvYcCU2hkwwgHa+4e7Y+UOtqCMQ9vvPxgdLL+zi9e0VkLsAhc6/0Qg42Yp+TXYzinFcao/TuAJIpqcEN7th5g8SBlI=@vger.kernel.org, AJvYcCUhdDhoY/2HTeFQ3ahZBbiDOC6EhOxoonJfUb4VoJUjlEC1SbQvs1X2EKK53woHDUw3mg3hw+10K0fMqQ==@vger.kernel.org, AJvYcCXBeN2l68EwOMm/xM8NB44XF/UgpX4GNCRh4tQ8TiBE9+bFydliq+ZSxuljQF3qlbENj8/F3UohLkb2BbXp@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1xxZHMOUvE5GYOG0P8v/QNiGCuc56MHCGIT1ZYPvLYFpZ9CtB
	YX8pdAOBa7W/O75C3hEhGC+NCfE1i6UKfiWeqn7RSN/Wqnkb5xx+
X-Gm-Gg: ASbGncvQeL6QlgnddgRyETXX1Ta6eLVc5FAZqakSc84dV3F5sMckTzB/0ptwhf6mWVT
	4capVEnGVrMxwWT0eUhiDmyw5OBWOmFUrm7cccLWtEsIaGL1R9EfzeINgqMNWy/qj9BflLVqql3
	lLs/R414JrG2+BDEzQTaGvDI0hhdrQmmeyq+W0MtHVDkyqGJAeKlS1KoASuCTs7CUG+QqLDjkMy
	/3F3F0wyotQ+oyKiTCHpkpLnVUw4d+CusAqu1SGltdXUdru4uEoqWd8CPLLPLCI0XStyadXV/ho
X-Google-Smtp-Source: AGHT+IEwVMkqZp8eqbPtZFH/iiNLo+m5WpJ1yf8zzb6MR2WdJAjTwUTz1XI3YyknfBU5Y+2qz1+f3w==
X-Received: by 2002:a5d:584d:0:b0:385:f7a3:fed1 with SMTP id ffacd0b85a97d-38bf57b6717mr37257735f8f.44.1737914833513;
        Sun, 26 Jan 2025 10:07:13 -0800 (PST)
Received: from void.void ([31.210.177.244])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a1c35e1sm8665018f8f.82.2025.01.26.10.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jan 2025 10:07:13 -0800 (PST)
Date: Sun, 26 Jan 2025 20:07:10 +0200
From: Andrew Kreimer <algonell@gmail.com>
To: Rob Gardner <rob.gardner@oracle.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>, sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] oradax: fix typo in dax_dbg message
Message-ID: <Z5Z5zry4zE28e2PF@void.void>
References: <20250123201909.15469-1-algonell@gmail.com>
 <cbabbe58-8b11-4bf8-bacb-5d4154b8a571@oracle.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cbabbe58-8b11-4bf8-bacb-5d4154b8a571@oracle.com>

On Thu, Jan 23, 2025 at 01:23:20PM -0700, Rob Gardner wrote:
> That is not a typo. "Copyin" is correct as it refers to copying data in from
> user space.

My bad!
