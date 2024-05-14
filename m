Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D239D1E4B3;
	Tue, 14 May 2024 19:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715715493; cv=none; b=MGlIBljO1Uv8NB2SZM9NAuH4TxJ263t5m5AGUdWZe/K5syurtgYgEL7yYFB6GlveqgUIml2026tSJP95E/yGtTuqLhNk+2JX3LUCW02AxBZd+EP5BjcfcnQwA1QJq4gNVInxueNAz93ux2e74zOrjnQF/QFc78rKdSP+CLA45DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715715493; c=relaxed/simple;
	bh=lQwl2puuKbV72+DsiO9T7adpACTwdXUGgRTJQloSNHw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AM+giA9osH0RGCEEDcGjRec6mYpZE5Uz/Zn69mW6eHZIYml4CYzFLVUxdp/0/Ozmw0F+4KbryQfrPUp+sX4rhyjsGgILsPlhng7YoQQaZNHPVcDw0xZEWdF3N4wuW9b6RIAHe+s53uX8iKCaIGfgGU5hv8hW0KLHM3ZBgHvzz8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jCAyFNUu; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jCAyFNUu"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5e8470c1cb7so4072578a12.2;
        Tue, 14 May 2024 12:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715715491; x=1716320291; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WZ2nrAvoRZbBvV3Qzn3kjm6zRoNtce+1pSkoAvyjL18=;
        b=jCAyFNUudUtOlRMGFQXXniiPGkmwt2aXkvrM+PKDJCVjMrSR9fnRDMtqOBF7qHHcz1
         r5+M5wdEgUG+5xVNlQss9zkz8LvsC+fKGwdtkCivTUM8wIS+ziuqOcjA/ObgJPwNzsxr
         tYXWjKVRenyjjanImHckT1QK9OQgf1hvac3HlQAkKSYG0Qw9fApm6bL2K9Diz5nahpRa
         2xMRjxykmPRwMBqkjw2USXQBfNtGnuAJnYFy5e3/TCSYbWpKZuhKgj/FgqSW9g9F+QlM
         ZLasVUTC1dsFclPfFGD7pI9YkXPZNlAexEKVV7X/9NsaCg7O9a1rD7E9U3gNYX75p1SQ
         e0qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715715491; x=1716320291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WZ2nrAvoRZbBvV3Qzn3kjm6zRoNtce+1pSkoAvyjL18=;
        b=TarcRkA1g40KInImlDc9eD9cW2VQQ3uO25lcpU00IGLr/cJkbXyGOFcr5mAgFVoXyD
         vpTMa9uLDw4cLHP7Lf6H9ufNy/ZBLfyqp0f+HPOXL/UFqC9kQTMvcM8x6PgmqfrBwEDS
         iizJEe1+ln2jVG7lwzBQ1VS025IhJAPuyI9CRYukRsWfpFIYtiXAdBp5D9A/jwL+AIg+
         nGpsjhjcRsk2AnEXHJ7pWkVlqTltLse/MmvRd+yIdlbuTnHirJnHiZ4TmN152rr4FAU/
         S47aFmpPX85DpPFGONiP1NjQRy2TpzkthONIStfKpKQ6L/dlsaDnL+ZTB6iFkuh+rLXU
         kiJA==
X-Forwarded-Encrypted: i=1; AJvYcCUsrP5sw/QlxvlxmJc6QheyIn0ISmeFI710GU9SOqIdiI1FRENdRwlXU07OMplwwj3vd0/XXgXbxhYKYw4MQHA4g9vQRLujEk0kXuD9vmfDY6zcIrF4FAoZKmdgjlN7Y7qD8RCrX6wzGgMqKZ0CsAq69Kmzmwq8QPczPz1jG2xfQXWitxMtMQ==
X-Gm-Message-State: AOJu0YyXQocrA8pdnWa+NcpqgPtPPjdmksf1k1DsJPG6VV4dCBtijaOy
	wki2Ls8UhoQGJ+mznXSH6j4BQYUNT8NvwsrxAbowkFma/q1ohtYoft5RDvYcQopHFVgiBH1JvlT
	/X+a5OpQlJVfdxVFe1C6f7UvxY+k=
X-Google-Smtp-Source: AGHT+IEkoXXwK9l3IytD9abzRUJ7pARr01xxC9ZVTAxyNlzUk3jqzWCDyF/FBf+hBTkrB9lu54xbeA1CsvodhyDGXOk=
X-Received: by 2002:a17:90b:4c8d:b0:2b3:ed2:1aaf with SMTP id
 98e67ed59e1d1-2b6cc76d3acmr11217429a91.29.1715715490914; Tue, 14 May 2024
 12:38:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240501084110.4165-2-shresthprasad7@gmail.com>
 <f1707254-ec32-4884-275a-c3c85b48d7d5@linux.intel.com> <CAE8VWiJy-2x6sKCAmN69Uq9Kf1cTRnaJezOoLDyZ0SbgPWuHAQ@mail.gmail.com>
 <2024050357-shading-fedora-2d4f@gregkh> <CAE8VWi+-HVuGo-ojGPwKubpLweBmJ4-L097nh03QkezcsciorA@mail.gmail.com>
 <2024050402-eraser-stimulate-3908@gregkh>
In-Reply-To: <2024050402-eraser-stimulate-3908@gregkh>
From: Shresth Prasad <shresthprasad7@gmail.com>
Date: Wed, 15 May 2024 01:07:59 +0530
Message-ID: <CAE8VWiJkDm9ezho6wNT=NCycTccgru4HMkVYS_nEYC38DYOy3g@mail.gmail.com>
Subject: Re: [PATCH v2][next] tty: sunsu: Simplify device_node cleanup by
 using __free
To: Greg KH <gregkh@linuxfoundation.org>
Cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	davem@davemloft.net, jirislaby@kernel.org, sparclinux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	javier.carrasco.cruz@gmail.com, skhan@linuxfoundation.org, 
	Julia Lawall <julia.lawall@inria.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 4, 2024 at 9:32=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org>=
 wrote:
>
> On Fri, May 03, 2024 at 02:31:22PM +0530, Shresth Prasad wrote:
> > On Fri, May 3, 2024 at 11:04=E2=80=AFAM Greg KH <gregkh@linuxfoundation=
.org> wrote:
> > >
> > > On Thu, May 02, 2024 at 10:21:16PM +0530, Shresth Prasad wrote:
> > > > On Thu, May 2, 2024 at 9:35=E2=80=AFPM Ilpo J=C3=A4rvinen
> > > > <ilpo.jarvinen@linux.intel.com> wrote:
> > > > >
> > > > > On Wed, 1 May 2024, Shresth Prasad wrote:
> > > > >
> > > > > > Add `__free` function attribute to `ap` and `match` pointer
> > > > > > initialisations which ensure that the pointers are freed as soo=
n as they
> > > > > > go out of scope, thus removing the need to manually free them u=
sing
> > > > > > `of_node_put`.
> > > > > >
> > > > > > This also removes the need for the `goto` statement and the `rc=
`
> > > > > > variable.
> > > > > >
> > > > > > Tested using a qemu x86_64 virtual machine.
> > > > >
> > > > > Eh, how can you test this with an x86_64 VM ???
> > > > >
> > > > > config SERIAL_SUNSU
> > > > >         tristate "Sun SU serial support"
> > > > >         depends on SPARC && PCI
> > > > >
> > > >
> > > > By that, I mean that I compiled the kernel and ran the produced bzI=
mage
> > > > on a x86_64 qemu machine.
> > >
> > > But you didn't include the driver you were testing :(
> > >
> > > > I unfortunately don't have the hardware to test it on, but I don't
> > > > think the change is complex enough to require testing on real hardw=
are
> > > > (unless I'm assuming incorrectly).
> > >
> > > That's why I asked if you had tested this or not...
> > >
> >
> > Really sorry about that, I thought compiling and booting would qualify
> > as testing. What should I be doing then?
>
> Compiling and booting the code you change would be a good start :)
>
> thanks,
>
> greg k-h

I've managed to successfully cross compile the kernel for sparc, along
with this module, but I couldn't figure out how to boot the generated
kernel image.

I looked around for quite a while but couldn't find any straightforward
guide suggesting how I would go about booting my own kernel on
qemu-system-sparc.

I would really appreciate it if you could point me in the right direction.

Regards,
Shresth
