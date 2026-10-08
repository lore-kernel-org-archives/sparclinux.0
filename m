Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D4B3D093E
	for <sparclinux@vger.kernel.org>; Thu,  8 Oct 2026 19:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791487784; cv=pass; b=COkCfZW4Ziy7IiDfzqSkBEmqhzt+kxXUAPtEYji6sLAvHsS/qIgz2zOP1oE3VgGEeCc3heutATid2rW1vPFCQe6qyrUnZ2UXtdJdv1XSm1dKNujzWTXpdZpmcgHMqY6m3ZMEXWlQaUIaCaRJWSKeKg2OiWTkbbjpu9vm/bYY3XI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791487784; c=relaxed/simple;
	bh=bH3Ys777xJyJceuaHq+fKZvqaHs2+JI/CEfT6ut+TY0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e4Gd7jR6lJDo0OZjdMX6BVjq5ehMZ9cx3IQcgCvL26xT/YdsOJojumS2CcERX/APLzYiulnKpdr2VxSYiX2rYb81GT6RSb0oS6qmbyqP/y+AFb4fJJmR0T9zsHLn7OI696AogIBfVuCvFIfj2z8aoT86+7vCqlMdx7C8MWgRpyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wn6s8tb1; arc=pass smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wn6s8tb1"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3a9bcdf29a6so5290841fa.1
        for <sparclinux@vger.kernel.org>; Thu, 08 Oct 2026 12:29:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791487781; cv=none;
        d=google.com; s=arc-20260327;
        b=scoYdATC3X3g3d55SlBQzge7KZr+ZxQUPSgYf2JsNrmXXrBRoZbR/2aEwxRWuJuPyz
         ALw0qGTuI/8NDArux7t6VtPHW31SqmwlxV5fjrk1YAw7mrStuHE7X3rJaCbDHacJDZ8A
         wayMM5z3tUfbBq7jt79v1dqLKtCju4KN4Cc8zESZ3fAHiWRWwfO6rmxVSPXFSoNdSNtr
         L6WPkAkOUiZW7Mf4SBvegYygQnk2NRrXAf9ILra3uzv0xJJeYcDe73LyFqWAjAlgIbeN
         h6z9T72MFDe3Z4ZWYt/4sNr1lenzhLnFENKigsb6XMDBEOP6/P5ZTEBZ1989Djbda9yC
         AKQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bH3Ys777xJyJceuaHq+fKZvqaHs2+JI/CEfT6ut+TY0=;
        fh=HeKhKpF3RKTS+x8znuBx4u2B8nzY3tSzhKSCJlvcUlI=;
        b=VpAlKRnhl58WwWLAlyOIfGbWfJmAbj/fqFHmP4lpjunR2bgzGHafkU7tVDQeiWz3eQ
         XS2ZNd9pySb5mMmw5E53cqPrxt2jg2FwwVq9bN0r2WLquZfUrRYtHpKDp/3FLHMk9m1i
         539/CQI33PJc2khFSR2Q++AWt1OhS6n37l0mkQST9e9qZRz1zqpscTvP6F1+497CZ8Ax
         IKkwrTp3jTBiC2ajcsHvxugfMvrps8KVN4oJ9/8DR+AxcJuBk2iyJncLgd8ja2/56Hgt
         JczUK8aNax99yWup4ryD9iUcdzRms8wwKM2inZkKEBQO50NMyVK5DmSOP0LtGAVjb/E3
         BNKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791487781; x=1792092581; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bH3Ys777xJyJceuaHq+fKZvqaHs2+JI/CEfT6ut+TY0=;
        b=Wn6s8tb1eiVxlv5gZBq8iT3KJpGjQLvnTO/AHZIgEXjIZG+Lhz3cBxz9g6pMTSivp0
         wtTeLJOmaAiPJSlSQOd9Ej4zOx0wKZ4ym1gMaPC+5iNC/XwmE9do2x1yWrR0ZsT3WHTh
         w+VsM0qSr/2GWJx1SzOM6Eby6osj7AxkURxNuREKFU3Ova6vf++oZ9+etNFhyam1NALj
         Od2bQ1cx/eFsFP3UDnGod8REDTBpuxc5k3J6frNul3JoTNVqwgWMjVadxVY7lHJthEaH
         ilc/QMDjwZp2s7n7giziRaMUj+76BvUF4Ofor4aLNHTC8T1qC9C6ChFjGbX5KO1AgKQ0
         k8YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791487781; x=1792092581;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bH3Ys777xJyJceuaHq+fKZvqaHs2+JI/CEfT6ut+TY0=;
        b=2tjBgZETk0dTTm3+6CJpLRztWHT94J/Vol4yrJfYVpIXT4FlKNwv3/j7PTO9e8puq6
         yMq2yTGVg9Qr1BzgiOewJW4d/5iU8mL6fQaZabswVdC33yZOK2NLdIVKSaMcoxNf8EMM
         /yGcYwF7mrRqabTs0iX7MXRPLvMruX4WckKUUvvxuLOqBx5uoEhapVZrmVuXXOfzdSpi
         lR7/tcqF3RZ2h43y76TMre7P6EgsGaN2wr9t/QMLD03zIKY0PEyIBJklNdWt3UPjVytj
         4YprCj+dNfPiKRBD8uqp4+/hpFx0M/Wtil+PaoneTfiuGKD34dpuA5BLKCTVbedRVRWp
         VBaA==
X-Forwarded-Encrypted: i=1; AKwUvBw5h4av95jPLBfv6cRshGfwJrxJlbnwxPMGpbm27xYCYgnks9b5WmISJLgnIOh2+6pvAhGhnME4mXlE@vger.kernel.org
X-Gm-Message-State: AFq9FYKW5dgc32JoyDSjZ/UuusSXKcx8SwFGx69S73QZRc9Ki6wMDKcV
	FAqwr74fSMtOe6kiACvdV5BcxRbyLqc+HVkq7bqSmdEA/SOP8h/quW40i1NVJbvVd+Xj1slVrCW
	0gxTHjNbHSFS8sCeeT9tCTtoP3C09YCU=
X-Gm-Gg: AYBFou0hCl2Fp72UtxRu2j74RgBpD4Hahs3WAppCjX051KJ7NDFwq0TIAz17dDiaSra
	8oByWu0HzdPFEOYhJwRodsr7kHrZxf3p3bsLcV0B3WI5OC5tZNZtaK9OrJ3O3DtVGYsnBjVLVsi
	gqO4jtbZLwkdV7mYYNRsGibquZbzza5aROiC61FfK8CvWz/rHjCtocuNpfPZFlkxlr+VfzjBoNf
	GArH4k02sk/wPyYvNcf7nl19/erVD5OKbVdJjkYjijZAFWby42nMbp7MnREqSeDdFZp0Gxftwpn
	/nVYf9W3AL32zRYq5E8+fJ79+fvkNeX0UQpBoC0iTGwk5Lgd72suvaKB1dCmjhWhLIztP/j/1Pi
	6TrEn2IMVxH6DmA==
X-Received: by 2002:a05:651c:15c4:20b0:3a6:58fb:8540 with SMTP id
 38308e7fff4ca-3a9c2a6f0d9mr491601fa.19.1791487780457; Thu, 08 Oct 2026
 12:29:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803-alpha-fp-exceptions-v1-0-c99d75608e60@gmail.com>
 <20260803-alpha-fp-exceptions-v1-3-c99d75608e60@gmail.com>
 <CA+=Fv5QUxT-T0XgXccAF=1_6Dz=nCpY=NQu=ruOrYjbB+q7YCA@mail.gmail.com> <CA+=Fv5S_ZrHedEVPR9Oet2Egg2hwy33pEqEXaQa0zGdQdNjWRg@mail.gmail.com>
In-Reply-To: <CA+=Fv5S_ZrHedEVPR9Oet2Egg2hwy33pEqEXaQa0zGdQdNjWRg@mail.gmail.com>
From: Matt Turner <mattst88@gmail.com>
Date: Thu, 8 Oct 2026 15:29:27 -0400
X-Gm-Features: AclHuK-YAox1Xf7NjC5L8Z-SfaibsiX2e4acSu8a9kwaQSKw1rOePouwIqBhWL0
Message-ID: <CAEdQ38EM0FyqYZH6b30oxScZ481dGqnsqu23iePLdx2gCpqzxA@mail.gmail.com>
Subject: Re: [PATCH 3/3] alpha: determine tininess after rounding in the FP emulation
To: Magnus Lindholm <linmag7@gmail.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, linux-alpha@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, stable@vger.kernel.org, 
	Michael Ellerman <mpe@ellerman.id.au>, Yoshinori Sato <ysato@users.sourceforge.jp>, dalias@libc.org, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 4, 2026 at 2:13=E2=80=AFAM Magnus Lindholm <linmag7@gmail.com> =
wrote:
>
> Hi everyone,
>
> Adding Michael, Yoshinori, Rich and Adrian directly, although this
> is an alpha series, patch 3/3 also touches the shared soft-fp code in
> include/math-emu/ (op-common.h, soft-fp.h), which your architectures
> build against too (confirmed by grepping arch/{powerpc,sh,sparc} for
> includes of those headers; parisc/m68k/mips/x86 have their own
> separate math-emu and aren't touched).
> The new _FP_TININESS_AFTER_ROUNDING macro defaults to 0, so the
> intent is no behavioural change on your side. The new guard it adds
> in op-common.h is a regular runtime `if` rather than `#if` though, so
> it still gets compiled against your macro instantiations even if it
> should dead-code-eliminate at -O.
> No action needed if it builds fine for you, just flagging since it's
> tagged for stable. Let us know if it causes any problems, or feel
> free to ack if you're happy with it.
> I've reviewed and tested patch 3/3 on alpha already (Reviewed-by/
> Tested-by posted).
>
> Thanks,
> Magnus

Hello all,

Could a maintainer of this code find time to have a look?

We can take it through the alpha tree, but we'd certainly prefer some
review first.

Thanks,
Matt
