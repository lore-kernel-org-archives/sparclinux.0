Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFBF14F9ED;
	Tue, 11 Jun 2024 19:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718135460; cv=none; b=Vvfkl/FBGR7gQYv5hw67/17JxhR4YGTZjfoITQFtxXcv+794chlCU7XgR49L7NkM4ln52mzhxSMIDvKwGuWJZmjgINiNYQH9rQaFjU3mCLGJWgqAb6oz3qGdPA8lN/p8ihQqL0mS85VqLvJPKkBwMSBD0SopXXeqCvlzPNBTM4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718135460; c=relaxed/simple;
	bh=TrgoARjs7ThYWQ1Zax5XgzNUc6x1JMOv/8bIggoKkyo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MGHKKVkBp0tYaAyFZiNl+TbUpIInfXoGZYYqK8f8bpJmCb6YqwdFs99+Zdx8kwlKLOpMjM0NRkk+nZ7Ct9rjazDgeyZKwqb7jnbgYNnpS+eEdLEPS8VWEu/97f6HoWykBrmbx1VYOtrdulrxdkmQpxdBVYf2XYPI1EHXuysOJAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52c84a21c62so3234458e87.1;
        Tue, 11 Jun 2024 12:50:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718135455; x=1718740255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7eXZ8+T5QNNII5GeGoRAsMrF7X6NWE3VbH6k9q/af+g=;
        b=UltwJOCUOmza9Ewmv00X0SKViFajiCyilS5DbuS2ucj0BF/9IE6BHCc/wBABM50p3V
         dW1GKjQjGdljuDLUP1WdukLnPbUFInoNCc+XASxj4E9rnjMbXBCTiczvvgVIIQqmOprU
         rBsgEr7GMVpg8Oa3Ib9tf+XpzOZd4jTYoqQKCDLoyRX7KNi+DLMFe2KbJcASg1rX5567
         8oVb7K2lv/gcVi2EACELcII2/+DWwg6G1NRSotrbQRqQUzgIA6G1vSDdnJzqWs4K1yCX
         6jP7kOOUmfunXjT4T6ru8LZYTKAbhSuknxDncqqHF4zEmvMfQmUGBrZbq+xacI3VzJMj
         AHmw==
X-Forwarded-Encrypted: i=1; AJvYcCVJ45uLCYB+E+UajH4xyZit/FC7sh72Mn1Jys+Xtrn+eVcJU9NWIzZqTiO4V/CEXa+cVyIpZt9uykFt1kXccsRiENSDU0qENVQkyDtDLFqtcC3uN+DPuIwWZwlmEdHgI4BNFunqNTrVQw==
X-Gm-Message-State: AOJu0Yxnvrjwj5B+ODFG7YKYtZzwWNIiSJ2EUMgEKP9AHplc8LJcfxaZ
	uAgVkbOwQ8JcP90jCubNkVQyK9O8457511LSTA7m/ckEF+8iNEWwuLyTHHfGEUs=
X-Google-Smtp-Source: AGHT+IHbfvOLQbzltn9ppiEf4S9LdE6FO/nSopWZEZIOSQbGhM6/qe/9CWsh0eqbtGVlZZzwZOWHlA==
X-Received: by 2002:a05:6512:12c4:b0:52c:8a12:3d3b with SMTP id 2adb3069b0e04-52c8a123eacmr5335573e87.56.1718135455348;
        Tue, 11 Jun 2024 12:50:55 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52bb423db88sm2216098e87.223.2024.06.11.12.50.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jun 2024 12:50:55 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2eaa89464a3so65978871fa.3;
        Tue, 11 Jun 2024 12:50:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXaOPdF/oqFBuLDEgyyeuqNIT/4PZsLTSDJeFHkSD+jG48lsmY4pmMw9wxMkW1AURNDS/32MuVOlH+qLN2DheYnaNlAUpkfOebPIMUEYVF3sBHc78QjcW5frg3budzihFHI6Gpm5tiV0Q==
X-Received: by 2002:a2e:b889:0:b0:2eb:f8ae:1cb0 with SMTP id
 38308e7fff4ca-2ebf8ae1ce0mr12433271fa.37.1718135454888; Tue, 11 Jun 2024
 12:50:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wiK75SY+r3W5hx+Tt_bjhcSKPLdji-Zf_8HjikRPbn9wg@mail.gmail.com>
 <20240610071049.933142-1-geert@linux-m68k.org> <46c5a25-ea8c-4a1-5241-df88a9848a9@linux-m68k.org>
 <20240611173739.GB545417@ravnborg.org>
In-Reply-To: <20240611173739.GB545417@ravnborg.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 11 Jun 2024 21:50:41 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW__Uak2qkUAJc1b1eK1nOzGy=+cneRrtmj_QgBTanK-Q@mail.gmail.com>
Message-ID: <CAMuHMdW__Uak2qkUAJc1b1eK1nOzGy=+cneRrtmj_QgBTanK-Q@mail.gmail.com>
Subject: Re: Build regressions/improvements in v6.10-rc3
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Andreas Larsson <andreas@gaisler.com>, linux-kernel@vger.kernel.org, 
	sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sam,

On Tue, Jun 11, 2024 at 7:37=E2=80=AFPM Sam Ravnborg <sam@ravnborg.org> wro=
te:
> On Mon, Jun 10, 2024 at 09:28:25AM +0200, Geert Uytterhoeven wrote:
> > On Mon, 10 Jun 2024, Geert Uytterhoeven wrote:
> >   + {standard input}: Error: pcrel too far: 1095, 1074, 1022, 1020, 102=
1, 1096, 1126 =3D> 1074, 1021, 1255, 1096, 1095, 1020, 1022, 1126, 1254
> >   + {standard input}: Error: unknown pseudo-op: `.al':  =3D> 1270
> Hmm, strange..

Just in case you missed that: these are not SPARC build issues,
but SH build issues (gcc ICE).

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
