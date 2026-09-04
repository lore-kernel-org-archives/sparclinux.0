Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C0441A54B
	for <sparclinux@vger.kernel.org>; Fri,  4 Sep 2026 06:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788502439; cv=pass; b=oqYNH7a0yvxuQQ1mm2F5FlgOUAnCDN37pXgXlR7sltnJdLlH25MFi+g4hr8SD74LOqTfkQfv03J7NxNC4c1XZtoD6rZy0So2cU5bYxHJwE7BYlxLl2A6wESw2ggEO3J0ln4NgHvb+ADTtShL5uECQ/w5bDB8kxIURdhksDMNsZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788502439; c=relaxed/simple;
	bh=4dOgcAQlgO1QoOYmAB+wFP5Ip8y+D8KPjRKJ5U4MjNU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wp3XKMoLxy68dKIo91dNU3tia+iA6e8wC2LjerjOm9Wm7wLtEFXFNLIX/OjS6+L/7fVLSlbr+uGdBKxEbYQdpLiaDiEKrDGu9QUsdKckJ6ihxzZZJL+nL0Eo5vMLJbDm/pzj6ZGqgv7OtiBi5ufl5Cfd1Ap6FV1Rjb7XNyNvBqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jdml6mr3; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jdml6mr3"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6a374bea882so872258a12.1
        for <sparclinux@vger.kernel.org>; Thu, 03 Sep 2026 23:13:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788502436; cv=none;
        d=google.com; s=arc-20260327;
        b=WjlX2jixha2FlX02BHnO/EHQe/cvoFsdKDZSnW7D3sFdtvCgxZ3V7vvcCNhAEN6kGv
         YF5XpttHoqSmGVXtneiVnn/Uyp1kAWAfjvT97S5xfZbiPTrEYMkwJnl8QGc4EGXpBIV5
         sJGaR1KPg0tFl16/g+RicnLLqsnYLDnljfdg7JecKVUyg7IpvD2cnCWfFTY+xuoJ4N+i
         ao5+WQKfedEfPMl7VndQyT2K8og/HxuoTqGobX6E8ctHMX0qkaleUb/K/j60GC9uOkq2
         O7m5W1WZ9mJpgGe+SXqLpRkAdYXKabmqa99g3yA6kKOeoO5FaC1e27xNPNfKIzAaeCJp
         Zefw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=4dOgcAQlgO1QoOYmAB+wFP5Ip8y+D8KPjRKJ5U4MjNU=;
        fh=EZcb5v1iGFREbtfzrjbWyYJJfgM1/0i31vLjxxH8z6w=;
        b=HivXx6irwEfmsi676rYp0wGIkLypJQOurudVQueZRKhWpCRDkeeNvo6htX8i+CFvP4
         EDme+hAQaLIKiC6cuRCgK7eqFudF5C1xZGIIK+nUDbs5Dkh6OwJNUsqFezfd9upjPTph
         6Plxgb9mQefbVcD/4br32ZU97LE2zKK8c4gYWVQTmBqQ2JAWGZp56YEa2jeSsNtAgfZ8
         ErHvVMqVxwTniFAKna9Icds7XSJ2r6Itd+pJYT3gS/dLOGE/CCEMzj/D7wcv3m7eX0rz
         Rk3K1wzi8K5Ne87TAFQieJNIPR2wnVXZiZN8Nr3NBqB1nJvDKyvc4IBl49E8js3pcDk7
         KXow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788502436; x=1789107236; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4dOgcAQlgO1QoOYmAB+wFP5Ip8y+D8KPjRKJ5U4MjNU=;
        b=Jdml6mr3zaJdqdlBLmwY4XR3DyaMt6UVj+RrpvUccUAgAhxLkAJrowYyrxRQFhIoI4
         SFMo9P6pmG/zs5G0i4r06tFu7OzCsJNsjtIovofmLTCa1ETNmq1ySaCoppH9xw7+jRO5
         kpa+4BFPGENcquNHvcWbiFezTJ7t+UPQTVZ8szMSKH5imCpPBYDpGeJ8oC47XpX6Pc2l
         tOm73krqlGnR5/rddSkj8pDV59Ur+mb8k/X5yfB9bOLqjbCYAbPr8LlREHKCQPjWpHwI
         TaGy6n4nCeZ87ZF8OVjnT3VRS2LFuvBDh+W0zWOjb3AHCngRjwHDiGeXMuAzRIRJxfsy
         xEWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788502436; x=1789107236;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4dOgcAQlgO1QoOYmAB+wFP5Ip8y+D8KPjRKJ5U4MjNU=;
        b=PQMFi8I+hE93fHLMnySHqSiGWCdZg+QsMssK6E4AW0ruAfL+plFXSoFCNUOdC5KNx2
         AQ01IqwKNoJmJuDZcUbCePiRK1M/UeXNYRmfiwUGMRycok3mCl4SUJ+izDZ+BRf4Cg1a
         1COoGJt9DtlXHpKpz2q9cFrdQU5uOatDxBoQiilKSg/v8lmtNiL1TgukjUhDzmTSMMya
         UEEs1MN/2vbgiRErgbgNqUZ7JTjc+eRuRQPyziMzNGwi7sOARG30iqLqnw9BXJw+NwXk
         YnsTImWff2ISBca3XxCYgyU8KjF8yGVJwlIi2fA4ZqiUtoUiebWkE0AbeHDEuWWdUV1w
         x8Fg==
X-Forwarded-Encrypted: i=1; AKwUvByEWq+YLs60H16UYTO/UxJCchYNXDNY0eI6rwESK1+36VwJ6KybwodB6uqAm4rrxpKKf1FbbYIibUJh@vger.kernel.org
X-Gm-Message-State: AFuF++nDlJkHCuLQBA+/Rj58D3UsVuNh1nlGNZpxC0LsXnIYWrl8xz9C
	xoyroi5u52Dm1E+3uqe+kov7jF2f84iuPb9wDtr1cpEVuWa9OIPUEzDl7CEMOpZ174bkljQHHHX
	lW3ZJgp2Rel9FMRfSmhfMrC3KsmRtyZ4=
X-Gm-Gg: AYBFou1TiLiDJ+3uyj1j6K48a+9eAbffW3QoBkjziTQbMPFWngPPNGmndR9QvajT8tY
	KavVPIfjLVzp/E+ilPZ+8Jr2vFULYkVIsL/SSyVpCgRfoKWRHxgV2LH7/qJ7BTNFHenj0uo10SS
	xWFxN8+A5gMZ/eP34/1HHFRzEQl+SJlvTZlNbpZiqylkkt5dD5OT/SP+qHj/wtOcymikpmdItl4
	LZJxy+hTHnvq1Jcb9lm5prFmmwGhLSD6CYVbmArED2VcSkjkqJKAFNh69qEmn30cB6k2/pxOLRI
	KoORIOeMI432L0qs2inH6I/Z/KHkvDa9TnFLgLjZ5uqo5EpPPHa1ANHe08oDkbuxKyzMuB8CRdd
	ZLJI3uKd1+CMEJWyfX+tpBWrbgpSYb58=
X-Received: by 2002:a05:6402:46d0:b0:6a5:f44e:a009 with SMTP id
 4fb4d7f45d1cf-6a7e8d5a9f1mr1690015a12.7.1788502435914; Thu, 03 Sep 2026
 23:13:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803-alpha-fp-exceptions-v1-0-c99d75608e60@gmail.com>
 <20260803-alpha-fp-exceptions-v1-3-c99d75608e60@gmail.com> <CA+=Fv5QUxT-T0XgXccAF=1_6Dz=nCpY=NQu=ruOrYjbB+q7YCA@mail.gmail.com>
In-Reply-To: <CA+=Fv5QUxT-T0XgXccAF=1_6Dz=nCpY=NQu=ruOrYjbB+q7YCA@mail.gmail.com>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Fri, 4 Sep 2026 08:13:44 +0200
X-Gm-Features: AcwNN1VrnhEuSNjXaQkRHQ6SzaIw81uvdMaGdmatxDoxs1iIKPoZwAWCS6BhE2g
Message-ID: <CA+=Fv5S_ZrHedEVPR9Oet2Egg2hwy33pEqEXaQa0zGdQdNjWRg@mail.gmail.com>
Subject: Re: [PATCH 3/3] alpha: determine tininess after rounding in the FP emulation
To: Matt Turner <mattst88@gmail.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, linux-alpha@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, stable@vger.kernel.org, 
	Michael Ellerman <mpe@ellerman.id.au>, Yoshinori Sato <ysato@users.sourceforge.jp>, dalias@libc.org, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"

Hi everyone,

Adding Michael, Yoshinori, Rich and Adrian directly, although this
is an alpha series, patch 3/3 also touches the shared soft-fp code in
include/math-emu/ (op-common.h, soft-fp.h), which your architectures
build against too (confirmed by grepping arch/{powerpc,sh,sparc} for
includes of those headers; parisc/m68k/mips/x86 have their own
separate math-emu and aren't touched).
The new _FP_TININESS_AFTER_ROUNDING macro defaults to 0, so the
intent is no behavioural change on your side. The new guard it adds
in op-common.h is a regular runtime `if` rather than `#if` though, so
it still gets compiled against your macro instantiations even if it
should dead-code-eliminate at -O.
No action needed if it builds fine for you, just flagging since it's
tagged for stable. Let us know if it causes any problems, or feel
free to ack if you're happy with it.
I've reviewed and tested patch 3/3 on alpha already (Reviewed-by/
Tested-by posted).

Thanks,
Magnus
