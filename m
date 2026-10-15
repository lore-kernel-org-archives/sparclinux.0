Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0063B27F9
	for <sparclinux@vger.kernel.org>; Thu, 15 Oct 2026 14:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792074762; cv=pass; b=p1tTjLI7r5JNf06NaFZ4wLrWJQpNRltsJvs3aNm03G5wi0I4tVspEkdVoxAM3U7J8Ona9rPw9/7W4bQF2Y1SRJuQ6O/V3Pl1d3NEabhz+9Lh8RdgMx/+Q5JJD7PgLWsWKK/Occg0SPjP1JkfyQ1jy1Ukhu5pc7kcfC2DGY9pYLM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792074762; c=relaxed/simple;
	bh=ofBd06lRo+XzhftsfggDsplL1oublpBngPmxR5uXE08=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F/ctUUW6fSwpHSZY9hPRotU22ZA52z1teGd+0Tl0Cg4N0JGMVT2/egZC3wpSII1sw0TzqYSZqSbaYQTE87GXGKoxESMCZn8Op54fS1nSTC0CAeuy+LphFIJUVxrzN+ovF/t9RlCv2Y0fNwCWapWvtuZ2CAOIuCcRoek/+gnsCT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n3ZIS44g; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n3ZIS44g"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c2afa22e1dcso780542566b.1
        for <sparclinux@vger.kernel.org>; Thu, 15 Oct 2026 07:32:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792074759; cv=none;
        d=google.com; s=arc-20260327;
        b=XqQpKpr+592fZXUAmJC9BuAUklpYVkzYcXnn4YOV9bLLWkydfxQJvPscsBlm6hRcfn
         /golsgtK4Q1t8rIwuS8GWI6uCmbmbGAOLcw7WOhdCKrYHSyjNOkrX1gWT+4N1MmOoht+
         ILrRMeR+hWgDPT2gnhNxXBUGQO3+8TmdlC0mjAexkUy3JWateKWOYBfN67vvz/fMwpBX
         7Yipw5WMwPlaSpGBdG4PK2V2lOnniYSqcoENtATS57kZM9ZEfc56vXzuzeMcF8v80jBO
         TOhcRW6qF+OIe95jgwe5RfK7/1qW970NoINJX8y0bEbZM9QzU5fJ9TrKXK4x3jdKhYKT
         bkgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wRqyIPckjjj0g7xkzxWkuaV4wuNTZ6zOy7JXpcrFLBE=;
        fh=dQmxJCqsQ1409xBwqjE4eXcgwh4XVc5GhijGwpf56xs=;
        b=f3sCMqg1PEG3HD3E+9QMkMKyU6dz2AB7z/iRhdPaQXdDPFqQbI3ZPCuUMsd/brTczo
         LxFZbVOYK6BOjCWhgJYdBDTrqmhWrG/vQn1yHDmwjG8RR0qKkuQLy8PmJPnbuxfI+DrG
         YGbgyJpsLxl/rYRmhC3vR4yKRlcEZ2VLAHFBIlJYMhtX27AgeR4VpSTsBXr0pCvf35At
         dLChJJGhHJDqcS/VQqArwGBE2hYNpEbeyg+1NQOXJ27Pmy+w/0OtBTTl32BIyDKiwpC+
         l7etq6BVWYRRA56EHbZ3VEL+Cn6BP+h39T3eBnxMCPAVU2vUv5GoXEWlJ03s0GsaDrjD
         fecw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792074759; x=1792679559; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wRqyIPckjjj0g7xkzxWkuaV4wuNTZ6zOy7JXpcrFLBE=;
        b=n3ZIS44gSGAkQBYGkCeuEdmMZa2eLFe0o5GP/PVSPvWxu/CITE66oAztoogQaU448F
         VMg97B3HEbx0E4KQ+D7GrkSV1fCFVka+31dQ+v8AnfzTtul0JuK5zkVGMjXPy2urDHbN
         YGJXjs0WitzQV8v+UHt2Hz1+IpwWH35VJ3fb2ZaJQXz9K6tUWuAA3dkqvrq+hvxI2H3n
         frOYL04TraJstYd3g77vNvnDfjC2OjqeX5y//Z8DaXGy3O1tMaeQ05QRlu5yZeLLZNrt
         JbadyTwnSxJFZmxvlohFZR9R4s1Fk6IqDDUwsHFpGrJ6WFM/WHmF0tWd0nsCIxyGCQTU
         pZXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792074759; x=1792679559;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wRqyIPckjjj0g7xkzxWkuaV4wuNTZ6zOy7JXpcrFLBE=;
        b=GhlQmVC+nIN3WMHdb9O7uKCdh7pH7PIzbboeR6Mom46opWFGGE9PwCsmC+f/Dt1fMZ
         bYzimnn4w1oIfqefWR/CnkQJg6cu38BRBTekLvtlvUyccEtrxkPOE9xJWTmMdAyghO7c
         72oa3DeknTkOZ/2Cew+cNnQ17UtwoO6XriTxk70uNfTiAWgpKKLdVbOa8bcBmDNKZ82R
         uvguu06CxYF2RiRVhKprccG63RzXs0LjQ54+bVuVfoupUqyK63Oj9Tqpmy/YzcvtzLhb
         gskxTvcXrK6bsxkDOE/1AAcZeEwoboYsfvTpNibCDyyoi1vyhSgKi4OBE0QfrAc6/M8C
         9Kpw==
X-Forwarded-Encrypted: i=1; AKwUvBy454nLgK6AQhmmA/LgFlPIrUKYp+ehNyn3FyxLPV0ym97WLbVUkfkNvxmPay/aTiCN/ja1WEDDITQe@vger.kernel.org
X-Gm-Message-State: AFq9FYJ7i5FPVkx3p/Lu+9yjzRBHoreKjxq1u+bwluFG9KEYMAYCpsLD
	aocqMwsCrjJ4SUI20xn8gNlACebJWQ4KGcJEkHnL0BU6L/DVblyzURU778n+tJzJ3YKV01k/CSD
	USh6e1mG5lI9+PkKujOtpSE3qfjfiXao=
X-Gm-Gg: AYBFou1wnK0It2CDgUoMULLZ69h4UENIvPxwXFf87JsKqBcse4JTZKicOYl8YEj9oET
	S4NdaDJ1dhAgOY4hchFPANPPTJO2fbOF6qEbRdAsHuzSELi065O4z6994VaQsmUyWmAdQXw2E9J
	HMwRHT0sDDrc/OBjjelEj2fWu/+AlaSPCuBpkGXa5FC/0LVABEGBMyqL9YDSTYhSzuDBC8KZdzF
	qoqlRkhDZ3fHI9gHiv3HTZeGfc6HzyzKpim3sQIv6bpIFJ+EShR/K47Er4jmEGj5B77az7fBDWe
	ET/blWHFJ0wEXI3mwWvh3vU+JCvciiJcN8aGR9yTvUgD+mtq1THG6FxVP3wFP53iCBay/BwN7VT
	yr+ple6nx5o82
X-Received: by 2002:a17:907:3f10:b0:c2d:c6e7:9e9f with SMTP id
 a640c23a62f3a-c31aa081161mr1927055066b.27.1792074759295; Thu, 15 Oct 2026
 07:32:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260927005821.8369-3-kaloz@kernel.org> <20261015141508.3335785-1-ramin.moussavi@yacoub.de>
In-Reply-To: <20261015141508.3335785-1-ramin.moussavi@yacoub.de>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Thu, 15 Oct 2026 16:32:27 +0200
X-Gm-Features: AclHuK-bauEgyWck2g6rl7VlsT25zTvm0S-ajtBUtf9UOJHmSrypf8ZcxQeda3U
Message-ID: <CA+=Fv5SbeHqvF3vOdb34W9h84BMa3UnhikqVt+5hU7NGd=weUA@mail.gmail.com>
Subject: Re: [PATCH 2/3] sparc32: emulate casa on V8 CPUs
To: Ramin Moussavi <ramin.moussavi@yacoub.de>
Cc: Imre Kaloz <kaloz@kernel.org>, Andreas Larsson <andreas@gaisler.com>, 
	"David S . Miller" <davem@davemloft.net>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Arnd Bergmann <arnd@arndb.de>, sparclinux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ramin,

On Thu, Oct 15, 2026 at 4:15=E2=80=AFPM Ramin Moussavi <ramin.moussavi@yaco=
ub.de> wrote:
>
> Hi Imre,
>
> On Sun, Sep 27, 2026 at 02:58 AM Imre Kaloz wrote:
> > so a C library can use one casa for its 32-bit atomics on any V8 part.
>
> I sent a series covering part of the same ground, Magnus and Adrian
> pointed me here -- I had not seen yours, so we worked on the same
> problem in parallel:
> https://lore.kernel.org/sparclinux/20261015085545.3246951-1-ramin.moussav=
i@yacoub.de/
>
> Your casa emulation looks like a good approach to me. What I would
> still need is a way for a C library to find out whether the kernel
> has it: a library built for v8 needs to keep its own fallback for
> older kernels, and there casa is SIGILL. I see three ways a library
> could tell:
>
> - an AT_HWCAP bit, like HWCAP_SPARC_CASTRAP in Magnus' RFC but meaning
>   "casa works, in hardware or emulated",
> - a system call it can probe for ENOSYS, like patch 4 of my series,
> - or trying casa once under a SIGILL handler at startup.
>
> I know glibc does not want arch-specific atomics: on v8 the compiler
> turns the atomic builtins into calls, and glibc would rather have
> libgcc implement those with casa. But libgcc then faces the same
> question, unless it simply requires a kernel with the emulation; and
> uClibc-ng in my case keeps a fallback for older kernels. So from the
> kernel side the question how a library can tell remains.
>

I've put together a small patch series that lets me build glibc and install=
 a
gentoo-based userland on my sparcstation. The glibc fix is based on
Imres kernel fix. Not sure if glibc ever wants to carry those patches.
or if I'm even on the right track, but at least it works. I think Imre
also has some *libc project for sparc32 user land?


Regards

Magnus
