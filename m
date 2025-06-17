Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE092E7167
	for <sparclinux@vger.kernel.org>; Tue, 17 Jun 2025 19:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750189456; cv=none; b=oI8lM8VWBnIaxR7SxKcJtCIZqg5aKQQWwUiW5AgI1JRN0vYsu7FfXCENo9v5vyvTubbhnvJs1sQRraAk/UecwouBT1p2iVNMhQph01m2nZJw8O2y0NqyY8NnQwvSNaHvr7Oj4wkoDN6w4AE6hA1GQZE59MB/Ue+U8IIo2p1xUb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750189456; c=relaxed/simple;
	bh=GglwgC9V6N5x5dY/greRFE2ImYu5s9zU1NI2hHBVjMU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O0LakuSqAEqEbpVYkqK7mbtuhCa7noHz/jZVGA+DrFrOh1nvZTFEVCxI/e0ZwHYVhnIaPCnqoJBhxgdglE7aQs97Tpi1qsCFjjxAN6boWJ+bIunXwGXfhtFb+jD+HEpIp0VySofxtDv8mlb1DEstC8boUejvXJ9QxZ3ZOaF44Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=MfYfgTBf; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="MfYfgTBf"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-adb2e9fd208so1242905366b.3
        for <sparclinux@vger.kernel.org>; Tue, 17 Jun 2025 12:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1750189453; x=1750794253; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9BlEsfucVc/RasLKZoG4B3LJbpSakOO/+DV6/Nb67hA=;
        b=MfYfgTBfympgPOCejPRlacaQ2xSeWXzJsF7Iwjca6GTFxYez5PLk+BD2r11lmLKXC7
         c5Sp4B6OtlvroLdqq5TEQstgQJXfY8PCR5VEYQG2V4ZusT7jwtuV9vCrnr2FQMAm9an6
         g5wTWBeeBzuII18xwdfO+mbIX7eJdLZM5Jsis=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750189453; x=1750794253;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9BlEsfucVc/RasLKZoG4B3LJbpSakOO/+DV6/Nb67hA=;
        b=AlXT85OYKd4Z3ntihE0TwPURyl+ofN6P7Ied9M8wDS4MttleSvtTr5FTb1Dsdxx490
         mIr9lDNsvtEV3yxpVISeFw4lf+eD/AsLB/doDmbOWAnOnLUePANeZSW+C/Okakx4F/7o
         /dyHd1q6e80Ctgm8qNIASMVZI+kCZi+gAcr7POL/A9isamoGtFZ3/6vlp79B7wSKYeCD
         IVx1W2WdbAnLgrIbLdG3ea3HVJMlaH5rAbd2urjCnY1bUFxpeFhL5I7IMhn2U+UFqjRU
         kD7wC5D1AHMp6h37regeDayWTqjdqmS52DIZU2XNAuxcH/Rdza9pOHpPxCJnlPESGzjT
         B8mA==
X-Forwarded-Encrypted: i=1; AJvYcCXKnpFkZ0mdDYj6S1tipme1H20HsX4VDospRPPjPqFN/mbvsNw/D20emOMBWWlGIciBPb8c/ROWKtPR@vger.kernel.org
X-Gm-Message-State: AOJu0Yyjt7pOmveEkn80twO2bTP4NOSgryW/YPYMPNVKKCcEpQ5Q0HJJ
	6OHT4ZHn1JYx755cdbgm4zPDGBk4EnXu+FnC1VZhkfaULcf31vvjH1H5V6fHfet20p9V0zoawtx
	kFkWlk3Y=
X-Gm-Gg: ASbGncsQ4TR2HBiE4HoQd4jnSlZpUUdVMuRQKHBgTNKsUWD5EqHO+B10isPwBuCjOYA
	e24z8mKP1H0pePJR5IkGSUp4vxFJ1fh82tyboKee+fkFtHDzPtv/I6C1Ul68Ze/xTKDNQlvTp3d
	lj72sIMODRSQ9wk7Lz9wW3WviFxCIBrp7nkwXFOMR2XPZl1fDt4XrhSZdDkqw0jwTEfvCnZ2DI7
	fFc4B4MYeNK06Z86uUy+FLc/V9OpIBmYnQLo+Ep7/atPSsQ+umADuXkA21a9H12ZgtxH7U9Dcj6
	Li/5yhbt9bOM9ELfB8ECnova/XiySgWYG3Binmvb9HnuQQJu7Cz7ysIBXHC+MScfLPP16ycK+1f
	ZKH/qQsCy4MoCvLloH6KuiR/vpbekhLDpKRkJ
X-Google-Smtp-Source: AGHT+IGpFL6I41GA9s6PMwXtM5+ZV4q53J2WX2aIogDSQmC9hTZIMckwd8Y4SQRGufc/3/QBXTjARA==
X-Received: by 2002:a17:906:6a1b:b0:ad5:7234:e4a9 with SMTP id a640c23a62f3a-adfad54b256mr1467005766b.28.1750189452594;
        Tue, 17 Jun 2025 12:44:12 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adec892b0e8sm915636366b.138.2025.06.17.12.44.11
        for <sparclinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jun 2025 12:44:11 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-607c2b96b29so12058269a12.1
        for <sparclinux@vger.kernel.org>; Tue, 17 Jun 2025 12:44:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXcA6Uo9oc1PHyE5USll15zy08GFQM/wt5MfG4Fmo1Fk8QHJDT9WV8nYjUyZWzZJTq7iiU3VRmRoooM@vger.kernel.org
X-Received: by 2002:a05:6402:278e:b0:602:29e0:5e2f with SMTP id
 4fb4d7f45d1cf-608d086197cmr14681659a12.10.1750189450991; Tue, 17 Jun 2025
 12:44:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250616014019.415791-1-ebiggers@kernel.org> <20250617060523.GH8289@sol>
 <CAHk-=wi5d4K+sF2L=tuRW6AopVxO1DDXzstMQaECmU2QHN13KA@mail.gmail.com> <20250617192212.GA1365424@google.com>
In-Reply-To: <20250617192212.GA1365424@google.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 17 Jun 2025 12:43:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiB6XYBt81zpebysAoya4T-YiiZEmW_7+TtoA=FSCA4XQ@mail.gmail.com>
X-Gm-Features: AX0GCFszNgSlkg9Mnl9IREDvPmSYgcHDQLiQJ6pRqgmPlre4NTxTJm_9n0SX2DU
Message-ID: <CAHk-=wiB6XYBt81zpebysAoya4T-YiiZEmW_7+TtoA=FSCA4XQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/17] SHA-512 library functions
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	sparclinux@vger.kernel.org, x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	"Jason A . Donenfeld" <Jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 17 Jun 2025 at 12:22, Eric Biggers <ebiggers@kernel.org> wrote:
>>
> The tests are already in their own patches: patches 4 and 5.  Yes, this patchset
> has a negative diffstat once you subtract them.

Yes, the patches were separate, but my point stands.

Let me repeat that part of the email since you seem to have missed it:

> If I see a pull request that only adds new tests, it's a no-brainer.
>
> If I see a pull request that only re-organizes the code and the
> diffstat just just renames with some small updates for new locations,
> it's a no-brainer.
>
> If I see a pull request that does both, it's a pain in the arse,
> because then I need to start to look into individual commits and go
> "which does what".

IOW, I really prefer pull requests to do clearly separate things too
when we're talking re-organization. Or at the very least spell things
out *very* clearly.

Otherwise I have to waste time just to go split things out _anyway_.

            Linus
