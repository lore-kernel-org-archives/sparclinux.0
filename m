Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C933A3537FE
	for <sparclinux@vger.kernel.org>; Sun,  4 Oct 2026 15:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791127482; cv=pass; b=uAV4rHU4Mop8Jqglx2AauW2iEVuT1pK7SoNwAnSMprzkHLJMSsuYQTvMkyeeFEFBYMxqpDrKXWOKCjf4dJoFtojGdvL/kIeSTGcvWVBgrc5KhNlOawWP1MFmxs075IStx2md5Zn0Z2b1fgV+ZtIyZTJ526AVDGwOrprZywq/rRg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791127482; c=relaxed/simple;
	bh=zfERZtRz42NzMBBtXEPZ9R5a4EowuoieHt1vhQ/10JM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aPo98wKkO/FiAI4+1PBRpYCFOy1Th7UL1PTiuOsJ2fbMpnjLtX0bvl4YsiHri7DBooLT0AlOEYdEHd98i7oNQnJvzghWGR9tj4G4DjDlvieZ/Q9T9GRwiDn/S5NVZdCgP6eQYVK75y3REraBeSLOkFcjUO6UVQUsGzm5Ri3L0N4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kfG4nfR1; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kfG4nfR1"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6afbc363efeso886573a12.3
        for <sparclinux@vger.kernel.org>; Sun, 04 Oct 2026 08:24:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791127479; cv=none;
        d=google.com; s=arc-20260327;
        b=Ac7tJEB7xGvEr3rTv2a5E2OHJXCnXj7ASzFunKdOpoj/phoou1PUUxLmdEj9iTlpl7
         MIRCs55crIEKZiVPo7gac3/lMYbcV2UmrUAevrywV7rp9PNN4JtSQaEDUrYxfY4FfxCl
         iUV6hohprr1lN+cBng/Nc2tU3xA53yHzs7xZq5AgT3THzgyG16752dyzES0hdHS0oS24
         XHUpbHlw/i+hgaJ2EllfXQ5AVx/48wSIRc3ly3HIKiGDTbpP0yyhCn/F2emQfas3aGtP
         xITzjDpyyMyAvvGgQNY2YrH4/prcGnOUE4M9MXrJ2BSHFCUaqHMCOld3Z09QABVk6myP
         ygaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yUFgvHBaR611JuCHX8PR9qGQAU8yeWMF6UssxzuViXQ=;
        fh=dLisCXI+Ez4EgNV69qFbTMXitXQN0lKZ1sG8UsTmY9Q=;
        b=c4BUo/s4d8hE/lyXIkqBvuYMXu54wDQtkIdxrwT24p42VKiZqtLGDbZtkA+LZLRry3
         LC3b+WO1KdMWpUJ3zLkZfPseKUp7Ii+HIEoyH9gRmGsi78ENbmEv+9/aedi0uOb+fWH2
         uKw35klRVdz223a7AVcaWfNl+P+jEKF/F9J4ZyprBqy8J0ewC7tzgj66pJUVaXfX10yK
         aYJ3tqF2LFJsmG2BPbh99GK5rs5rzJo5JvFpUBqJ7PcrPQwfxD3cazluFqL794idiaQp
         s/65AfxgdXwkJ7PNggRv5cpn8ghfcMl1PlKIfbm+r2+HRnnoG6WHFmUs2TYCc8kPIg5a
         KwHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791127479; x=1791732279; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yUFgvHBaR611JuCHX8PR9qGQAU8yeWMF6UssxzuViXQ=;
        b=kfG4nfR1qWOn2/f1Rs4K2CHsIKHlIHQPcyewZjfrjRWiP78ikoHzQhjQWMymOTwq00
         KeZT0AoiTnDDsYmRdwN3fxYU6hRUKbx+hvDBWiU+RcPtPOeHoULpti0kMtPy5wG2BwqB
         QmKLkVoUJLxc77WPWY7nvY+/bw1Q8r1rOnRHa2XiCqJnqC7o5apNz39zTc5xO7eVSIhY
         ukAPKKk71SbLELQDv5lf3uJ8izAcgCD2UqsXaFp9bPp3cWM0VibLNCVuioHWFntEAgOo
         FCOFzvbD9Lu3czjg9bcuRioOg3jxhf3QZRNXWzrIsszHaHk2TAsByZIQrpeRwPqIlWvf
         cHbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791127479; x=1791732279;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yUFgvHBaR611JuCHX8PR9qGQAU8yeWMF6UssxzuViXQ=;
        b=yFXSzY2+Ca3ix5/23Zo/BTytM2oApsMdwJzRwdv1HMnoc7WfE47kGD1ddz8G5/dzxl
         S6IMaAhw7cwjJNrmGnAVB57j4muU02uVWKf/fU9etEAuHKmDsAUTcJ1nQD5nBB+ESPV/
         U7UNPy9xdfTFvZCwNr0BBDi3cKZBbWw0L7XILntLjdAHadgBC62lJqCe6YnIBymryRab
         uNuMfhGM0lMc7hUEUD4gxgxMdOX6qygTh4gxI6Af1bQEjZEaM4naWoeu2+WNQf+M44NP
         h2f1Ga3dyWkUNqQiJBC75X8t/KFI0TAU0fLibmyAyI9y2KpKOWxv9gcZIVfR2EPBnrvT
         cVpw==
X-Gm-Message-State: AFq9FYKl039KKnsXWw8uvdpBBHBs1mERrkwx2rbUVg/2adt9AHOsT1Xd
	KqtEfQR7d6PpTD46gxMasraYkzGOPkR6YK3x82AXEiGbluVWSlymC7of5hJEUwC9QXHuIx2jFPQ
	wkBp9TuDaiFaqUtqwHKkU5cGthF/Bsl21CEiT
X-Gm-Gg: AYBFou3qiFl+OZOuXXGOURqdIEtkgFah1+hlfsPZ1uk+laSkM0H9OKbMPWVstHz3zwJ
	5ZrPDJ+My8l01Q4muLkjqU69ZBXwCHj+wMkbfP7fFsiY399K76I784BJW4g1HCBZCtZcd1RypKS
	U+Vlc3qD73Zo1d069bSPHeiPWM5CunFffWZCogjScsZv8wCmLdRCak077qlZirQFOoa/T3tPbh6
	nbTtwF3zYWXu0k44r8dIWdUBlfVGANiaDrn+Jjay86RLF+wfCz0cD7e47chMohnbOVHRwxa8kHJ
	AHaVY3KypEt7TTllQ8UNe4dBLgQAqwZMVoo/AVtBx0aUBJX4JYZo56mYrbbq3PeejFU51CsUocU
	GWyzZDjuiifAwOveq+vv2lDN0c9+DDOf+CALa8k7piDA=
X-Received: by 2002:a05:6402:4547:b0:6ac:a828:c0cc with SMTP id
 4fb4d7f45d1cf-6afad760efemr3521524a12.4.1791127478724; Sun, 04 Oct 2026
 08:24:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261002161515.932316-1-linmag7@gmail.com> <20261002161515.932316-8-linmag7@gmail.com>
 <2026100415-impromptu-sultry-ce6b@gregkh>
In-Reply-To: <2026100415-impromptu-sultry-ce6b@gregkh>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Sun, 4 Oct 2026 17:24:26 +0200
X-Gm-Features: AclHuK-uAAu0JuOLh2P2vcb8AMeHq-JogU2rRgtxPU7ZqlRRcEoJsr_m9gxHF6I
Message-ID: <CA+=Fv5T6sMOxVmS82_VF=XOWudF06y8tWSWLv3XA1aTyAv3JoA@mail.gmail.com>
Subject: Re: [PATCH 7/7] hvc: add an M3000 firmware console backend
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: sparclinux@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, linux-kernel@vger.kernel.org, 
	Jiri Slaby <jirislaby@kernel.org>, linuxppc-dev@lists.ozlabs.org, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg,

Thanks alot for taking the time to review this.

On Sun, Oct 4, 2026 at 2:50=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:

> > @@ -11,3 +11,5 @@ obj-$(CONFIG_HVC_IUCV)              +=3D hvc_iucv.o
> >  obj-$(CONFIG_HVC_UDBG)               +=3D hvc_udbg.o
> >  obj-$(CONFIG_HVC_RISCV_SBI)  +=3D hvc_riscv_sbi.o
> >  obj-$(CONFIG_HVCS)           +=3D hvcs.o
> > +
> > +obj-$(CONFIG_HVC_M3000) +=3D hvc_m3000.o
>
> No need for a blank line, right?  And why no tab used here?
>

Agreed; I have removed the blank line and matched the Makefile's tab
alignment.

> > diff --git a/drivers/tty/hvc/hvc_m3000.c b/drivers/tty/hvc/hvc_m3000.c
> > new file mode 100644
> > index 000000000000..0ef4c888a6a2
> > --- /dev/null
> > +++ b/drivers/tty/hvc/hvc_m3000.c
> > @@ -0,0 +1,167 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Experimental M3000 Open Firmware pseudo-console backend. */
>
> What will make it not "experimental"?
>

That was stale wording from bring-up, rather than a defined support
status. I have removed it.

> And no copyright?
>
>

I'll  add a copyright notice for the v2.

> > +
> > +#define M3000_WRITE_ATTEMPTS 8
>
> why 8?
>

There is no hardware requirement for eight. The intent was to bound
no-progress retries because HVC's console write path retries -EAGAIN
indefinitely; I will revisit the retry policy before sending v2.

> > +
> > +static int m3000_stdin;
> > +static bool m3000_ready;
> > +/* Keep firmware buffers within the locked kernel image mappings. */
> > +static u8 m3000_buffer[256];
> > +static DEFINE_RAW_SPINLOCK(m3000_buffer_lock);
> > +static struct timer_list m3000_poll_timer;
> > +static bool m3000_poll_active;
>
> Shouldn't these be in a structure attached to the console somewhere?
> Otherwise you have limited yourself to just one of these.
>

I can group the state into a structure. This backend uses the single
/chosen stdin/stdout pair, and the buffer must remain in the locked
kernel image mappings for firmware access. I will also review how the
state is associated with HVC before finalizing a v2

> > +
> > +/*
> > + * HVC's idle backoff can exceed the firmware input FIFO's capacity.
> > + * Wake its worker each tick while open; keep PROM calls out of the ti=
mer.
> > + */
> > +static void m3000_poll_tick(struct timer_list *timer)
> > +{
> > +     if (!READ_ONCE(m3000_poll_active))
> > +             return;
>
> Why are you accessing m3000_poll_active like this in an attempt to not
> use a real lock?  Are you _sure_ a bool will work this way properly?
>

Agreed that READ_ONCE/WRITE_ONCE alone do not explain the timer lifecycle.
I will review synchronization between open, close and timer rearming,
and make that protocol explicit in v2.

> > +     hvc_kick();
> > +     mod_timer(&m3000_poll_timer, jiffies + 1);
> > +}
> > +
> > +static int m3000_open(struct hvc_struct *hp, int data)
> > +{
> > +     WRITE_ONCE(m3000_poll_active, true);
> > +     mod_timer(&m3000_poll_timer, jiffies + 1);
> > +     return 0;
> > +}
> > +
> > +static void m3000_close(struct hvc_struct *hp, int data)
> > +{
> > +     WRITE_ONCE(m3000_poll_active, false);
> > +     timer_delete_sync(&m3000_poll_timer);
> > +}
> > +
> > +static ssize_t m3000_io(u8 *in, const u8 *out, size_t count)
> > +{
> > +     unsigned long args[7], flags;
> > +     bool input =3D in !=3D NULL;
> > +     int ret;
> > +
> > +     if (!count)
> > +             return 0;
> > +     count =3D min_t(size_t, count, input ? 1 : sizeof(m3000_buffer));
>
> No need for min_t(), why not just min()?
>

Agreed, will change it to min().

> > +     /* Serialize the bounce buffer; p1275 separately serializes firmw=
are. */
> > +     raw_spin_lock_irqsave(&m3000_buffer_lock, flags);
>
> why is this a "raw" spinlock?
>

The intent is to protect the shared firmware buffer in console output
contexts where sleeping is not allowed. I will check the precise HVC
calling contexts and lock ordering before deciding whether the raw lock
is necessary and documenting that choice.

> > +     if (!input)
> > +             memcpy(m3000_buffer, out, count);
> > +     args[0] =3D (unsigned long)(input ? "read" : "write");
>
> A string being cast to an unsigned long?  Are you _sure_?
>

Yes: p1275_cmd_direct() takes unsigned long firmware argument cells,
and the first cell carries the service-name pointer. The existing
SPARC prom_console_write_buf() uses the same cast for "write".

> > +     if (!m3000_ready)
> > +             return -ENODEV;
> > +     timer_setup(&m3000_poll_timer, m3000_poll_tick, 0);
> > +     hp =3D hvc_alloc(0, 0, &m3000_ops, sizeof(m3000_buffer));
> > +     if (IS_ERR(hp))
> > +             return PTR_ERR(hp);
> > +     hp->ws.ws_row =3D 24;
> > +     hp->ws.ws_col =3D 80;
> > +     pr_info("M3000: firmware-backed hvc0 tty ready (serialized, polle=
d input)\n");
>
> When drivers work properly, they are quiet.
>

Agreed; I have removed the initialization message.

Thanks again for the review. I'll prepare a v2 addressing your
comments and explain the reasoning behind any design choices
that remain.

Regards

Magnus
