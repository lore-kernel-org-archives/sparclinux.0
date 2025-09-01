Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1572765D4
	for <sparclinux@vger.kernel.org>; Mon,  1 Sep 2025 10:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756724095; cv=none; b=SDjEbQXK3AUlPI8WQWF+ZtUNGjT8xmMiNy/ggviVNYZhwMhqwv42D11NhhNt76E8Z8rMaXLaP5Q1fsJseGnVf/dScM1QSF6VG1NM0FZ0Yadu5sC2JzuCXPVyyWE86RTMaopnSNq1em6YHSEuuB407l9U+ixrKv/vcyqbIpXVbUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756724095; c=relaxed/simple;
	bh=Y0cJUednc/5M4WDwpNxVBOifAr3cOm70FaB8K31QTbM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rVar61wdel4XfOzP7484Jt9i++IFdhMIq817BTkauCc0cPV4UTrcaZwmcRuvuvqou6VJu9YAWuxGUaBhmZsBgDZ2Xf/9yWOmDMR0llz2GFJ3exmeEkcXDB/oFcF/3YwVLrEnAnjmHAIkhDBptCNaLzp0Iath9rfEqZfNtFWcRYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=fNcld9ts; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="fNcld9ts"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-afeec747e60so627975166b.0
        for <sparclinux@vger.kernel.org>; Mon, 01 Sep 2025 03:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756724092; x=1757328892; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y0cJUednc/5M4WDwpNxVBOifAr3cOm70FaB8K31QTbM=;
        b=fNcld9tsrQfkLBARj/8aLwZfvILorXEiwVW9i7winHSNA0uL0Q88gBn6KptClTh/hk
         deRtm44UyHeKHzJ2EPW0rzdWZ+GpXMyMl0FiYV42iNI4QPr1AAb9fki2Xpt6PeGYnoEx
         GhXcXTnABFhSxolBd8GZ7vvhnvY+140d3889X98VNtc8HX1Vl3Gslk+wOYZxwmzPybN/
         5i6ZRe/Yh/98jtIxHENQcea/tYXbcnYQAWxlqMRZlRwMmOHS4NCIqFfOz6tnagIe4V3V
         E8i+qymJ5N4CFoI9FrCkNWC7L3nmCIRswL+vvZjYImcH0uf4VWbjFZgsVw13PAOVUgfx
         VhAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756724092; x=1757328892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y0cJUednc/5M4WDwpNxVBOifAr3cOm70FaB8K31QTbM=;
        b=FK+iwb52hoG/SJ76dR7zDWiBb2IuVkneNluEwIudE0Kikj7/OmHqvyX813UQ3jX1TZ
         UBlw+9weXsO9q3HaOVkJPxW5bRPLsZb0cWxtXARyWDkYM7cQSolpaztMAjdfbtrSOs3R
         EJGEAWhkQcgmhuRBv7CVqmUCQmThUUwMhAxjQ2QOP4kVjHqXkpF5X1COJOzn7tTkz3Tu
         onAWW4oaBl5CARcbxisz6CeNSsLnQhPNK9KzhwzYb8rURJZSWlbIbkN87Y/8DVrwkT9T
         CRp3p2chIZ7nGQqtk6M48sAmz7rZFcU9NHDJ87osSolP5xgzXgj1U3TlELWdOYvhbZ1Q
         73SQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMN6Qz3tg/ahWQIdkfAdOxQBjXYOaaLBcx5cT/i54uCL1KWtDMdoUwDc3ul4IbFZohM38QJ4U05gBq@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6qCeuxtThXE7Qo2nCLAU0R2R7GFVOuk8M4Y0KdWvguVNGOXWb
	gHChdImjYxLz/t+hwjt6LC5yPuxgcZsE6NG0or0bgOaWh+ELhAsgaFwZsHBjhBGhiffzDPeaBLK
	b7R8NJiJchJ7j/zEGPlg1WMsrRO3WX0GDtArO4jNKgQ==
X-Gm-Gg: ASbGncsZjoB6m4eOXKD8IvkveTHJRDpyROQ5+CSKmny13FCKk+FJdPKrFlFvfaCFK83
	HLjwL47x7p+GC8Mt2kbIhkSAG8S/D8/Avbh9AfrLqgD5vBP8HTB6k30ndOSKlCxeRm6cGoPT3Q1
	q/stzKddDK3uNs0YXBBQPMzHCA/FH51eZnTXjRJUQz36kQGOGbYVsjdk3vKeeGjPsx3xgV+tRZN
	J4IJgfrlNQqxgDsGPYa33XsEDNbwxv8052cKSoPfHp5JQ==
X-Google-Smtp-Source: AGHT+IErujEHTbrp8kr8EXUBMZI1Sefo257M2ZPpsFs+QhTHhEsC5J8bRxn273glh6y2fAFm2YbZZ83e+kTpefkb8iw=
X-Received: by 2002:a17:907:3e08:b0:afe:a4a7:df95 with SMTP id
 a640c23a62f3a-b01d8a26e5amr703688566b.3.1756724091540; Mon, 01 Sep 2025
 03:54:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901091916.3002082-1-max.kellermann@ionos.com>
 <f065d6ae-c7a7-4b43-9a7d-47b35adf944e@lucifer.local> <CAKPOu+9smVnEyiRo=gibtpq7opF80s5XiX=B8+fxEBV7v3-Gyw@mail.gmail.com>
 <76348dd5-3edf-46fc-a531-b577aad1c850@lucifer.local> <CAKPOu+-cWED5_KF0BecqxVGKJFWZciJFENxxBSOA+-Ki_4i9zQ@mail.gmail.com>
 <bfe1ae86-981a-4bd5-a96d-2879ef1b3af2@redhat.com>
In-Reply-To: <bfe1ae86-981a-4bd5-a96d-2879ef1b3af2@redhat.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Mon, 1 Sep 2025 12:54:40 +0200
X-Gm-Features: Ac12FXxbsfem92CYCNntd3O-eNuFX0uYoorx93G08GlL_Qka4oUWgjKqGl2mAAE
Message-ID: <CAKPOu+_jpCE3MuRwKQ7bOhvtNW8XBgV-ZZVd3Qv6J+ULg4GJkw@mail.gmail.com>
Subject: Re: [PATCH v4 00/12] mm: establish const-correctness for pointer parameters
To: David Hildenbrand <david@redhat.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, akpm@linux-foundation.org, 
	axelrasmussen@google.com, yuanchu@google.com, willy@infradead.org, 
	hughd@google.com, mhocko@suse.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, 
	surenb@google.com, vishal.moola@gmail.com, linux@armlinux.org.uk, 
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
	sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org, conduct@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 1, 2025 at 12:43=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
> Max, I think this series here is valuable, and you can see that from the
> engagement from reviewers (this is a *good* thing, I sometimes wish I
> would get feedback that would help me improve my submissions).
>
> So if you don't want to follow-up on this series to polish the patch
> descriptions etc,, let me now and I (or someone else around here) can
> drag it over the finishing line.

Thanks David - I do want to finish this, if there is a constructive
path ahead. I know what you want, but I'm not so sure about the
others.

I can swap all verbose patch messages with the one you suggested.
Would everybody agree that David's suggestion was enough text?
