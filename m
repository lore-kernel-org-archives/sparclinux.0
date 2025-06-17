Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51CE2EBBAB
	for <sparclinux@vger.kernel.org>; Tue, 17 Jun 2025 21:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750194638; cv=none; b=sNtOV2bESNhBAauxTPMp+WWDlRwHrCSVDdU+/Sn5lXzP8m5ojC67Rd8fpqpwZdKINZYaeq0NsxtnCkSBzqO1zKDmDQjxlmV0mFTjJ3V2nSjTLbhUXaFz+1qbcHR7AnrjW9Lj972n0wk0imWvy4r0vo1ScSDlYqLIkdHdgCSxfIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750194638; c=relaxed/simple;
	bh=ir2qXEQz0ITQfoN65/zED7gUfzbFZUXr94ByJGJvwQY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jRGULcmGl19taFtSPQJZ3x/7J22RjTfBpdtxaag3K+s9+L/6h/mFqcofbkRepc2py6TjeyHAO50gTfxrvx6vP5KnquHhDl4fE4prnwS2/HijZEPpU5cXy13lcEtOQTJ6cEiVqJOwoEVX6eRanVFfuzQZuBRovnkBh/OWW9eTJjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=GKGxioJe; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GKGxioJe"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-607434e1821so9004426a12.0
        for <sparclinux@vger.kernel.org>; Tue, 17 Jun 2025 14:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1750194634; x=1750799434; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NscEjg9Y1LWinfHLpsahI5dfBkkxck14FsEzSEH/mHM=;
        b=GKGxioJeNQ1m3MD+VTMFWiahlOG40+CTfxNSdw6ozP/K0DiboOKFT1CYrPNsR9hG+C
         S4wl1fAL0nwXFJoNPcxlUofj6jn7zWG6CQ5fZVIurImhqLwNJXzSGz8RveJ1TIGiKaQW
         DZ6u+A+f/kRtJ9rOqSJ0xtaaZHD1uiDiEf+lw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750194634; x=1750799434;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NscEjg9Y1LWinfHLpsahI5dfBkkxck14FsEzSEH/mHM=;
        b=knFPViiabY2+Mos+pUvrokTl8NZrEHIyK4anNcUABrLR4QB8OfQ8+2rWyzajjuqoKT
         tsU+fOo6LgD4Xal6hrTir+5kPOw1oJ2HRGWxyTe9yDUBFdbVrFpFSN6jUqMCCibT3wtV
         jCAB6bXjjqXjGoURtXteLc206yXWBu09yjR5cfYI5Df1GCniopn6OOpqXoK4HsRXw16E
         3q8AUd+40WRplxBqa6kKDdYkVQT6fro6zGBul2BVz/ZeYleCGM0piN0WuOAG22UaRecx
         XoARknWOkeQhsqGso8Od+e5eQhA6vHfj6AezEVqvv3r/r0QB5uJT2wgPpEAREKwV58D0
         hEUA==
X-Forwarded-Encrypted: i=1; AJvYcCUZzSAzrq6OPcuy96rlkHLnoludCj4esPMHxsuaYuLk9CpYjjWZpqwFDW4dMa/megBDpC2Fsx9BSnRr@vger.kernel.org
X-Gm-Message-State: AOJu0YxRorSfO6pSW25uj0sYVkZSd8WvXb9KKxLyxByv54hd05IegiIX
	eMjbciVe4RuTWDMrYggBoWWeGlNxYw2sYI+wWyPyWbjrgg77mZGXZSCIHleowmPzNTWfq0rspNn
	vhxXTZ7U=
X-Gm-Gg: ASbGncuD69CcL7Deab0A682ZSgXgyD3tPukXTIJDQhqkr+mdppwXPtRsBfUSnW/AKot
	tOdYQtgGCDRPd4r1/0UnisZl4VHpz4VjvUp+3/FYQqUk8c9PGag+whVkXosF4E92RCzKDXghRBs
	MAyXIRWjRSaLTB62Whirak+Dh0B4KYO2TtKQYW4eKG4aa9SyoE6mwch9MRb58u8MiFXGpAGYgnc
	7guU4k8tgViQAyMRGirdJFEh91UpjOrQmBxIp6UOXpYn8IdmVteAyfFgvUgcY3+B1lrmfU8/uU2
	8AO0fdNp8l72eXKeb0p7x6vBliU7D2wSpamVlv+1m713f5Y9yaMk/IeP3CyewKh/hW9VUK03Ax2
	Dr1Bjbr3hZaX/UPSpgzZjZxiAgBGYPCK7mhSm
X-Google-Smtp-Source: AGHT+IGLxHXVjdA55BU4Hyago1+OOLVaU7AFcvo/qSdc4DDVWfPpjSawlx10yNxkvpADo1stRqWHjA==
X-Received: by 2002:a17:907:3c89:b0:ad4:f6d2:431b with SMTP id a640c23a62f3a-adfad46a0f5mr1238727066b.44.1750194633874;
        Tue, 17 Jun 2025 14:10:33 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adff6cab54esm291539866b.30.2025.06.17.14.10.32
        for <sparclinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jun 2025 14:10:32 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6071ac9dc3eso10773290a12.1
        for <sparclinux@vger.kernel.org>; Tue, 17 Jun 2025 14:10:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVJwx6M79+GYMsUEZfUKLXJm4tkpI1j8jJaQvUTRNtvivj5dBKMyZnDaRcB/d8NZRnKQCPPk24tJPWv@vger.kernel.org
X-Received: by 2002:a05:6402:5188:b0:607:f55d:7c56 with SMTP id
 4fb4d7f45d1cf-608d097a0a3mr14798722a12.25.1750194632040; Tue, 17 Jun 2025
 14:10:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250616014019.415791-1-ebiggers@kernel.org> <20250617060523.GH8289@sol>
 <CAHk-=wi5d4K+sF2L=tuRW6AopVxO1DDXzstMQaECmU2QHN13KA@mail.gmail.com>
 <20250617192212.GA1365424@google.com> <CAHk-=wiB6XYBt81zpebysAoya4T-YiiZEmW_7+TtoA=FSCA4XQ@mail.gmail.com>
 <20250617195858.GA1288@sol> <CAHk-=whJjS_wfxCDhkj2fNp1XPAbxDDdNwF1iqZbamZumBmZPg@mail.gmail.com>
 <20250617203726.GC1288@sol>
In-Reply-To: <20250617203726.GC1288@sol>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 17 Jun 2025 14:10:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=whLENPVgWtHg5jt42he8Eb2pFzZngbvfSWXUmq64cyaAw@mail.gmail.com>
X-Gm-Features: AX0GCFteh8AxHdG-O3SktB-Vd7hTjMUC_EBJsHwrbakY8eEhqvV4OBO-zVcDyV4
Message-ID: <CAHk-=whLENPVgWtHg5jt42he8Eb2pFzZngbvfSWXUmq64cyaAw@mail.gmail.com>
Subject: Re: [PATCH v2 00/17] SHA-512 library functions
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	sparclinux@vger.kernel.org, x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	"Jason A . Donenfeld" <Jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 17 Jun 2025 at 13:37, Eric Biggers <ebiggers@kernel.org> wrote:
>
> Okay.  For now I'll keep the test commits last and plan for a separate pull
> request with them, based on the first.  I fear I'll quickly run into
> interdependencies, in which case I'll need to fall back to "one pull request and
> spell things out very clearly".  But I'll try it.

Thanks.

Note that this "split it out" is really _only_ for when there's big
code movement and re-organization like this - it's certainly not a
general thing.

So you don't need to feel like I'm going to ask you to jump through
hoops in general for normal crypto library updates, this is really
only for these kinds of initial "big code movement" things.

> Just so it's clear, this is the diffstat of this patchset broken down by
> non-test code (patches 1-3 and 6-17) and tests (4-5):
>
>     Non-test:
>          65 files changed, 1524 insertions(+), 1756 deletions(-)
>
>     Test:
>          14 files changed, 2488 insertions(+)

Looks good. That's the kind of diffstat that makes me happy to pull:
the first one removes move code than it adds, and the second one very
clearly just adds tests.

So yes, this is the kind of thing that makes my life easy..

> Note that the non-test part includes kerneldoc comments.  I'll assume you aren't
> going to insist on those being in a separate "documentation" pull request...

Naah, they're relatively tiny, and don't skew the diffstat in huge ways.

             Linus
