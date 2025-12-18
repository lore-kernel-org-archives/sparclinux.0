Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A643B32142A
	for <sparclinux@vger.kernel.org>; Thu, 18 Dec 2025 12:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766060981; cv=none; b=Y5DgjK+IeLZcAF1MxtHkKz7l6M1HxWF2kNNeKbOLKtR3AuX0qCIZIE/cNxIvtw3I3jk0rzuDxMLSyNT+slfNYYuAvLdgd6bMme30OQ3r9+Bl7GS79PAY/ShgF8mTCzK1u3IdtwZLRevsa8Rtue5A9c+RnmavWDY6TEBWUfsd3hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766060981; c=relaxed/simple;
	bh=ffPTyuiEVHWwTCiNfJpfvcZQat/klsCzHR7/EM+Qf10=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GIZFHbzpenFFLAqklHZgzstuVr8zDpXg5V3/2GWloXlfU3T6yDfLF0r/DpATTS1WZYJg5LwmL5CV3YfdXG3+lnLkabOsnAn01bwvTD74FijMteS/FDYxXkaVI4JRV0qMb93t3nQgWe2oMUmLuF/ftdJg1ul9Lq1hXjJHngPZ6aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V0faqMlq; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V0faqMlq"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2a0bb2f093aso5995935ad.3
        for <sparclinux@vger.kernel.org>; Thu, 18 Dec 2025 04:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766060979; x=1766665779; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ffPTyuiEVHWwTCiNfJpfvcZQat/klsCzHR7/EM+Qf10=;
        b=V0faqMlqLPPqIDrihHodxm064xbKtegyNJtiRgMAXZiuOVXmBpeYrXTmb9BvPCjerg
         Taw59kv2VOTpN6UiZs+cJw2zdl6B01gEh8afLVbDJ85CktQEvYiDEtkNrQ9IYLDv2BFo
         /7H6b24pELOPVll7XcIxH9k+EqsbzwjBFKht5IgGQoIQ46I5Rx48y1gH2m9GIXfqzWIX
         04AWLPr18TwPHKKwasAdTYsGvqu+gNx/CM67i58yFMxxEeQ2l9/swRZIphbkFX4rAaMH
         k4fbMZwr2Kaci5rm8lM6lvEahG4SE9F81CzTkCuBgINwLwlvub0pxrCz/Ir1x1LBZSbU
         FaEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766060979; x=1766665779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ffPTyuiEVHWwTCiNfJpfvcZQat/klsCzHR7/EM+Qf10=;
        b=Ydy9YB5LGVyr4K7G3ExDNgTTJrpnFmKyUEf7UXWDZjSYTnvlXjSPvPcCwpKvlQqFBc
         4IoyHwlJtC2nHNF6olCLsUi7fKIOfZgjZUASz92W4thHTW0UN90GThKD7EKIdP4NLWZ1
         nDszRe4oHqJHwLCbyleN5CwkCYCeeqdbWX6rboKViBybDJHsGHrsh0w/LjN9sqtinLVZ
         VoO/PtefysvyxOyktT99PLK8P4yUu3iglGDqhMYGe7FA3N6hAYNvdFW9N8xRoDhiZKnG
         HHZTam3dA3QHgl4QB6zmloUmKr/eMrqDngw2bgu5IqbNsmXAPDH91gdBS6ZOe5kJzhzj
         h7xg==
X-Forwarded-Encrypted: i=1; AJvYcCUzzP5VuU1DtobbQT5SqsfIjmc+7UxM1lTQ4+QZGD30iCGhsOIiMb0P4LcC0+pYZPV4rsgJozp5NGGX@vger.kernel.org
X-Gm-Message-State: AOJu0YwC5AYkw1DMh7cgicX7GqZGHz6lfY31BBd5XT5Pb84JDF/GeOlD
	Q+TBGycRK448nqz8iWKEZ1p3PUVD/sQTWah0csSy4jF3X+ziubced8YLnCiTzLRfz6/B7ly5Yt0
	ckuLmQL/g7KEcW8Cvockazhrg+dy/Eig=
X-Gm-Gg: AY/fxX62hMgOeEuYilLNnji1smSOeRHtnUWgxoLbfZp71xaIe0saslur1ME6pyphhJy
	hB+WLJMYZ1ESEZwz1k5xmWgO35asgMqPlBIiu+xOG1iI0xBDqfThCOyjhDf/3+W9DI/zQlTqZNz
	bKa+p/IvVpjML8AYp20oGq7RIdwVL5S7wfqKLU0cYOmGry3RVsBHn4kKxiJQsYS1bB3V6UwCbye
	d9YsLV3A7hcRxC6bzWLAYPXKEwm1mL70hGzqgxrGm35k9+B20P6z74hwiwXGf0dpr6YyN2bUAEx
	3WZn
X-Google-Smtp-Source: AGHT+IEttbzL3TgeISd4JSQbWLlcIpr31jHSAc4dl7Ysmfw70BtvwM2g27MIdwEy92Jtor9ZBzlV7nCoDMgSPn0w63c=
X-Received: by 2002:a17:903:1a03:b0:2a0:afeb:fbb6 with SMTP id
 d9443c01a7336-2a0afec014amr148642795ad.8.1766060978829; Thu, 18 Dec 2025
 04:29:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251217120858.18713-1-pilgrimtao@gmail.com> <aUPiFbuaglcjqiB1@kernel.org>
 <CAAWJmAaxtKY50BEm3N8V1QTwpyCgQLfLFarrVfPVVpXg9ftmcw@mail.gmail.com> <aUPvecgVj8XXBcw5@kernel.org>
In-Reply-To: <aUPvecgVj8XXBcw5@kernel.org>
From: Tao pilgrim <pilgrimtao@gmail.com>
Date: Thu, 18 Dec 2025 20:29:27 +0800
X-Gm-Features: AQt7F2qe4Pk_SuV9V8zg1gW8M29Sp6bxxmJHkeChyw-ETnoQVSTJAeHwFR1AQTE
Message-ID: <CAAWJmAa44SF=dj+FTiXn0aZwLLGbSTAieb8Cy73RE0sGAkAYLQ@mail.gmail.com>
Subject: Re: [PATCH] sparc: Use vmemmap_populate_hugepages for vmemmap_populate
To: Mike Rapoport <rppt@kernel.org>
Cc: davem@davemloft.net, andreas@gaisler.com, akpm@linux-foundation.org, 
	david@kernel.org, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, 
	vbabka@suse.cz, surenb@google.com, mhocko@suse.com, kevin.brodsky@arm.com, 
	dave.hansen@linux.intel.com, ziy@nvidia.com, chengkaitao@kylinos.cn, 
	willy@infradead.org, zhengqi.arch@bytedance.com, sparclinux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 18, 2025 at 8:11=E2=80=AFPM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> On Thu, Dec 18, 2025 at 07:45:52PM +0800, Tao pilgrim wrote:
> > On Thu, Dec 18, 2025 at 7:14=E2=80=AFPM Mike Rapoport <rppt@kernel.org>=
 wrote:
> > >
> > > On Wed, Dec 17, 2025 at 08:08:58PM +0800, chengkaitao wrote:
> > > > From: Chengkaitao <chengkaitao@kylinos.cn>
> > > >
> > > > 1. Added the vmemmap_false_pmd function to accommodate architecture=
s
> > > > that do not support basepages.
> > > > 2. In the SPARC architecture, reimplemented vmemmap_populate using
> > > > vmemmap_populate_hugepages.
> > >
> > > What problem this patch is trying to solve?
> >
> > Following the pattern established by other architectures, vmemmap_popul=
ate
> > is reimplemented using vmemmap_populate_hugepages in the SPARC architec=
ture,
> > which fulfills the intended purpose of vmemmap_populate_hugepages.
>
> But what's wrong with the current sparc::vmemmap_populate()?

The current implementation of sparc::vmemmap_populate() is correct
and functional.

However, I believe that generalizing vmemmap_populate_hugepages()
still results in certain architectures requiring special-case handling
branches, which is contrary to our goal of a unified implementation.

Another benefit is that it allows us to eliminate the external
declarations of vmemmap_p?d_populate functions and convert
them to static functions.

> > The functional logic remains unchanged.
> >
> > > > Signed-off-by: Chengkaitao <chengkaitao@kylinos.cn>
> > > > ---

--=20
Yours,
Kaitao Cheng
