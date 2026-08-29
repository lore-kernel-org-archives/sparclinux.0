Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFC4340A47
	for <sparclinux@vger.kernel.org>; Sat, 29 Aug 2026 08:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787993660; cv=pass; b=ISyWrbva5A45o1AAh5htnGARwk5IqaNg8Pqqup8OUENqVxogh2kn6hsL2Ej8RdGHXc7TxCa3UWin/EMS5siXkNLt0Snf8VJo+lW3J/jEFObNpOP7y51RFHnfPRb8qmH3EX6AoxyDVuYOpLHJKDQQJtZzkMc3VaLi4kId/dy3U3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787993660; c=relaxed/simple;
	bh=hrtNEgtG3j6zaZK3E0236Rq/kyzlkNTa4Qq5rfR+cX4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XAC9mK2uhNNgMTKxDQsMh1g0qu+Z1aAerkM2fj68zBMCsp5KiCoDS5Z9cB3cBysajHee87ZM1Q+DDAN3Kvd0OyGUtSA5uqFpSOBLIgw/FqGAljiPw/l/esI2pNmb0VLlLA9wE+WeumnXHp5Cr6UMH2+CcJrxOKLzJpYV42JOwJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nL6zmajk; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nL6zmajk"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-69f7fa1c548so2748884a12.2
        for <sparclinux@vger.kernel.org>; Sat, 29 Aug 2026 01:54:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787993657; cv=none;
        d=google.com; s=arc-20260327;
        b=pCrg4HWWVqylISkat+26lDqV5Q3c2b1o+Bh8w86gsU3BQdBwkBSKjJRxv28OnLmTNx
         lThmLY5tddIVeIo9ww0AZBXdMK9P+nyz32ApwBE7OJ3Wn2zYHZGOhzqyQa1z6ZpgKhzs
         jwEtL3rpKRRL6ZG+rlVe0gT6f44/DLoErXVl338G6H1zz3crY/JyG9hXDtQ60GqI7INe
         3bFpmiiVU5Z9PTH/JRnZyfJ4g7K3W/upKN2gmBddgcFIkOFk0dRmWiaKQwH4Iw46ViKo
         rK4UYdc3FQ6ZkM4PJKaw9a3PGbROLTDU+AXfYWSodFW1mWil8U/qiFSI1NCBtrLQJHuZ
         K+OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hrtNEgtG3j6zaZK3E0236Rq/kyzlkNTa4Qq5rfR+cX4=;
        fh=xL3khHFPu8t9rYa5FOGRy4DapmWu2s6QCpUOa0aUhYE=;
        b=jJF3SgJh1myXyry1vosPgy7UDB3RR2HTxO5ErI2yxniqvj6Kh+EAzWusOf4MjlRR8u
         1sX2UlFl3s1RBIxc2eMs4qUNJhNEhjxmYWL+em+0xAgu1hVpQNHGp9STG86VTzqjLhqe
         tbjNDrZKPvq6RETkSTYpU7AZ3DUrxi0v5+r+HY7Kv90wZT4UqP5QztAh8OlvMua2krRd
         ObokCs/cwHcCjDY4zvWgVO8quFcBn+G3uuwWEBx1WB0ASW8cJaN2oobTO2xCe2h8JYKI
         quUMWti3M92w+gX1Z+YvovQy/KabCPzbBKOclfj5LPHhXIUbCBKHJOWYjc5fCN3/r9wo
         BtDw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787993657; x=1788598457; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hrtNEgtG3j6zaZK3E0236Rq/kyzlkNTa4Qq5rfR+cX4=;
        b=nL6zmajkEZ/qFYFDwXGycrsf64x0wQAyYSCEbwO4TbG8E5VPzoddPYFzJfUtLudb9T
         /Hn1TuUU4GgqOzO/ePVCs3cGJy8YeuEBWjQyqfyEs7Bw5MCU/CwTAHMYNxAX3575Ztwm
         9MF/Qv42oMQRDYWSOe0mll7uxWdR0XX1Vd5XnM/JLt/1RzQdTvX6yMTaV6jtg8fw9nDC
         XO8IKIhOJQP2rChjLNzw24zBbsxQUEJR0RS6cto1Gc8ubo2Qel78VPyReXbCcAiBpzFw
         CetIxPt+7b74JPKKmFC59xJ/MNqH1DOS1v7FbRnuQ/wmOXe110vqmyjD3s+cLij5wGte
         JaAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787993657; x=1788598457;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hrtNEgtG3j6zaZK3E0236Rq/kyzlkNTa4Qq5rfR+cX4=;
        b=jVExyTO8I1M0R311TXO1oLPokWBVFuX4YtV8d9FTe5dst3CUhMWjj2l2BjHENO93oJ
         JXbhk0W0uB9kOmLzfnKkgMaAQG/uiOJaJwM7r98vMYaj8I34QWW4CG+xO+KI35x+ogTZ
         YbF2PR4ftgDijhxOy6dLzFGu29u3p8e5Z+N3lQ4eYpQ+bfFeuHaZaKz0p5FfBW2lREXJ
         /8pv1I+6Vp4PEoS32w/mU0Kbyp1GREmZByJFWPms8a9YKGb/rsMcRBmLi50KA3Uolnh+
         GJqHQrzxseaE3cMb6vDAQc1JgE6MSRIBXdFwGnD3Jr5a9IJIkCF18NcEPmULBUO4f8Ez
         rzrw==
X-Gm-Message-State: AFuF++nzywlSAgZyu44xFFHXswYDGxRm5dTY0eHuilmglKmMDQmBiYAx
	91/BOhEaLPF0FHbxkZcKmCW/tPPYGuJRLDCa04vwVXAVy5xX1vFSfm7omnGMLpm60qjBpHVAeoN
	vCNEFa5UnSYquCxthCJyz34Y+lwHzDto=
X-Gm-Gg: AYBFou1CORXI2KYSETXwH6EWVmiqyXBmbHd72Sp80yIxjk1l2l13+t0lB+aLG3jQoDV
	jBb4GxmF3jDFOtnGb1buNlw1cEtEVIFHhXebNSUzwPtGJFFTZ8ovslI7rg2P/tNz2/JVgctIXGn
	Oi65wkc3hMEcKANdTjRQETG+xxKruMGt/fGOkq9jPnDvh8DOtiydbUAiz0Ce63Psvz23zDuKn6V
	YGBHCK6vYki3fxOsc3qEXNy9PUXtMUI43g+gYeEqcDBuO/vVvmM7JEcx4QCT6XmJ6T0vypI6cr8
	fEaBga5JrkkDO5DOc7PpaVwI5C6BR05SiOpHoe5Fh9vOuAh8urBMrSQKX4IVz+SgSd+UkiNJyP+
	57klHKbGr7oZfbB2hWnZcPnsWcE0IGQ0=
X-Received: by 2002:a05:6402:3812:b0:6a3:6d83:ba44 with SMTP id
 4fb4d7f45d1cf-6a60d2f3663mr9153249a12.2.1787993657229; Sat, 29 Aug 2026
 01:54:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260827182757.6856-1-linmag7@gmail.com> <20260829062933.GB44338@ravnborg.org>
In-Reply-To: <20260829062933.GB44338@ravnborg.org>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Sat, 29 Aug 2026 10:54:06 +0200
X-Gm-Features: AcwNN1U6gDCQuxm8O0njez-6ceR_nScc2jt9Lo2gqUB-dHcQWIJBt5FHMPzsBF4
Message-ID: <CA+=Fv5QAFULPP=hwFFAKjrhEm0Mcb8J5kqr3tdvkTzJ3bFgwCw@mail.gmail.com>
Subject: Re: [PATCH 0/5] sparc32: replace sp_banks with memblock
To: Sam Ravnborg <sam@ravnborg.org>
Cc: sparclinux@vger.kernel.org, davem@davemloft.net, andreas@gaisler.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sam,

On Sat, Aug 29, 2026 at 8:29=E2=80=AFAM Sam Ravnborg <sam@ravnborg.org> wro=
te:

> Patches 1,2,3,5 are:
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
>
> I left some comments in patch 4.
>

Thanks alot for taking the time to review this, I'll pick up your tags
and address
your comments in a v2 of this series.

Regards

Magnus
