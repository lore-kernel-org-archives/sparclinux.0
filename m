Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96AE3290C7
	for <sparclinux@vger.kernel.org>; Sun, 11 Oct 2026 19:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791746293; cv=pass; b=m9WMJqIuwCT+40z0ogsGNWYSUcemHOMf0vVY+pnbughmom/4W5k/yW0ZFRqCOSbDLPvPHJi7qX6s++A9AlEVmtpNFnGZFJNeCPMvuOqzHmGR147M4hLe2+jly4Umbyl3E1kowCUzqbxcUo6HVQyUl4S6QDU+i287izvTfPzyblo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791746293; c=relaxed/simple;
	bh=IWM92jlv8+bItDuNLx6rWhbjIBftHslCpZwGdPKFMhA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a2ePBgLdZjIqJt1JtmSlc6zD5FT9ekpqpARgDsQJ9wMcV6COkzZLV1zRvjsENMB4Ks6iSZPPFMANQHsXx91EvhkQJK6weeIWWpc5CK3BnYiVN9w6zWaw5zp1TnatwA04dG9tXvqfBKPJVSnzJ60NRb7kAlB8lzuc4MiR4ZW0bog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BPhi9XT8; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BPhi9XT8"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-8ab395abf79so7024937b3.0
        for <sparclinux@vger.kernel.org>; Sun, 11 Oct 2026 12:18:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791746291; cv=none;
        d=google.com; s=arc-20260327;
        b=O3i7oWYe/DKg6mNND6iZ/zU7xhFb/XZZNGbSEHXMUbLZ+Xe+pBlfLmcag+anSMM2FU
         OScRgHDnzRsjMjZBfYTBUXXUFnOFjAxWaJAIdnJCXskDK66wAK7qlGQjqcK/k9GmnT43
         dYfyCLvLe/OqByEUkrHGi9vPXRdoNRJjrfe17bS52NrFSOEU45xSnMu/qBcq/oaB4+mD
         wKzIqA7sPhwsdtb/A9H3eCFFjjZrI8lgTFFeU1g9d1T9BauTLzGlW0Sgsuu7PDMMyWC/
         8fXwF0sJHiu2BnLj1jJlORplSzYc8UEJ4WYtlKKZsIresvaxB/o5Bs3DmWEPFjzholSm
         9Jzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yLIfFMIqaxLJpdrdg/vzw0VW5DZQ1Rbzs/ibWNjyDT8=;
        fh=60G+xt41yAJwUwe/khu5QMqeRAXSzh9thZtSUdKc2+o=;
        b=H9oAJ7Hp2MqS20KOVytuEH7CP4KEfAIFaMaRLZ5RSAOEI69+A3bu/xE0YH9XYTC26X
         lUzn1ueBr0lu3IrVWfmQ55QkobhwDsReJ46OAPW5s8d7xcQ725cilBp7iGptp3UsAMyl
         wIgwbTc26V+BRbOY9jfOiljj/yk6DtSTGawHYHbqPn9K/FRDUxhGha9TT78Yx0yvRxQD
         Y4WEW8yA7UrBpBKQB5RqWI5BWi9QyrB/P8wX94CEvKwy6a/qQQa0sD1+3MZNPBTbD2im
         6dtDXveImRHFklh8GiiuZNHWj6ObottLoQrT/09QrvARqUWW1YtP7fhAL054oTZv2iuo
         AmFg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791746291; x=1792351091; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yLIfFMIqaxLJpdrdg/vzw0VW5DZQ1Rbzs/ibWNjyDT8=;
        b=BPhi9XT84rYDt+zxZ6gXkQxgHxvWlpvvlOPox30hZfYx2xsDsxCCGmjdxQ4kqO2uoT
         mehK5dqkmYwyd0P93bROzbUnemwIjqF3MsB2Etm0u9qzrXqIOXjzIpuFjvw+000+/e00
         kimg5GnrdclIHLmmFNXWQA/ErOIg2Z0P2kVHwgMumn1DWs2OdlnIAO1nnudzOocBmzTH
         VhcJUNy1fQkJ3v6yg/FMXvsbSB+zfRJRGE72XKO0/R1ZfFRUlbXs+IYX5Qzb1Wt2BN9g
         GITHrd5GN7iruDqYacitZ/MX5LmbH/Ts6ZjqGsC5Sulor/LO2OqWIpi1GmnN5cOU9W65
         ri6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791746291; x=1792351091;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yLIfFMIqaxLJpdrdg/vzw0VW5DZQ1Rbzs/ibWNjyDT8=;
        b=dDrnOYQhvyDbhI8rZTEsKhDSqlz3LfweaWqGIdIhLpk6CeoAI2NBOAEhKXUUk3z5rI
         +cJcVf89HLL/LX19jBwkC5TdlqZ6ZrN16KFhjRR9bNpBqfQTfDvO2DGLSA/V+u6eN9eH
         ZBf60zGHgT72KZCBXnmKET1KPEbUbt48a9Tz+uaZrd/RNuMilYMF39ElT4ufYVgna0OS
         f9xCVMF885+ml/KCMFvHh9V2Oo60J1AjaB3eW+IZfdLJahRehhbeKCT+FVvJwn550dz5
         jFeGohGKB5A2771TunFdBdMUbsyaTJqztr5NLSl0AIt83Lm/x4pBUiwaUrH+/guWM6zN
         efVg==
X-Forwarded-Encrypted: i=1; AKwUvBzjgYwc2sgizW/db2w/FI0mTsl9qN9DNZW4PrbJzbvTrMQsl2n9cllwAl08+rjU5YcprFiZ3la8GVmK@vger.kernel.org
X-Gm-Message-State: AFq9FYLsyd47ixj3qK3h6IaoKZN/SgowQyL1zEcrX1BLdz2f6o64FI4w
	440vLuzc1dRN/ItkLfUctsVnWV5pM//pPiRCeP0kMwuWtJMP0H4NnSaPiWMp5QVEr6sWWGKKvBa
	sN+aeiKx5tLmeNsc/Bpjo+l2aVcgYL1Y=
X-Gm-Gg: AYBFou1t8a9Kkp+IAKOA/hg5KILIEDMNjLBpwkwQW7K2QSDTsbqiznMbnYqopwU0toH
	BJMYlK6JPAFk/o4TgVSBKCyRoDhHeXp70iFM/AuPxuDWY5QgS1sOtKTIrf6Z0U9JxaKqMh+7fiV
	g7R4Bu8KjN33of9nzzSx0FRRrRF89VhYkp+j18jD8ThbDBRiVDMp549+XZkOpXyekPB61ONaUi9
	knXGtiiaBzqSTL6siYKPkjiUUGe8/x80k9sMgLzt/S7vTJuUUZAg7D0/Myw7ocLo0Wf3pH5vCxV
	s5kGwlVj2ZPVz6VUeIHWE5CBfWUkDJdWzGEuMCrPxOz7VKS+fG0D8uxBGZ2NVvd2m3/p1onwdts
	711eHYeZZEyLb2d/sZskWwjpMriL2J+7UExVY+aKvBxlUktATWQ7V
X-Received: by 2002:a05:690e:43cc:20b0:677:d1d9:1277 with SMTP id
 956f58d0204a3-67936aa750cmr1760899d50.82.1791746290718; Sun, 11 Oct 2026
 12:18:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261008220433.965791-1-linmag7@gmail.com> <038bffb2-e40d-44bb-b7ce-53e9de32e50d@lunn.ch>
 <CA+=Fv5QvhYd7EqVBYKWVgvf92SLE=FjE8EYcZvUQ7HKdx2kc3Q@mail.gmail.com>
 <becc8f95-4650-477b-b1c7-cc4952e5e980@lunn.ch> <CA+=Fv5TU1rOUimi8f+e0R4_48ki+X3qzD_+1QPyviTnJz-irvA@mail.gmail.com>
 <c8bc138e-2d62-4ee8-9020-5f1091efe015@lunn.ch>
In-Reply-To: <c8bc138e-2d62-4ee8-9020-5f1091efe015@lunn.ch>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Sun, 11 Oct 2026 21:17:58 +0200
X-Gm-Features: AclHuK_XYA2IeX8EB_wQ6S_Y8XgepVmJIFtOKL2to5kfxrIk9XqHG7Csp2E4u_w
Message-ID: <CA+=Fv5RiKoE07MVn5qRS1+WtLXUVO+HrXyLpVCcXGoCb7X6X3w@mail.gmail.com>
Subject: Re: [PATCH net-next] tg3: normalize inherited M3000 register byte order
To: Andrew Lunn <andrew@lunn.ch>
Cc: pavan.chebbi@broadcom.com, andrew+netdev@lunn.ch, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Sun, Oct 11, 2026 at 3:33=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Fri, Oct 09, 2026 at 02:52:57PM +0200, Magnus Lindholm wrote:
> > Hi Andrew,
> >
> > On Fri, Oct 9, 2026 at 2:09=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wro=
te:
> > >
> > > > > Is there a legitimate reason you would want the bytes are swapped=
?
> > >
> > > You missed answering this. I'm guessing, but does the hardware offer
> > > this to make big endian machines more efficient?
> > >
> > > Please could you look at the driver and think about what would happen
> > > on a big endian machine. Is the change still correct?
> > >
> > >         Andrew
> >
> > You're right, my earlier reply missed the underlying question.
> >
> > That is a plausible reason for providing the hardware swap mode:
> > it can accommodate big-endian accesses without software byte
> > swapping. I haven't verified Broadcom's design rationale.
> >
> > However, Linux tg3 alreadThanks, I'll expand the commit message with th=
is explanation in v3.y initializes misc_host_ctrl with WORD_SWAP set
> > and BYTE_SWAP clear on both little- and big-endian builds, before
> > this helper runs.
> >
> > The helper restores that existing setting. Its swab32() compensates
> > for the device's inherited register state, not CPU endianness.
> > Subsequent accesses use the normal driver path, and the separate
> > __BIG_ENDIAN handling for DMA remains unchanged.
> >
> > That is why I believe the correction is appropriate on either
> > endianness. The runtime tests were on the M3000 running big-endian
> > SPARC64.
>
> Please expand the commit message to show you have thought about this.
>


Thanks, I'll expand the commit message with this explanation in v3.

Magnus
