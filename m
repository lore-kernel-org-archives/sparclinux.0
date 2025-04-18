Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B4C228CB5
	for <sparclinux@vger.kernel.org>; Fri, 18 Apr 2025 17:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744998631; cv=none; b=Sgvmmt5lB+g2iIuIWFuGkovwA5HsDBmN5xyoUrpVsNydI/hOXxvRZ5KUzjEfo6RRGgKhOX1A+Lw+k1OXWdc5sRbXG9hG+dcoGyNvBpSe/FD6BLknreF0KXECQE2vWUA74mSiZPAc0WavC49Jsz4LPr0TcDqdYoCzUa8Ltnac7c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744998631; c=relaxed/simple;
	bh=AzeVQAOnRtcbGIrt74vKKg1t+G+1IlWiUF0f/IMwOvY=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID; b=YEdeBH9KdsAqBSf1isOS3ODMPhO6RniKzw9phul7zk5RdtUz/zzX6ga/vkuxPTjQgHtNXGmhdM/1SHDMt02dRyJQXjqfkK/ZbINOSFz3hkjNKanV8wl9GWZH3zRwVaIY1VFzOPMg2fCb2/J14vuiThyRNC1NOSd+guO82zzniJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=rNiJphm8; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="rNiJphm8"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22423adf751so24673685ad.2
        for <sparclinux@vger.kernel.org>; Fri, 18 Apr 2025 10:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1744998628; x=1745603428; darn=vger.kernel.org;
        h=message-id:to:from:cc:in-reply-to:subject:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xitBrw85Cpa/PH99l1OqltSYYTa4EEM01UtrGh+UZZU=;
        b=rNiJphm8duOFgq6fY8LWfc4D1iONPxu1H7i0MNHYxtwgxPNdD3kJcvIi6To+ZsBfKQ
         K39iwYzygNtLkY+mRH5CTJeRHWm85WrOxQXHk/PtkJW53j2/F7Yl6L+7RQ8GMNiIqXie
         nF9gkCu/IPPH2xyeSMC/QEGOpizuxFfwzDWQpLMQZL2Pzj2Tyl4n6bq5VkxrLUW2tgiT
         vpzP5YT+CAqsQVZ1ZW2cxlF+ii69k8o8RztIXXFNYlYERdCoVtGeGNn5y0tVoAiknCxb
         shJ7BEaPcCc64rTSkc2dTI1BLvrxrNmTfXguc+Hb2vTBN6jDl/K1hdRoNq2ndjHwwqzB
         +sNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744998628; x=1745603428;
        h=message-id:to:from:cc:in-reply-to:subject:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xitBrw85Cpa/PH99l1OqltSYYTa4EEM01UtrGh+UZZU=;
        b=lg8Wj4KwZyxXY3NGpFwe7g06qCK1bd/8nS16KTA+L6e/QEucnedCFQ6Ji/zyeOhiCy
         KsV5nkrkNDGmRVgeHUnRFfbW3x/8D6K97uJncbhE5WEFWfAVPmLJSOeFEAWBNajvHXIG
         jfR4T9M/ac+8oToxUYVJHfo3ekI8WfBrzL/n1sSLbrQnuZnzbBzJLwm66uKa5JEH+MuX
         FlyV+AQOBPhUbLaLq7K/G4TJQYlL4DCxhcB1YIXprY630PyFozVVxi2LNK1mGpJCvx/Q
         kDVN0XhYrHmAbtHQbyLmUdyIm39e+SYKBAsB/Al6yPlJHt/MhNjmVipfW00VdTxlkjFp
         7rbA==
X-Forwarded-Encrypted: i=1; AJvYcCUJsW7YHbnV34ovY2y/A4D9+PL3uCHEmuYoR5/ZVtXEyUUGmakmjNacQGftMdO95M/WaHHqhOIhD6EZ@vger.kernel.org
X-Gm-Message-State: AOJu0YxIH8gig3uM23/olm7b2Wa3w1IZPLWqijdlKC2+/zfMBmzz7S4y
	4Bw4ICFB+PRCe0jPL6XhLJQY4Qyea7haUrPRwZMn8qtd0iZwPd8NQR2eym6rk7E=
X-Gm-Gg: ASbGncu33X7rkbm10Fee/4glblOPA2W1ekE9cs03EM9EUBTgOUuXZgz74foyR3H+Vwc
	QcvFK2ftn6Mv4ff1a27ZWpcSWj6qc1dq2jafy5NU/hsu21O11572Ddf4VLtY9K6rQ8QYC5DtsGS
	aXjImsTKauY5sj9mSV7QsTh8oPUZr+ZLza3bNs7jHbUZyZ/PXz4ho5lnnfd5k1XEVPtUwAaAsFs
	gxM+Ciay5hxRlQKIt2lkWB3QwduiIWJtLdGxLtj1xeIoaAqVcgNRxloQjSSaF8EjSmv5Hsz2QVl
	yKHz3ZyIsXuaxnNVaOs107Jl+rXBEJNurw==
X-Google-Smtp-Source: AGHT+IHTtFpIUh9V1D/hgIg7h0JnpsXp9Bovo24GVumcqsEBZfrWrJPuzOPDear/0hml7HCNfS1GQA==
X-Received: by 2002:a17:903:98f:b0:221:7eae:163b with SMTP id d9443c01a7336-22c53627298mr52330365ad.46.1744998628042;
        Fri, 18 Apr 2025 10:50:28 -0700 (PDT)
Received: from localhost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50fde845sm19513745ad.236.2025.04.18.10.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 10:50:27 -0700 (PDT)
Date: Fri, 18 Apr 2025 10:50:27 -0700 (PDT)
X-Google-Original-Date: Fri, 18 Apr 2025 10:50:25 PDT (-0700)
Subject:     Re: [PATCH 08/15] crypto: riscv - remove CRYPTO dependency of library functions
In-Reply-To: <20250417182623.67808-9-ebiggers@kernel.org>
CC: linux-crypto@vger.kernel.org, linux-arch@vger.kernel.org,
  linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
  linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
  linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, x86@kernel.org, Jason@zx2c4.com,
  Ard Biesheuvel <ardb@kernel.org>
From: Palmer Dabbelt <palmer@dabbelt.com>
To: ebiggers@kernel.org
Message-ID: <mhng-78030c23-f066-4b83-8d7b-c1720725199d@palmer-ri-x1c9a>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>

On Thu, 17 Apr 2025 11:26:16 PDT (-0700), ebiggers@kernel.org wrote:
> From: Eric Biggers <ebiggers@google.com>
>
> Continue disentangling the crypto library functions from the generic
> crypto infrastructure by removing the unnecessary CRYPTO dependency of
> CRYPTO_CHACHA_RISCV64.  To do this, make arch/riscv/crypto/Kconfig be
> sourced regardless of CRYPTO, and explicitly list the CRYPTO dependency
> in the symbols that do need it.
>
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  arch/riscv/Kconfig        |  2 ++
>  arch/riscv/crypto/Kconfig | 12 ++++++------
>  crypto/Kconfig            |  3 ---
>  3 files changed, 8 insertions(+), 9 deletions(-)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index bbec87b79309..baa7b8d98ed8 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -1349,8 +1349,10 @@ source "drivers/cpuidle/Kconfig"
>
>  source "drivers/cpufreq/Kconfig"
>
>  endmenu # "CPU Power Management"
>
> +source "arch/riscv/crypto/Kconfig"
> +
>  source "arch/riscv/kvm/Kconfig"
>
>  source "drivers/acpi/Kconfig"
> diff --git a/arch/riscv/crypto/Kconfig b/arch/riscv/crypto/Kconfig
> index 27a1f26d41bd..08547694937c 100644
> --- a/arch/riscv/crypto/Kconfig
> +++ b/arch/riscv/crypto/Kconfig
> @@ -2,11 +2,11 @@
>
>  menu "Accelerated Cryptographic Algorithms for CPU (riscv)"
>
>  config CRYPTO_AES_RISCV64
>  	tristate "Ciphers: AES, modes: ECB, CBC, CTS, CTR, XTS"
> -	depends on 64BIT && RISCV_ISA_V && TOOLCHAIN_HAS_VECTOR_CRYPTO
> +	depends on CRYPTO && 64BIT && RISCV_ISA_V && TOOLCHAIN_HAS_VECTOR_CRYPTO
>  	select CRYPTO_ALGAPI
>  	select CRYPTO_LIB_AES
>  	select CRYPTO_SKCIPHER
>  	help
>  	  Block cipher: AES cipher algorithms
> @@ -25,43 +25,43 @@ config CRYPTO_CHACHA_RISCV64
>  	select CRYPTO_LIB_CHACHA_GENERIC
>  	default CRYPTO_LIB_CHACHA_INTERNAL
>
>  config CRYPTO_GHASH_RISCV64
>  	tristate "Hash functions: GHASH"
> -	depends on 64BIT && RISCV_ISA_V && TOOLCHAIN_HAS_VECTOR_CRYPTO
> +	depends on CRYPTO && 64BIT && RISCV_ISA_V && TOOLCHAIN_HAS_VECTOR_CRYPTO
>  	select CRYPTO_GCM
>  	help
>  	  GCM GHASH function (NIST SP 800-38D)
>
>  	  Architecture: riscv64 using:
>  	  - Zvkg vector crypto extension
>
>  config CRYPTO_SHA256_RISCV64
>  	tristate "Hash functions: SHA-224 and SHA-256"
> -	depends on 64BIT && RISCV_ISA_V && TOOLCHAIN_HAS_VECTOR_CRYPTO
> +	depends on CRYPTO && 64BIT && RISCV_ISA_V && TOOLCHAIN_HAS_VECTOR_CRYPTO
>  	select CRYPTO_SHA256
>  	help
>  	  SHA-224 and SHA-256 secure hash algorithm (FIPS 180)
>
>  	  Architecture: riscv64 using:
>  	  - Zvknha or Zvknhb vector crypto extensions
>  	  - Zvkb vector crypto extension
>
>  config CRYPTO_SHA512_RISCV64
>  	tristate "Hash functions: SHA-384 and SHA-512"
> -	depends on 64BIT && RISCV_ISA_V && TOOLCHAIN_HAS_VECTOR_CRYPTO
> +	depends on CRYPTO && 64BIT && RISCV_ISA_V && TOOLCHAIN_HAS_VECTOR_CRYPTO
>  	select CRYPTO_SHA512
>  	help
>  	  SHA-384 and SHA-512 secure hash algorithm (FIPS 180)
>
>  	  Architecture: riscv64 using:
>  	  - Zvknhb vector crypto extension
>  	  - Zvkb vector crypto extension
>
>  config CRYPTO_SM3_RISCV64
>  	tristate "Hash functions: SM3 (ShangMi 3)"
> -	depends on 64BIT && RISCV_ISA_V && TOOLCHAIN_HAS_VECTOR_CRYPTO
> +	depends on CRYPTO && 64BIT && RISCV_ISA_V && TOOLCHAIN_HAS_VECTOR_CRYPTO
>  	select CRYPTO_HASH
>  	select CRYPTO_LIB_SM3
>  	help
>  	  SM3 (ShangMi 3) secure hash function (OSCCA GM/T 0004-2012)
>
> @@ -69,11 +69,11 @@ config CRYPTO_SM3_RISCV64
>  	  - Zvksh vector crypto extension
>  	  - Zvkb vector crypto extension
>
>  config CRYPTO_SM4_RISCV64
>  	tristate "Ciphers: SM4 (ShangMi 4)"
> -	depends on 64BIT && RISCV_ISA_V && TOOLCHAIN_HAS_VECTOR_CRYPTO
> +	depends on CRYPTO && 64BIT && RISCV_ISA_V && TOOLCHAIN_HAS_VECTOR_CRYPTO
>  	select CRYPTO_ALGAPI
>  	select CRYPTO_SM4
>  	help
>  	  SM4 block cipher algorithm (OSCCA GB/T 32907-2016,
>  	  ISO/IEC 18033-3:2010/Amd 1:2021)
> diff --git a/crypto/Kconfig b/crypto/Kconfig
> index 2467dba73372..8c334c9f2081 100644
> --- a/crypto/Kconfig
> +++ b/crypto/Kconfig
> @@ -1424,13 +1424,10 @@ endmenu
>
>  config CRYPTO_HASH_INFO
>  	bool
>
>  if !KMSAN # avoid false positives from assembly
> -if RISCV
> -source "arch/riscv/crypto/Kconfig"
> -endif
>  if S390
>  source "arch/s390/crypto/Kconfig"
>  endif
>  if SPARC
>  source "arch/sparc/crypto/Kconfig"

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

I'm assuming you want to take this with the rest, thanks!
