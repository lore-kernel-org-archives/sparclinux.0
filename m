Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDE9394493
	for <sparclinux@vger.kernel.org>; Fri, 16 Jan 2026 16:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768582039; cv=none; b=ZcDdkwmKs0nO0vhq5anoanapotn6+p0DfWcIFk3sHaFw92zY4+JJficg4Za7JTF5JtY40S7LfJv3QDgRWsRO+z95BqV7KtBszjqZ1/zeA+s/NCq+hD1V+FSWo/TW3HxMyOUoI0FzxZ1EY1rgLdp+6Ub8tvMXcHdibG763cdlCec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768582039; c=relaxed/simple;
	bh=+Q5MJCj4TVd4LpveiwsjRWBEpJtCsPIHTEKopKSlucI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GPIrdpYxJYfer+WX9cuq7H/3QAjAcHykU26UEwaY2a/bzV57TldfmMaUpR3+LB0WTyhuaShhnv9kcebgjJoN8Z2n+ECuDRnsK+k/s+Z0Zq8yJ4Vvwqenz2kC9RhoEZRIC55nTgevhAckvA7+7g17XhnvEBSShwdBaEUtp3qCHYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrtc27.com; spf=pass smtp.mailfrom=jrtc27.com; dkim=pass (2048-bit key) header.d=jrtc27.com header.i=@jrtc27.com header.b=WPtDGPHr; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrtc27.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jrtc27.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrtc27.com header.i=@jrtc27.com header.b="WPtDGPHr"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47ee76e8656so27147045e9.0
        for <sparclinux@vger.kernel.org>; Fri, 16 Jan 2026 08:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user; t=1768582037; x=1769186837; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kJzgUKOJB6oCUo0JSuCqlChu8wca/s3XgI3abK0Mh6I=;
        b=WPtDGPHr3jwkYBgL7DEwh5KiVuzmiqU1JR/yHeVw6iJDr5bJcFt2WBz/IvsDv6t9gV
         wQRgWVAdpndKN5GwVOC4SD6LJvSrrCO3i20TGkUr8e18OlcmSspBgLWYJkjgisoT9qZb
         oDVESTUyfa6fZj7DIdwFsmLM0Qky9wFebsIXcbJ2TIXbJmixEIuOJu62PK8bBHIHO3t/
         6o6iRct81O58wfUtDnsJcOcitRMrxbEkUwe3Fs3te8cDjPJdwCMQE+Nts0mbfeaP/6H+
         r0jY7YbCQYGqzwLPlEZT8GaU8mrkAFYoN+D3B6iJLPa63SG/2NaenLq731/UJVkRAeLX
         tLug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768582037; x=1769186837;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kJzgUKOJB6oCUo0JSuCqlChu8wca/s3XgI3abK0Mh6I=;
        b=tjbE9FnvwFWDRpzzNbbGEU2ogT0CL/TpS0EuTJBjaOOd6S/rqkSgBjms3QB80S0uYL
         C91Jo3gP5DtR3UWectYly3sCmQiVFCUPDgZQ8iSKNmHF+gPTalTpRk+5A7dsIJrgFuAw
         rhRYcT8g8VnMG9o6To9NIrll8RlATwRzTIR2tZLgvL8L4QFZQLj2yUh7xrwNGNI4Sx+e
         oww8/S7Rl5veQju7Tl8L25P3SGJLO7T+uJJVuzcN+05Q07HsCn6VjLAmyeiFWAHq7Qrl
         UGZ8qLkUWcXOrdPt68M7jkZzcQQ8dPuRpH+4MTHdHVBJo7SLDGgDenmx1xvBWlhoow6G
         V+6w==
X-Forwarded-Encrypted: i=1; AJvYcCVlSpwXjR7nR0yYoDCW0p8KZK+gl4xIGPZZesDWk3s4cQh3b8xvOoyg13jiiZSwqBrjFllU7oxI7aOo@vger.kernel.org
X-Gm-Message-State: AOJu0Ywattr2ElkG0mNqMWDxpuyluf4rgLZ+Bv3hsHmeSjODhZzMHtek
	TKKmrMTmjaybE1rgfozb7cps38PvZBByFRTgHl+rgZ4zDMXisFPqjEsIkHKOecrpGdw=
X-Gm-Gg: AY/fxX4osPJh2eF1tDpYwIpoNA8g0VuDoxULGR8hPczsnqSbv3842WXiCouGLaxV4D9
	ZOEH+xikNyKz5A1yKy3t9PbKCtPQfRbGm06YLRt8axs4gcwxpgqWoprJ6b4qozl2b/jI07AIjz7
	gyiQwLATLI+bvwNrPSFs4kLf/qcAOUGCN8mLnU/0aUcp59b/cUs9JAQhblAaDGLkjQQ9atvC8K3
	sw3r4kgYBW7cLLLg8In5rGFmfjdqZ3cTHtns/zKYeJy/fvN9KyoWypmvSSoaDWkhskcD7UttmST
	WhFzHwkwEZ67UJyJsI28rID1oiRgZ+l6y2EN0k3N9GVWKJnqQ0leLaSXglFoWAorH8Xm/glcj5G
	SYJ4E0UFZU8AzMoIb2Gkr3rJVLneVHInAysepmD4VKowsRgEgQr+fqoLH8mzfbXovMEpqm0sCaR
	SLupt1x29V+H/gkC+qGhw5ROnpn6DsNZXLm9TteWsCplfai5WsdCci62OLD/GjU4F9MsMmarmls
	xzrgkUySyQ=
X-Received: by 2002:a05:600c:8718:b0:477:76c2:49c9 with SMTP id 5b1f17b1804b1-4801e2fb9e5mr46263395e9.2.1768582036182;
        Fri, 16 Jan 2026 08:47:16 -0800 (PST)
Received: from Jessicas-MacBook-Pro.localdomain (nat-184-7.net.cam.ac.uk. [131.111.184.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801fe2c04bsm19443975e9.8.2026.01.16.08.47.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 16 Jan 2026 08:47:15 -0800 (PST)
Received: by Jessicas-MacBook-Pro.localdomain (Postfix, from userid 501)
	id ABF0710FE3389; Fri, 16 Jan 2026 16:47:14 +0000 (GMT)
Date: Fri, 16 Jan 2026 16:47:14 +0000
From: Jessica Clarke <jrtc27@jrtc27.com>
To: Ludwig Rydberg <ludwig.rydberg@gaisler.com>
Cc: davem@davemloft.net, andreas@gaisler.com, brauner@kernel.org,
	shuah@kernel.org, sparclinux@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	arnd@arndb.de, glaubitz@physik.fu-berlin.de, geert@linux-m68k.org,
	schuster.simon@siemens-energy.com
Subject: Re: [PATCH 2/3] sparc: Add architecture support for clone3
Message-ID: <aWprkg0fRoYQl5DP@Jessicas-MacBook-Pro>
References: <20260116153051.21678-1-ludwig.rydberg@gaisler.com>
 <20260116153051.21678-3-ludwig.rydberg@gaisler.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116153051.21678-3-ludwig.rydberg@gaisler.com>

On Fri, Jan 16, 2026 at 04:30:50PM +0100, Ludwig Rydberg wrote:
> Add support for the clone3 system call to the SPARC architectures.
> 
> The implementation follows the pattern of the original clone syscall.
> However, instead of explicitly calling kernel_clone, the clone3
> handler calls the generic sys_clone3 handler in kernel/fork.
> In case no stack is provided, the parents stack is reused.
> 
> The return call conventions for clone on SPARC are kept for clone3:
>   Parent -->  %o0 == child's  pid, %o1 == 0
>   Child  -->  %o0 == parent's pid, %o1 == 1

One of the benefits of having a new clone3 is that the interface can be
made the same across all architectures*, unlike clone, which both passes
the arguments in different orders for different architectures and, in
the case of SPARC, has this weird return convention inherited from the
SunOS syscall interface. Is there a good reason to deviate for clone3
too and keep this annoying oddity going, that requires special-casing
SPARC when other architectures can just syscall(__NR_clone3, ...)?

Jessica

* Even Itanium's clone2 could have been subsumed by it, as clone3 passes
  the stack base and size rather than the desired stack pointer
