Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4B5EAD5;
	Fri, 31 May 2024 00:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717115652; cv=none; b=fi518GI2FWJZjddVhtDGnP87w2AAompSbO37arKi+zwbhFdd+RsONeUUlaIU3SqBNUN+eWq6eHdCEuLKy5L+4cWhUPBC735Mha3Kg2hfF5bSEuCeWyqqfK79qltlcsHrtExfl9V+m/oYspAP88KwLMrgrpKqenCcp4gihTlDK7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717115652; c=relaxed/simple;
	bh=4iD+jMVrqhrZtx04FcJs/ARGL03L84pPco+/wK/UA+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fQN+Ls5sFJ8OaHvRP4SyfzLikKFLNXQmnvDXIyiQM/6MuWQQsgAK1OIY9+xbxRCMNDBZ9PdtvwgcGNrSAansyra0ibDsurPS+6Fl15CIiesE3HT3UhoVvMP25UJKulZVSwd8kj1zMZtKRpLR+MRBEJTOf3BbBTK7YDOFKhOzFXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b6x7kPSN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b6x7kPSN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D406C32789;
	Fri, 31 May 2024 00:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717115652;
	bh=4iD+jMVrqhrZtx04FcJs/ARGL03L84pPco+/wK/UA+8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=b6x7kPSN5aAVzsB/HUrBHdjU+AYePayTWNmjFw0naAiPhXJoMdR3Y/q1DOv/UtA9a
	 pmsbQFXjh+tebTUPZnk5+M9xSEX/wT59tC7MQPoo5YT6XMmTuq7eMVV+db0jhPxzms
	 U7gFEeF5SVTJgoOaVM5iKd+Wd2ll4ymPOVkPQbNj1rRv/U/1VMB6Ih0mxeDvodamwE
	 pd6OFKFWk5hza4bMFrN7BGTNkk5KDkgvPba+WjOGVHH9WSitMDsAzyAgNB7RW/J6KJ
	 mhPvkZ5xh6p9YQEAXPsT9WpM9XcbIrcOO5jzd8dD3zYiTC9zTUlz4wcpCZDH8U5G9E
	 KjoZlylYjeHuw==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52b78ef397bso1524927e87.0;
        Thu, 30 May 2024 17:34:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV2SqcfQ6CDTU6JkHa3CcBOoMKXiOfD3httDUJ0IzOC5UTTAZkiu3VwJUH5Zu1AGfThAL2rYoIl5oK6iYF7hCJLtdpeogpfsdMrgZmuj9DhsSHzdWbRFxk3IvUEhzseO3QgaSb2bzuiJWGh4gMqLMDCYmmHic0FkHR5/3cyj3ZB2SBDYDo=
X-Gm-Message-State: AOJu0Yy0H3yx/II0a3rjXhhDDjklxgb8XB6EncAAyXMGOwWOYun1zFd4
	VWaaDhT6+97z6z+En4ZADemH1saOISzfoRedGOwjMZvzdCiAU+UNYWT6g2G1ce09m0yfPeQsyXV
	Wh7zNOVPJUgea/bSM90A62QVI0w==
X-Google-Smtp-Source: AGHT+IG9Z2EpLaf4ub5p6M8NL3Z9H8cwWJ6uYyD+6TnyOEekF3Ohw3BBBbGyhA2vy6pz+C0o5/Vt7mALs2KAtVfTuys=
X-Received: by 2002:a19:5504:0:b0:52b:6a18:5b00 with SMTP id
 2adb3069b0e04-52b8878cc6bmr131096e87.34.1717115650688; Thu, 30 May 2024
 17:34:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530185049.2851617-1-robh@kernel.org> <20240530-surging-sprinkled-f209b2452395@spud>
In-Reply-To: <20240530-surging-sprinkled-f209b2452395@spud>
From: Rob Herring <robh@kernel.org>
Date: Thu, 30 May 2024 19:33:57 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKC5kkMvWDHVdt-3gS-sW=t=cvLctVVbHhcvPXpe-2nSQ@mail.gmail.com>
Message-ID: <CAL_JsqKC5kkMvWDHVdt-3gS-sW=t=cvLctVVbHhcvPXpe-2nSQ@mail.gmail.com>
Subject: Re: [PATCH] of: WARN on using default root node #address-cells/#size-cells
To: Conor Dooley <conor@kernel.org>
Cc: Saravana Kannan <saravanak@google.com>, Andreas Larsson <andreas@gaisler.com>, 
	Sam Ravnborg <sam@ravnborg.org>, sparclinux@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2024 at 2:21=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Thu, May 30, 2024 at 01:50:48PM -0500, Rob Herring (Arm) wrote:
> > While OpenFirmware originally allowed default values of #address-cells
> > and #size-cells, FDT has long required explicit values. It's been a
> > warning in dtc for the root node since the beginning (2005) and for
> > any parent node since 2007. Of course, not all FDT uses dtc, but that
> > should be the majority by far. The various extracted OF devicetrees I
> > have dating back to the 1990s (various PowerMac, OLPC, PASemi Nemo)
> > all have explicit root node properties.
> >
> > I have no idea what exists for Sparc, so disabling the warning for it.
> > If any other platforms hit the warning, then the warning can be
> > disabled for them.
> >
> > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> > ---
> > Sparc folks, If anyone can dump DTs from some Sparc systems it would be
> > helpful.
> > ---
> >  drivers/of/base.c | 2 ++
> >  drivers/of/fdt.c  | 2 ++
> >  2 files changed, 4 insertions(+)
> >
> > diff --git a/drivers/of/base.c b/drivers/of/base.c
> > index 61fff13bbee5..6930aa29fec1 100644
> > --- a/drivers/of/base.c
> > +++ b/drivers/of/base.c
> > @@ -96,6 +96,7 @@ int of_bus_n_addr_cells(struct device_node *np)
> >                       return cells;
> >
> >       /* No #address-cells property for the root node */
> > +     WARN_ONCE(!IS_ENABLED(CONFIG_SPARC), "Only listed platforms shoul=
d rely on default '#address-cells'\n");
>
> I assume "listed platforms" means things in the first parameter of
> WARN_ONCE()? Since that's only SPARC, why not just say it? The error
> message is rather obtuse as-is I think.

My intent is if you hit this warning, add the platform here. I imagine
it will be older stuff we can't or don't want to fix. Maybe I should
just say that as a comment instead.

Rob
