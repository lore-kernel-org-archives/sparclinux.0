Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6152F3621
	for <sparclinux@vger.kernel.org>; Thu, 18 Dec 2025 13:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766065012; cv=none; b=dEtdqqD33SDWNjCVNlz8kEgt28BhCphj0ULEWiEp0ifgW41pVJKiL0fLvFsK6ZO5cE5sg6iN1Ir7h6M1+mTJ9PEjNJF3Zln5ioPT1awbFwIo6JWucpGkIEEV8FwI1W9jXnV8LYCT4XGmq66l9AoLWD7LXRLJEk5JYESwPQQPADI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766065012; c=relaxed/simple;
	bh=HUwXVzNK4q6QfPc1DZoQYLQOHUNGJ3bwL7HXGimF9NU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fZa/bO4h8aE1yVYEdt64nh14U75QZsH3cmN0zoa2iM+FY0DHQPnIpDrjR47s4NNCXzcy7X1emsS1rQzrJJaUG2UWzghAP9w4Ng6fxBdNHBUCwcqIqFossFitKMy56GiDh5fjpN4Y0I/GtGweQnlt83OAd305njTk6WA4upz2CFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NaWoNUhS; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NaWoNUhS"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2a0a95200e8so5682285ad.0
        for <sparclinux@vger.kernel.org>; Thu, 18 Dec 2025 05:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766065009; x=1766669809; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HUwXVzNK4q6QfPc1DZoQYLQOHUNGJ3bwL7HXGimF9NU=;
        b=NaWoNUhSdtMkq5TXgzOGZ0dD30GqaJLGx9BpbFaGbEnXPHC/9pqo113H2E3cXcQoNO
         kpNed9Sao9eOCDMZITAoohDQFnr87KgQ08K5oU1EuQJkHMV/bfVuwQ2NrT+m75Ju+kt7
         IXddHHKfvreuGQNYmyoJdIV/wZ65QyL/WsMtz5pQOahtsbgzZIRNs5PJQ1WnF4hWGP26
         tNzb7OQJ9RcOmoCvrHUvkSHCsxwX48wJDa/ipdQdUOz6nWgbp2E3finltB0B0ge66Bcu
         TpGm8GOJgfI+VCTBFYQs69PPs5AK6VAIP2NZTuel7MCOpLLnQvml6yC7Yj2CjeFKWrra
         dg8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766065009; x=1766669809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HUwXVzNK4q6QfPc1DZoQYLQOHUNGJ3bwL7HXGimF9NU=;
        b=G8jn/6hehFk7Tu63Iq4tpHKw6kKmf6a/CjTkF3bXj65fiDdyOxew3jPX++BI7ENNP3
         Tppdl3Tc8TJOzVjeQWRDM34wOatHQ+B2H8nNwbZBRlv8xPcXahyTwbIrTrVeKJynAMuh
         LrK10d8dZgT9EbZwMcv2nvLe89ZyXyCQ0265TYUXH+/yoLngd6+WVaWXdXIjzmjothXu
         Znq8+HoZxLLbHE6n1aLu5R0qD+0KBeC83jkeTWr2fthruvqh9RD2Key32eVaLQ3fIqax
         9gjgMk3mgE/LFgaz5GZ8wNKSWKZIsl/ZVJvkoMnb4VD+Ay33d4jVIlvfMnNUimp06rb8
         hqPg==
X-Forwarded-Encrypted: i=1; AJvYcCXSTEKun6NM1l40kBy4CjrpXKxl3mPjWiszb/Ac0E+rB5DH3QG28RMlbRJtJc+GZj7jr5It/8340wnA@vger.kernel.org
X-Gm-Message-State: AOJu0YxmQZVix0SbQCa6DDTYg3zjsuHU1h6LFqirUI7ZmeLdZoovkxry
	pNK4pdCIClAzDKaxJQZxjYhGuSubYzDxEhgHiOLQEWaIMzMb4k7ehJvfifb0M4uLE2KpCfRUxU3
	AjquOegYxFVN7gDtxafhPbXmz5waZVnc=
X-Gm-Gg: AY/fxX4h2kWLw8YSzZkQQNN/0wrc4wL6Idu0bf+Km6XITz/P2plLDIkGwoX6p9u2/At
	J0/o1e8i2aEE4YhrbW00qRzDtWVo3K3BBsymIPNwMtqHDz3OOFgQVceWeOubPRGxDOZppYJTscB
	YD2nvhMe61tJODDaPB+MuXPu2QL4hcrp4M918wSzRxDEPWAZiOYUGbkeTke8tIdVtDiyr9SxqES
	KMOnJ/q7tzZCTSil1cH373FWLs+A8TXe6ksB9gLkFyyHWQYellmV4N0mhHvbvfJUS38EA==
X-Google-Smtp-Source: AGHT+IEtiV9gJa6n03OtIVg2EUyEuXyuvyJY5GYWeTWXbjFNC/3KngqUaCsS6lNADFSzK7UYNQWwRqhYLx+nywedns0=
X-Received: by 2002:a17:902:ce8b:b0:2a0:a92c:2cb6 with SMTP id
 d9443c01a7336-2a0a92c2eedmr158564655ad.36.1766065008626; Thu, 18 Dec 2025
 05:36:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251217120858.18713-1-pilgrimtao@gmail.com> <aUPiFbuaglcjqiB1@kernel.org>
 <CAAWJmAaxtKY50BEm3N8V1QTwpyCgQLfLFarrVfPVVpXg9ftmcw@mail.gmail.com>
 <aUPvecgVj8XXBcw5@kernel.org> <CAAWJmAa44SF=dj+FTiXn0aZwLLGbSTAieb8Cy73RE0sGAkAYLQ@mail.gmail.com>
 <aUP--JzrvOm1-Q2P@kernel.org>
In-Reply-To: <aUP--JzrvOm1-Q2P@kernel.org>
From: Tao pilgrim <pilgrimtao@gmail.com>
Date: Thu, 18 Dec 2025 21:36:36 +0800
X-Gm-Features: AQt7F2rzVE3Pu_pRYVaxkScyvBNFF6tJv11hZDClKsnLEh-eiK-sudCotGdrHL0
Message-ID: <CAAWJmAbxdBfjGtF1zwqNWwyKxfkw6Vdjwf9dEB3qDnkr5mEHkg@mail.gmail.com>
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

On Thu, Dec 18, 2025 at 9:17=E2=80=AFPM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> On Thu, Dec 18, 2025 at 08:29:27PM +0800, Tao pilgrim wrote:
> > On Thu, Dec 18, 2025 at 8:11=E2=80=AFPM Mike Rapoport <rppt@kernel.org>=
 wrote:
> > >
> > > On Thu, Dec 18, 2025 at 07:45:52PM +0800, Tao pilgrim wrote:
> > > > On Thu, Dec 18, 2025 at 7:14=E2=80=AFPM Mike Rapoport <rppt@kernel.=
org> wrote:
> > > > >
> > > > > On Wed, Dec 17, 2025 at 08:08:58PM +0800, chengkaitao wrote:
> > > > > > From: Chengkaitao <chengkaitao@kylinos.cn>
> > > > > >
> > > > > > 1. Added the vmemmap_false_pmd function to accommodate architec=
tures
> > > > > > that do not support basepages.
> > > > > > 2. In the SPARC architecture, reimplemented vmemmap_populate us=
ing
> > > > > > vmemmap_populate_hugepages.
> > > > >
> > > > > What problem this patch is trying to solve?
> > > >
> > > > Following the pattern established by other architectures, vmemmap_p=
opulate
> > > > is reimplemented using vmemmap_populate_hugepages in the SPARC arch=
itecture,
> > > > which fulfills the intended purpose of vmemmap_populate_hugepages.
> > >
> > > But what's wrong with the current sparc::vmemmap_populate()?
> >
> > The current implementation of sparc::vmemmap_populate() is correct
> > and functional.
> >
> > However, I believe that generalizing vmemmap_populate_hugepages()
> > still results in certain architectures requiring special-case handling
> > branches, which is contrary to our goal of a unified implementation.
> >
> > Another benefit is that it allows us to eliminate the external
> > declarations of vmemmap_p?d_populate functions and convert
> > them to static functions.
>
> If the goals are to provide a unified implementation and eliminate the
> external declarations of vmemmap_p?d_populate() functions, I'd suggest to
> send all this a single series rather than a single patch that updates spa=
rc
> implementation.
>
> Regarding the ability of sparc to fallback to vmemmap_populate_basepages(=
),
> it does not seem to me that this is an architectural limitation. sparc us=
es
> base pages in the kernel page tables, so it should be able to use them in
> vmemmap as well.

If SPARC can use base pages in vmemmap, I might remove the
vmemmap_false_pmd implementation. Thanks for your review.

> > > > The functional logic remains unchanged.
> > > >
> > > > > > Signed-off-by: Chengkaitao <chengkaitao@kylinos.cn>
> > > > > > ---
> >

--=20
Yours,
Kaitao Cheng
