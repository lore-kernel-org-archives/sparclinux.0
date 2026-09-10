Received: from mail-oo2-f42.google.com (mail-oo2-f42.google.com [74.125.231.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18CF3C5837
	for <sparclinux@vger.kernel.org>; Thu, 10 Sep 2026 20:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789073734; cv=none; b=lBHWIaOtGUU6ASFFzckbypAXS1cjZWUUnDbGWZhFt7I30DnVTkm96O0drDc+LU/+wkcMO1kn93uFJKMF23+asQ2vpZMjukdJhPOA2R50YtWZbXZHCXiOeX0+VAiyUCjZsle+0VynXKAm1MmWk/7eFD2EwAaExx2x6VgbkI8WpxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789073734; c=relaxed/simple;
	bh=t6ppwnoW/+SGU7+SZTpQCy0ZyrHu7AGE6vmt1IJD2Xk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=e39PFKc13vKVtH0CWMx+cZnKyeKZNvWq+tBYAI8jUm73b4QwiKDHkoHrevU7FDIDG2tZ1s4OdCL7ClplgVrTt8ZMVZnrfIAIVdT5U8TeptPl5HPUkrjg8Molsh5eIjk+BtQ+V5Yv7W/vRlmujEiWHu3hcQTYpSjXwXBNxV4OFRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=Vp+7ZKLl; arc=none smtp.client-ip=74.125.231.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="Vp+7ZKLl"
Received: by mail-oo2-f42.google.com with SMTP id 46e09a7af769-7fcb425fb6bso138535a34.2
        for <sparclinux@vger.kernel.org>; Thu, 10 Sep 2026 13:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1789073730; x=1789678530; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B/R1OOuoA7A615cqKW89RYxj2atLZSBY/Ou5CD1Turw=;
        b=Vp+7ZKLls41ZsActN33B+Ko9uzXa5TmRUtTWkEuC65XqHFmTroSDd4Q32h22Eu3lYN
         gEyR64HkUMPmN2/MDwWfLwSS1+TskHgIHH++hUeGn3rbPLcHGku1OECfjpSY6woYvlf5
         kiYSXuh69eG+Q8R9PjFXyg6FW9ETbPrtwR+/WOt5+vbHKu1b8UPWV4Ruq/FUfpI25AZy
         58camd0NXcgJmJdpcaHNPkv4PrQEdW5UrAO6LsND17A90OIIVG9l+aNj1Fh9zGxui5Uq
         ZXS5bG0Ef5W8AqQh7zsBA4chfq8Isp7P79IYyG4QxyQwR2bXmwSVmvawk7t+vd6Q5m2W
         k/MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789073730; x=1789678530;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B/R1OOuoA7A615cqKW89RYxj2atLZSBY/Ou5CD1Turw=;
        b=KjsLsAiNpVCtOrLNR8ee28oVp8tp0MNsVzbT8ykyWUOpBkF1687o6PbhP4PXNLr/cZ
         lHrm2MedWH/LKpcFKFPw8ONFZMxGHiGGo3cQLRX6BneEjfY3zY6xyTkTeaS2gZt8zjbY
         xroGLIwxBdnYRHAEwjJSqkAfB9EOla6smZb0VRIxkszfMiD6r+XpynBui1rJIlTyvbnL
         uu/Ms7+1w0jyOmW7obpeKiruSQbhFpuDSz9xbyErbCoKHeK8CQo1SfHfhv1h3zry91TN
         Q8PFJ1FTh5q1q1DRGswVtLqS/v2QJ6UkCPq9KBoA25gMg9j8ge7OVEy+eyTdLcHPkOc1
         oZ9w==
X-Forwarded-Encrypted: i=1; AKwUvByP69iDCxVARGbsgQxTaA4eF3dtkpru+Z1REepY2c2Q0Mq1lUyCL6HkVn0w108ITt0Qa6pWq6j0Re7S@vger.kernel.org
X-Gm-Message-State: AFuF++llc5/yzCV1qevmCZL/xMzZ2tTJ7E/ol2TbLO//uT2jmXtMn3B2
	1GUZBtlFUqeT1TC3w2NElzcfSqknAW4ArcG4RmvofhDZyYEXGDRIK+5wwj8lZpCKJAw=
X-Gm-Gg: AYBFou1mj5NjpXp4K5j37XaZ8g+fuAYlQaPAq+AaymSAhVabyNn/B0TYrgchtSRk27A
	qWnjkmwMaiCh2Aj8qPmkCs/QdlqnEt0Diw7ZzvBR7qy1+ZHQEQd3xauOwf8q/DmpgIbBOkhuYym
	iUcNV6AmajwfDeJi3atA/sHDeTWSv4ErSUmjzIcorzeqvsb1ropYW9Nsm+stjKhnr1+SzUUUBKx
	I+hT/mjRQHNP73YC0ipbfu+QX+eLH4Otkz03aLz3FXkVqzINpLk5zq13vsxDhzGBjCxzEdJuDkc
	0bsW+ycGybjkPsiO5hpnfg+X/ZhkriNboAqea5u7xAPg/NH/YuLm8A0R7BawwytS6ImEYTt3vCO
	xvzK7fO7S1DeBejeSy+XZ/aHVadGaKNj/9P6ghhEIOZ11ZKpET10zK0EMy1wHZqG13OxuKpXrIL
	lMZUETqxuptvY0OJSQc9nYb3bG7vw2ALdocnd5+cOphNZ4e66QvCJ0uC2IouIkQ56u6u0pdJpoz
	5lXV1NlQJfrHyO40PX/7pSyorAzMJNdLu8ABe65f2hKy67gdag=
X-Received: by 2002:a05:6830:2690:b0:7e6:d384:459e with SMTP id 46e09a7af769-803fdfc94ffmr847414a34.3.1789073730048;
        Thu, 10 Sep 2026 13:55:30 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-803f60fe54asm635779a34.15.2026.09.10.13.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 13:55:29 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Stian Halseth <stian@itx.no>
Cc: linux-block@vger.kernel.org, sparclinux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, andreas@gaisler.com, davem@davemloft.net, 
 glaubitz@physik.fu-berlin.de, regressions@lists.linux.dev
In-Reply-To: <20260901173947.3292110-1-stian@itx.no>
References: <20260901173947.3292110-1-stian@itx.no>
Subject: Re: [PATCH 0/2] sunvdc: fix silent data loss under LDC congestion
Message-Id: <178907372879.484803.7974471214841698578.b4-ty@b4>
Date: Thu, 10 Sep 2026 14:55:28 -0600
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Tue, 01 Sep 2026 19:39:44 +0200, Stian Halseth wrote:
> Since commit a11f6ca9aef9 ("sunvdc: Do not spin in an infinite loop
> when vio_ldc_send() returns EAGAIN"), Linux guests in LDOMs see
> occasional spurious write failures that manifest as filesystem
> corruption. The failure signature is:
> 
>     sunvdc: vdc_tx_trigger() failure, err=-11
>     I/O error, dev vdiskc, sector ... op 0x1:(WRITE) ...
>     vdiskc: writeback error on inode ...
> 
> [...]

Applied, thanks!

[1/2] sunvdc: unmap LDC cookies when the descriptor send fails
      commit: 0c6da21fa35e03fc74f09895433ccd6d4a9c3530
[2/2] sunvdc: fix -EIO issue due to lack of retries
      commit: 5067d4ba713961d8ccea1e06cd4c453793f3121e

Best regards,
-- 
Jens Axboe



