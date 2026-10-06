Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8693C769F
	for <sparclinux@vger.kernel.org>; Tue,  6 Oct 2026 07:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791273573; cv=pass; b=r2IPcf37TZcnCZJ+XkL5iThQqJp7BXhDWg+iwtUd1S1/+mZoUQevjxfEN0EYkXC6MyRV1v27o9kKKFQyGRzbibKEmrGo2rZaK2X9y1Oic1imLh8uSDRO30AlzRqw40328plc8viYiJPlHmH96hw5T/BQkvL2uEvfu3JTttrfi2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791273573; c=relaxed/simple;
	bh=ZU2cQMmasHr1yoJwdZJaMEya/Sh1a70VvSBGFfdNluk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u6HK/T0CaiGcGrB8WVogNYKAS+j6iOemM8K8gs/bbcoTLWm54ufIyqyaNhAm0hZ/QFilGmRWfrcYd7a7qbOapmY+FqAY0PFQUeivYlzZ8qjrwoaovDYihnM031Xiaus6qoEJ+vtGgwiq7u0xZu5ZBabW+AHx34+f49V3gEPisAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IDM3Uevr; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IDM3Uevr"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-87005a0e052so4143957b3.2
        for <sparclinux@vger.kernel.org>; Tue, 06 Oct 2026 00:59:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791273571; cv=none;
        d=google.com; s=arc-20260327;
        b=ScWr3lEMpAjMPyKfL30q8LW/gLxPI43h39Om7l8scbz99ezZaSdvTErRmdZN0xutL8
         QVCp7hdEdbGpFoghesPmW8MegoIxNMVi+6ya6n9agtyQ+H6xBz9/jKeksPnWyJkZ+Kzg
         WFMn394cZ72/TVYKp7DIhslJD6h3VTGZXk5QLJcd55OnJ2Gk96//iE65tPrwAzPRsFEj
         r40Lobmot7J81rX0jyXHxxEre2mbOuiF22TsnH756efInhCQF3j7ukRpDrlCrHVcTNWG
         jPE02BZC920Yf676108dRDqqBZaQTdlfq8XiHwSu6SucsyJwRruXES7HvCTutEl5P4xe
         +/Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=fRhb1dHMtjLWIFI+yLicxW3PUFK92vbcjg4NpaNjie8=;
        fh=p/ooqgt8XPwicb9FxoNZvPAFLge/yTOk1Hp6rZjPaYM=;
        b=G7NL34e65wlMtretdjIUBzm1CnGom78XOjHpm6pExCho5FBkCnPt1RVG5dYQqqINEF
         h7YamlbP7XEGwYZPqVe3e1mtvGaCBOGFaRf8peuzqP/YVt713CqR/ciigXchxzTNFqyl
         K34j02V81Fwa6R/sIdS4dO+R+cd7hyTUnf2yScAkvdfHQG05PxwKwbXp8JyrIMN0W1+t
         qcjnwKMNv2kSP0/Odre29rbtUjkiwVA1D12YYjU4v4pj93wyHB4arN+Ix2p0pW1V/F/u
         MmhYYBYOfAyPNqQmqBr4doskA8I8zIfmmRXcxK8Forx1ei+2D3m9kgURC7eJdiyZ/4ps
         sPng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791273571; x=1791878371; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fRhb1dHMtjLWIFI+yLicxW3PUFK92vbcjg4NpaNjie8=;
        b=IDM3UevruLW8wL5ahJL3Xl395wiGZ332KWncqlqlr8h0sNZ+wh96dxk5Kp8vssP8Mf
         RZUZneqnaBIyUmKxSmDmkngTXRhvEeI/ih0zD6YfiUQJc49LUE+izd6gc2gmHbGBJD0/
         67eoT7HpWnsnM0TkBP109jvTioqtq2gkIS8njCpud8dJbqicChqdMzzU/4L8pBeaH9ch
         VUx7b8CLt3pMwhiefeRdhURXu01lXNjVvAyXZ+60N3mhS3be8x/6RhzgcMS148B9HYHc
         eIfX+xlh3nkfJcyvZWovQoRF/+uxToKVvwh92r2hG5tDHSgLVlAIZRHr+cE2TUvYiydy
         rNFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791273571; x=1791878371;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fRhb1dHMtjLWIFI+yLicxW3PUFK92vbcjg4NpaNjie8=;
        b=PODwzr2OCNC7oK0b8UT0AXqVkwyhUuIsC8BbR7sTgQn50tCoqH00N39R3ETLjPZonD
         wAN2JYBD3zBW4Y+ekOmL46t4qwN7Rnkmp4D4DmF02U/pNdvuBrUzL6FsUBmhchkuW+60
         hsXJVCM6JnXW5CCH8ZndQej7Vsb78jAqe/o4eQHgMyf5pWKFqpZ26ecAlguSmCz8Zikj
         jTRAJ/JpCItQqnoq5TsA0mZoCVHahcemg+60i87+kDx3iFzYBMGuOpL7an1nJJStywQK
         guB9VQB2yM8JmRdwBR3OuTZAa19o7dtptspLKrvHfZfOgcUQeSQ8sxu+zKNngZ1LIMY5
         7R/A==
X-Gm-Message-State: AFq9FYJLBekYydPtPhcmRYm2SWtnMhnZXjZGDersApGCB/sfbWGS74wE
	kW+8eSErNP7jvMYlXFxjc+Y5AYOM9RyMB+3H5uQJUU9JN6qTo6tGsfjvPNlG1v/hV2RMDRuC9Sk
	i9BilP2M7Ko/6mAgQKyhrN+H+OrQWnWk=
X-Gm-Gg: AYBFou2CKhXlKnPRuaY5g4McE+lxmt1cSW5QdTe4u72zkAkzptUCA22rkYskWoEHCZr
	IeQdYRyn7AozBxseWQlt5i/z6VeQI9493Ol3Qv0txjkPgeQtYODQkOq3m/BjuVYwfUdW5GFnAxk
	GKpEc97oM5A4iyrJhpMCbD+msPlYD/3iLA8uoGRGKpLI70OKo7D6WbEUgIAGzuuFp4Zbj/aWdMy
	75iE4kKWfX+QNjs6mo2VSNwyTn4rVY8BglFFYBrKp7yKjJoj2eQZTXR2stM/GXWhcDe0DckNsti
	CJbw+et64YC60d60yoJkd5Gu/jjnUgtr4XcqF2/u0eoAvyxuH8oDpahrH7J9yhp5+zBTaXsa/PK
	AtwPcZ7Z+Dezjj9+xkYVdN9I8QtFcdk8QWnuKzA//qNrngWcZSezoX8hrEs+ZrVHmL+j0x5818n
	g024VM2BdfNbwTpPbGn7iqOiYPMT4u06Ay0e5Yz/XgFu6sjsgd8fw=
X-Received: by 2002:a05:690e:1407:b0:677:b426:5072 with SMTP id
 956f58d0204a3-678fcd9a7f6mr260069d50.47.1791273570848; Tue, 06 Oct 2026
 00:59:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261005203930.246598-1-rosenp@gmail.com>
In-Reply-To: <20261005203930.246598-1-rosenp@gmail.com>
From: Kjetil Oftedal <oftedal@gmail.com>
Date: Tue, 6 Oct 2026 09:59:19 +0200
X-Gm-Features: AclHuK8uZPRVB-V-7veiRIMf2yGygSpvVmN2QjDCYDa6UJqn_IrMh2dWc_mXHWU
Message-ID: <CALMQjD-udSokCKS07VFWauBQzac5BTPJqbORhskxgddsuX1vLw@mail.gmail.com>
Subject: Re: [PATCH] sparc64: Define p4d_page() instead of stubbing it to NULL
To: Rosen Penev <rosenp@gmail.com>
Cc: sparclinux@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, open list <linux-kernel@vger.kernel.org>, 
	"open list:CLANG/LLVM BUILD SUPPORT:Keyword:b(?i:clang|llvm)b" <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

On Mon, 5 Oct 2026 at 22:41, Rosen Penev <rosenp@gmail.com> wrote:
>
> A sparc64 allmodconfig build with LLVM fails in vmalloc_to_page():
>
>   mm/vmalloc.c: error: performing pointer arithmetic on a null pointer
>   has undefined behavior [-Werror,-Wnull-pointer-arithmetic]
>
> sparc64 defines p4d_page() as NULL, on the assumption that it is only
> used by stubbed out hugetlb gup code. Generic code now uses it in
> vmalloc_to_page(), ptdump and KASAN. In vmalloc_to_page() the NULL is
> used in pointer arithmetic, which clang diagnoses even though the
> branch is unreachable on sparc64.
>

Has this been reported as a bug to the clang project?
As it throwing an error on a rather obviously unreachable branch.


Best regards,
Kjetil Oftedal
