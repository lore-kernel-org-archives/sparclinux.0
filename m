Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A0044162A
	for <sparclinux@vger.kernel.org>; Fri,  9 Oct 2026 06:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791527346; cv=pass; b=jAIYA4XB33PRO72QQuvqdu3us4K/CL/PAifEZDzR9eI7LmrlxuPhrETiOtU6R0PrIu3RQIcNBl5nluBMm+hsLAej+2OIqsTVZWXBBE4KoOTYBb3uQ4QIRMSZIn6lPD27UvkeDxG9O3XtckrdYzyTelnWwqWx/7qsayUv8iHQI1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791527346; c=relaxed/simple;
	bh=Y5NCAAj+S8CVX/AK6zeAmzUsBUrcPbh6f/6GokfhsQE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OgnkMNqjBQVT5w4fsWVmR8fskH9/3CRj/ycf6ACLVXGb3CuuIHe9DcUnM6bX+v+xnAGQ6T50ogSmUpd/GNoCsa0utGDA5MxVoPiA9s7y57ZfZNxmEXu3BTj1lmwc14/qTk9yJ8ljOcMacugppfZsMCCI9MQb4P5n3nPWvtruC8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WFB9ma93; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WFB9ma93"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6a9e5ba741aso5653659a12.3
        for <sparclinux@vger.kernel.org>; Thu, 08 Oct 2026 23:29:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791527343; cv=none;
        d=google.com; s=arc-20260327;
        b=YAtZlTqh7NL1Z660c+l8XKI2pVNjfYS9rdVwo7yaDNdD3L8zR+37/D0DEX2rLlp758
         /9TiggJGnGbFMBrIGrUzTVpPjBQmIvzPeeOtXGfel7SnVprnoLak75pWRFct2iWS06CE
         6i5cgDx/oFyl4kZuSwWjcJemY7L/sxtRBhytHFlYhX7kWSiSqe8nhsbjI75YuZdg0ReK
         kroHTjqRm905qIKl2AXaTeDiSwP5uMHuaN7YaCgUw7ghvwyqBe9SLhRGTaE9MkyzhCmZ
         zS/ckcn6l4dy4ZS+lJX7JaW48bF8oc8J+IdsC5sdj1//wMXXxosIaYRszxhGgTNGM1X8
         PqhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=U1VUoDa7q17rAeqnY7bbHsgshGRs6k3XUU7zBz6pXTY=;
        fh=uYNo5zto5z/9IbrVujMR7YmMnlfCVMSHHeQzd+qt2tg=;
        b=I2O7TXdIMNQQbgcvvLwapDuJhMYLosmPPogYmwi48ZLDlF2wbRTd+DjjZUH3dpHEDf
         QrqL2Dq8aWgvDEeEcM0y/kIxkwXt8NG+hMS25XBgU7u2QQutYjOWXuP0HlfDjJ3EA43T
         +Gu8KEULNxRjK2RUyPiNKHbrD2Q3LGZglyfJHuTAlPDyV2HmyDaqyxnYWrYoQxCEJYu0
         TVqjwcMMnYBkt6o7s23ac/6iHFzj91R/UG0ZMzMkoxaKmA+j9t5iqNdUCi+2TY0UO4zq
         dPq8bC/8TlD/PLqVmceJDh/Riov+UO1KWbrpT4yTUb3Yd4Mi3kONir5+HCgqbsduI4bQ
         Gk2w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791527343; x=1792132143; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=U1VUoDa7q17rAeqnY7bbHsgshGRs6k3XUU7zBz6pXTY=;
        b=WFB9ma93JZ3Nl1BNB3eZkXfmHvUmBSt2pU5rbVClkK9djK3bnXDrFrGVfa71uw5j9r
         bso5qwjiFI9JVSoYThINt2nTUnJzeJS/I9eRmPtI/JZJLbKsGvZ/cm9IjjcQJ3V/ugy5
         l8jD+oE8aZ/S+iTPpYw29e5dyjcKPnUr7xsIzT/liKjKFNfSyOK6Y3b0JjV/tUojU+NJ
         hrBCo3BsdHtDTJZYYcYgQHbUaRdK5sLU3oTtl7zhHSHXSZn6noIo3Cbiq5Do9AGj2f2A
         NHVGjmmKksg2WcAQlRyyRreXCDvAVbJgKW0HlTGm+Wf/CE70A4TnNcxDq9WXfhgh4BE8
         55TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791527343; x=1792132143;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U1VUoDa7q17rAeqnY7bbHsgshGRs6k3XUU7zBz6pXTY=;
        b=Kh8Q2KGPoPfmUE904Us+/FZcue+NFBd6Top0/Kay0Krf0PjRGysxVonQcoQz9Ubnsz
         +T3xDxHWao1CBr6ScVknIbTiFtnGtBHxf1/l4BkuIESh090NTguQBzZ+pT/ExwcxuXYE
         T20wDlc4iV9jpAUpt9iHBvOUomrTzucq5sZBwitTvkBgRxNp/bRU4hxF0vNsoKu/dnZ+
         mjkqIPGHIasqDsyVIaNzUEGdsaHOrWErH0EmeKDi3P659ozYv5VKG0VK8X5jWWEnACqA
         Z5j+iGPkwmp+HRouv8C11wsajWXD4TDw1KFZXRxBipXpARvy8opD9uDxuMXTfyI4ROE1
         Eusw==
X-Forwarded-Encrypted: i=1; AKwUvBwyR+eNWZ2dVTUyr9BMZck6/fwaeV5/aOvI9ETqGt6g7f2hXrs9//LmK8lN83hfqwNuq9TP5cKJmdAh@vger.kernel.org
X-Gm-Message-State: AFq9FYJAFVfQXhNEXAk+T7C4hfDQrNKZT+9BzWTeN/ausHCouciTgRto
	+Jry9up613jcERdaz9oCrputiYEKqztVb51Cfh2hNkn1lXFfWjyyitYVwF0yS7kUcDZofzdfSc+
	Z3m+8mEpZjoucg76UMPywExVFa7HEZzE=
X-Gm-Gg: AYBFou2Sjt597aT/+9XvJYuq4uUqvp+sD44NoQljderELEDIafBWug8w75bMdHxX0dJ
	gg7UTlpgzwXIR1CA06Uvfbqa96T+DOcTwDs06cJ9yHLwNEzQVZx2Ri3Dj8WEk4zUqAvSTxmPKFW
	BG0ommzacmWgcWMazvrJE01uGWKcYAJd1RqDovitCPjLmmmz57ZL3OuSoo95sr2tnQfsv/PWnRV
	qSx5mi/ZjMPWBOY54bNBwGfe4QKGDdJfl1CVeldAruP4DdWxQ9EzIquj3IiBExvMjm1iKyABaMX
	cl5QEV+5HCZEJmbDKYASy5Vm4wweSPVCkgcYhYO6itLamNFUc/k7QuKcE1tpTCQAilPVM3q5qP6
	N9R2BnQwaqVkp2QVJTuT5/5TWVbUKxSXzji/q4Y1j/Q==
X-Received: by 2002:a05:6402:450e:b0:6ac:9a44:d409 with SMTP id
 4fb4d7f45d1cf-6b17c1dec0cmr625458a12.4.1791527343140; Thu, 08 Oct 2026
 23:29:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261008220433.965791-1-linmag7@gmail.com> <038bffb2-e40d-44bb-b7ce-53e9de32e50d@lunn.ch>
In-Reply-To: <038bffb2-e40d-44bb-b7ce-53e9de32e50d@lunn.ch>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Fri, 9 Oct 2026 08:28:51 +0200
X-Gm-Features: AclHuK-JpJJ8BWVdNGK7pt4HrpIyJkAQKyqnfpnG3fkPyd0w-Sx8RYMtjvqDjms
Message-ID: <CA+=Fv5QvhYd7EqVBYKWVgvf92SLE=FjE8EYcZvUQ7HKdx2kc3Q@mail.gmail.com>
Subject: Re: [PATCH net-next] tg3: normalize inherited M3000 register byte order
To: andrew@lunn.ch
Cc: pavan.chebbi@broadcom.com, andrew+netdev@lunn.ch, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Fri, Oct 9, 2026 at 3:13=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Fri, Oct 09, 2026 at 12:04:03AM +0200, Magnus Lindholm wrote:
> > M3000 firmware can leave BCM5718 vendor registers byte-swapped while
> > standard PCI fields retain normal byte order. Match the Fujitsu 10cf:16=
5a
> > subsystem, IKKAKU model and swapped revision/product signature before
> > restoring host control; reject failed PCI accesses or register readback=
s.
> >
> > Keep this in probe so failures can abort initialization; SPARC firmware
> > enumeration skips PCI_FIXUP_EARLY. Normal rebinds and other platforms
> > retain their existing path.
> >
> > Use tg3.h's MISC_HOST_CTRL_BYTE_SWAP and TG3PCI_GEN2_PRODID_ASICREV;
> > the inherited state was observed on M3000 hardware.
> >
> > Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
>
> > +/* M3000 firmware can leave the on-board BCM5718 registers byte-swappe=
d. */
> > +static bool tg3_is_m3000(struct pci_dev *pdev)
> > +{
> > +     struct device_node *root;
> > +     const char *model;
> > +     bool match;
> > +
> > +     if (pdev->vendor !=3D PCI_VENDOR_ID_BROADCOM ||
> > +         pdev->device !=3D TG3PCI_DEVICE_TIGON3_5718 ||
> > +         pdev->subsystem_vendor !=3D 0x10cf ||
> > +         pdev->subsystem_device !=3D 0x165a)
> > +             return false;
> > +
> > +     root =3D of_find_node_by_path("/");
> > +     match =3D !of_property_read_string(root, "model", &model) &&
> > +             !strcmp(model, "IKKAKU");
>
> The DT Maintainers generally don't like this.
>
> Is there a legitimate reason you would want the bytes are swapped?
>
> Can you not just probe the registers, and if they are swapped undo it?
> Does it really need to be conditional on the machine?
>

Thanks for the suggestion. I've tested a revised approach without
the machine-model or subsystem checks. It checks the BCM5718 register
state, leaving a normal revision signature untouched and requiring
the swapped revision, byte-swap bit and product ID before correcting
the byte order. Both register readbacks are checked afterward.

On the M3000, all four ports normalized at boot, with no additional
normalization on driver rebind. Link cycling and bidirectional
file-transfer checks also passed.

I'll send v2 shortly.

Thanks,
Magnus
