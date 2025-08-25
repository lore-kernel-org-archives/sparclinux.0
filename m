Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2316285C80
	for <sparclinux@vger.kernel.org>; Mon, 25 Aug 2025 20:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756154905; cv=none; b=jaZIHDFoVC5pK82y9DkNXesVeAFJmHgWCtSTsQ7sb5+YCl+YgyMQ/h+ryLV5oH13ZvXK5aIHomVGcz7RL8a9Znmap46JDWBDH9AZu9BmSRS9pUcPK3SfblosF7wXYk/xapwszBwKj9C5CUxpajryRL9fPUGLEdeUcTvs06sNKqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756154905; c=relaxed/simple;
	bh=ws0OH/LPbfD0uWhZ3//ck7/pwntfVUXedOFJRthyTE0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fBYHY5k1T3kp8yZmaWFXjONiuhdqrGtyfMwyY1r6Jvvjx2VQABzhGA69bdc4xwJOwDReUWGElNjF/bJf5JbUJ3c5mQ8sBwLPYdmBCdPsVvNN98yvY36Zzp8fOIcqkRzlJV181N/wuh9l9GgY1vP69BJCUTuY4ZyE9GvyDzBjoyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=jZH9/6ae; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="jZH9/6ae"
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-88432d932d6so59213039f.1
        for <sparclinux@vger.kernel.org>; Mon, 25 Aug 2025 13:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1756154903; x=1756759703; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N/dnllQLN8cDpaKVqJzQZtSLrZ7j3LLHfYLifC1ogCM=;
        b=jZH9/6aeiq6scjXh74JMeDRknBu0YK1nVmdvthVMAlC1uKD6/6YiXbcN0d9uOFhQ8y
         n5VOI0KFRdom7vcCh2mFTkp2sEjBeLtvrpwmjhGTwmMURUIf+hINw3wtrwFg0VAZvVFJ
         DnogJpcDUJSSM4JQ5eeutJ85KJnu2jhLgUnKiMuACh3rtdaPxU6Hb5AmPv7aHB4l8mNu
         IvEzWzVGgskyavxiDt7E+Sqw275JD1aC7EtvEnGuIrA5LEDxWYauZo36SBhv+aKCCKmh
         qp7eK8YXq5krcHBKgokh3yv5r2zCwcezlUnx5OFFgipygHxemWQ6ZEwnTtwt5qxHNkMl
         BZXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756154903; x=1756759703;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N/dnllQLN8cDpaKVqJzQZtSLrZ7j3LLHfYLifC1ogCM=;
        b=asH2CjFhTZ7TII40JiofYMgeY4UaqKW37TGQG9MzZoi9dYpcpGAy4KwqtibyFn01UN
         yQZGM8+PF9U12zvV94pp38Qb/yOspzu98H7e4DNiNfPUNDteZFckGXelzfx18I4CiNAC
         66N0hndDRyuvbwF5EDPyr+YFlTraxoFfxvgTiaBJaWeyz4lcHgVWPZDaeu8tKIKvBL5i
         Li5W1YzwCsFoji14/sn6yPyjKUk0UbnDE7/Cl8GEg0nwf8cjnn+fqXYUXtzaLAsZqo8e
         CcZz50kTNynvCdBqPwgICyFhGG8mLckAYphZq+TT3enRnu9nk0s94lrUoXPwNke6WjM9
         G00w==
X-Forwarded-Encrypted: i=1; AJvYcCVpu33rGjk1tHIsRbtrKuxTX+ku+5JB2evnHMFgkNzW3Qxq+6Z+gLC1IXjIg0YPmE3QmC+EV22AzdEs@vger.kernel.org
X-Gm-Message-State: AOJu0YxlAHhoZjHFa8G0+B+7pgL1NJXhM1HuJkaBGiaVzmmUnNz+fEyT
	vbYpa56Ul5Rk4i9zfTBs2ZkoT0T/lWoXg2wPzYmvGzZDc9K/2ZrC/w1ZNspV7HLZJ+o=
X-Gm-Gg: ASbGnctL/jobVvmyJaTJDu3tQqlnGAxzsEipZZQJhM+isE2w5wGj/THd7MYQi+4vq44
	KnNYRdDWucF33n/pPbDDItHuceGXqUXqM+Az4tXzASBtVHowtnG/qz5rmPY58nlvaYw/9lG62ep
	L1ORrbhXVMxu9nYOO5xEsExMeBXxHEuDVhA2TvJfLieYS3EWAEogUuLu9em28KIEWREZIdvvEpK
	owrUPEM7xNWfo/6z4xUJz+J6OxChfuZ90m7R7BuZd7Xk8cRz9pz5aP5sskbC47eho4iHCtksrF9
	F2aPGl6VGQDXygRyN1UvFZ3fabdW4DOaY3zHJEo9L7sG5Y45cYyJTPLD7pBnue/N5hYvUp5Ks/6
	x6DcS3ol9iVvdPA==
X-Google-Smtp-Source: AGHT+IGz/OLusjKqnvYuytsepj0QasUaFhQNGeebbI4cWxx4cpCIdsaTdG9b8SEzhdQW1utDLqTgxw==
X-Received: by 2002:a05:6e02:1582:b0:3eb:cca5:5586 with SMTP id e9e14a558f8ab-3ebcca5874cmr83676445ab.17.1756154902655;
        Mon, 25 Aug 2025 13:48:22 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3ea4effe70csm53084775ab.51.2025.08.25.13.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 13:48:22 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Helge Deller <deller@gmx.de>, Geert Uytterhoeven <geert@linux-m68k.org>, 
 Thomas Fourier <fourier.thomas@gmail.com>, linux-alpha@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 sparclinux@vger.kernel.org, linux-block@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, 
 Matt Turner <mattst88@gmail.com>, Ian Molton <spyro@f2s.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, Thomas Gleixner <tglx@linutronix.de>, 
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Denis Efremov <efremov@linux.com>, 
 Andrew Morton <akpm@linux-foundation.org>
In-Reply-To: <20250825163545.39303-1-andriy.shevchenko@linux.intel.com>
References: <20250825163545.39303-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 0/3] floppy: A couple of cleanups
Message-Id: <175615490112.25116.3742797696959119744.b4-ty@kernel.dk>
Date: Mon, 25 Aug 2025 14:48:21 -0600
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Mon, 25 Aug 2025 18:32:54 +0200, Andy Shevchenko wrote:
> There are a few places in architecture code for the floppy driver
> that may be cleaned up. Do it so.
> 
> Assumed to route via Andrew Morton's tree as floppy is basically orphaned.
> 
> Changelog v2:
> - combined separate patches sent earlier into a series
> - added tags (Helge, Geert)
> - fixed typo in the commit message (Geert)
> 
> [...]

Applied, thanks!

[1/3] floppy: Remove unused CROSS_64KB() macro from arch/ code
      commit: d74968780bf287958e2815be5f088dd6c7b7aa19
[2/3] floppy: Replace custom SZ_64K constant
      commit: 8e7ee0f6fa33934373c1c37e8cfb71cff2acea09
[3/3] floppy: Sort headers alphabetically
      commit: d4399e6eb27a803b73d17fe984448a823b4d3a30

Best regards,
-- 
Jens Axboe



