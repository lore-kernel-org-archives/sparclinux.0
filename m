Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4AD2135CE
	for <sparclinux@vger.kernel.org>; Mon,  7 Jul 2025 17:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751909525; cv=none; b=T1jDr12UprQhmS5XaywxEFUEqBW23P6Y6gVbUCrAduspPnCGPe0ox79eADtWDRJx6anYwiqi2EinpmPyp8aheadMxwVkeJfyIIcmGoKZ4/npWSP8Et5WJOQqsnagv/O/3FxCQkTj5+2y6ONEr258VClWLG6powTGQ8O8mJWbbb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751909525; c=relaxed/simple;
	bh=m/RJRRzLZV9ZprHXRI3L3Yhnmws+4bQEO4S7mLo6nI8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d/Fi8DefofuWcqvCsf1Kc+pY+nuf5xdQWQRABVnQP5A/RvtBQVzu8CY4DOUJYjYCfhNh0nPQOhnoJlJLTjCbmXsQB6IECOvLJ4c8pNrhVzC8P3AITQsLaGKJwY4dU9p5cG1nUBBCfLZOJQIvf+5jEcN2zePQjcDCK6KoiiLwvcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fdN+mEd5; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fdN+mEd5"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5551a770828so3386437e87.1
        for <sparclinux@vger.kernel.org>; Mon, 07 Jul 2025 10:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751909522; x=1752514322; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P8P2bx0lTgk0pSQY2SFRLxv6/LeGjzO8AMGPe6JBrJQ=;
        b=fdN+mEd5YmlDYV43TxHYOyjgQ4BW3WD+bEBECMNeWiEL9YMAJxhm70DKxByX0yEnUo
         dtoRffE0PDVx3OP56su3bHYpsP2OUlZpDVQ+bdTeX0QYJQ6ICPJbeRoqijit8kF/zW4Q
         L0ksHftdDdch47AsiOc70zwrF/c7hL4Vp4GajWhiDmcsKFAAlsQ1aa/Go5K2rXWtCyvP
         K7VQ/gx1qy3T6W5/3FzTSokLRKnMJTLGgI+3raLF9v/PgBZHN6CyKWgRgd2UiinJnOSg
         iKm4K4CWfb2Lg63F93xzqu+OI5hV8ej+2QMLwPWUqF3eRUrD3E438Z/Qepoc07Wr2ul5
         A3AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751909522; x=1752514322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P8P2bx0lTgk0pSQY2SFRLxv6/LeGjzO8AMGPe6JBrJQ=;
        b=wyp/RxHuXfnOMfhBHsbJRkLW/Aak9g0xfjOWfAZS6h2H0KoXIwh2YAfgqRxqtZBkdt
         tOeOWZUA4BwcajsnH+V9JN1tG7K5P11Bq4DKS42f3Wy/ls0yn+eu6itLjKkNFXV/Ep/D
         J/LumxOrdPFOyOU+b7e+l1+tBV/y2f9NZBYHHjxSAHHv/kojyJmF3W5Mk43aWL9SNSCu
         lCxCguZIPhnUfbSFWVp9CkFS7a2EGb0ocAEtE5P1Ec93TSE3Y1BIbsNoZKzg545Xaq0d
         0ILHqb0YRmelCuYKiqYSIUfUgQF3NinTcd2sveB1ElnU2ZDBlt9BpaD8waiVgnIwmLAJ
         rTbA==
X-Forwarded-Encrypted: i=1; AJvYcCUEyjJFIKuJeyzu/5Py++wZd6wMerHtSTlcwnJGVtkeBC5dIypTznrCkwXRxWQd/6sEARAYAJG5Rda6@vger.kernel.org
X-Gm-Message-State: AOJu0YwD32uT/HyOg7O7y/QWhtGECdj/0PMZY3D6unqekmH1Hfh/478u
	6tz7NUEDXSkQlJsJnOWKcp1PIH5CW+Ml90wHoj9LlwWcRagSZOtMQJaFlFFeC15sfFLzvIHEwzJ
	c/HN99QWzz29ws7UIsCdHZeH45rrfVZfh8ULsqgM=
X-Gm-Gg: ASbGncvUwY5WLuh9BEo1XpxD4DEJZ7dUHBbY2y2nFtMFFhkOSbvdF3+LF7LJmSBVKwo
	6/fSgdaewaQcC+LzK728/LWdJYKFMBb5XB6VdRa0ZT5Ed97xIDBqrllQrdLO2dVD9cmzC5sDnwj
	VjB6OAD42ltpQm6P/dknfXDW9lxWdZ0QWJBOT7JL+iXf1EFJlK0W3v5JZ8l+ZYPn/glbJ+gIQt
X-Google-Smtp-Source: AGHT+IFan4LFv9Tc5Xb++OJAJ1PhPxcGF7r+GsY9ScwjWdFJpsT5Y89TdN0nRO9h0GSYHX75H8U9uCm318/eI3TP8no=
X-Received: by 2002:a05:6512:1094:b0:553:2eff:8d74 with SMTP id
 2adb3069b0e04-557e5574fffmr2471382e87.42.1751909521461; Mon, 07 Jul 2025
 10:32:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250707144726.4008707-1-arnd@kernel.org> <20250707144726.4008707-2-arnd@kernel.org>
In-Reply-To: <20250707144726.4008707-2-arnd@kernel.org>
From: John Stultz <jstultz@google.com>
Date: Mon, 7 Jul 2025 10:31:49 -0700
X-Gm-Features: Ac12FXzjQY0ctd2-8dBMFgYuaf8bcO3blJ6y5kQoLF7Xn2XcSt2ELN2c5zxB2Ps
Message-ID: <CANDhNCo_zAA3owvYMcjZOv8mDc8_Rh0V+ux3LS-BdsLcjuGhZQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] clocksource: remove ARCH_CLOCKSOURCE_DATA
To: Arnd Bergmann <arnd@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	"David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
	Andy Lutomirski <luto@kernel.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>, shuah <shuah@kernel.org>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Stephen Boyd <sboyd@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Eric Biggers <ebiggers@google.com>, 
	sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 7, 2025 at 7:48=E2=80=AFAM Arnd Bergmann <arnd@kernel.org> wrot=
e:
> From: Arnd Bergmann <arnd@arndb.de>
>
> Without the sparc64 vdso, there are no remaining users
> of ARCH_CLOCKSOURCE_DATA, and it can just be removed.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/sparc/Kconfig                   |  1 -
>  arch/sparc/include/asm/clocksource.h | 17 -----------------
>  arch/sparc/kernel/time_64.c          |  3 ---
>  include/linux/clocksource.h          |  6 +-----
>  kernel/time/Kconfig                  |  4 ----
>  5 files changed, 1 insertion(+), 30 deletions(-)
>  delete mode 100644 arch/sparc/include/asm/clocksource.h

Acked-by: John Stultz <jstultz@google.com>
