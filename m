Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783E0325708
	for <sparclinux@vger.kernel.org>; Thu, 18 Dec 2025 11:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766058369; cv=none; b=CfwSd89I5IRNSi8EJ7wSst8Z5chQCUIzQC1woDgTqqwVQx9YzqyRPvSZShlZANA3X/hdaDH5NKxcWZWYaLHCTdc1vFXO6z3GXaT/gvtX7xCaXUCr3xs/omkYHscJmmjQsYLZut5SMFs6lRjcRl6kLxvSm8agc3ClWAyj6d5aCUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766058369; c=relaxed/simple;
	bh=1IZn9sTa7c3lv2AGukKMMHC7g199ZBSIk2OztX1p5Dc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PYs3fv9+2ZTS2tZFLYH5FGvCjA0cpSKs3bcbF6tsNpayGB/YNYcGLMdcRP3bYTIxApbuTbYD/vmUx4FduboFxo8UDeHsSzep9It611wbqp4X+BuW7X1NGaJTMCT0Fi6BRuCbHiy8yQ5PKwtvY/u564w70lR1tMVTQ7ZnCjW871E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UVHiOfDf; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UVHiOfDf"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-34c1d98ba11so602186a91.3
        for <sparclinux@vger.kernel.org>; Thu, 18 Dec 2025 03:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766058364; x=1766663164; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1IZn9sTa7c3lv2AGukKMMHC7g199ZBSIk2OztX1p5Dc=;
        b=UVHiOfDfO6jgjnpr+05mNdJw0XfpoxgomjI4qi2A8jH7QK/N1m7Xx3URxqiP3O1rOX
         ca1pLrp1k7BZLYgzyxSTchXTi0Gee9AUJ/noId+vuueh5+ZelQ4CCyJB8KHSaA7207FL
         gL2A3vFwvOABPcJS+Vuc1/vNxnnhQTug1+m1ueVoMvSSaCuJ4rYQBarSaa/YIJdYDmcM
         4CeM9fVRAxCFPIxDPKHthQckwqSQHVDdlwwFGhmhjdfeeLs48jWcNwcgn/6pQgkWuwGP
         0qZajYsZNtKm3di5wdJfkTAzqswanWT28WpxbhpYVZMjh7TSmOfbYwuULezZmAjJUNOQ
         0xAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766058364; x=1766663164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1IZn9sTa7c3lv2AGukKMMHC7g199ZBSIk2OztX1p5Dc=;
        b=KC9916Ldaxy6yboAlrrvvN5hOiYMpqUBtsoDK2eDISQrEW4gTJ/5eCw65ZmpzvqYes
         2J2r9ordYqUYrEPnYY8b8YEzv2epMxmjRTViLVD3p7+lbVKBPkVaUlMCw5tL+stzSAf4
         Nb8lQjR/AFAHcBhtmTvL4Q33cr2gOdOSL7G9kNpNhnywBjQ98EoR2s/3o9hOj3AUs2UB
         FsdaKLdTT5g61AljTbB0y2H10Sg9T6ky956A+Le6ofsY/FvS6DhsTOmoJetikvcy7kFb
         N+67t5ElEEI2/jiInWRRTb86tv+LI+me/aYRtMXARf0/wZl9y5WA4aeKQJtn99NwuzIZ
         n0+g==
X-Forwarded-Encrypted: i=1; AJvYcCUaATDQlgSdV4SK0DcOvw6NI6IulJjG7UgHq3AQh0GrbIY0P1rUL8nUsvxqBulXemrNVOq99Bw2F7wp@vger.kernel.org
X-Gm-Message-State: AOJu0Yy24T7VHkKQ/vn2DKgdde1UmAIOmzkHLP97uhmS/oFNcpYL4gJJ
	iLw9zLirtrkAtc7LZIpHDmMPA8g+nfrm+nDgFFTQsGwJiUSZg5AAbvZ1oz8EIZYRreBlmf0EQiC
	3hTtlCqPhPDDp/yIhelZurGjTqJT2ukQ=
X-Gm-Gg: AY/fxX6rrkTjQN08J8DC1Zasg9q1DUbGJaJQOqRcaRSIHsJWrXkxIn1BYbjPHAgLXYd
	MO1cm/LwWbPtvxohFzrsfs3kWZ6dpCF9PxAunnOnSHwdsXNix7RAwha/W3dLdbfKizyowHS8OAB
	LCPyb32CZm1IcDf/KSmZZrrJoCdI7p4f3E/grbcE5XGMCTHMo6LuQEF6F9Lvl66QBeo1mFeOpH6
	cxdvAQLkLjx5ZOYnRlhLjz8kLHfeM0htOIkrFr8PXfXXAnEK5nwNwgRLQCb7Gn1s6X6Jw==
X-Google-Smtp-Source: AGHT+IEvF1KBiCCd13SNnZh9nGwSbCfJXkC7JARZp2pD1vme5z96PC3eWOuC4uYYsxgFL4v1STQ3q4UOVbVFIF1Idp8=
X-Received: by 2002:a17:90a:fc47:b0:338:3d07:5174 with SMTP id
 98e67ed59e1d1-34abd6b5d0cmr16492807a91.5.1766058363931; Thu, 18 Dec 2025
 03:46:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251217120858.18713-1-pilgrimtao@gmail.com> <aUPiFbuaglcjqiB1@kernel.org>
In-Reply-To: <aUPiFbuaglcjqiB1@kernel.org>
From: Tao pilgrim <pilgrimtao@gmail.com>
Date: Thu, 18 Dec 2025 19:45:52 +0800
X-Gm-Features: AQt7F2oFJjE5kIHB1KINR0FTWOfFtI5SPHyYbe5RtYRwej8-SfnmNij2BqSQqR8
Message-ID: <CAAWJmAaxtKY50BEm3N8V1QTwpyCgQLfLFarrVfPVVpXg9ftmcw@mail.gmail.com>
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

On Thu, Dec 18, 2025 at 7:14=E2=80=AFPM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> On Wed, Dec 17, 2025 at 08:08:58PM +0800, chengkaitao wrote:
> > From: Chengkaitao <chengkaitao@kylinos.cn>
> >
> > 1. Added the vmemmap_false_pmd function to accommodate architectures
> > that do not support basepages.
> > 2. In the SPARC architecture, reimplemented vmemmap_populate using
> > vmemmap_populate_hugepages.
>
> What problem this patch is trying to solve?

Following the pattern established by other architectures, vmemmap_populate
is reimplemented using vmemmap_populate_hugepages in the SPARC architecture=
,
which fulfills the intended purpose of vmemmap_populate_hugepages.

The functional logic remains unchanged.

> > Signed-off-by: Chengkaitao <chengkaitao@kylinos.cn>
> > ---

--=20
Yours,
Kaitao Cheng
