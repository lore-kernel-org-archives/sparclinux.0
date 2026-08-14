Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993333E6DCF
	for <sparclinux@vger.kernel.org>; Fri, 14 Aug 2026 21:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786744738; cv=pass; b=ZvKxFkdNPHbD/5jpXX0ZXv+n1JKWvwPkQRFBwAWG5XDT3HI8HqJmxorRyDH8QCGrj8MmRr3pL5k+dZJnPXTIhsrgJeLs3SElQSH9gwIujpQ8Yu6hn+Xk/Z8XmiDBeHKXAOURcv+Gn37DVlcvL6FI4w+JHArNh7MYWlzOfEFEyHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786744738; c=relaxed/simple;
	bh=nilVc6nvu7/iJpSZm14D1rmmMSkreXTyX4PZg3lOqm4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dnmH6ROJoRMCXnMTXY4BkKu0TfY4+8q+QBRzvjh/epCjTHt8j50OBkp+rBDjGowAVIRrrszA7oqXEzARC1aEiseqk3cqxqRuUbPD2I5HfWdhtmYk28hPcVLjbKHBM9nrpmM1zkBs0mF9ZZUMEoH81794IjOJi1X78nQtKm14Uko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fWhZD7Si; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fWhZD7Si"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-69c108fee7fso2087441a12.3
        for <sparclinux@vger.kernel.org>; Fri, 14 Aug 2026 14:58:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786744735; cv=none;
        d=google.com; s=arc-20260327;
        b=dDN4wYSyRZgI+gdYNGPZVKYDL+KGdTLb9Tqdos9iIvM1Ruc6JqyxsDUIy5EYplRnft
         K5iXR5r5bStxqqCrTMtORNvlxk9KpZ9hXbTMpkGpUya8Ub7P3xVfzw/6UVXXwGc6iJxw
         L+F3HhBW5iOpFJ++um8yTTp3TfC582/shwwcItySG+RYwiBcXX6V5fx60k2jw7bYLjyQ
         PI22oEeBY7wuIVh03cTEymT85WhxcTF7MOYNCgV7DbxUZxAEqa+zmz11BHVyn3EQ51a/
         IfXiwsx+F+bKRAxIwAhXcel+nATcXOKX8i2LpdduOtUEOjLxaVuO8e1aSDr0jJvjr0KH
         gP+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nilVc6nvu7/iJpSZm14D1rmmMSkreXTyX4PZg3lOqm4=;
        fh=i4kKtj6PZRu6fYQHmdmf51ddnTdRTxly3X+M0hHtE24=;
        b=RyXHTk9gbMNECUH7RHVcZ6+hKznnq1qP1Bbq/ruWZnfPEmuof3iC6L5qHSnx32K6gl
         OWDtNE3A2rWfK51B/PEnL/uCc635c9I9kZ/7myZGBsEP8nPb1oOdVeF/Y7gyd47QmIVH
         yj1Lal3y6C5IQExM8wbqCtLPtxWjoipYuOFlveM9aU6TNCu7/dgJQgcTj/UQZK9+xk7t
         6CvFSN6WD4BrGQdxtlQWDowcw3YKi/ZcblAotz1tDEJrHq9vxmvbfWi/wrMKOyFs4JHu
         gBCiq8IgVS7vxlWUGepS5bJP2qjPDpBxv5KhbII02O0CcJAMxP5sUdMnfPW1DxxruL4D
         1nlA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786744735; x=1787349535; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nilVc6nvu7/iJpSZm14D1rmmMSkreXTyX4PZg3lOqm4=;
        b=fWhZD7Si42knWY3ZndceLun4DfXKkWO7T+CDOWlqzg+MWS2IecPdI6SRvLym1b3saA
         huhStTCyeOPCMfq3LzcZXATMa3gqhrwoEaO2MLKqGe5fztmxY7voMc95hGW+6Lb6L//M
         66ZDgUS4W2r/ZnlV3w/exkzZNeNEaGqk9/l7VGdKz1cbNSEjk6aMozt+rGYav7gcQZIb
         cbQ0msNcb3bbx5SRAAjCiDjNOmvgIcmIptS3nIN5LBf8bDag6WX69X45l8jlbcs8rcQE
         i+m+1B1Xs23SjIxN/4ZQvJxjxtyBlpkW7tmzj1joX4riYRWxoGt2r11yMeYprVNFcZL8
         e+EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786744735; x=1787349535;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nilVc6nvu7/iJpSZm14D1rmmMSkreXTyX4PZg3lOqm4=;
        b=M9Sb+nzMCkBPxfmauscc2NzTz2qEm+SUVNnhXwbkv+xQugb5QSUXg1KUmDe3yEnzur
         sGvy415qPNz0mruYIzl2N/eEctx0lFGjQIRqaB/+Il+sPOA+E/BlHdh1Mf4X4dIOeqZh
         L3zawOa3wCg4bHJ7BUJhfFTyOCClVksupxdCDJSy2kpd1M0NacHAQGj+9nn5sOuWiFlI
         8wNElGudY4NUh4qyiJorQ2o1XjlpE5uPXNQA8NaOfBRljFTlSMlghJ38jnuLGDPeybHx
         +hOedQZONj8HDgCmjCwn2XYpyVGS3ovRK+eg/z2ru5BOTwO5JaUn9fMWF8iBOXe/khVX
         /i3Q==
X-Forwarded-Encrypted: i=1; AHgh+RpZSUGiQoYboBLRDw45tSHBLaWTU9llpbZeAsJj4zXzG5lKdQnZvhRCIOBo3n6D6eVFW3WYlgOnMMOc@vger.kernel.org
X-Gm-Message-State: AOJu0YwAATmnxtpvmMAWh1FgMHbV7QZfihZN53wxgA4Ds8UaxmRjnVPi
	SvYBMQN1Cr7COzP+3x8J4Zao/65sAw/ntWmF6zbt9F6sfjT63XLn4+mKQFIFr1+9iuSqjLywHKq
	eGH1ZbbFXodmsCdXSLWe43KJ07CNbGB8=
X-Gm-Gg: AR+sD12GzHuQGQUX1SUgAVTDOIVufa3KTX4J4euVX6imHV4mW+uMnOt2WB0sFte96p1
	0CXML07jm/7BS05w7syQJv1saqb5+LvLSa3nwSXxMqokoqOiX5XqgqQQC9rte7IrWXu6X4OgIQP
	i3FRyahOFXmtQFVwpIIvVD1yfTdaa45HNpft/wTx1hd5SDm+RBG3RLvQYPQ/tli0E2c73lDG93u
	2lpH49822IwYek7RpFUxsv3CujzEyel+gxh40jwbocEH/jln7OA350OSNXF8Jk3ije9QLF6Da41
	TjE7z9BANh4+D0iXUzQP0OmVxJWIdbfFroLCFIyG+HjShpQXBEzkfkblsICCDSrz8NQXNnM99HZ
	9P9YohtC3MlAZIw/9MHxPUXt3oYehJOI=
X-Received: by 2002:a05:6402:2111:b0:6a0:dd2a:a7b8 with SMTP id
 4fb4d7f45d1cf-6a38a9bac9dmr4257550a12.21.1786744734634; Fri, 14 Aug 2026
 14:58:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260814105723.3454511-1-linmag7@gmail.com> <20260814105723.3454511-3-linmag7@gmail.com>
 <20260814204652.GB534878@ravnborg.org>
In-Reply-To: <20260814204652.GB534878@ravnborg.org>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Fri, 14 Aug 2026 23:58:43 +0200
X-Gm-Features: AUfX_mxTOBKhQmQfh0N4yB4fRv5zznGCzXcaA3xx92zfFct8NWla3ABB9J398gQ
Message-ID: <CA+=Fv5T4d0WiKZJ6ZahZ99+kN7a5vxZEy5qBz-Q1SKJ+n9T6Uw@mail.gmail.com>
Subject: Re: [PATCH 2/3] sparc32: derive phys_base from the PAGE_OFFSET mapping
To: Sam Ravnborg <sam@ravnborg.org>
Cc: davem@davemloft.net, andreas@gaisler.com, sparclinux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sam,

On Fri, Aug 14, 2026 at 10:46=E2=80=AFPM Sam Ravnborg <sam@ravnborg.org> wr=
ote:

> Use 0x%xl to avoid the casts?
> If we are noisy like this it would be nice to always print the RAM start
> and kernel start.

I've taken that as making the first print unconditional so both values
always show, and leaving the "adopted" line only for when they actually
differ - is that what you meant?

One wrinkle: __get_phys() returns 0 on anything but sun4m/sun4d, so on LEON
it would read "kernel is at 0x0" - happy to gate the whole thing on those
two if you'd prefer that, and I'll send a v2 either way.


Magnus
