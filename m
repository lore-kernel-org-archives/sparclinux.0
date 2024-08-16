Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B904B13DDDF;
	Fri, 16 Aug 2024 09:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723800771; cv=none; b=qjF9SClykZZDzJi5ca5ezNOobf0kpLn9q2bpJiNeBkfXlZA+9z5g9dPMHTqXTNiKjv29IZVhhiVS2tJT1slJ+aJMYQhhChTJPHLYT+Sg5ZuDxxZSLiaqZvIWSfZxZrYaO4svW7ISP5AgDGaIfjC++7P1UH5HZzlLlSm+OTpnkpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723800771; c=relaxed/simple;
	bh=krRonHVJrX/AM3Nh6AH5T0UFeYhSLpzdF/4nvnQSNLk=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=TjoaRGUdHFAQdlH9Swf9gk8SAWNp4CxEUhdkGggfN8Nf48TIfPWH/wYXNxVWuUOJ4IKyzFZEHyHYfsEbTr/6T2lvXEUICSOB3huOQU8ketcqOFlScdu2PH/1vmawPjhEM+ONEKV2fl4lmnyG8UbZdVp5HTEIxQzJku2x8PAU9Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jAObeU86; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jAObeU86"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7163489149eso1376460a12.1;
        Fri, 16 Aug 2024 02:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723800769; x=1724405569; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=krRonHVJrX/AM3Nh6AH5T0UFeYhSLpzdF/4nvnQSNLk=;
        b=jAObeU86yRHebQM92Aon/gHI5MgmZz8lmm1rg/WmvneZDxj6sq58LVeyAXbX5PaaEU
         Ch2eTTKrPv7p19GEmY6okohA9zx561/NVkHOh3EVd8n4gGUZxVK0ai/KaEGCFyphjM0n
         MSHg3CLT4IXknVoLB6IlmsJZwv+651WQwFyCQgiPtsFA1FZChXm8+ME6X1tvxh0IzLYQ
         POkr6+n7Avse9HR7V4Kc5rEoQo+gljI2RH/huz3z/FoNhqkoSrUHn3F9vGmBszkPnPnz
         slYaW6ylq0o7JcNzjGc1aFU46Cv0oMrLQniOc4LyM1QqhquGFFVjul/kTEcS1slp/EXP
         UsKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723800769; x=1724405569;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=krRonHVJrX/AM3Nh6AH5T0UFeYhSLpzdF/4nvnQSNLk=;
        b=GIPhA1xeHS7FgCWC9wa12/I6TQ0Cn2wSa+vBxfWUdLWf21R0G3YKjXgA8ZgHeE+NEP
         VOedjcVjiI771SkjD3R9VGtvGTtRa4We1kY10yU17LQTcscXCKvogmkoKW9Tm1/hmw5k
         Ll3MM6a5AQskDk1lPJ4knrxLLheVInLg4pIt16lImdGhJdZTV7HAvOkf9XZB5qVZamQO
         szFmJigWp3CVJu9GNa0s0B+cnGXyBeu+HWBJuhkztK7p0maKlV/sYQmNddpqsFYOJfT8
         CNcFhRyft4ff+56r5TQBYzoy5AEPq/xMRhQ0V2HvsAN1c4kbwbFaHLw5gZlUff/1Gvfz
         ZK2g==
X-Forwarded-Encrypted: i=1; AJvYcCVidwrP7ISD8tDXm06uhQ8DDrSHgmnZBXMpXvOiLJDl8qCnL63qWrV4539mus9z25Bx9dEmzme5KnAhYCrRaQievO3uJGS5DHx6SEMZfXYdalNQE0TsdlsX35kdUUdt8byHlEA935Pb+g==
X-Gm-Message-State: AOJu0YzrX2hmXs5AwDbEwUQlj9Ku5DwaWN8V59zMhcWgQ2itPMQDz6U2
	VzY2Zx2hq4MtZ9stHdbNlMqKzj6ccpH4C5zm2A5vYBcUN+mtsLLsuqJagvVT
X-Google-Smtp-Source: AGHT+IEbadLQ3EsWNLRHBGUbkbVeKvJBQxqdi7pSFm+E+9BELUVrCrGaU7dUduoC1Giqg66jrNytuw==
X-Received: by 2002:a17:90b:2315:b0:2c9:1012:b323 with SMTP id 98e67ed59e1d1-2d3e00ef816mr2657329a91.27.1723800768847;
        Fri, 16 Aug 2024 02:32:48 -0700 (PDT)
Received: from [192.168.255.10] ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3e2b65b85sm1374199a91.2.2024.08.16.02.32.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Aug 2024 02:32:48 -0700 (PDT)
Message-ID: <8acfb0d0-a03f-4e6b-b4af-bd00ce631a36@gmail.com>
Date: Fri, 16 Aug 2024 17:32:45 +0800
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: alexs@kernel.org
Cc: andreas@gaisler.com, brauner@kernel.org, davem@davemloft.net,
 linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
References: <20240729064926.3126528-1-alexs@kernel.org>
Subject: Re: [PATCH] arch/sparc: remove unused varible paddrbase in function
 leon_swprobe()
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <20240729064926.3126528-1-alexs@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Ping.

