Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F344C32142B
	for <sparclinux@vger.kernel.org>; Thu,  2 Apr 2026 08:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775120274; cv=none; b=sEPWztWybEwg55duGXXlm6Pl8hKTaXox/NEEMlgC8YG6uCBqQJhfaPvZYfWi9E+CZ5ILwjJgDZykxEj2LITfvrUSR9IqHINw613PcQbxHKiP+F1gHDeEMgBw3gMHbrYo+v1OUjYHADqf7zrcoLCrlG3z/OGS2zYRoY5I7ldZ2gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775120274; c=relaxed/simple;
	bh=7tyJ0+wz5LzsOmdaY0Yimnd2RzEPrZZv3nZHEii7oEs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m6FrOcUzGDS8+w0J59q7OEME5qknuRJDkAjHjx4UYYaLsGkMBoU2XXdgXnBmRZ7vyiNVGyIn78ZZk9pT8+JdhZVzcRhdGb+BDgl8i0vY2W8OdiQ2Q4TP99bRzm8B61ZIBsYfDfVrKGTb2lCZsP6GWX5DixbaQDlLc4ScLiX/56s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N43yz0Pb; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N43yz0Pb"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso5220075e9.1
        for <sparclinux@vger.kernel.org>; Thu, 02 Apr 2026 01:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775120270; x=1775725070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LnQTQFMkaspyfTBlP7NJBNzFuL146lWNPT7LvqeL2XU=;
        b=N43yz0PbY37tKQwLI7fxz/TezjohnBPHceaTDSIHXJZ3lR+l7erEdzyuYI3/5fRC/P
         aKbwZiXH/cRosXudrYOUKNUT8TPbaLVOs6PeIW/HuQH5TsnCf4Fm5Sgo24YdKsa6ii/U
         /fju0wbiv5lfrFjides8gma93qJvGrmo2JqMyd4NJj0a7E9wY3w+nIAyjyJTMEfvk7PG
         g3zBjCmG4+hbFTu/luNZzrq8m7P9/XsoiMeRQT/rmz73FwKb6JnSjpaUqV0ZmOFNtuUi
         vKFA8PaRd5wgturtCUT32KaTz75xIUFFg4zOpfG2jjDwyipSacuYVDVzYgsXBFUpnDzh
         LkIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775120270; x=1775725070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LnQTQFMkaspyfTBlP7NJBNzFuL146lWNPT7LvqeL2XU=;
        b=T51A111q9Htw8I3whir+5u0PcpykjPusXRl6hKYxa7VX70YRkPBx34hMOrrqYMkApI
         8/u0JGhPSMDRV4O/ebb4ccdxlF+o51QJzBU9OGmWnnn4yRq0vGWRC38BV4RzB+nTo9Rj
         +KQIFA7r1z4yxGrfuPZUlb5NfZHHa2dBF/hldr62P04Odt585FLjWRfKMg1gb5N8dvI3
         6BhPmbfSSmEig8cMBP/Hv33c+IVe5Ev7rKQ6dEszZ636gUnPr2Clk0CPhi+yJfpdoECE
         kcHrRuJqzUmGeifY9Mev3EyPz3TNe5QArglgiVWOASarlIxBnyCyXEN/TZQCLVLSIM+3
         NfyA==
X-Forwarded-Encrypted: i=1; AJvYcCUZBI3W0YH+fj9b+n2GtR1xABanhsW3G67bw9E6Nf+EuFKbSGjH9UK+Ne7ZnL5kYgFhc2YWyNnb4cjw@vger.kernel.org
X-Gm-Message-State: AOJu0YyphLjTNrJYMDXpkq6OzmlSR/8b1TqQk4DniBcinue1O5SUOq9D
	9Y3bsSYHzZ8i6dDe/rIJbanLkgwsHRV9J+YwCadt2q3+TY/FYVL6a8R7
X-Gm-Gg: ATEYQzxvn9Lt+yPPGw+zhDzEAJxa+z/cpCZ7eSFrv8jwXqGRrW7oruwtfZlVrhJewJR
	OXxsza4xEKiYLSmTYdcW+WRHymp+9SkhK8sw9/5rOPP480AO5uUJZHG2EzS/HRWNkoN4kQC0noG
	1wcLAPgfFQm//dv4484xKltrUzusQMgi99G7zpFwu6NSRQUwv0MgQ8ipqCWxo3U9HF5gntcX0nJ
	5Zso19LH/E/+sd+DHvlDccVv2cMekoBKYax9X6D3E7ZJAuO/00qWyV/BcDRxCQS7qFyXz9JFsD2
	0ts4zNkNWcw/bhxnFa5VYPJmTCnrCSlrWCP6b/USSPOc4Ahc63qjNNiy/iA1ZBi10pr6hi4j6On
	hQO+GQXw6mdOtxnTnrELlNIl6Y4mYhikbJscCxz60AKs5C7dJ9JDi8jB40sVO2eyKY/3ifhPFns
	Zpn5qJA+vSnP6DovrtF0s8rrS1TN8D7AH4fph6ZM37TWzT48u9L8TWqQrFYBBa
X-Received: by 2002:a05:600c:630f:b0:487:288:1198 with SMTP id 5b1f17b1804b1-4888359da58mr102555095e9.22.1775120270131;
        Thu, 02 Apr 2026 01:57:50 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e735532sm217845265e9.0.2026.04.02.01.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 01:57:49 -0700 (PDT)
Date: Thu, 2 Apr 2026 09:57:47 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, Matt Turner
 <mattst88@gmail.com>, Magnus Lindholm <linmag7@gmail.com>, Vineet Gupta
 <vgupta@kernel.org>, Brian Cain <bcain@kernel.org>, "James E.J. Bottomley"
 <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, "Christophe
 Leroy (CS GROUP)" <chleroy@kernel.org>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Yoshinori Sato
 <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, John Paul
 Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, "David S. Miller"
 <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, Thomas
 Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>, Max
 Filippov <jcmvbkbc@gmail.com>, linux-alpha@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 linux-hexagon@vger.kernel.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, Jakub Kicinski
 <kuba@kernel.org>
Subject: Re: [PATCH] cmpxchg: allow const-qualified old value in cmpxchg()
Message-ID: <20260402095747.6efbd456@pumpkin>
In-Reply-To: <20260402-cmpxchg-v1-1-4561e2c05d2c@gmail.com>
References: <20260402-cmpxchg-v1-1-4561e2c05d2c@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 02 Apr 2026 14:56:01 +0800
Hangbin Liu <liuhangbin@gmail.com> wrote:

> The old value passed to cmpxchg() is semantically read-only: it is
> only loaded into a register as a comparand and is never written back.
> However, the macro currently assigns it implicitly to a local variable
> of type __typeof__(*(ptr)), which triggers -Werror=discarded-qualifiers
> when old is a const-qualified pointer and ptr points to a non-const type.
> 
> To avoid this, let's add an explicit cast to __typeof__(*(ptr)) for the
> old local variable in the cmpxchg macros. This explicit cast suppresses
> the -Wdiscarded-qualifiers diagnostic.
> 
> The new value is intentionally left without a cast: new will be stored
> into *ptr, so silently accepting a const-qualified new would allow
> callers to store a pointer-to-const into a non-const location without
> any compiler warning.
> 
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
...
> 
> diff --git a/arch/alpha/include/asm/cmpxchg.h b/arch/alpha/include/asm/cmpxchg.h
> index ae1b96479d0c..b4b8dac759c4 100644
> --- a/arch/alpha/include/asm/cmpxchg.h
> +++ b/arch/alpha/include/asm/cmpxchg.h
> @@ -234,7 +234,7 @@ ____cmpxchg(volatile void *ptr, unsigned long old, unsigned long new,
>  
>  #define arch_cmpxchg_local(ptr, o, n)					\
>  ({									\
> -	__typeof__(*(ptr)) _o_ = (o);					\
> +	__typeof__(*(ptr)) _o_ = (__typeof__(*(ptr)))(o);		\
>  	__typeof__(*(ptr)) _n_ = (n);					\
>  	(__typeof__(*(ptr))) ____cmpxchg((ptr), (unsigned long)_o_,	\
>  					  (unsigned long)_n_,		\

That looks like it loses the check that 'o' has the same type as '*ptr'.
Maybe this works?
	auto _o_ = 1 ? (o) : *(ptr);

  David

