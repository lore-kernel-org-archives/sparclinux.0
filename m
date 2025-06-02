Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9349622ACF3
	for <sparclinux@vger.kernel.org>; Mon,  2 Jun 2025 14:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748875579; cv=none; b=aKSp8KjgjRU6rG0D/uqrxElqQB0wi5I97lq25OdP74lIqFDm73Qi/zW8IsKRECvHZmivLsiL8D7JzD60cah9MPbyt2n2aZ717oHCjCfPQElz9jrHA0/mRZzHfksglrry4meMjUnWdNQFJ79d/4CSb0ohOiSsJyhteR3bzVHrkG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748875579; c=relaxed/simple;
	bh=BMdmqxyCVbd7fEc++ql37zNwaBo1D8/TV+gOsCFIGWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u6tNEtfDnzBn+P1VcntpGpA5H8O2OI24AJPCenokET0h/NayLUsT4CAkRQkbRieR6fnUnQlzGRpY1wcCMdjRseTFnuVVgf3AXGBJ/OrD7OSLwATBafJxIxDIxEE/O+6XSFmdLFdEB730e9XCTBSfvzKGAEchd2DJiOhPKX7Xt40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=iCTZiqW3; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="iCTZiqW3"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ad88105874aso701572866b.1
        for <sparclinux@vger.kernel.org>; Mon, 02 Jun 2025 07:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1748875574; x=1749480374; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Cg0dwJvYfbYUNtSY86lpjPZ26U71B5eHF51TBSSqPe4=;
        b=iCTZiqW3SJ/t+gdVt4ga6XGES01PXlH3Pq9wsq25SikMyzqQGVB1A4voeRnuBnYXtl
         Lv1Vcb+Yh2amgvfjPEnC8KOu7W3T73s6Nqbz63LNbLoXUqmX+e0bzBT0cfm4bq/WWMrk
         kRyq12vg8k4Sek8Cr88188sUtM9vIJ5gDkLrQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748875574; x=1749480374;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cg0dwJvYfbYUNtSY86lpjPZ26U71B5eHF51TBSSqPe4=;
        b=KEWu8FwtDxWs95usXWEgmijPc2ZwsEEUdnautiCqQtn5mbJCw0en8h0okOFOVFzQK5
         u1AwZLbvjPv28o7VOnnQS1byRbCoEfi95YzyYMx6eKVmf0IXz4rusuOvoOV33v0H6OQC
         pcAHcGRgYvQxAm+u1Z6WJ926790fjeIuMpFhsUn3/w/3gUizrLCA/sG04OnEiZQN2z1V
         UcW/9hZYFNZ8LBKVHARrePR9Zmu5tPCziL9+W+3UcEZ2hUbOeska8ZV+Ra88Z253SW/s
         BvbeWX4+QoiKf9X92eNZv9qc6Y2uI2Zxrysc7irfHkr3bjtOh4VXvqGg3p1HbmFaMaCr
         ad+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVC4ldCQXw83vcgB1H3Y94oEJqEo0z7bF7i+NVU0nIp2nUPq3J4EUVj1Mjb4fteojGMnEsnV7g5ZKJ7@vger.kernel.org
X-Gm-Message-State: AOJu0YxsJHC4vSqnqdhSlN17nxYtltB3GAQHT6atka19LvTW6ftnpoee
	9+0mXnuQqo9WqJDoWrCrHVoIOoTyVWKLSByMLiSunSOO6g2iILvFcz2D7R9wJu8494VEvgvDT+f
	aywORUj4=
X-Gm-Gg: ASbGncupTaA9ksqbwToTsDxosGvB30Upx7bp4Bj96KpW0QQRgqVNgQzA+vv+7txbv9c
	i2H0b7elksti180D+YXDBLNmGGPhMsoV/VOv3s8/+Q3sD/6x3pkN9UZdjjFBdeFOdOtgtzsBiil
	KA+3cR1k+nIdeA52zCqUgGZefRc9Mbzd9qTNsNJtDqdRYSmGCZ4CguTFCJdSq2K2aU1YyWs3YAT
	oFiFvITkkIjUP/2D1qj0XYcnS5eO5vHjHmUvCkUaM+QV5EVXccIMVm61j7J/dvxBDVL8QiV0O/I
	UPmViiViMH6D0f2gpZQrUIwkKSg8tpw9xk4z/eT2GGS+yjA7cyhVr4waOgScpcpUoqmz9IwZUJA
	M0eaJoSWBoXUAIo8K6ETvTi+Qi02Ka7q4AmKU
X-Google-Smtp-Source: AGHT+IH5MvQ8hHqGqa6vt9EV/c1fB/W3tV3gbNvFomSLktFkZAcFSTmsWotiY/OoCwOYQKQ7Dn9+RQ==
X-Received: by 2002:a17:907:3f12:b0:ad8:9d41:371e with SMTP id a640c23a62f3a-adb322fe389mr1477525966b.36.1748875573856;
        Mon, 02 Jun 2025 07:46:13 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada5dd043d5sm803001266b.121.2025.06.02.07.46.13
        for <sparclinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jun 2025 07:46:13 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-604f5691bceso8080436a12.0
        for <sparclinux@vger.kernel.org>; Mon, 02 Jun 2025 07:46:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWxMicI6iXYyspCzL49slS9WdwNkixqt0zxIKbOmCTeVTSXuIyWefggQFe6ixCAYUOq7VscqcgKUg13@vger.kernel.org
X-Received: by 2002:a05:6402:5205:b0:606:3146:4e85 with SMTP id
 4fb4d7f45d1cf-60631464feemr3563572a12.4.1748875572780; Mon, 02 Jun 2025
 07:46:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250428170040.423825-1-ebiggers@kernel.org> <20250428170040.423825-9-ebiggers@kernel.org>
 <20250529110526.6d2959a9.alex.williamson@redhat.com> <20250529173702.GA3840196@google.com>
 <CAHk-=whCp-nMWyLxAot4e6yVMCGANTUCWErGfvmwqNkEfTQ=Sw@mail.gmail.com>
 <20250529211639.GD23614@sol> <CAHk-=wh+H-9649NHK5cayNKn0pmReH41rvG6hWee+oposb3EUg@mail.gmail.com>
 <20250530001858.GD3840196@google.com> <20250601230014.GB1228@sol>
In-Reply-To: <20250601230014.GB1228@sol>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 2 Jun 2025 07:45:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjO+t0FBrg=bHkbnXVsZ_U0TPgT9ZWUzu12-5NurCaWCA@mail.gmail.com>
X-Gm-Features: AX0GCFuodXM8SKmhJCuuDQhW2iq8pjrSnsjy_QXiBCm4TA9D0azfhocKT2KWhmk
Message-ID: <CAHk-=wjO+t0FBrg=bHkbnXVsZ_U0TPgT9ZWUzu12-5NurCaWCA@mail.gmail.com>
Subject: Re: [PATCH v4 08/13] crypto: s390/sha256 - implement library instead
 of shash
To: Eric Biggers <ebiggers@kernel.org>
Cc: Alex Williamson <alex.williamson@redhat.com>, linux-crypto@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	sparclinux@vger.kernel.org, linux-s390@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, "Jason A . Donenfeld" <Jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 1 Jun 2025 at 16:00, Eric Biggers <ebiggers@kernel.org> wrote:
>
> I implemented my proposal, for lib/crc first,

Ok, I scanned through that series, and it looks good to me. A clear improvement.

         Linus
