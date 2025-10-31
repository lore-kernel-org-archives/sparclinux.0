Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C954335571
	for <sparclinux@vger.kernel.org>; Fri, 31 Oct 2025 10:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761905336; cv=none; b=YVE9NBS/Y/5iobRgxQW7iIAbRnf8t5NgF7Ka2kXNFljOMtZ7n01TPMVioJY4wtwSyuZ+kgwKPp6BCLKvUwdD36tyPEIVn8vHKAZnftVftUJ9jGMIkfuQ9R8rv8WOvITDDxcEaAyzklklCydaQO00DKGelOkZE60I9JjbeEX3tD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761905336; c=relaxed/simple;
	bh=GXjp8ZBy18xilUA27OFjILAOQ0YF4cNrnmbDvM8+UwM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TZjMvRymQKJdm0cYvsjzgGRuJtJC/UZWkzLinxU8Rt28uL06AoM/oyeZVFbMVdFevrDKBSMuMusHvEmxjrTdat72jpeAEjCU/c5MsFA/dDv2Ro/ZjRlCHCRe/+r7xTXNetiCthMli+a2AiEgAsv8DjaCYYOytYaVodBmwmqsjiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-5db37a935f1so925251137.1
        for <sparclinux@vger.kernel.org>; Fri, 31 Oct 2025 03:08:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761905331; x=1762510131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e3JTKGjcvpUO09DKaENRtxv+sRC+3x6y4adxr9X/nJ0=;
        b=WPTSUT0J/1g/JAAv4w4Fl44W5wn52JuWn3Pz9F5PIDqpFcP167EFl/Ox8JFvxJ/Kp8
         mqMcKSI+pXHgCWzcSa3LYuuGxTYu/uB/pG0UvChVgYe/iBrl5Q0ihuH2skF6w4ppQgqR
         GhpxybSdtrlpbI8dlInboovWyKqFadwofTjgLQ1Fg3yuKNdNKwnEcj3W5xGBhAWtTY1V
         LG1pQZ6iLCQaru2W32HaYYi8ko53cqlLOhnG/Ts8Kama6tDz6/fPK+kN2fVom/Ly3RE/
         V2XNsAnLCjAogdklSsQRw1uf1B14axTwPRxOdFUp96sPDTnCRCMWY9cYT0CkaHVX/CSG
         rRQw==
X-Gm-Message-State: AOJu0Yx1IbyNWqxpB5pias3CmgXdaIL5FGk5QPYivxb+k2OnoH3+QDTm
	OA0lX6XTV0BfCXJVYnJF2EU1PW29Amki1Q7TOpp++5jmyz5rTM6iw47CY5NfbDEi
X-Gm-Gg: ASbGnctmGgq/mIE1wqLyvmVSDHM0cUMIENKO5KGmutojz8POLqt9HG7msM/Oxry/ap9
	KBeHci0EGbq78K2NK1QQoRzdIgz8u5Cf29Kq+QxiuRJyazo9W+/PzIODI0bHnZfCwYEfTKWSy5W
	GrTwCHuj5lmWhxfGm0hkLe0bA8qc9TmgttESPK2RWBa/tH4TpvPdzOL1f98cTlifY2akh1lA/yX
	YbfQ/M6YLdi2PTDDe9G2AgcwHfhJT4+vmToqisMje8Asd1ZRvrXnqmhLc5dL4okHvyLtjb+NZQ3
	7JPOvQ3koEsjVKaHsadmi6n7Y428C/GMcmwIvRuhdkJeSKq0f+XHGiz81O/LN8Lb/ri74K0Qxwe
	d2dCDExAlYtc5sJ14d2dEPYqn9w51IIbAXgaI+Lne5Gnmz3xnUklARFjG4AOy1SABV18qHKzWXL
	chsrC8sBVirtHS1aazu25/IkMFWCz6xkImwL0nKw==
X-Google-Smtp-Source: AGHT+IF8q3dSEgmxOJD5lgHfpO2oKgAhrnqYd9bUOlo1GXtEG0uT/YPj7nf85nPmW2ffpqfHf66rxw==
X-Received: by 2002:a05:6102:510f:b0:5db:54fc:369f with SMTP id ada2fe7eead31-5dbb13260bbmr718098137.32.1761905331112;
        Fri, 31 Oct 2025 03:08:51 -0700 (PDT)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com. [209.85.217.54])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5dbb5db2699sm464475137.0.2025.10.31.03.08.50
        for <sparclinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Oct 2025 03:08:50 -0700 (PDT)
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-5db385e07a6so948606137.3
        for <sparclinux@vger.kernel.org>; Fri, 31 Oct 2025 03:08:50 -0700 (PDT)
X-Received: by 2002:a05:6102:6216:20b0:5db:b35d:abcd with SMTP id
 ada2fe7eead31-5dbb35dac5dmr303555137.8.1761905330752; Fri, 31 Oct 2025
 03:08:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2fa899eb-60b6-4637-9035-aeff78e261fa@web.de> <CAMuHMdX-uKt3-Lb2NaxmONEqWdtFgTOqXEo1nOfGq-R8ysHfcQ@mail.gmail.com>
 <33199802-d83d-48e8-9032-f1c4c61cfee7@web.de>
In-Reply-To: <33199802-d83d-48e8-9032-f1c4c61cfee7@web.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 31 Oct 2025 11:08:39 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXL+YXxwAM+HkawzTMxL2ez5O4bQ-j-LCCXTjz=NoLOKQ@mail.gmail.com>
X-Gm-Features: AWmQ_bmfYw_9WSYikEEtVKPAs2-VGkHCdHdb26XN5HT-568_sb09UKD7rIRpQBo
Message-ID: <CAMuHMdXL+YXxwAM+HkawzTMxL2ez5O4bQ-j-LCCXTjz=NoLOKQ@mail.gmail.com>
Subject: Re: [PATCH] sparc: time: Use pointer from memcpy() call for
 assignment in setup_sparc64_timer()
To: Markus Elfring <Markus.Elfring@web.de>
Cc: sparclinux@vger.kernel.org, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Andreas Larsson <andreas@gaisler.com>, 
	Christoph Lameter <cl@linux.com>, "David S. Miller" <davem@davemloft.net>, Finn Thain <fthain@linux-m68k.org>, 
	Tejun Heo <tj@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	kernel-janitors@vger.kernel.org, Miaoqian Lin <linmq006@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Markus,

On Fri, 31 Oct 2025 at 09:46, Markus Elfring <Markus.Elfring@web.de> wrote:
> =E2=80=A6>> +++ b/arch/sparc/kernel/time_64.c
> >> @@ -760,9 +760,7 @@ void setup_sparc64_timer(void)
> >>                              : /* no outputs */
> >>                              : "r" (pstate));
> >>
> >> -       sevt =3D this_cpu_ptr(&sparc64_events);
> >> -
> >> -       memcpy(sevt, &sparc64_clockevent, sizeof(*sevt));
> >> +       sevt =3D memcpy(this_cpu_ptr(&sparc64_events), &sparc64_clocke=
vent, sizeof(*sevt));
> >
> > IMHO this makes the code harder to read:
> >   - Only 0.15% of the memcpy() calls in the kernel use the
> >     memcpy() chaining feature,

It is also less clear the passed size matches the destination pointer.

> I obviously propose to refactor this implementation detail.

Oh no...

<other-bad-ideas>

The above function could be shortened by writing

    (sevt =3D memcpy(this_cpu_ptr(&sparc64_events), &sparc64_clockevent,
sizeof(*sevt)))->cpumask =3D cpumask_of(smp_processor_id());

And after introducing a variant of clockevents_register_device() that
takes the cpumask as a parameter:

        clockevents_register_device_with_cpumask(memcpy(this_cpu_ptr(&sparc=
64_events),
&sparc64_clockevent, sizeof(*sevt)), cpumask_of(smp_processor_id()));

</other-bad-ideas>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
