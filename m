Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FE527FD76
	for <sparclinux@vger.kernel.org>; Tue, 18 Aug 2026 21:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787086918; cv=pass; b=EjsbZGYjCovBCThI8qquYEiqYuJowWgl3i3zM0kpZDEI92VTIecMmk93ysMzY2+7L15k9AXBhAWAIzXrarNnSuyLuV0Czk9K9by+ZDcjnhSygqr9cjj1utNjEDwa32AkzRaM+4m43o1tQ5ds6fnZNuKasY/C3Elmcy7B4pFKROs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787086918; c=relaxed/simple;
	bh=UcBJCcg9BvbiBnPhJGIOcwbQBsHSavE4kSVYtQ1d5Zk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IMjejjard3AHBLzg2/CIRlhZTPgVE4qvzmwO/qWp3JjgmEoCERKAjRrL63cXf4J5lnvZBERHTFh50yF9s1/TaO14rdlU/BrwcA//noyrVWCUFMtuLqm/QBaoIgHIUozkF6fJMkJt4/rfteidUPc3B7q403RRqO6wAxCg9Urts40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZpDRzO01; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZpDRzO01"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6a10b20634fso600363a12.3
        for <sparclinux@vger.kernel.org>; Tue, 18 Aug 2026 14:01:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787086915; cv=none;
        d=google.com; s=arc-20260327;
        b=JS3xHJSFFyY8WZJkN2q1eqRZLEQs7ym4lieYyYPvtqeEhgR6a9QN/28nscP8YfFHqc
         CCknVXNyAxHavxSm6BwSpTg00Hl/5avXcQLNq4+YvSky6MWknsLUcrVirdgNS0UVqjbr
         Y9hS3qXljEbEyTNNaJeUO7oB68Opmaz9Kcpb55wI7Gnb3mhJLm55Pb17YGNRxee8r8xc
         esrU+ncQcpS5sR2xuqR1rYTRZuxUKVsQ82tx0wEfM7pUzewvmVQe9zo4cgXAGYlYYcjM
         HoMd4KF4pT3kqWFVxES3nTPP+iB3bjqU73x5hHoKj5qcujywek9uSOuCVm1x70vpSlPk
         T05w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UcBJCcg9BvbiBnPhJGIOcwbQBsHSavE4kSVYtQ1d5Zk=;
        fh=BHR0yqGawlsQnGja8KWIfS8G5+wJKbxPnJCTdu2hb90=;
        b=Snpo8hofFYxbqzTQ9h60ezzLKNDFZ9DSygU8hsPUUaTrUCKJFudsQZ6UPRWpNgtihK
         dygjPbr6KirSje5A2bh94Jw0yXEXiYIpZFnEXLoNJkqkilFmUGLVc+BKXvEGJWE9jaCP
         JbRD0K/3a6n+jxlQsp48jesyqXMbF+o968qByLu84D1XdIvC0SDIIMXWKLILIvwyKqhy
         EmCnGm6ikujpi5lrxnfDEqkWolpnKCT9xlnJ/DPutZWd4jgbweNyEVcZm7VyjYgueRPe
         ZKnuyLPDVLlSmq0+2/L23LxL4dT8sq+pab7IoMLcnYEp/lYKawfQ0r5KIClZV+mMYlci
         1Unw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787086915; x=1787691715; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UcBJCcg9BvbiBnPhJGIOcwbQBsHSavE4kSVYtQ1d5Zk=;
        b=ZpDRzO01p+6E8F9nkRKkhAp10uuzANaLgdJfAUFffWPwHgTGK6M9JRuzcF6hbN7HjR
         D7cCYZJ7b0aTtRWrJ4G/DBERQjA+Pmn/foxNtsR+W1HbAT2pgy6GdMsNBaPz9V2Z1Vqn
         THLdKILXerOKYN+dE5/4Cgk5lyb8O2BGFgTgrbsL3Hw/j7bIkyrPNRv36FjLtwl/eaBk
         suJWlAys4R9KplpNSNZdWz8XijLclp2BDTAesztLjCEawm0WoEaA1/idbBPLAF2G0KWX
         X+7+8VJBW4A2yPLIvUBfIzZo6vVQsn782YbjXrSJXXWLisPFki+2Z7nUnxXC2vL3Uq5I
         e8ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787086915; x=1787691715;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UcBJCcg9BvbiBnPhJGIOcwbQBsHSavE4kSVYtQ1d5Zk=;
        b=B5G5x5TiNoVBthb1nCTpeyaezyJlfhJ8o69G2GyVhSrQg7qgJbxmZXM1kkY83+OiYz
         a3m3DvqBRvOX3YnK2V6G/AEhf9CtLmWhQJ7CF9PncQWOkJP9zc6hLKU9GRE2peOzdbCu
         7gPyEm98RcI4vgfeledXP8zu7+fqwc6w3iBHMqCjsyDZzF6eXKjzXogre8yyQ1CsY2LI
         a/5b1cXvkgnjoq+fNHcXG6Z7J1yHnyujYWKsCU43/glOx5o0tbeC+L0bqk3dbxW22YGx
         sZe484FZN5AFKHONqo9Zy4f08uKHilyRNAEAxi3foAxgjUyCQVkvxtLIA2ZC6JZzSr4C
         cPxw==
X-Forwarded-Encrypted: i=1; AHgh+Rq4bYFXfkI4n7gBt0WR0frunH5MiJ8n4JaLiC1o61e4u1EyU0ZX7XMU0pCI0nxwC03QAvff/GqrjAV7@vger.kernel.org
X-Gm-Message-State: AOJu0YyZG8uptXF76IxBDqUT1JZ6npHz9yXsb6MEdSdIo2FJmfOxgoSA
	UfT6FnmqmoRD/i+x5dWJ1nu9jttSAz10j5v/6tgOOTgssSmKY57TkeH+XZX63L3WamBeQCDKvcA
	yTRC7Rv8H1+FwufdEhfx9ISYoEbYbM6Q=
X-Gm-Gg: AR+sD11hrf93H9UnnGMj0QMnWWZU8t3cj9ajs/kjfIb3DlLwxBbYuE/cnVFklKa1R33
	8Tdoi7JjcN1YiUX+8G1KH2t3HtaseqPzU8grZwGL+8v5KPbyhhj4qXlFg44m7xbfGXMj/2Govzh
	8LuFuVhabWKPr5bX+3NdLZHDBdQBGlaljQM+iURxymUZM70XDQDOoVSlxBRsk4y1CwZFYQflj75
	d6T48SqIwk9LsHpPAujnXV3WJgwYw5czKzo3S8gurlJNvbA/Qzko/8YRr+lCU+HtD3jYadivbab
	11DX1Xc7vk+12aOsV6Me+LaVhyEnxLrGFlNAVhh9uASARw8zBniP3e/iruiMHH1/6Z+fDWyucKW
	/wWtiIMLvV5420NXR8fLSroPpt25BnBspzTmw7dltUQ==
X-Received: by 2002:a05:6402:454a:b0:698:c13e:179a with SMTP id
 4fb4d7f45d1cf-6a3fb76ab19mr444244a12.10.1787086914737; Tue, 18 Aug 2026
 14:01:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260816075141.3489194-1-linmag7@gmail.com> <20260816075141.3489194-3-linmag7@gmail.com>
 <20260816195456.GA660273@ravnborg.org> <CA+=Fv5SfLQo+LMoEH2gtmuuw814hjcjfnd551E7Og4t=JsFWug@mail.gmail.com>
 <20260817153237.GA702187@ravnborg.org>
In-Reply-To: <20260817153237.GA702187@ravnborg.org>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Tue, 18 Aug 2026 23:01:43 +0200
X-Gm-Features: AcwNN1W7ErqK5ZB2H9xGzmacfU1cyUJYCCJWcAgF6T19GjTEH70gstuV4fnQ568
Message-ID: <CA+=Fv5SFHk+1TnRbVSJkR4KggLwDE38-ScS0noWh0683LF46aA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] sparc32: derive phys_base from the PAGE_OFFSET mapping
To: Sam Ravnborg <sam@ravnborg.org>
Cc: davem@davemloft.net, andreas@gaisler.com, sparclinux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sam,

On Mon, Aug 17, 2026 at 5:32=E2=80=AFPM Sam Ravnborg <sam@ravnborg.org> wro=
te:

> The patches are likely online somewhere, but I found the relevant ones
> that I have attached here.
>
> These are from the middle of my sun4m/sun4d removal patches, expect
> parts to be missed out and for sure they do not apply in your tree.
>
> I recall they were tested one-by-one via QEMU, but I did not test on
> real HW.
>
> Feel free to claim full authorship on patches where you do anything
> than trivial edits.
>
> I hope you will have fun working on this.
>

Thanks alot for taking the time to dig up those patches. I'll take a closer
look and see what I can do. Having the patches as a reference will for
sure save me some time even if they don't apply cleanly as-is.

I'm sure I'll have some fun with it. My old sparcstation has just been
sitting around lately, I'm happy to be able to make good use of them
again. I'll keep you posted on any progress.

Magnus
