Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C39A15C9
	for <sparclinux@vger.kernel.org>; Sat, 30 Mar 2024 02:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711764342; cv=none; b=qKfCMsk1zXM4RZ/aH/bfKLIc71tP0zZHb2MFJc8ww6uH4JXuDHT0C87jD0/fatwpSZ5hcnkYs9UMd6Hc4AZAjXegxL+evJbsdHtyeblxF14RLI/ZG20QAqyzAQS0T0neYzOfi9cyVvKKzCPGcSCgioDLeinW0G91EkFFXN5vtzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711764342; c=relaxed/simple;
	bh=E/jX4KlSIaa/Q8QtoYy4eUqMqZjvH5LqwLaZpzp/ucc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hZsC8VGyU3Ih5zy+3oLyWsfsn42Y/Fvx5TCa0Z3RZlOHhYDZIS7Y8NgIXCCfOtBFLMkqo6+ZSo/an7y2bUWXnu35wN+7kOZa0fFu9mSj4vAwlrib5P8x1bcpwiPc/pape2XyR1wu50Bf+ceBtBw9rMKoIG5GC0rtQcB2T82xEWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=iRVpnaMQ; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iRVpnaMQ"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5a4f608432bso1584702eaf.2
        for <sparclinux@vger.kernel.org>; Fri, 29 Mar 2024 19:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711764340; x=1712369140; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F4b5SWRCYZt8i7P0MBjW3Wz+qnk6OUO4+JznjTM8IgU=;
        b=iRVpnaMQGyOifKDMKfV4HDQhfKO2I3PqjSeGvk1BCJL2XQEgqxw6gG5AIc67e8Ex48
         MgrsqNrt6KRr8GNhnVCpn7oa/2iZGkQI62KN+vNLkBCTEfeMhw3apZHPPwq79axC8JP7
         XIcvafJRVutcxNUFOUoU1vTP7a4o3bh1xpkvY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711764340; x=1712369140;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F4b5SWRCYZt8i7P0MBjW3Wz+qnk6OUO4+JznjTM8IgU=;
        b=SLKc5kWPcCTLeAraMSov86TZShFObRd9yGTqetZvIPvz0FmiqBo7h7J1MXCr5TQnJD
         EZR+NEOOWaQrYZoNcjCGq8EwCF91h2Ejr11NlmQvr2A6B7hWff+X0Df1qRZgoL3iTPgm
         mo9LdQDrwtbqcTGsiA1H0x7Fnpi/ksG6zhaB42n6dMHAx6ZoDgIWYnAlwGNoQB7gkSOs
         yX1mkXuv33T8V5gRdn8CwozFgZAf1tlJPnXCjCXsF7yIWGvsolBfBZJ7UE+58qiE5vZ3
         XMgmCEzvnPt2cU+yo0wyLzNrziDFg4hvg74eRLPJ6RuvNoiIXJXg0K3sNmYGJwFEpvaW
         nLCA==
X-Forwarded-Encrypted: i=1; AJvYcCWYy/Gbkvxqwy92FXq33uk5UuAbvvwPQQMkfhVd8uzHxReVF/mO+PL+BXoto/ZayAeEDaEVmvO5CCwoJJkgXaurxJylsJ7V1upZwQ==
X-Gm-Message-State: AOJu0YwRX0iz+4nE7udN6VgBZM55cFMMKVMjTshxsJjRzJchS8e1ILsP
	Gqj4jJFSl8wQHgDs75/6YR/vI9ArKGdSaARtKbDV1oomlapFAyVVdsLQDwZU5Q==
X-Google-Smtp-Source: AGHT+IGZUureMcBcAiDHCXDSBEA1ISgTNfHGRDI1385rMqG8mvlZa9e/AHhEQI+LXUMGNEiBGPFkDA==
X-Received: by 2002:a05:6359:5a81:b0:183:861a:a6ff with SMTP id mx1-20020a0563595a8100b00183861aa6ffmr1969988rwb.1.1711764340110;
        Fri, 29 Mar 2024 19:05:40 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id m14-20020a17090ab78e00b0029c68206e2bsm3521375pjr.0.2024.03.29.19.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 19:05:38 -0700 (PDT)
Date: Fri, 29 Mar 2024 19:05:37 -0700
From: Kees Cook <keescook@chromium.org>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Sam Ravnborg <sam@ravnborg.org>, davem@davemloft.net,
	andreas@gaisler.com, masahiroy@kernel.org, nicolas@fjasle.eu,
	guoren@kernel.org, rmk+kernel@armlinux.org.uk,
	sparclinux@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.8 69/98] sparc: vdso: Disable UBSAN
 instrumentation
Message-ID: <202403291904.05D45FDD2@keescook>
References: <20240329123919.3087149-1-sashal@kernel.org>
 <20240329123919.3087149-69-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329123919.3087149-69-sashal@kernel.org>

On Fri, Mar 29, 2024 at 08:37:40AM -0400, Sasha Levin wrote:
> From: Kees Cook <keescook@chromium.org>
> 
> [ Upstream commit d4be85d068b4418c341f79b654399f7f0891069a ]
> 
> The UBSAN instrumentation cannot work in the vDSO since it is executing
> in userspace, so disable it in the Makefile. Fixes the build failures
> such as:
> 
> arch/sparc/vdso/vclock_gettime.c:217: undefined reference to `__ubsan_handle_shift_out_of_bounds'
> 
> Acked-by: Sam Ravnborg <sam@ravnborg.org>
> Link: https://lore.kernel.org/all/20240224073617.GA2959352@ravnborg.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

This is harmless to backport, but doesn't do anything. (The UBSAN
changes needing this are only in Linus's tree.)

-Kees

-- 
Kees Cook
