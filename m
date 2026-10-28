Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793207034;
	b=DNNxEig+IkXfE1d8BmDsStX5Z5Ab5/sJ8layTLb9yzDIuILpN7n9bInFemDCirO+hkWq
	 trBny41SNc1sIlIBzrUNBIgbfmcRLESy58RZUGXE3IEhNHxdoeYbxpxTjB1fat50wG9rt
	 xa/lElrLbQ5CbzvaoDnivrQrNafcCJ0+zKBaDKQziD3JcIWllwFxSOmHECcqgSMx1LTtB
	 VTb2XK3I/L6BcomSZQZcuo5nDutvGevcl6UEM82SA3N8yio947ZO2eZQ83fstgsog/emS
	 roN+Y9GeUx+B0ae+ijr6alMSGPhTnIK+Bp4skOVU1uof9fK0wT73VI8c+wUrqaStqew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793207034;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=h+YDFIcoYa8WhHiPI5vwzPAhBMAspg9LSUNE5xsSIjU=;
	b=fdedaAINtLerTYWQXiTpn/z6y9rzOGrG0Ifz87ZM/9rtxTZtouW9sXGRAuPSKtEe1vOn
	 r9VLavGvjpi9SE+2RErDHnolkSxhoby5K7DGQxrBT2sYQ4NPv1aBwUZq4dDeMd4chi3yq
	 hk7Eb4yJZRh7V35u8FOSHl30gQWhidY6NcvrCPOTbQHhPmzBbqhN+5FVMCHvoP6OnC9o7
	 8P+JyfHwXUNmHMA06WJItsajqeV3RNTUKjZgj17zx/kzquodmRmx5JYx4zC2Jx3/IOG59
	 oBN8Uv0D+97LSmL24cAT+3154utqUVAbp7k4sAIGzuAZoQM1JIbagUjmlLMM3Q4CzFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=HJEmqlAa;
	arc=none smtp.remote-ip=209.85.218.49
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A7C606A31C
	for <sparclinux@vger.kernel.org>; Wed, 28 Oct 2026 17:03:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09A7C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=HJEmqlAa
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c46bd7a7345so224578366b.0
        for <sparclinux@vger.kernel.org>; Wed, 28 Oct 2026 10:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1793207031; x=1793811831; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h+YDFIcoYa8WhHiPI5vwzPAhBMAspg9LSUNE5xsSIjU=;
        b=HJEmqlAaHjkokdckwBFUA42WhJIcz9eYNRImMUCKybu47xeRiO9kKcQsYJKOdBO5Zh
         LKzh9JrwNzC+nj1WvuMNqlkEwBgxKoDqp0EgV3cQXUGIFu01XbIUNBpJC6xxv0ra2F7a
         /y2VZ74ySU5NGD4KpUqDA7Vm3WYshLPdJ0PRA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793207031; x=1793811831;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=h+YDFIcoYa8WhHiPI5vwzPAhBMAspg9LSUNE5xsSIjU=;
        b=gavDFEWervPItJkvfRx3ed1kvH6DAmjjGMe28L/DNz+gsKuajH3UwD0KETbQq+mGPf
         c8995qHsKbMAZdNiHeOqc5W26U+J/5V4dEJOxdioZvxM69d1FtnIy9u3MzUbazCI/I5l
         9XNcvEcmUYybNZYESloFOoQyUbN4+ySFzbSZrc8dgzfArBEN0lWQSwNJ+QmKVCo3ro4K
         55TJv+hC9MWdj4qTHI38gZY4+iXYnscIg9BF+i5hk5zkc81x8+5uFpY4s5K0tbd0Kul8
         naYCCnNqVEAW4Mw+w5SpF8G2DUA4FnE3QgpNFUXaERXHWfAPDOXlo/FKH2FRWOa5Sb5O
         uOaA==
X-Forwarded-Encrypted: i=1; AKwUvBwB8x8e/XyU+Ydh/TtDkcwjKHkrYefjBQtSVBh2z6Sw+MfYRlMUbGL21VPAWXAj4jETdTlsbyipbSFN@vger.kernel.org
X-Gm-Message-State: AFq9FYIohRePkH1LxuNnD6BUe3AeVyz3C4H9c2rfx0s2BgtyOvIgmISU
	SH1d3oYB7XTcqburQZPiOqi9UHl7HCnvXg7LOlueS9XC2bOEJmzHud/YCgLiBrWXRDBkfyyyr/W
	8NECQDTs=
X-Gm-Gg: AYBFou2SBGv0FoB8pVgtDXHC+HEUmW+SLilghdVGW/DzJ1+khXge2o5y0J00y03nedF
	330V7tEMLigq1FvA/bTUNDoJ4X4YJFANmOx+Ialyl5AaQyKvA+OB2HauzDoL1GIKvalG2MwMeEb
	sOxdnnEotUPHFuELdaRkv7RrmTL4FTm2Ab2AY2ID3G1cD8X5xsMXdb0oAgLlCoFQaH3WJpmNVBO
	0EeWeITrj0fGMHnhuW/YXw+1qDWZAjopiYwUmQi8uakLF4FT3l6YpLPQQbZz0VzMClyFZJInus2
	mUmh6p79THMnPbYbuVQtK2twJzfa/DEuM4MN597hc0SThFIEg6oQGOUXiZl5Pk2psGRaplbfTjZ
	n8ueZOA9f09w08nyAHvi2kvKiRtnwmXpt9DbhGkvRb7CLekngJWKZyiCXghd0TqPwsmCe524g6s
	8NIDyvhpm0PJCN+It/a7JCRQbPNSPIvMOwQZs1PRyISjjC1m7T598e/jLtzl84wAxvGkuZqzvqc
	YUlSqA1bttP6NHxkim9Gv00o4H51eQog97sLmz9P6ktBs2SoxNu+GpMgBFqK42achuj97vXaeFF
	AMrE//aGMSJuPe874kxIyN0z4DcBSyvQujs3KV2HX98ySCBrs9iv8e8r+spFvS5awuZbx1A+hh8
	ZMz4=
X-Received: by 2002:a17:907:7f9e:b0:c25:5159:6a25 with SMTP id a640c23a62f3a-c49d1285bb1mr13335866b.6.1793207031400;
        Wed, 28 Oct 2026 10:03:51 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd64f8b6sm629090866b.48.2026.10.28.10.03.49
        for <sparclinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2026 10:03:50 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6b1f31c63ebso3884141a12.0
        for <sparclinux@vger.kernel.org>; Wed, 28 Oct 2026 10:03:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzOQbNtqZz8PSZBf1/EtQlyLHZlF1bIVE+x/KrAIUCSYO+GgvTt17MfCH57/VMCP8/DD+1W/g9hTZTk@vger.kernel.org
X-Received: by 2002:a17:907:60d3:b0:c42:fc8b:6c6a with SMTP id
 a640c23a62f3a-c49d11b4b51mr14802266b.14.1793207028992; Wed, 28 Oct 2026
 10:03:48 -0700 (PDT)
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Post: <mailto:sparclinux@vger.kernel.org>
List-Help: <mailto:sparclinux+help@vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:sparclinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <5df90753-163f-44d3-ae93-c6be6ca8647c@gaisler.com>
In-Reply-To: <5df90753-163f-44d3-ae93-c6be6ca8647c@gaisler.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 28 Oct 2026 07:03:32 -1000
X-Gmail-Original-Message-ID: <CAHk-=wgrPOQTFxy-mV2EaWLj9RvHY151sQTQ8jc7e0FiorhvDA@mail.gmail.com>
X-Gm-Features: AclHuK8-USVJR-1T0Fea4kcfA6l9aoyMDdQza79RH1k9Ebxwlcs6AJdMI4vWZl8
Message-ID: <CAHk-=wgrPOQTFxy-mV2EaWLj9RvHY151sQTQ8jc7e0FiorhvDA@mail.gmail.com>
Subject: Re: [GIT PULL] sparc updates for v7.4
To: Andreas Larsson <andreas@gaisler.com>
Cc: David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 28 Oct 2026 at 03:44, Andreas Larsson <andreas@gaisler.com> wrote:
>
> This includes the following changes related to sparc for v7.4:

Send them for 7.5

This is the second week, and the commits are all apparently basically
just a couple of hours before your pull request.

The merge window is for things that were ready before the merge
window, not for hurried last-minute updates.

               Linus
