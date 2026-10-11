Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC112C0303
	for <sparclinux@vger.kernel.org>; Sun, 11 Oct 2026 19:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791746921; cv=pass; b=CR25JlHizS26/k4XoLIKpz9bpIoTJrhKQ0mUaJ/cvQVLNZLu89sM6SiFcy7paJRC4fSWEFBYZCh0NT9aVVD0HCu6fAAin/kZDsrHEcsIkUZF9wxxn5qodnhHXxgLOw1NS4dacLCgPcaypxhZg8HObu8QPMz+EYVLs57/xV0ymGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791746921; c=relaxed/simple;
	bh=BLEABgEnE8rYAQd8iA6vK+bI7h+sKyrVuNbJ+ipNorc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hQtju2RL9+NR/dR68XoqIQrSKFJNsZYHt3CPNHzM8m1j4hbjIkrgp5vQaG06RXsk2R5O6fSlYZ959HvDyl20lu/EJurjdgM5bkM/0v80NuJ+FxnKGTjs2vgyOY/FBJ04oS2p1KcO0Nhi9jaDIbOY5RqfbOgABb6REO4s9Ob9WUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MRkDF3k0; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MRkDF3k0"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-677b5148acaso943460d50.0
        for <sparclinux@vger.kernel.org>; Sun, 11 Oct 2026 12:28:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791746919; cv=none;
        d=google.com; s=arc-20260327;
        b=FzGEc9NflJs+DHNs//uXtx01KidjkG0dNmB69ChgGp/oWgQThgxQ/M9wUSPWRB6g/2
         kCIGXGqehcWf6VE+gY0gng3d6JJL577+3aQ0aT41gFXnrz/wwRGd8jAiI4Ss2G0zr2Gq
         85Tn0lMblBiKtbylQgCiEaOuJIxgwH1MHTCpEFYpyTJ+UtFfvZiv859vdnp+vBxDcWjI
         O0gZI8OzVkqD18J01BhhBQ7PGSJ7/K03pzkGcGS+0RzjsF0aDVQ4eX0OT01AYzhMmSs0
         ZW06324Y3pH4qutuhhlbBRyU519rY/ULYz38FCyz8cGbah0D2KQ7oIQJ+y6qPZ3f9fSj
         5kag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uIoUJ4//XLHXKPGzWcHseIlVJr2mS00wCM4xkDYRnJQ=;
        fh=loDIP39DikOeOIW8kmgZjnsUOxdJmsmOrrj33OOIrh8=;
        b=syc7o0NYzDNrw7RHyz+eHJ5PEfztwLVbLxtl6p2TffWfCrccvyxSquYnQKcXy10fHE
         t2u1zkBDy7SY8SGZxpf8KXXsGQQ3ONv313iwPpN/+QJHFlkNctyIcWe12ECKdARGd1Qo
         oPLfUScyPXGiztBd51ERCLmxs+0858awDObl7i5fiCk0u+h8LYBDD39XPeGBmwq4EVYn
         bEwV1LAWCqE/od5RiRaZOA072f0jtXFRoAcrk4FTp5gIxz4rMwYPAI6V9YOqZLt97+Ke
         aARM/UM+uSWLtVcDwF42CDspP6Kaq5rmqfLNCINpRcwC315AYUUdsPS+7ngFRofb7w7U
         TxvQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791746919; x=1792351719; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uIoUJ4//XLHXKPGzWcHseIlVJr2mS00wCM4xkDYRnJQ=;
        b=MRkDF3k0xCCXdziUjawv6bpNREPc3/s70nKgLS9ojSFWAdvfvCefIXIYsfoyaugC3A
         3pGUyBS73oPXZwl3ZZNNKV4DEhUQyJkzOK++2Vqh6oeIRlasqRmcy4WwDfyq8SRLim7n
         LZIFsCMznlin/YAgoU5iFzrIPu3OSPNNW3QDKmwmaK0nJ6FFUMtttyemssQuBniSzUWW
         +3hBUcEhLcUx0jVpJa94w/s1I4peqpHAJ+ErmCFAH94QtmcH/+uhwSNJgm7CzJTRzm51
         M7b52PRhDuKMgadClO87w1+rM0vRNcUANWIzwzmK4io3Lvy+XtoXTKUhoWg3YhpkT5Ez
         Sqpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791746919; x=1792351719;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uIoUJ4//XLHXKPGzWcHseIlVJr2mS00wCM4xkDYRnJQ=;
        b=BAL8Zh/eYr1nIy3urQcKnB1SusQN5shPbRpZ55u6mnxK76Q1QRChhg7PV053JLcB4O
         d7UlmFu9cy2uhtw6OL4MTKq9is5VHTiesWmYJLXKrhs9VtOrr/aIa3YF8yzZJOkJZmYo
         cjGQblB1S3qJ6/Q8V7l9WM2qFE4alsIpEOwCMmVz0o1zou6MMQ0AVbP2iJ1IGkzS8+aI
         hB6ehHSzKk5jgz78vH6Z/6pIakpy7QEatf/68Q+HsdYrbyIHDnTBfaTdESSzwY8CMaJs
         ivVNRoe+Gq1KZNluszdK7wUQzxkJeFPcbBoei+4qgTHgw3ZmogNuX9UVVdM/Kfdt/46v
         +hhg==
X-Forwarded-Encrypted: i=1; AKwUvBwFEmxMmdBiz1DUSAvngiSz3L6F4V4S6HNPg874mvSHMXbmkvQtdyt7k+GgoEp9lBvgSorPRCEyTxXv@vger.kernel.org
X-Gm-Message-State: AFq9FYI63n19QrPlBrLgCczBdkcdAHZDNYoETMNlk9AbS+jmRrYXNwpl
	Zn+KKYCTE0zb8tTQE1FkQvhJO1p2RCFWmuhKzBRHspb0NdJmrvUhx2uPiAoY4lcnDlv9PA7ZSwq
	1hIDqwQ7fsg04Lzo+axAgIjWaiEaxEzBkWXfDmSo=
X-Gm-Gg: AYBFou0kf3W2RE6kEH3JEm+qiQRFf8J2hojMbFjgnyLwn+IV9HEXc9Ya+Vk9moHdj/2
	omUtqMX6MwUykEF+n/BSdh0QsMPAfQQdi2Cs+3IUqgMceSBXfozJdWEH7a3OA9+jMK1E2jrJloo
	sptLhJm3DGVX0VK/aQ7k5NxPkB8zHCRbmT+nDdl2Mcvwj1fkCRArz2Q65xpsNQMLXFd417I9Tpe
	HlkLZej5+dZKuP5CZLm28gUd2tl9x/bK9w3mnYrPtnsJemCmfdVnL0msPd/qoH9q5bMrm6U95JV
	cQQLcx5l9nsdhCHie7p1YAHEGCRZZgcklMujo5855EIRpg5dWTKMbXGLfXRzSWG5o39yVEHfHLx
	tXBa3L+A/i9DNNR1vTfjkWMo8kBGhh2CADFFClZ1f0vmIwt/hnVr8
X-Received: by 2002:a05:690e:43d3:b0:673:8cbe:c16e with SMTP id
 956f58d0204a3-679360595ddmr1290533d50.69.1791746918680; Sun, 11 Oct 2026
 12:28:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b74cffe77f82562fae8cf611349e765f1f38af2c.camel@physik.fu-berlin.de>
 <14ae2aabb9e681a69818d3e02da8273cd12261b8.camel@itx.no> <69c1798a6409879a70474c10e3d653fdb37c7246.camel@physik.fu-berlin.de>
 <ef8e85c1fc00c999e74b2d43048bfa67997c13a2.camel@itx.no> <01bd740a7b5f2c5cd12b4ba025fb9a53573188bf.camel@itx.no>
 <ed3c37da1320ac19bd45dbfaa89957d9a8c05e0f.camel@physik.fu-berlin.de>
 <b85e047233f5b38cdbfbd7af852ce30055680b47.camel@itx.no> <c4fd9e838043b2b552ea9c33dfaf716a5e9d5b6a.camel@physik.fu-berlin.de>
 <6a37e24972e63cf3c6212644e7c3f18a8a9c06da.camel@itx.no>
In-Reply-To: <6a37e24972e63cf3c6212644e7c3f18a8a9c06da.camel@itx.no>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Sun, 11 Oct 2026 21:28:26 +0200
X-Gm-Features: AclHuK-nIFmalB4GuEIorrewu--1XC3StbQgKc4FxbrF1MWh7noJhY1zIqKs8t0
Message-ID: <CA+=Fv5TZYv53K=c9QFhwCSXJMVyCi5Kv6WjPKUcrPxEpU2BKUg@mail.gmail.com>
Subject: Re: Mount crashes with SIGILL on v240 on for-next
To: Stian Halseth <stian@itx.no>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, sparclinux <sparclinux@vger.kernel.org>, 
	Imre Kaloz <kaloz@kernel.org>, Andreas Larsson <andreas@gaisler.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

On Sat, Oct 10, 2026 at 10:45=E2=80=AFPM Stian Halseth <stian@itx.no> wrote=
:
>
> On Sat, 2026-10-10 at 22:18 +0200, John Paul Adrian Glaubitz wrote:
> > Did your kernel ever crash with CONFIG_CGROUP_BPF enabled? That was
> > my original reproducer.
> >
>
> No, but my V240 (Sparco) runs OpenRC, so even the test kernels built
> with CGROUP_BPF=3Dy had no cgroup BPF programs attached.
>
> Since v2 fixes it for you, could you send your Tested-by in Imre's
> thread?
> https://lore.kernel.org/all/20260928132102.1707-1-kaloz@kernel.org/

I've been following this thread and made some tests on my system.
I tested Andreas' for-next on a single-CPU Ultra 45, built with GCC
15.2.0/binutils 2.45. It boots successfully both with and without
Kaloz' v2 D-cache alias fixes.

However, the same source and patches built with Adrian's full config
consistently panic while initializing the LSISAS1064 controller. The
failure is a Cheetah deferred-error trap reporting =E2=80=9CBus error respo=
nse
from system bus=E2=80=9D, usually in MakeIocReady()/WaitForDoorbellAck() in
mptbase. Building MPT into the kernel instead of as modules does not
prevent it.

Starting from a working lean UP config, I enabled the following options
incrementally without reproducing the failure:

  - kernel-side XZ module decompression
  - modular MPT/SCSI and ext4
  - FUNCTION_TRACER, FUNCTION_GRAPH_TRACER and DYNAMIC_FTRACE
  - JUMP_LABEL
  - SCSI_SCAN_ASYNC

The latest kernel has all of these enabled and boots successfully.

So the failure appears to depend on some other part of Adrian's full
configuration, or an interaction between several options. I will
continue narrowing the config differences.

Regards,
Magnus
