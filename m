Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DAD3BB112
	for <sparclinux@vger.kernel.org>; Fri,  9 Oct 2026 12:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791550394; cv=pass; b=giKkLeHyXW1lJuMXHx7VqUFDdp95ITqyOfSg+A+5OWYlmERr9WHZJl59tMFcAKChWV6bfT0My6y5fqOVF9BjEnC7R9qAA0EdFRgjOyX0L9ugFPFUeFByKIx5EiqoFTjQeKiFu8K0tphNNdfnv0GNDH5EkR8FmcDz5OxHBJ/O5Qs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791550394; c=relaxed/simple;
	bh=Z82pTd9B92P9L7FdZhm2lYoAuLSq6EAjasYSS9dt8qE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OWv6vBqpVSZYHwS4N/etebpf690oH/WrYrVNc3RoNhaoI7W1U9nu+h0oK5PBtVA9D2MSv5xn9nU1CisV0nBNdBmwrG56KJ2IHPZqzsW+kYQAOvx4f+4DSA2JAhlmqxK/hAWIImYlvzZ5f8LOM1+CSjIqxXqHXzAdIuCwZBR8sOI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ifsh87Ll; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ifsh87Ll"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6b170129413so1958105a12.1
        for <sparclinux@vger.kernel.org>; Fri, 09 Oct 2026 05:53:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791550390; cv=none;
        d=google.com; s=arc-20260327;
        b=MHreQBCOQ2HR0Jf3eEkMoJ8oEApQm9jYy7XdEWyQbWb+fYCHslZMDuz7n7vTnRZ5mq
         0MW3Mj4YjMYDtTO/87E5rmHxiuIbsmdFPrJRbZkqlgGraADSMt8uLg/hSamzMEwCyuR7
         XNyU/yhDifIxwRbxwmcHswFFsUmNfXH+IGd0iLx0KfJKSOKks9eaZsZfCCpehflZ15Io
         CYmwrTbId9prYEnm81nhJcRjBp5wzVVMbeVypsOq9zE88rGwAJ2DJ+Zu6qpo+Enrns23
         KRhyjulJHXpPbXZVBmQ9nXXVUiTxtlv6+XvM+FCE0pdziySh3HaBTxThVS678ete2JxU
         FzHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5vMZXYMYLUNNQlIgyE1yknyh4fPOMVeuczGExkJ8JXE=;
        fh=kuFrjmKHCW0FB8pv1bqzsAsFCzYBxSC6SWUEGlqqJyE=;
        b=nZu+DiG5bC24nO+kzXHqJ3a6z2LqUDwZ5oJfFaE+S/2UBbdc+hX9zw1TyEvjji5etP
         OsTn7qPrKYB5rB2tr52lFb/l61/z71WWP81S53tsfk0W2zrVaEhRbS8Vr7756rKRfZ6Q
         0lX1qwam8qCb4hKlvxrVUwGSd0hmnjUZYpaLp8PGj4heR9Sr1arv4kQqwUHXGsHZlG9j
         uiEJ1zWKiLGBRm7W3b8tHghN4HgNZ6JKxDAe/kJjH0Eq/fHTNtv9+htUWeA+KrR7dJNF
         RdrrZrisdOrmDvm4lww0AAJcklTPKD1XGRRRWWrYakFWxGn/hQF3Nl4WvDp0uYKpT84q
         wN0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791550390; x=1792155190; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5vMZXYMYLUNNQlIgyE1yknyh4fPOMVeuczGExkJ8JXE=;
        b=ifsh87LlCN3wkWRcmDkQ60dk2vICGEyqa/7HAf24ZPWmzJygOFJFEFd/Ap2pale/Y5
         RJ4UR+C34UlrOvZuK6akVfOgLFtZn2Eayw2SxxUc8y1qbDw1luHugqGuinmlChwPOreG
         k2JyIOrrVWP6y/TkPZ5UjBXweBOydjaP7guPO5yWmOUtH1ELuDy4p4r8w0itCSiXAMSe
         jQpaaoju2Wf3qFA8SjG22MjAxWmVXeEL4dL5ANOQv3ICeeMzzJsbheJ0hZLmSnJXfmu7
         goZOzxXb6LwZA2pRrhHqAxHbcdZUNN5vA7wUxbFZKT5SnAiJl216AHAf6nqCO9BZWVid
         Y0iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791550390; x=1792155190;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5vMZXYMYLUNNQlIgyE1yknyh4fPOMVeuczGExkJ8JXE=;
        b=wg47PJb6kCTBPpgVjuCiW9ImKZ75DWx7lEaS+R3NIhnBd+5QGFz1hCNMaZrGEPyvkZ
         4xEQFnSDKUYMI5JEfCfbrtJVIzhfPUC7ZAJ0uPqFJ1ZBVyPBM0TH6jKiq7ajSRtZAGPJ
         7FkNq9uIVe7yfOvQT3SUbD1+nrF7AjwgwuXfPxmJPiPpCv/OIiImRNuIpvO8+Xm+GPyt
         Udxv9r4OBIcruDL09ui3vvc49FuWZc6vOIhmmcQanoETwhu1giVdGzP+IqpjjIyV2yQA
         hJApg3YYx71a2GFLuSxs2ukSH6cC6yG9JoUWNs/ZHzkZFpDiiVOt25ToqxAOaU8Wmrwg
         qY8g==
X-Forwarded-Encrypted: i=1; AKwUvBwXuZOEueFQwXq7cx0WwxxVZGOLw5ivMCb11WRO/2DG1GZkNNb5t2kkjE6P97osvfS5C59oQOlH2Lzv@vger.kernel.org
X-Gm-Message-State: AFq9FYKGUu4lvRDI32CbsOsbgyZAJFLEzXup8Ud/TRsgZv+BzvFc+FPe
	d0wnppMMaYrcg053AACCQM8eabiGvE0GOhJvqhkocBvFSgskg7TxpbjLrtwyqJagKdoyTZmu8RU
	5fWLRx3TWAK4hWGmxOqsxC2tPiieeZbE=
X-Gm-Gg: AYBFou3+JTC26miDR/m8O4zH17UJdFP0z+vAVm5BQELVqTH9OWBDeqyuySJSEFE5PoH
	kn+smZl9DKuJnHTOoanOWbXkpV6+BNVl9iboDETApRDAQxEbYKhVz0T8J+a7YiJ7hPU6GtnAnHw
	Ui/bvfXD5hBxm9pTkAUzf79E1ipnLRWrfOf6BEs/96ElvZOZOi+YYUJow6WWJ/npFKaMMXE19da
	zdWz8K+/yaza2S+0ravkQLiW7uP4WWXJ+CmsS+/hMCXtbH5SFt40cx4Zpl9DVbyNIL7iRPTUfO0
	cWmzwG+tq0iTovFL469nlJvPU3k7bf0rk06w2voCM9tVwa91jxoWuxIYaSHTTmRWIx8zC0I9VxN
	jY5PK+9G5R4eiI97gH+G/ZekfBHRrudIc2V+TXGdpaaI=
X-Received: by 2002:a05:6402:450f:b0:6aa:f2cb:754c with SMTP id
 4fb4d7f45d1cf-6b17c25d3ffmr1597123a12.10.1791550390235; Fri, 09 Oct 2026
 05:53:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261008220433.965791-1-linmag7@gmail.com> <038bffb2-e40d-44bb-b7ce-53e9de32e50d@lunn.ch>
 <CA+=Fv5QvhYd7EqVBYKWVgvf92SLE=FjE8EYcZvUQ7HKdx2kc3Q@mail.gmail.com> <becc8f95-4650-477b-b1c7-cc4952e5e980@lunn.ch>
In-Reply-To: <becc8f95-4650-477b-b1c7-cc4952e5e980@lunn.ch>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Fri, 9 Oct 2026 14:52:57 +0200
X-Gm-Features: AclHuK8k--wFHWgEgasHO9Vp771hJjGyFtQegdxLzMtXg-Ear1hkFG0UCoGNSGY
Message-ID: <CA+=Fv5TU1rOUimi8f+e0R4_48ki+X3qzD_+1QPyviTnJz-irvA@mail.gmail.com>
Subject: Re: [PATCH net-next] tg3: normalize inherited M3000 register byte order
To: Andrew Lunn <andrew@lunn.ch>
Cc: pavan.chebbi@broadcom.com, andrew+netdev@lunn.ch, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Fri, Oct 9, 2026 at 2:09=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > > Is there a legitimate reason you would want the bytes are swapped?
>
> You missed answering this. I'm guessing, but does the hardware offer
> this to make big endian machines more efficient?
>
> Please could you look at the driver and think about what would happen
> on a big endian machine. Is the change still correct?
>
>         Andrew

You're right, my earlier reply missed the underlying question.

That is a plausible reason for providing the hardware swap mode:
it can accommodate big-endian accesses without software byte
swapping. I haven't verified Broadcom's design rationale.

However, Linux tg3 already initializes misc_host_ctrl with WORD_SWAP set
and BYTE_SWAP clear on both little- and big-endian builds, before
this helper runs.

The helper restores that existing setting. Its swab32() compensates
for the device's inherited register state, not CPU endianness.
Subsequent accesses use the normal driver path, and the separate
__BIG_ENDIAN handling for DMA remains unchanged.

That is why I believe the correction is appropriate on either
endianness. The runtime tests were on the M3000 running big-endian
SPARC64.

Regards,
Magnus
