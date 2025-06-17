Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6C12EFD8D
	for <sparclinux@vger.kernel.org>; Tue, 17 Jun 2025 20:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750190915; cv=none; b=LotHs9fhRaE4f42IbUchUsXcL8UJX0GExNuDdpnMzJHELsJ4aSPFIcoYfLkhsVdis9tcsQ5X4gp9bYPG7Fid9tG2eJ8MyLLOJHLy7xP69Eun1VRE04lyP6rbILZx7HB7EDKcl88SDoapPMvV5FNV9NHpXD/UaxLBZc3yBs3NgCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750190915; c=relaxed/simple;
	bh=NQoGyMTrLvZ94cQK6qr/U5S3n/jCYrB9gj8+lWNrtVE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MG1h+Qv3Ilaio6oWazfVs68kkO4P9ogNCecUL0iEf8Wi0/d9rAYGTtu5hheasZZcGNbuAx1SF0rJs83gOcHslCwbfqxTfKYGF9gcokmuxU+zKvI3JaMWgOhZmBrmdKZ0GNBaqTAVCOTHg/QoUS0MpwQe8mp9aqwRJD1cboH5KlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=DHFFK/Vl; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DHFFK/Vl"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-601dfef6a8dso10273307a12.1
        for <sparclinux@vger.kernel.org>; Tue, 17 Jun 2025 13:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1750190911; x=1750795711; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KANIOG1UnKUU5UjGnVcj73JF4ShRkYSB4zL4V2vR3Pc=;
        b=DHFFK/VlZ4Ssk73LyTWhzRdIdZa31mheZCsUMVBcoWLZFg1+x9hxtDzvFjgmRerD7o
         L0eBp1m6Seou/nVH5kT/zfilk99apca1R+zbaVQYjK7ayFiD5AilrcYWPwo9rCXr1ST7
         WZFlfuvMy5dM9emEnaELYsnUDIP3VXjre6NQs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750190911; x=1750795711;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KANIOG1UnKUU5UjGnVcj73JF4ShRkYSB4zL4V2vR3Pc=;
        b=Tl92azz7E3U1BossWKB4iwr/vIOmktBakPeKT9ATnYi7IXPEU3MZ00FBzAJbNhls0z
         zY8bk8bcb9WAW6GEY9P3XvqJ+PfB9f29m155SUyZIIQKKY6hJr0QrOmi2H8V8MvOnDxA
         oCWVKq2GoaeJW4z7tI1h6Ckxc47pOJNgKCuFxluM/qZPO21Ov8TWt50ktgeKroeKrApD
         +R6k7q2gZRWUUF8zB+hLBiaTHlP5ZzMiyarqrAKdVVE8Fp6f90LV5mI4GLGbL4CD7ptd
         iZkU/Z95JEVckALm4Z5pDe89onjgS6x87hWr+YBIBIePcF/oKDADJJY7f+PEY8ej1JsJ
         LQEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXk513RGf5Sf4jVhc5PB/1z81zs1dx+o3YChO+8SBMcbl6vUOgVR3uoHqiKf1zFFD2FhDzm/nXAzb0n@vger.kernel.org
X-Gm-Message-State: AOJu0YwDiFa+gmauagW+y7jAITdvWws5DDwPS04VnyoBFQ/2rD3TZ1Sn
	DKF7o8YzzT6z4HAErOZfa5PvWdO3cjSSUKPrfHXwOAoX/mMU0jR1u8CVj66rjSRU6vPsmuwDW0b
	pq1ZmlnA=
X-Gm-Gg: ASbGncu775rWZXto4PeuZhjs5BZGWJL7L04sKF2fp6dFgvlzEoPW6gS/hyu+DYqeuY4
	2hPVwV+M2GuUQUSngalF0y5466nyKLXBBqke719NJIO45FTPHNZKQKz5JMaGxlgO3Dv30iV/UMA
	z/PEA0pV5C6PrNl53jeqyc40RunUxdElp1Utl+CdtIZlBJoy0zlxrNlhC9AuV0jv8A4RrsIVbar
	4enYJzS4pB3MRxkeyyg0F8Qn+rzV8T8IuG41SygH/CvvgdeEmEPsDVi88d5NHHWlXYIgZ8Mwa98
	FInOdtUczPJELVX8Bmz8T3mwB4qhm5jCpc/vkjhBGw8sM3eFBaR1gYRM83mOfmEuX9nF8aYc3U3
	ijKqr/+x9b9lkvR0A8F+6hGCKNavpQIzTppPYBRdA2pCly/o=
X-Google-Smtp-Source: AGHT+IG/t/PPw5JtSpkZodEFwzpPnx+HXinlApHOxJ+6Q2iqPRyIFQDYg41cQ7+xKJLKOjNVbV2Gmw==
X-Received: by 2002:a17:907:94cc:b0:add:fd7c:ae9 with SMTP id a640c23a62f3a-adfad4a480dmr1556594666b.45.1750190911489;
        Tue, 17 Jun 2025 13:08:31 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adec815dc93sm915130566b.35.2025.06.17.13.08.30
        for <sparclinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jun 2025 13:08:30 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-60707b740a6so9403732a12.0
        for <sparclinux@vger.kernel.org>; Tue, 17 Jun 2025 13:08:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWbeVnVTnsT8l8cz8Ul20S5jO1jG39D1KErx9XvF+AT4vg3sz5duVBFxdToNv3WgIdk7E5SWO75RLAe@vger.kernel.org
X-Received: by 2002:a05:6402:2550:b0:5f3:857f:2b38 with SMTP id
 4fb4d7f45d1cf-608d0948ae9mr13954090a12.17.1750190910438; Tue, 17 Jun 2025
 13:08:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250616014019.415791-1-ebiggers@kernel.org> <20250617060523.GH8289@sol>
 <CAHk-=wi5d4K+sF2L=tuRW6AopVxO1DDXzstMQaECmU2QHN13KA@mail.gmail.com>
 <20250617192212.GA1365424@google.com> <CAHk-=wiB6XYBt81zpebysAoya4T-YiiZEmW_7+TtoA=FSCA4XQ@mail.gmail.com>
 <20250617195858.GA1288@sol>
In-Reply-To: <20250617195858.GA1288@sol>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 17 Jun 2025 13:08:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=whJjS_wfxCDhkj2fNp1XPAbxDDdNwF1iqZbamZumBmZPg@mail.gmail.com>
X-Gm-Features: AX0GCFuoL7ATRJ2CnwP4RNLTBvlSmkXnXI8fTIZk-24R8V3-BYf3WTK_tAsCN-o
Message-ID: <CAHk-=whJjS_wfxCDhkj2fNp1XPAbxDDdNwF1iqZbamZumBmZPg@mail.gmail.com>
Subject: Re: [PATCH v2 00/17] SHA-512 library functions
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	sparclinux@vger.kernel.org, x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	"Jason A . Donenfeld" <Jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 17 Jun 2025 at 12:59, Eric Biggers <ebiggers@kernel.org> wrote:
>
> Again, the tests depend on the code they test being added first.

Sure, and that's fine. We have lots of "this depends on that".

> I could do two pull requests, the first with all non-test code and the second
> with all test code, where the second depends on the first, i.e. it will have the
> last commit of the first as its base commit.  Is that what you want?

Yes.

Or if one single pull request, split out the diffstat with the
explanation (that's the "Or at the very least spell things out *very*
clearly" option). But two separate pull requests would actually be my
preference.

          Linus
