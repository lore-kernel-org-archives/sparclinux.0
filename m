Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00522238C33
	for <sparclinux@vger.kernel.org>; Mon,  5 Jan 2026 07:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767599254; cv=none; b=MhHSOkVlK+xo3SuorY8nnDO/C9MsNgfSipj/0ENL8YphcvERHXT4kTyNHwusA4yeSI31KUwRquV7Idkg/0YkpPjbqOLLzDenZ/igi8CJFL2zwbkB1Ie9m1AW0pDYpnykiK16RnYynBNWO3lNT0r/8ZGo4qpfCCBoNOknQn88DH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767599254; c=relaxed/simple;
	bh=nZVAqheaPq5rGRSWmaOVnJe8g46n6sKwiOrt8BkPTmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ss4e+Ugx9DwmJ/c5eBHO1LjjKyXeOUNelB9ok87wbGNj+r9dp3F6ZnGZZDbtdBzhnNDy0I03vHqCRrH3I3dyFtRIz58m99tLV/Ck3LHI2cukPNwnpQNXfZsSHHOnu7/4MSpRTjZkp5SnN0Nqj8tSWo4ADVXo65q+SclO1aWZs5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XDKMJWyr; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XDKMJWyr"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c1e4a9033abso12231512a12.3
        for <sparclinux@vger.kernel.org>; Sun, 04 Jan 2026 23:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767599252; x=1768204052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Smn7G9NNF4TKpSBrLZt6/rkru/ozPf2jYkxgsCOt/U=;
        b=XDKMJWyrvDbiwDOfmQKLltH6IiyxEaweMnOAZFBZVGTYC2GOqTfKh3n04lf5GJ84qu
         5s0gbg4aU+QvgUmtV7ytpI0dXCqPB+akAz5slCfWkIk9tIcmZWrmUxBoEwmp6kRQeVdB
         mWGTurcze4OqqRw5CUYJ8rQ8v9uWuLvqfyqXF/tOyXXg/195fsYvebVWZJ6Ki+oIuXZa
         lq8f2FsrXZaPRS0o17VkIPhBt2cfSseITAlkOoe59bKGSK7ub90fst0TVAjIauffDcOP
         3+BOPMFIVMQjTL+v2cHEnTNRAFpbbJ/cCITAJrPSRtrSDdpNrBJvN+U/6tGxmjdBBmBl
         8Xvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767599252; x=1768204052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2Smn7G9NNF4TKpSBrLZt6/rkru/ozPf2jYkxgsCOt/U=;
        b=n+ut2LYZDKXgMkiDZSwRAoOoduAh/q6OYXFR1HqVWDLPofEwve/yuDnlbnjqd6BI5R
         /1H7uQAJpqppu2/RnnQpC0EtdwExy3zokcDccgWchLM+owlxn5yrvxAgrav1gCWn8mrq
         +DXyeC4/pXb6geyFjlmT9s25SvDyljmtvtL2wIb8vq+TkZjbbeFI8YejsIsO0Ulfj1YA
         gwTibJYtW5F2apaHPXsDQjz3WyIdUdkLcliZr9zq+08zc2+lZiCCYQRTUEszXLNyfftG
         t3hIj+9W2Lmp8XMt6xmC3KqgS7BZ8m1Vfbouv4QqwxAyUN8LsxaWN/CgMxSDfq4NKsd7
         o8SQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjo1hcjt+vgJl8vSQzTyDRAsrv6W2rqDP3pmagsuVJ/UnUqbh7yjQm8Gx0SXQMv9uZ3J6XPO2NsPOz@vger.kernel.org
X-Gm-Message-State: AOJu0Yxyhtwp7tuswuFQBpS/1YMsktcYA4bdN7TlqVb5qBziEw7V3YFG
	1ADh1IAU9dWoIn41Q4+ldcJG3Sn1DXlfGxC+KZtFKUSBI+1VWz3OA0Z1
X-Gm-Gg: AY/fxX4snTVes30HBoZEKyddeNFnEe/9R/CtYpqrq4TEZpi3VXZxCDKB0MBh14oOjes
	5M/UeouoF9y3dgGmQdQ5h/GM4/6r3o89nOXLsk5Jm4r0lkpPw5kUHvrvblk6m3OkJNwan7CSUiT
	yGrZPWrQPf0nsqx6X7YnPWWbvsxFYlW1zdQpl30HF5nrSPNLAgTMpU0lDZrMGKwbZPj94iozuRR
	CWa1irsvR5ijGhy44+tj/NjLwocIDTPdb8Xyvi2nRy7tLGQniTMEExiPq7IFnyYzPM6FyHzeykp
	mXg/o4zaJJBir7v1T3279WcPdCh0F3097J0sTiKZgyGALtt4ofjvH/7AuBa/tCKHOpVKWx29Ehh
	MM5FB2s1Dzdh83fNk6dezifAHwH5UQgICkIPyDzqVoj2QxBt8yEAAAvQ8Zkb+I+8trwF6YOFmQA
	==
X-Google-Smtp-Source: AGHT+IHVaBHzL3ldcoq10mQ0DvSoQNAzO29+h1IBrSy2gZY7Qh6quSoh5XWNmgIvhDzcT+gz+HyNHQ==
X-Received: by 2002:a05:693c:8008:b0:2b0:4f8e:3273 with SMTP id 5a478bee46e88-2b05ebd7223mr36936529eec.6.1767599252090;
        Sun, 04 Jan 2026 23:47:32 -0800 (PST)
Received: from gmail.com ([2a09:bac5:1f0f:28::4:33f])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b05ffad66fsm101610210eec.4.2026.01.04.23.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 23:47:31 -0800 (PST)
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
Subject: Re: [PATCH 02/36] lib/crypto: aes: Introduce improved AES library
Date: Mon,  5 Jan 2026 15:47:12 +0800
Message-ID: <20260105074712.498-1-dqfext@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260105051311.1607207-3-ebiggers@kernel.org>
References: <20260105051311.1607207-1-ebiggers@kernel.org> <20260105051311.1607207-3-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 4 Jan 2026 21:12:35 -0800, Eric Biggers wrote:
>  extern const u8 crypto_aes_sbox[];
>  extern const u8 crypto_aes_inv_sbox[];
> +extern const u32 __cacheline_aligned aes_enc_tab[256];
> +extern const u32 __cacheline_aligned aes_dec_tab[256];
 
__cacheline_aligned puts the array in ".data..cacheline_aligned"
section. As a const array, it should be in ".rodata" section, so
____cacheline_aligned (note the extra underscores) should be used
instead.
You can also apply the same to crypto_aes_sbox and crypto_aes_inv_sbox
while at it.

Regards,
Qingfang
