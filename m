Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1333F0A8F
	for <sparclinux@vger.kernel.org>; Fri, 15 May 2026 09:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778837359; cv=none; b=KXnzo52cwmIB73rUprDUByzqLjnNnx5F0PV/7iWdvPu+z0yohArFLVoMGuT7YMGNCewhGoOMJQyTR0GR/a38eIa4a6rB3Hf+GMzp0kJoWj3+6wfs6U+g/Kn218KJrt+T9gC1XWvfKAfCD3MVnP0d/cqJBSUr0YLhd9Ty0dHUpus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778837359; c=relaxed/simple;
	bh=v+pupytczKAjPJGodDLVEr1rO2j5I2ZpqEZPCdYnJ8c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qiBWY7dnHGRTYwX714zpvwQ7gdvkTh0eSJMyTzaKe+ZkshSdvZR02/iUfcry3pkN6qyg270uNMmWzbAIcZYyXDg6iBCJLglpi7ECIBowMG+sFk5F7w2pxdDK5GuEtzPWySeUyY9cV6nixbjVO0n1YvKWo/+bIEEFAuf4GRoNhFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ax00u2zJ; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ax00u2zJ"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4891e86fabeso102762905e9.1
        for <sparclinux@vger.kernel.org>; Fri, 15 May 2026 02:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778837356; x=1779442156; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v+pupytczKAjPJGodDLVEr1rO2j5I2ZpqEZPCdYnJ8c=;
        b=Ax00u2zJfOWhpd5bb+/hdVew9ViKdCrtQSJPeKXOAGlUZ2pqI9o9k6N5lVdaaIi7TU
         W1zdDCe8ndoTqFV3ckv74DUW26LDO3fnDv/o1VOa3Uiml8Z8oebED7WQ8dKRYlhzKprD
         QaSvUzHHXkIJaDlSOsJTVKYM9Yj0d3cQa8iclJJiAPJuFGJ3pYXmroIYeXEupHbjBxHI
         vlC9SugWfw/kutEYAi8qgFEkcTyMdbhDasC5LTbzGrRbKWnNB7Eq6uFyptiHaIfXLRQc
         k5s2Pe2Ph5R6cCbJOxuTqNNa5gPZRIiRTSAYzSZsulaNLnBar41MbF2hrgSPa/muFxMX
         Oayw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778837356; x=1779442156;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v+pupytczKAjPJGodDLVEr1rO2j5I2ZpqEZPCdYnJ8c=;
        b=Woj4GrO8FZVZ+FMHFFdeUwOTSJSVUDnJXxJjSAp09YZJJOivZ7d/T7JF7Mk7pnIiqz
         gLCJ1Ak+Ejv0qVgOan4Ny5wiKGhrPza3lhGEnzmfPlgkmlfzuBXIfQVE7K8DtlWtkIJp
         ZT2+wbZIBe6IYGEwMh8ii+mkDzdZSPm78rSVMwcL+ej7qQfhQ2KTVdMv1FYbj/wC0+gl
         3zhO5mZs7ecI9E+oQp43BxIXClLwp0VDAata9bCGiAWh71+jCIG017PdsBG6gRlvOhBL
         UeNcntA3oj8Mx01+aCSzXsIYvuioMRkdu4y8Tz2HZ5l1yM3akIpBWtvmHy2pe+65omXj
         5v4g==
X-Forwarded-Encrypted: i=1; AFNElJ9iWmp47PN9c8Nc+8KpkX3gBM4cJF9u948j+zI8I3fmjNY+JY/A1ZDapn1dwlPU2HKzIGXA+dc3602h@vger.kernel.org
X-Gm-Message-State: AOJu0YySuX4vEo6p7K+ZYF1W7CghczYmvml74LdX0o0vPPCVj6OxA+HN
	YSvTts27IQlHgOXN0PJKeqn1YINRMZKSs/VUuFb9v/i+zYJ0uLy11E0JUWA3QTUpf/4=
X-Gm-Gg: Acq92OGKYp+NffEHXzew5Cdyk0Wiqo3jouz4moq8MpYCKLQwN0pWvZxjWhgYdkATo+p
	5z7ES5RI1ABpwWZk/DsCsPD4lU04J6XzNdzzSE3Zb0j2o/R0OWWpdKnVOMOf3cXLjSvCslAm2Th
	9Zp4mZsIOOHfAAM355plpmBpQbzeJpnhVQsvfaH1UXiOdaAeK21b9VHnVgOQBc7tlPYf1iR5S3m
	MuABh8TR9OpBmhC1V0nhtj3Utjwq+UhVtaUXSEVNthMCSBjXp4zAp4c2FqeKTje9ecFtL3+8jrz
	5AehQnBEbr03uKZEgJgZK9URIvarwVXPh9yBrkz5mtzqdtXkKBoJJP7xom0kQ8unXjTX8cWAThW
	mrDJ5lp0ho4ifkXeoTHfvVGkNP1vroMv5t6LNfFkD5nlpo4uvlDAmmxn3U4Wfym1ltAdhMJFiFZ
	ktyyH26ij9xQKPsFL9ivL/XQD3kLpO2Uc9
X-Received: by 2002:a05:600c:4455:b0:48e:8dec:19ad with SMTP id 5b1f17b1804b1-48fe60ea94emr41434695e9.12.1778837356485;
        Fri, 15 May 2026 02:29:16 -0700 (PDT)
Received: from [10.11.12.109] ([79.115.63.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48febe66544sm9672215e9.23.2026.05.15.02.29.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2026 02:29:16 -0700 (PDT)
Message-ID: <f15efac1-0df0-467b-8d75-18383d284be2@linaro.org>
Date: Fri, 15 May 2026 12:29:11 +0300
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH tty v4 2/6] serial: Replace driver usage of UPF_CONS_FLOW
To: Krzysztof Kozlowski <krzk@kernel.org>,
 John Ogness <john.ogness@linutronix.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
 linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Thomas Fourier <fourier.thomas@gmail.com>, Kees Cook <kees@kernel.org>,
 linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, sparclinux@vger.kernel.org,
 Peter Griffin <peter.griffin@linaro.org>,
 =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 Alexey Klimov <alexey.klimov@linaro.org>
References: <20260506121606.5805-1-john.ogness@linutronix.de>
 <20260506121606.5805-3-john.ogness@linutronix.de>
 <87lddvy2dl.fsf@jogness.linutronix.de>
 <1a5abd2e-e9ab-4a48-94c2-5e082f57adde@kernel.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <1a5abd2e-e9ab-4a48-94c2-5e082f57adde@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/13/26 10:50 PM, Krzysztof Kozlowski wrote:
> Cc-ing also a few Linaro folks
> which are using this platform and might be able to help us here.

I think that will be me as I worked with the serial.
I'm a little bit busy right now, but I'm adding this to my todo
list in case no else is taking care about it before I get to it.

Cheers,
ta
