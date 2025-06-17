Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F16221550
	for <sparclinux@vger.kernel.org>; Tue, 17 Jun 2025 18:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750184977; cv=none; b=L2yc866IyVfLDLu0kz4SiIhB3MNKNSiroV01fgiAMHpDs9wmPuiF0Q6SS0qIguXZaCqafVfli5Me0V5vj+Dk/RpTiWnWFi5dt8ZPG51dN2HqK2oEptkj3y+AwF1f4U7UtX4pztOfTcfPw3TdhEH9JMVjymp6SYawcx/MRx030F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750184977; c=relaxed/simple;
	bh=4D7DO/f/TIDpTtJg/TTFmgQrH4mAxp5ug7V7AlGUGEM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pF1NF3wTV6hc1QWYNGsK+NVml85UgUj0jHYXQhOp2M66Y9077t26sp6xrxnxlFlSCJBfvLnZBEJjwngCEjTD2rNMypOkgD5ZSkis9lhycp31kAb2sCFqiDBp04dAyZo+d77PnhLY30YjLHI9gqtvrN45vBBwBikeh22c+QUI2+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ZULnhdeA; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZULnhdeA"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-605b9488c28so11675905a12.2
        for <sparclinux@vger.kernel.org>; Tue, 17 Jun 2025 11:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1750184973; x=1750789773; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BpmH32X+ubnFGRkDpBaCqaiio/3lQgXW15x6m1ucLKk=;
        b=ZULnhdeAZv+Trzzq5xzt/azn4/Dh+J6LuQR9TATLOD8coIES4JnNPqeaeQoN9LvgF7
         KlhVBrAk0Cfljg1ouLWQuEcxHXE7DC1msQ7pxvlQSiCXEUa30IGvcPvAjUZTxyLf0wDC
         NI7XXjEZCn4CwdSwugKLYQxp2JqqUnoa4XBm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750184973; x=1750789773;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BpmH32X+ubnFGRkDpBaCqaiio/3lQgXW15x6m1ucLKk=;
        b=PyOfC1JpvRCcYRZZfHztwcgS5fq9eQ5Nb0KoGK81CKuXZd0gSBlC3Luij9XVhp3VhU
         FWPeS5VierLWjRzGVzgMMPzlKNfAGUGorx+4uBp9d9nQejALrCEAjP0u/2cWJNAwHjIg
         6Ds98HWCR/69Ql26fdupvr7wj/EKodp9r91DxnmvAGt8Zf5aGiqUx31YHs++uMKoGyHP
         ppNBP15NoRnmx6JRZudkFEQ7g5QhKyeXjnlZJoewqtWOqzrrpf3qAmEJHos2yQ/esHmh
         ACrjgU+cC/LWuhdH6HgWg5F+x3EJG4ORKz50Yk4jQCmBbL+wMH/ZSDlNWzEGqyhf9GFK
         eQ4A==
X-Forwarded-Encrypted: i=1; AJvYcCWU93bTTCCNkI0ItEg21toCy2QS/Ub8QFbqztj4Oq8sFMR2yZkIFudtKZDOOkN8dUkMTItR2/0ioA9K@vger.kernel.org
X-Gm-Message-State: AOJu0YybZbMHpAroZcs/Tw50XncCFSE1Xs2ScnPs0EmfSqR6rZRhj/FE
	UZZjO25g+xMAR4EduvPqzcuq5Lw7WCQu/MNage+UB4Qq68CatBdGHRy+dWWie2wN0S6R32VG7H3
	u3smoQtE=
X-Gm-Gg: ASbGncsd1LYTJsKsXihEN2hEqWAQ8FqCWhTADl/eNPkTMGfFWyGImMnzWjLGhk9eMlN
	s+a2y/Ijmd6UUvAeQvexIh4XQ0AZU8vDQpbxmFyoCD1Y2hX9Fxka9FK2Xh4XmCgmxlZGOToHA2t
	E2hfsFE8eWyhGiFf4l+IKkjTtTbsgQM16ZNfty3k6ww2G0aozpx3S/ydOUW9UwdpIbEjPok9P/P
	+9saE9e6jUlozHlQigkVcwfyegyKRHeHahZQA/38ldnRZxCOTg/LdzC3AqoL3O79AnUeY7TvUGv
	z3et8wh0BwtBGqjU/+YA6UzmeRBarvj+RIlJn2feXiI2YFsnv/tiEIQtVqe7ru8Bak/86WS63wa
	xqpjutUo34ips0bVGsfjyzFssx9PJ6cavPmIL
X-Google-Smtp-Source: AGHT+IH/PfIfi/qfP09scrQm6iOVt5fwZm52tW4/A2pTX6kXGm9T3DqW/A5OXICMknVMYJCgfAvsjw==
X-Received: by 2002:a05:6402:51d0:b0:608:47ef:46e4 with SMTP id 4fb4d7f45d1cf-608d0948630mr13503776a12.17.1750184973032;
        Tue, 17 Jun 2025 11:29:33 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6097ad640bcsm2764491a12.25.2025.06.17.11.29.32
        for <sparclinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jun 2025 11:29:32 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-607434e1821so8793889a12.0
        for <sparclinux@vger.kernel.org>; Tue, 17 Jun 2025 11:29:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVB3oSrUlslNe1APF4zYbtkANky74M7DLbnNMF371mktSTskT2SB3uSGtp+PkxzJsHdnSDT/wHiMCP3@vger.kernel.org
X-Received: by 2002:a05:6402:40ce:b0:5ff:f72e:f494 with SMTP id
 4fb4d7f45d1cf-608d099f37bmr12876236a12.31.1750184971733; Tue, 17 Jun 2025
 11:29:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250616014019.415791-1-ebiggers@kernel.org> <20250617060523.GH8289@sol>
In-Reply-To: <20250617060523.GH8289@sol>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 17 Jun 2025 11:29:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi5d4K+sF2L=tuRW6AopVxO1DDXzstMQaECmU2QHN13KA@mail.gmail.com>
X-Gm-Features: AX0GCFsDpDEWkWJGZUHtM58JGRAX5cSPaq4yB3fqNYhO8hMv3GVq-qz3C44LzlI
Message-ID: <CAHk-=wi5d4K+sF2L=tuRW6AopVxO1DDXzstMQaECmU2QHN13KA@mail.gmail.com>
Subject: Re: [PATCH v2 00/17] SHA-512 library functions
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	sparclinux@vger.kernel.org, x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	"Jason A . Donenfeld" <Jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 16 Jun 2025 at 23:05, Eric Biggers <ebiggers@kernel.org> wrote:
>
> An additional note on testing: [..]

Talking about testing - when adding test scripts, can you do it as a
separate thing entirely - either before or after?

As it is, this code movement is hard to judge just because the stats
are all messed up with new tests:

 77 files changed, 4012 insertions(+), 1756 deletions(-)

that's 2k+ new lines of code that pretty much entirely hides the
question of "did this code movement result in a simpler / same / more
complex end result".

So in general, I'd really prefer big re-organizations to be *separate*
from new code changes.

It's just a pain to review renaming when it's mixed up with other
changes - whether renaming variables or whole files.

And that's as true on an individual commit level (we try to avoid
renaming things *and* making other changes in one go) as it is on a
pull request level.

If I see a pull request that only adds new tests, it's a no-brainer.

If I see a pull request that only re-organizes the code and the
diffstat just just renames with some small updates for new locations,
it's a no-brainer.

If I see a pull request that does both, it's a pain in the arse,
because then I need to start to look into individual commits and go
"which does what".

            Linus
