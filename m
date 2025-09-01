Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284DB2D5940
	for <sparclinux@vger.kernel.org>; Mon,  1 Sep 2025 15:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756740180; cv=none; b=Zi2WuHGpKM4jwQuDQyJhqNIHpMLpidy+v1OQDB76ZtGtGEKUF2wYwH7czaikD3VSAZzk9xm9gYtH13WQtBFnbX+JJEBrMvWVwTF0s9PTRA0+/QJ9YMR5yXxhIqyXXkq9I0FtemxPgNUIdeQIrbkVeWconq9nyjNad+rW7DtvGXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756740180; c=relaxed/simple;
	bh=xqYJE8gaVl+wcM64SwwllZC2T3TpIFwcaihrMWL4cIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GDLt+sRuKo5/reyLx1C6Yf9Qi/IgdUPRD/koQm4w7oSZyhZj5uEVP0sgiegA0GQqwMp0AVCRtmmu/yz1Fn25B3CEAKliI/gf/BiK7tf4SjLJuo1dG6SSMMFeNg5GcIYMbIZmKLtjQB3yN6MjneZfmKI/FV4UxKPLsWJRZ4OPDT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=V8FU0ftV; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="V8FU0ftV"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b042ec947e4so167946366b.0
        for <sparclinux@vger.kernel.org>; Mon, 01 Sep 2025 08:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756740177; x=1757344977; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xqYJE8gaVl+wcM64SwwllZC2T3TpIFwcaihrMWL4cIs=;
        b=V8FU0ftVpb2p3tqAzIFJXxS9Ss99K7zDrWutbLl7NXM+DVbrHRVuPdUwELaYxrUoJ5
         m9CACTX/9p5DCsmSlRkv3pow87OTYaHJ+U/hZ3zV1ObOLfuEdmJ6W2D0SdgImFxt1rGc
         YBOBj8dcjxunOFCA4rlg2VL4iJpu8cz9Q9kZ9wh7pakm9lptgJPkdDmrl9Wbumvavx55
         PEVAgB14GA468wMQXDOyGILndkwcV4tLIz9txw9r/0k6Jh3z/xgkmkWzHLxAwFIh0tWW
         A2IhGwemR1wxv1W8X5/qKELXxe8HrfXNd6ANkNeRr8EAxaYN82MI94epPvY+f9P4695p
         dzFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756740177; x=1757344977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xqYJE8gaVl+wcM64SwwllZC2T3TpIFwcaihrMWL4cIs=;
        b=JgxkXiHsCQ+r1sBrOtdTRBH04K8dGc5c48F2v5C14j/YcTlEtc1y7PD7I6mvJW+ngG
         OtXlaiGVpyXpeYWZ2BDz6phEyOTUNqD7SWoA2QdBtxbO7sNC78Z3AelTZaAcywskz+7j
         Zb6O65+Ev6A2NQis4JgHB2+hIqm4es9mSlPuWR2o6aaIW8ClhvPSdujFNY6ENdVqAz0B
         4FKc60MAVViVOy81LdoKUzZ6EqYgrzoy0oLSljGdE/kp88IQOCgvPy5YwvjWKuJNwPxV
         +Qr0YULM9qHEPIMDnbhWGzY+u37o18nxSH0PpoZ4QvAwQIxFJhAtgSDpGFu9hKITImyF
         7evg==
X-Forwarded-Encrypted: i=1; AJvYcCV037PjW/Ac7rVqQgXlGDqlgGqB1IfXXidlG+Kop/gpoinLhoxYJ1jO3HQ3F6P2wh90Qrumb1Y+GHCo@vger.kernel.org
X-Gm-Message-State: AOJu0YxtkPwgZ03RFD4yAUgyihWB8sCgcBGnLnvE7YlT5qwZP+kJxZTW
	qlbR2SrCCV0rNzMFgJfOsvMk9Op5Q5W3D/mWL+IeOt3P5raCYQOl2QNAvW+o88W8NcbANB26ohJ
	xQrAZ/CW+EP4IsqMW2s+986Xr97wnAB80YJylzJdF/Q==
X-Gm-Gg: ASbGncsVq3pcWyBQLVXawk+IqVuexc/Yaky85cjNm60e784de2TwQKJFhf9LxiNbUiy
	qgKNdIKY/XBbWITAIK3LjgsZsDI2naO9R6AOJZADZbgmsNKaQtGg8/FyrE7j4ERwn++I9ptqGry
	/P1tN6kuodBYJ/0VGS5e317KVaERXafldf34WfBMFQ4O+wM3oqC4oVxo96ULJa175af87K242rz
	Zox767RebjGxxlQyYfyRik93qUR8IMiyhk=
X-Google-Smtp-Source: AGHT+IGyHGBQU5Fmr9N1bQCrhCA+i8zJzAFx27YAdwJf0bpouLhs7aYdtEtaq8rinlUX8phhR2x58GzGpQKldL70zDk=
X-Received: by 2002:a17:907:60cf:b0:afe:a7f0:80e6 with SMTP id
 a640c23a62f3a-b01d9756fb9mr875954466b.33.1756740177075; Mon, 01 Sep 2025
 08:22:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901123028.3383461-1-max.kellermann@ionos.com>
 <20250901123028.3383461-7-max.kellermann@ionos.com> <ce720df8-cdf2-492a-9eeb-e7b643bffa91@redhat.com>
 <CAKPOu+-_E6qKmRo8UXg+5wy9fACX5JHwqjV6uou6aueA_Y7iRA@mail.gmail.com> <0bcb2d4d-9fb5-40c0-ab61-e021277a6ba3@redhat.com>
In-Reply-To: <0bcb2d4d-9fb5-40c0-ab61-e021277a6ba3@redhat.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Mon, 1 Sep 2025 17:22:45 +0200
X-Gm-Features: Ac12FXxiiebv9X2d18G9zaz1-52NeLol_OdOPtBiylMXolSmoqbk-OqNT_yTCiM
Message-ID: <CAKPOu+8SdvDAcNS12TjHWq_QL6pXnw4Pnhrq2_4DgJg8ASc67A@mail.gmail.com>
Subject: Re: [PATCH v5 06/12] mm, s390: constify mapping related test
 functions for improved const-correctness
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, axelrasmussen@google.com, yuanchu@google.com, 
	willy@infradead.org, hughd@google.com, mhocko@suse.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com, 
	vishal.moola@gmail.com, linux@armlinux.org.uk, 
	James.Bottomley@hansenpartnership.com, deller@gmx.de, agordeev@linux.ibm.com, 
	gerald.schaefer@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, 
	borntraeger@linux.ibm.com, svens@linux.ibm.com, davem@davemloft.net, 
	andreas@gaisler.com, dave.hansen@linux.intel.com, luto@kernel.org, 
	peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	x86@kernel.org, hpa@zytor.com, chris@zankel.net, jcmvbkbc@gmail.com, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, weixugc@google.com, 
	baolin.wang@linux.alibaba.com, rientjes@google.com, shakeel.butt@linux.dev, 
	thuth@redhat.com, broonie@kernel.org, osalvador@suse.de, jfalempe@redhat.com, 
	mpe@ellerman.id.au, nysal@linux.ibm.com, linux-arm-kernel@lists.infradead.org, 
	linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 1, 2025 at 5:11=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
> >> Should this also be *const ?
> >
> > No. These are function protoypes. A "const" on a parameter value
> > (pointer address, not pointed-to memory) makes no sense on a
> > prototype.
>
> But couldn't you argue the same about variable names? In most (not all
> :) ) we keep declaration + definition in sync. So thus my confusion.

Variable names in the prototypes have no effect either, but they serve
as useful documentation.

Whereas the "const" on a parameter value documents nothing - it's an
implementation detail whether the function would like to modify
parameter values. That implementation detail has no effect for the
caller.

Of course, we could have "const" in the prototype as well. This boils
down to personal taste. It's not my taste (has no use, has no effect,
documents nothing, only adds noise for no gain), so I didn't add it.
If you prefer to have that, I'll leave my taste and home and add it,
but only after you guys make up your minds about whether you want to
have const parameters at all.
