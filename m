Received: from mail-ed2-f34.google.com (mail-ed2-f34.google.com [74.125.228.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EA83B3884
	for <sparclinux@vger.kernel.org>; Sun, 27 Sep 2026 21:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790544363; cv=pass; b=tvyE/xhjgT5qFBCbjiSMNQ5hfbKBRAP9Zw9vF2bOoTRijj4KClvIQRkdkFaomBPZctd9Ho3N8I4SjwWUL0/JyO0NmXWz0tp09HLSmITFfO+SvNRAtKLW2UXSJeTibhGxt0u9iSB98LG+Q7aibixW0d1H3p++T0HNQyJ+uVIy27k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790544363; c=relaxed/simple;
	bh=OyV5qzOI5Wnnh6EHmB81OBgeAGzOyLQLRQtk4fN0xoU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bFhzYjno3wc77alWCzgFE37rvQDJrOteq+hZ3lepp/jMetljDFg2gHFDZIimjP07wJLi3fg5WblEqAF0gNX8J+qFwckN1QBNuBhtuxI7ceaBfQAaA2EHrl9+jOWV3ys18lsS+R7Q5UfNtU+zixNhY//JDIh9j88Zw23PxXFIrEo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EY9voiOW; arc=pass smtp.client-ip=74.125.228.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EY9voiOW"
Received: by mail-ed2-f34.google.com with SMTP id 4fb4d7f45d1cf-6aae7b7fe22so3998602a12.2
        for <sparclinux@vger.kernel.org>; Sun, 27 Sep 2026 14:26:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790544360; cv=none;
        d=google.com; s=arc-20260327;
        b=WEAZOr4UoCsBK1ocdAQV0cpxYgydBVsL6S9WyYP30la55Ez6aLwCZ5gbRg2Nq/zgVa
         X+KGBj5jVwnZZ1YEty9Jtwyudq+aiA3pb4ybTzQZwljP6eDY2Vog7qWAX/8H54vDhEwu
         7LGlSOe7rhhDPpAysFzXzkiDrTLMcjboENJNewECPGZVFWAYEAq6v0WgF2hm1wqGYXG1
         gF4iAIJJBz79kHR8C001tnd5mM7vFgwJU/QUb2I3wX9ErtoTPZEqb47fKWUV2kqkcoV8
         eqdOZncRwC97SF2+Dx3VMFtukSZqzmIAHDCndwlTSbwcO+4kHH8SpwTX6BxcwZnYK0vD
         Vfpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=afx6rs3MUp7cbF13CA+ODxBNiOALqRqQFIDJ9EhzSts=;
        fh=mtFiA67D+8NZT/J2MeddZVr8jPJEXDgFYsQflZB6RAU=;
        b=E+xR0M+7p7aHM6HvAqKuPQm04faabTH+zdMNCshbOlfKh9ZEd1+g05dEy9rm0EO00+
         FcGULB/gnODQXfitEt3UFx+9sxolcrG3OH19IKvIHTNSWvrkn22ZD9s+F+gaa1bqwU05
         /ncSr+njJW7I5S5NKBAuVUXUhfHhn1WR+UXLq2oL0ufkRkIO0dtbHyLsEELZNlR6Id5k
         P2Mz0eArRQZOchew+e+M6hrV6iufm4LmwykeyGvy49v8NnpUHjxP9Ans7IUQTIhvKcfX
         GTeLM9Gl5+yRpCoxPt1GLeHQfm3domBiRry1JqHHSO4qZBmA2E6yi9xKNstoPWymJHSY
         04qw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790544360; x=1791149160; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=afx6rs3MUp7cbF13CA+ODxBNiOALqRqQFIDJ9EhzSts=;
        b=EY9voiOW7q8/CSGhvbV9BmRABSJK9PMj/Uoka2WzQTQCJSE9aIcxIVTyTuJBcbCNR+
         eWZISKjZLqjE81Lnru4vaaK0KtU+MpE6amO6dBWVrJvHepGv4I/bZRuv9aBpJw8/XbEN
         y0B0abEjsSwWusMkQli6vSIQ5nrc6be+h2cjSjyDSd0gVPHHmfk7ebLG4OYhrHH9vnRI
         9hTebdPXBd9DsLkoLLOCoJQPDbuheJEhCskeDVGnIGLVbnqTDxa0kaRTnBG7YD61UDfW
         qpksxrfheFjAd+HtSLx+jeAeG0ZSLSzZ7Nn1GqniMym5vYK22gSLhfgPc7d7yyLNLbHf
         vjYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790544360; x=1791149160;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=afx6rs3MUp7cbF13CA+ODxBNiOALqRqQFIDJ9EhzSts=;
        b=VblH08pfnSZSNP+karAUnXqmh5TKHQRRN+t5rwulvcjwT35gQbphnNiGoeMRH2cQzJ
         bjXTpaqirQLwILgwY55LLWFsZEg8WvQl8yUEvfc0zz+aPo/tUMrTEYPapq/8b6r3Z/t+
         QGZKzc5kx79McQ1HnfxAmN713EPaGoTtmAktwYvQxiswoZzj8lAr7Wo9s7DsieJQACfs
         BZTNRrjRkmxxdcJPpbY6v9xzpIgaGACTfJErpAQR79Gfy0dHynbhmw//DbaESCZGCthI
         FyoeRuJd4yvyiueEhkXry5Q9+F/YOb8G3TQBJ39prPyCajUGpwT3asILGlcBB0RW6RvS
         kvfg==
X-Forwarded-Encrypted: i=1; AKwUvBwlbc2FaeFg+xezZO2jUuxEyM4v1mWrhLT5ANILJRhv6HvXGrK0q6/O0GV+9VdceRL+N2J5lGcI52Zx@vger.kernel.org
X-Gm-Message-State: AFq9FYJErbhit5mAAygiVpUP/tDIvcjWyCIl+sH9BSA2G86VfqOU+pzf
	NfNiMiSO2FSHRJ3doaFzbpKMg4DZpcSh0f7kYfefpQS5g2WjbMRUBrYi2Fr937dFn2Z7986pYKh
	bMOMKPhoD7K3ltOYuhoVsbKHgTy2Ze5Y=
X-Gm-Gg: AYBFou2MLCy12OhMouo3/Kdr43w/eSjH1L49CePRO/znYMRXpd2GMVkWC59cfFlt14K
	ZgnTr+1JLB8NEIkogpHO8qHTSwoSymolCG0dt27VUSN/IMfDgN/SPOkjgH97vqKvLOocltGzwlV
	xNntpz9lUuoSS0jk54FfjQJB+QqcRU1xUSf3ocemjjNkW1O8i+eGZzTm/rvV1ODdu2Hf9pzj8FY
	wpLAKCshDI2E+4B5eR6nyrdHIPDMDW76sYkYqNryEoAwlNduTahhzZa2fVx0rOSGi4LSVVcWbk6
	qnsnWgu6NuAngL9KrVih1mBuOJTMMW8FjlvwscczNyG37bQTWtIZB694x6twnTwedPRZhvQRnQ/
	Ry+CpzryKzen29REPduVF1YJjoIKeCqphFWHlmPlzcg==
X-Received: by 2002:a05:6402:901:b0:6aa:f260:b851 with SMTP id
 4fb4d7f45d1cf-6aaf260b9b8mr3902937a12.33.1790544359978; Sun, 27 Sep 2026
 14:25:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260927005821.8369-1-kaloz@kernel.org> <20260927005821.8369-4-kaloz@kernel.org>
In-Reply-To: <20260927005821.8369-4-kaloz@kernel.org>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Sun, 27 Sep 2026 23:25:48 +0200
X-Gm-Features: AclHuK_Xr-YU9xa7Qsr97sxtxNSM-8bhp3vLKoV0Yof9ImrfSJtY4G6awdb5GmE
Message-ID: <CA+=Fv5Qu=X0Gc=50UN37ijW7oZ35X-ASEmCWPSppkWZKUZ++Ww@mail.gmail.com>
Subject: Re: [PATCH 3/3] sparc32: emulate integer divide taken as illegal_instruction
To: Imre Kaloz <kaloz@kernel.org>
Cc: Andreas Larsson <andreas@gaisler.com>, sparclinux@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Imre,

Great to see some activity on sparc32, thanks for taking the time to do thi=
s.

On Sun, Sep 27, 2026 at 2:59=E2=80=AFAM Imre Kaloz <kaloz@kernel.org> wrote=
:
>
> SuperSPARC and SuperSPARC-II implement a 52-bit by 32-bit integer divide
> and raise illegal_instruction for udiv and sdiv when the 64-bit dividend
> {Y, rs1} has significant bits above bit 51, as the SuperSPARC II
> Addendum documents, so whether a divide traps depends on its operands.
> gcc emits udiv under -mcpu=3Dv8, including in libgcc's __udivdi3, so
> 64-bit division in user code on these CPUs dies with SIGILL.
>
> Complete udiv and sdiv, and their -cc forms, from
> do_illegal_instruction(), sharing the windowed-operand helpers with the
> casa emulation. A CPU that executes the instruction never reaches the
> handler, nor does a kernel-mode illegal instruction. A fault reading a
> windowed operand raises SIGSEGV, as the casa emulation does. On overflow
> the quotient saturates to 0xffffffff for udiv and to 0x7fffffff or
> 0x80000000 for sdiv, and the -cc forms set V, as the architecture
> specifies.
>
> Signed-off-by: Imre Kaloz <kaloz@kernel.org>

I stumbled upon the same issue trying to boot Linux on my SPARCstation, and
posted a fix for it on the 24th, same diagnosis, same saturating quotient a=
nd
condition-code handling, same window-flush-then-fetch structure:

  https://lore.kernel.org/sparclinux/20260924205646.870950-1-linmag7@gmail.=
com/

Yours factors the windowed-operand helpers into div_emu_32.c so the casa
emulation can share them; mine keeps it in traps_32.c. Either does the job,=
 so
I'll leave it to the maintainers which they'd rather take.

Regards

Magnus
