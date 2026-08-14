Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2A63C0A0D
	for <sparclinux@vger.kernel.org>; Fri, 14 Aug 2026 14:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786717122; cv=pass; b=jIO2pVhy7eLn3MF16Z8zL8kMCh6cIJRQ/rq5HWNtPPpvvE4go6vl4DDmxACrxhhelhJBWA49IKfjAL3W6sR6kA7UZ4scHcL0LAwf6w8KCtbd5lZnd+YcfBjvOMOMx6APeozutOh3VBSLxxQdF3ea99vc0x5zaIyg+HBpAw2eCwg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786717122; c=relaxed/simple;
	bh=J2Et9xBW4RkgZAk7FjSJnpHByk38ElsVSS5rO89oVz4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P0OQ9KBOTttgUCTsJG+9RXTqGnXzHOULuh4zyR0/KTS1LxQ5cd/xVGsKdA/yKuQkT3b4hvw+ztDUsLOiAFU6PHMB+N19tsnarcXDqZ729y95gnDS94jlyAxc2HNHkg+aq8IeSsqZlmTTX7hOEcsFtDiHwLdopLFqlrmvwYrxVh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gnCYHmNr; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gnCYHmNr"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6a38098734bso1578223a12.1
        for <sparclinux@vger.kernel.org>; Fri, 14 Aug 2026 07:18:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786717111; cv=none;
        d=google.com; s=arc-20260327;
        b=KNjyP2KYGQVXrL7oTDjp2Udi/yEpLGoPBe7HqelGN3GTQnRH32/30FM5dSZYXVLzQj
         5Kwlhz6fczsu445ymG2sS2YmgQK6EC/cbX2tjUpjcfRdDM4mZYzGWBVuT3K7enmU3NhP
         /QHTzHUi65JpUwRgp7wtg512KdSpQRK6In8o61wBlJUe7Ko1G9N/8onoCzaN9j5FQvAY
         VgNhkjN86W7OGl4gQAgsi56jJmcjE47qpqQ9hvbUOL7hlz7kKuK9Qi2luNOEpN5gUTtH
         tW2dRX6+OhVoT1jygX8vve6g/gxLrszBJpL4QBG7qtk4hTvUkl/SgSIr6y5pdyMHqZgu
         BJig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=J2Et9xBW4RkgZAk7FjSJnpHByk38ElsVSS5rO89oVz4=;
        fh=wEW7VA2S3UfdOnw30iaMOuH83Z8KVNqgeJG1bCK44o4=;
        b=ksTziFimsYMUBimW+ldKER1gSFQps4L+3sypNAqFC3XjaMJd+nxzs7rj9RuB1sUPLR
         hPTbzewil5ssOJpQ4r16FejQu8dnWqaPAkLZAyJTnedTnNeJNEbdwWRFZt/LS/OnIYgt
         2teHQcrMjbis6rayZFk+nwBIZFFTvOr6TTnDqg1LJsc1V3vpTlJ69IFrySb81Z1SpREg
         c5gc+K25go720iYXxKbF9HK0bJpyiby2HPEL+07fTY1y3YS2LbSHGd+dHXB1DUG2pzgv
         18AagfuBrWOkMr0Gu2rjaFpKtVT0J7RkreBGwXD3ptqUjPCU24rSu7fetzE1Z0ag7LLo
         V2gw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786717111; x=1787321911; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=J2Et9xBW4RkgZAk7FjSJnpHByk38ElsVSS5rO89oVz4=;
        b=gnCYHmNrq9DqEFTeBlesYOmuLZyPZqr5d71WjNtm9YXzkXf69u2SwfBJhDmjJFSpDS
         EvulQ7A0i+9WDLx9iXfX5S5h5dPM4CRtG6kWKFy4UfqnVF/GkPiMmdoGBHYSbmmt374t
         ll72FIOKOVaHDeMqNtLVPhO5vzfM/qWXuGpcu2+WMGE9dg7k9iKQilqHYuwjf/yFXn1I
         oBut29AQDtyTzaC3hVQd7jk8YgFTfMSb04FaKfURkzbJ5ajmrsdv5vYeNurx1Rk1Svdu
         LWADkk7O4Kk+g3wwtWvm8Ch0qm69yMvXVkMCFR1V+YpkkErqRjEUSZSQWuhzWAW0Sfpt
         NE2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786717111; x=1787321911;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J2Et9xBW4RkgZAk7FjSJnpHByk38ElsVSS5rO89oVz4=;
        b=U0a/zfNKEmzOKW61UREnn434QIdzJPndeKszwOrbPtmXjbUgwGlhChEYLrpdY2vrE/
         +eHqlXk1KS4A7GWNOTQYtXTDs5cdfz96mKyv202ko2SpzUAJluby5p1lW/ZTU6HFYQY7
         70jyl3ixw5ky6KvwJqnJ3d/wvYN1x+AIr033ZZaX7G9+KT7A8MSYLGdLeHqQwwpd1gSM
         gL+1+2Gisrbjusk7hO82nLKJ/xjg7tl9uHPPn6gQSdUQOzfE7zKnwWw9H84CB4/Xch9/
         fs046gP/vImqWvRGP1g+uENENsHQE/GjiBnAep9nN25GbYki/H0icNrl5gSyU9S3uKQS
         5BKQ==
X-Forwarded-Encrypted: i=1; AHgh+RqngCLlsCaRObJfFiODSKHC/6UrPqBe1QI4kPu/5UOYS7jCsk3eoxnzDrIBnU3UUmWL8fddGZ8awvUs@vger.kernel.org
X-Gm-Message-State: AOJu0YwRu1XOJp1N4bOdznC5PRwZGQFRtdXBlWK+vB3mzPHHtpqJD6rb
	X8u4HGWCyg8iEe0367JBqQI4Ru+CtQ+j9f0BGr/E76r7Xgw0rK9VB8+vJVPqO5lAymx+A4zRCjG
	UBAz2Kqt6fKlm5d3i9cGWhcrTX3P+XYQ=
X-Gm-Gg: AR+sD13bYDFfqyza7yBQwwQQ47iLqEYnW0FnPiHZaoD17LnvXV9bvmlXBx5uPFV2plt
	HKNbNC6XKZ+6XeJLiwZitbj2Cs4KBJsLQdBiIjQOB22HbBwoWlrfrqb9uU3VXMizOBmIG2i09ns
	bcesB072PfeDMBWMfu96ZA9dctulkYu0vxYHPHWBe+BUHpN0mRlWHZ6QcPO6YnKjjpKYeY9s568
	fuHBGQAwb+KgzP5wg02ZbuMhjm1ORKqGdVSU1wYaDpcQPlbOBpig36emj51p7aeKFTvlj3MteEl
	23j5eYbnotfOwUNClUesdHdouxmd85O8CLE1sj+qlyCSPLx94Xz5GYaEWLyExZzqzY9MUlrAyjg
	lOT2HC+gusvDUG8apwKtD3pIFihN/yjY=
X-Received: by 2002:a05:6402:5cf:b0:6a3:8652:a373 with SMTP id
 4fb4d7f45d1cf-6a38a8bbf12mr3048120a12.3.1786717111059; Fri, 14 Aug 2026
 07:18:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260814105723.3454511-1-linmag7@gmail.com> <0d428f9f8b6084d80b65145e148025b170703345.camel@physik.fu-berlin.de>
In-Reply-To: <0d428f9f8b6084d80b65145e148025b170703345.camel@physik.fu-berlin.de>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Fri, 14 Aug 2026 16:18:18 +0200
X-Gm-Features: AUfX_mwNFQzltwNXc_tdiAxQYd5hTGhsFzj1js6F9kFAgth75LYIDaD9epQ6Fhk
Message-ID: <CA+=Fv5QBfTFYvot-agcYEAn4EVvXGFg+VL5BABvk6FshzU4x_w@mail.gmail.com>
Subject: Re: [PATCH 0/3] sparc32: allow a kernel loaded away from the start of RAM
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: davem@davemloft.net, andreas@gaisler.com, sparclinux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 14, 2026 at 1:25=E2=80=AFPM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:

>
> Awesome, thanks a lot for working on this!
>
> Do you know whether GRUB would work on these machines as well or is there
> anything that blocks the use on 32-bit machines. I'm currently not sure
> whether there was any show-stopper.
>

Thanks!

I have plenty of sparc32 hardware sitting around, and this lets me run curr=
ent
kernels on it again.

GRUB is not an option as far as I can tell: there is no 32-bit SPARC target=
 in
it at all. configure.ac maps target_cpu sparc to sparc64, and the only SPAR=
C
platform is sparc64-ieee1275, so sun4c/sun4m machines have never been cover=
ed.
Happy to be corrected if anyone has got it running.

SILO still works, but it needs the loader side fixed too. A current kernel
does not fit in the 2.5MB window it loads into. I have a patch series for t=
hat
here:

https://github.com/linmag7/silo/tree/big_load-pr

Magnus
