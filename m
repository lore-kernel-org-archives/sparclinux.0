Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309182D0C98
	for <sparclinux@vger.kernel.org>; Wed,  7 Jan 2026 03:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767757730; cv=none; b=Br981Odfil87pySottazx7x8zdepeVWBm5tSr5hFAt8hDk0/jrRk4PKqG0fpFQBYl4Azmf54+6rjk4q5G0Y5g4OVjhIhqiyovPxllmCilDSC2jISwhUAeA5NWxr1YMKogDa948l8wYrIO+WO3RkUKO7sBRAjetAuwbGeqgNL7Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767757730; c=relaxed/simple;
	bh=7b6FVIVpJo+xA4SNmeOUyxog3DMDCGrnHY6W6wXIjPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tmHAfEZasvpQPO+CwgDNzPrmMRfRGAmQnLjez1QsxalcMrHrsOP8lDM6dveD8N2I3NvQEGPc9tyHi2ELpaDUk5NP9laouE+HgVv3zgghfSRerV32FsctH/d0u/g+oUztCTDA62PiaVrCEZSGeWR8jP10kNbbaii8Ts3lygCgzaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iuyPj14X; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iuyPj14X"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2ae38f81be1so1083799eec.0
        for <sparclinux@vger.kernel.org>; Tue, 06 Jan 2026 19:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767757726; x=1768362526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lVfOOsMtVesahSpJ7NzEZB2a7bFJ+2QiFmRNgCZu9gM=;
        b=iuyPj14XKkoWH9MWkyK+ItoYjysm2xwZQnqd3XHofHxkQDmMGac9oSzcLBYDBeqLtz
         rM7Y05s+Vp6JPcTNmWjefnB/fGHoe5JvPk4EfglNeWSJ2uMUZ3hNg2M4jQmaQCVwWHwp
         PGn3RUeyEAQNdEzO2/KVXwyL7JmHDrVE+K0Ku6AXrcedu6MmC7f7MYeRluE5+IoOQ0gE
         M3aTso69uZ2l50bovlSz+mHhtXJXkrK/nwTmuyToO6Vm0V7sg7wCAM2ZIhjKOUJrY95g
         RPMB5Gryt3l8LxiQDX/ReWMNTbZuoWRjqyfyqMQEanatzzhStz8WxxAuXQT6R1EpDCLR
         8CwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767757726; x=1768362526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lVfOOsMtVesahSpJ7NzEZB2a7bFJ+2QiFmRNgCZu9gM=;
        b=uBfjfw3sGyJFhC5EABFO1SUcKVGjV/gvFlhvC47WEsG8O98fdHQbNKI3qLwHIrp8YA
         EgYXOksbSN87mnwlMMARc4oqZpKLJVkdXvcbmb5sL02bIdYjthKTFIDcRSbu44Syl3si
         LCHPZVsc1k4CRgKxCLhx1LqAEo+kNr6HOsbQJs2Yz9JSX1AcxfH4+R1yctLuYbUqZvKM
         stOAMbZbvKVjLBtaC9r8k8S6XnzWmPhu42GsvSWRkMH4cJB8qz3KzA7grZ2CEHnL6D21
         bzuw333SRFIJ72IqF9s1/1K2TmcCue0ARmAdQvNFm0DAYdqbnS24+I1uOMG2o5Y5gQKI
         H7Ig==
X-Forwarded-Encrypted: i=1; AJvYcCUtX3mKhjdQVKgRUwfQOtSYkzdgMdIMMRpZDSmbKuHqzAIdJOwXYNhT5uzL1f9la/KBQo7UCfMxKfD8@vger.kernel.org
X-Gm-Message-State: AOJu0YzM/tGjbFKGIrDy9KHsOC2sMBvCcg7QIiPDWaqLQF/ymZ/Ee21k
	2729ik1CL3XYO/ph1BNGuuVH2yie5exB82ZJTHXOqaqM2kYaO+xGv5Fr
X-Gm-Gg: AY/fxX7ew+YyGbIyrAeh2+uSxgEbubIKTSAEY/x9WSU1D6lmj/X/+RcfRc3RI7tw7Mf
	MutAmOaeMynVcR/Eg/J8iqGnzEIxB6l0gr8Ovxe6GiSqq5o/PazNSVL0a6GihvZ/7n+7j4OOxBp
	HRFrIJV0OpgOBVcm1wgjng7TKmsyNluVaYj36/lsMAyQKz0K/7jHMJdhtLL4ad7jBGRb+30vdwZ
	REYC+OTUUJwyE8EoljsOLErni6R6zQCUAhEEnI++NmfHrzoeykREWBBih/l1KuXOO4WtmTV7oXw
	AqAIkbugIQU58Xw+i2h71GacOv6ptarSc+PMmZQb7iHg8squSQB2r1pqJAzCC1+3QDKbyvyAh5n
	REcep8KcaVkQNhi8e4YkhvqjPDl6KPWtqmgbXNipTulS4wZuhfxvvJxD2hi5EG4w=
X-Google-Smtp-Source: AGHT+IH/ZbpZvf+ufhdSrgq15FQAA5DMOGdsUeBWMvuc3LZNVn+XAns8eGMqcOV8TZ1Q54ktkq+I7A==
X-Received: by 2002:a05:7301:578d:b0:2a4:3593:c7c5 with SMTP id 5a478bee46e88-2b17d1f058bmr978905eec.5.1767757725777;
        Tue, 06 Jan 2026 19:48:45 -0800 (PST)
Received: from gmail.com ([2a09:bac5:1f0d:28::4:33f])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b1707b2256sm5392191eec.25.2026.01.06.19.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 19:48:45 -0800 (PST)
From: Qingfang Deng <dqfext@gmail.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org,
	x86@kernel.org,
	Holger Dengler <dengler@linux.ibm.com>,
	Harald Freudenberger <freude@linux.ibm.com>
Subject: Re: [PATCH 30/36] crypto: inside-secure - Use new AES library API
Date: Wed,  7 Jan 2026 11:48:33 +0800
Message-ID: <20260107034834.1447-1-dqfext@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260105051311.1607207-31-ebiggers@kernel.org>
References: <20260105051311.1607207-1-ebiggers@kernel.org> <20260105051311.1607207-31-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun,  4 Jan 2026 21:13:03 -0800, Eric Biggers wrote:
> --- a/drivers/crypto/inside-secure/safexcel_cipher.c
> +++ b/drivers/crypto/inside-secure/safexcel_cipher.c
> @@ -2505,37 +2505,35 @@ static int safexcel_aead_gcm_setkey(struct crypto_aead *ctfm, const u8 *key,
>  				    unsigned int len)
>  {
>  	struct crypto_tfm *tfm = crypto_aead_tfm(ctfm);
>  	struct safexcel_cipher_ctx *ctx = crypto_tfm_ctx(tfm);
>  	struct safexcel_crypto_priv *priv = ctx->base.priv;
> -	struct crypto_aes_ctx aes;
> +	struct aes_enckey aes;
>  	u32 hashkey[AES_BLOCK_SIZE >> 2];
>  	int ret, i;
>  
> -	ret = aes_expandkey(&aes, key, len);
> -	if (ret) {
> -		memzero_explicit(&aes, sizeof(aes));
> +	ret = aes_prepareenckey(&aes, key, len);
> +	if (ret)
>  		return ret;
> -	}
>  
>  	if (priv->flags & EIP197_TRC_CACHE && ctx->base.ctxr_dma) {
>  		for (i = 0; i < len / sizeof(u32); i++) {
> -			if (le32_to_cpu(ctx->key[i]) != aes.key_enc[i]) {
> +			if (ctx->key[i] != get_unaligned((__le32 *)key + i)) {

"key" is big-endian. Casting it to __le32 does not seem correct.
Did you mean "get_unaligned_le32", which also convert the endianness?

>  				ctx->base.needs_inv = true;
>  				break;
>  			}
>  		}
>  	}
>  
>  	for (i = 0; i < len / sizeof(u32); i++)
> -		ctx->key[i] = cpu_to_le32(aes.key_enc[i]);
> +		ctx->key[i] = get_unaligned((__le32 *)key + i);

Same here.

>  
>  	ctx->key_len = len;
>  
>  	/* Compute hash key by encrypting zeroes with cipher key */
>  	memset(hashkey, 0, AES_BLOCK_SIZE);
> -	aes_encrypt(&aes, (u8 *)hashkey, (u8 *)hashkey);
> +	aes_encrypt_new(&aes, (u8 *)hashkey, (u8 *)hashkey);
>  
>  	if (priv->flags & EIP197_TRC_CACHE && ctx->base.ctxr_dma) {
>  		for (i = 0; i < AES_BLOCK_SIZE / sizeof(u32); i++) {
>  			if (be32_to_cpu(ctx->base.ipad.be[i]) != hashkey[i]) {
>  				ctx->base.needs_inv = true;
