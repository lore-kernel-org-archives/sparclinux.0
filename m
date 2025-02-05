Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC06135A63
	for <sparclinux@vger.kernel.org>; Wed,  5 Feb 2025 13:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738762805; cv=none; b=DL+bLtruCEQEuHW4zh6M0a3WMpcmpYR2V0x2kmm4AKf47T3GXWBSxWC5Rzmt1bWjIfnMqFQYBHiU/jypGKxHuB/qoTA5SMcORMrOtU4DWAQd47+KURyeqgJu4+EDMvgZxOoeBfD5SQKaDjqwNcL4q0r+5wnanaouKFLnYC9Wz/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738762805; c=relaxed/simple;
	bh=to0rndXbutpCdbidwW+dqd9uyYlNfoEbmkQvSdSVRow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dX9KWpIm8bl4EHRirmXfoPi/tmPdKnzIdkwE+oiShCOoijMl3UzNW2Iul7Vxjeoix85lygQ8Nl8JDCkiDb9RCbHcEvXGm7vd2QHTiJnFuC81zKxqBP1vdluVcdkov8Moq4Cxy1gTaaR3ItrFr3nKGn+gLF3tkGOy7p3zXabmFFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=0kEnSMJ2; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="0kEnSMJ2"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43621d27adeso46769445e9.2
        for <sparclinux@vger.kernel.org>; Wed, 05 Feb 2025 05:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1738762802; x=1739367602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0jiGn42kvvsu9ocdoHUA3wGODMdKmSTejfdkpV2G8qU=;
        b=0kEnSMJ2JO66/e13CHlOrYuYu1BhaVtKYh5bJbuJDWZ1slzOAeYNj+cgNKyM40a2Dm
         YdPXX3C6lyu99rReB8abYCBWhPkqvrJz/5FriaQz6ItkI8YKdLzroO8Jgiwkosehf6Sd
         +Ki9a4UZugLjgOFwUhYakE7RpBrJYF9dv7xcNDrOlhDWEEesE1NDdQJ3p5Q3hGWW+OKZ
         xbIlUugV3UBnEfco+BSZ7xML/yCPLC5WR8xwTca/9JuwTe0lEOUaKzkPE0gg3ysyBdO8
         JdLKJuwIQoSxrVOr0pEFACRS7pUPbdPpRCu5Kf+rkqYyTgLws1TCt9KezsI1+fQMgwha
         Xrsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738762802; x=1739367602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0jiGn42kvvsu9ocdoHUA3wGODMdKmSTejfdkpV2G8qU=;
        b=DX3XltZi7hvdEM1hMeAeLbqv78nHEMkExqwtQsGW6MKICFPYast7z9qlVBf/bMf0IB
         nusWUcEhZs6Yhxd9Qf6zOSmvJO2cVQjecYueJdMuh/zL6aa2iceHPkTWX+53az1kA8OJ
         qePTusRfcx+jCql0vSUt7hvgy1SLmNgo2ScamzaZ+fkLmE6cIPmno7N9vYiHk73mRSZ+
         5KyzRfczTt3+t91kHvJHzK7xY9iKMy2N/Fcr2ty7mK0VpSXSnrf5cJXsKOaNjU/fFMJ9
         MzdAlilbdH/h3Ch5wfR+/8ybDfLbtBinMBSXIfYxgCraUMI9AEgAJm1ox4iivocbFTuD
         PRuQ==
X-Forwarded-Encrypted: i=1; AJvYcCV97DGmyCeUgR4zxQyqA5Tz62d0LkKZbw6CpmHQMRG8VmUMtReKNLmx8/k2FdfF7p+qU4jNOwUkxYrL@vger.kernel.org
X-Gm-Message-State: AOJu0YyMQXNT+4D8puw4yeJ2pH5BuZ/siEDx7ix+CZZorOAz4ubQR+Pr
	uakGDwhzdZEYAu99sAWVGBx+avxmKupmJOKiOXCLSOItnFHULIkxIgU93Psm8t8=
X-Gm-Gg: ASbGncsZIHZvXghQUTv2th4ZFaeVeBwBSY30MLqAth0bWM/Wu8cyKIOGMo0JT4wkc2A
	Fi9juWaxPiYwNmkUNJ5X7ntiwnd+V4lUSl/qzxSG/R8aLu3wwYFAtQ2GqPNUJ2GuVO+EMBHVtq9
	mkX50QG1rjR5Hq6zHV73ugtzAbIQyvHxVACtgqtz/LXSM9YT4+Kdkv3P/587u925Oji5p6i75Vb
	y8hEKqa4pjCppxWZApGfGyQIRtxCiWE29iRiEdeed1dQjMsuMhfm8B+oHBMBFD7P4RyLU60o9mn
	2TmxktMvbD59e0E=
X-Google-Smtp-Source: AGHT+IEo9hIviDYhb31r2hIrMu00KPJNKRFNZRRwmU6V/iBqIa6axOmyAKUSv1JNDBSNjuzq7Fi29g==
X-Received: by 2002:a05:600c:3b9a:b0:434:feb1:adae with SMTP id 5b1f17b1804b1-4390d42cf2bmr22533925e9.3.1738762801531;
        Wed, 05 Feb 2025 05:40:01 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:3239:b668:f15e:fed8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4390d93369fsm21974185e9.3.2025.02.05.05.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 05:40:01 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andreas Larsson <andreas@gaisler.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 resend] gpio: GPIO_GRGPIO should depend on OF
Date: Wed,  5 Feb 2025 14:39:57 +0100
Message-ID: <173876277707.18360.8561413925372301898.b4-ty@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <db6da3d11bf850d89f199e5c740d8f133e38078d.1738760539.git.geert+renesas@glider.be>
References: <db6da3d11bf850d89f199e5c740d8f133e38078d.1738760539.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Wed, 05 Feb 2025 14:05:03 +0100, Geert Uytterhoeven wrote:
> While the Aeroflex Gaisler GRGPIO driver has no build-time dependency on
> gpiolib-of, it supports only DT-based configuration, and is used only on
> DT systems.  Hence add a dependency on OF, to prevent asking the user
> about this driver when configuring a kernel without DT support.
> 
> 

Applied, thanks!

[1/1] gpio: GPIO_GRGPIO should depend on OF
      commit: 5393f40a640b8c4f716bf87e7b0d4328bf1f22b2

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
