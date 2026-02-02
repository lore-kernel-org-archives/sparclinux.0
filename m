Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008C2274B35
	for <sparclinux@vger.kernel.org>; Mon,  2 Feb 2026 06:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770015457; cv=pass; b=bi1pEqVMCny7Tmocutz3TFz2rb/PGNGEFbKfAKmzVU8LjoHJWLzNJ160bWXqkZKNv9wc+pbM7t8GFnR4rTEl3FadYbQp4+0Wl2NKaHJ+3haMOnGJ/HtRYkV9CiQ0o9wL+NXLLArzA4dxonrhV/Gs56N8n1IwRklP9yKhxKn+4vk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770015457; c=relaxed/simple;
	bh=8aSn8GmDakEMqNqPDJbCPU0l6WKLAkD9Z/71St/ZQYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u6mieewJ2JXOfaqWhpM1nIedouFPT7b8DoatOuOQS+TQxVadTWXBLBV1dnuR4nKj9NB2Ink0ee4XmeuGsnZjZNlzM74WeM6cOvZ/2Tji9W6GILv0HvCMLt4V2GJcGwIVw69fCw+06n8HZx8O8b5ei13ff2th7uT9URNrzH7NZCg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AQjvJLqA; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AQjvJLqA"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b885d8f4092so703501366b.2
        for <sparclinux@vger.kernel.org>; Sun, 01 Feb 2026 22:57:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770015454; cv=none;
        d=google.com; s=arc-20240605;
        b=iZmDH1ZRJnRX7mrDjsKuANcwwqFBDw2hwavpWbO6Gfu42JpKsj0NqtSZIr/I/l8BQq
         EUJrsL/uosnS1CVcS4ZZsTD99GT1CVwrSviHrIsXtVoc8K0o95Oe/YNU6bbJonJ8f24+
         0Ur0zaLbPbEUASLSDbBQWCAL1Y/iIzmyxHudPWNnw66d3Tzjxz5myCa+yzKxUvcaig7w
         mXHm1uzExawYoIOjz8eb0WLzCVaGNMdH4CjEzkYvBiL6R4TYnHQdDr9h0X7I3kOylqqA
         AJoPzyQlDzH1w9voIlgaz0EABifOXCqKAPoLV7NQPynz7wtn77ShSdNTYUszaBbU9mk5
         xyGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MTmRA3Phy/tCo2380dNzzOdOfqKMLKnjbdMnyqMlppk=;
        fh=P+/czFgFcIhNRGhFMTBkov1EdZyS+FZI1Mpbhfmk06g=;
        b=O6kVl5cKZZzUSLfL6ow5EFrYXU/s9zS2cYcRFSnhhVLQ+GZzitNYaF1gf6cTcJe7U4
         NlhGnXVh3mJL1se0bHgXGAjV2Fy7B9UV9vVMdnz5fFGI+Hfx0pM7IsJSag7/2DxNXvRM
         ZeRvvnohNZPhf7CMgf9IJJ0HiMIpj35yb7vxyy1P3/A+z7t7F5X7Sa77CNbcwPobPzLS
         KCFBaYk6Fs1BOcrh6GXpnVmjDBkJLlfx7MNjhTJw7mBAQhOmPsaVO8rlzS7dfH7Un3Rr
         Dy0IKRLADnPPh7LgqHYDXe4Zn/lguw1Y/A54UzDh3qftMyq1sbHkenZ0MQkMtevRscal
         iwiA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770015454; x=1770620254; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MTmRA3Phy/tCo2380dNzzOdOfqKMLKnjbdMnyqMlppk=;
        b=AQjvJLqA0DEO1SF7Mu4XBIFTIONyKvuR2RdtXAEHbjhUhbLcpw55rxBSXj7E2HxMX/
         38Oo8aZJR2xG4pm2LlGCFQy7/Auvy5TB5F5Nk7eGbuEA4ZXACVYubGWSHXDWy5MbC4ih
         5LA7JmnQfQUv3Pti/nWpcWNhBE6nBdjCFHf8yEfpG/DGDSqOllOKaJxSsDIGcNZiQDBs
         ykSGWgxwWPNrDEyI3MW0DXUsyluaoEca/9eWf1xxjvw9R+9KLgOFOobOFf0/Z+FkAeC7
         juftAgzIyxy1ZvvmQr18rdjNgllEJdtJPq8jM/ozfwglGq7kB3t3sE3fl0hsQF+LjwGU
         XHmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770015454; x=1770620254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MTmRA3Phy/tCo2380dNzzOdOfqKMLKnjbdMnyqMlppk=;
        b=k7jfqA87D1iU/5DLNY9mUvFArb30J57C1LJd75IeMhQMjMPPJq8zwNMNuRZCDLSo7a
         VFrcdzoG0+5QEy9xOHmXH81d3KPzG06Tsz0ngaN63ibRr9iqVJk52inOoIr8svRTJ9Zz
         Vwn2FQjSGYgKxmG3K25T4/bJsHj7IzoJ80SjTBbEQu1p5jUxrJUxOuRkmv05PKvapMPJ
         br3XqHYlwMEwxlUfHNjnZrDyUmRWySi5sip6syXp11WTURhclBE0bKJNNJ5R1XOSyyD0
         ukREEzh+G/ceAZMzC6WZhMEuU4rKREtJiAdfU9knGEm1Xf45iAX0P7YWGVtwsrQupw9A
         HkUA==
X-Forwarded-Encrypted: i=1; AJvYcCUDIAPwjPmiLdd3W2OJaaEdr7cEX+UuzCpYAtzeOg8Are5eJ4EZ5ivo5qdvJUJJDalTI7MSU7RFqZ4l@vger.kernel.org
X-Gm-Message-State: AOJu0YzEEpm8JS3S2ahexvja9rpa4qDAW189j8w4nOwaNj2yfGJziKjx
	oJL+yFdyQi0R5U5xy8VHL9CrbxvN9OSCBtEE74nC2k7EgUkISdiA93lzKNTJKegpdDK2UrmipeB
	OA9i5HOv6/22dZc9ABlMhoLQdY7e2x4I=
X-Gm-Gg: AZuq6aICyVzX6DSh4TfqGwoY8vCQaBh+HrL+FA41E+Bih3Q7wPz5iIPqEbvsVwTS7az
	0Bm0V2cs2wICNF73xXmez3tOtyyk7wiDeaquaiIHXWuNU9hoBIoqaTG0Ddjl/bH9QJYJCvcHtdk
	rWz0fU3bzAbvsWx6Knza9kPfS8dNHgMXiJj2j3IS/q0f4rnT3vR9GyKAo9CRj9wTCf41ox+0CPP
	LcQD4p84rT0L3McRx0TDeiFraGqWvBUruXDB+w1u+iGq4kTqzTfqmtF2CEGF6JTRYaAJMw=
X-Received: by 2002:a17:907:e110:b0:b8e:4790:d7cf with SMTP id
 a640c23a62f3a-b8e4790db6dmr207191066b.53.1770015454252; Sun, 01 Feb 2026
 22:57:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260107104145.51416-1-alexs@kernel.org> <494e98fe-0fa6-416c-b136-9c444c03f769@gaisler.com>
In-Reply-To: <494e98fe-0fa6-416c-b136-9c444c03f769@gaisler.com>
From: Alex Shi <seakeel@gmail.com>
Date: Mon, 2 Feb 2026 14:56:56 +0800
X-Gm-Features: AZwV_Qgh3Nd_faBL-MCprpIw-IeL2AVjcXbPcNnv0ru8cJ8Gz0P3WM1DMxQ1KGg
Message-ID: <CAJy-Amkx=EgsyZq3pdpg8Ucgb_=07evL-tSigZw5T=_F1EmT6g@mail.gmail.com>
Subject: Re: [PATCH v2] arch/sparc: fix unused variable warning
To: Andreas Larsson <andreas@gaisler.com>
Cc: alexs@kernel.org, "David S. Miller" <davem@davemloft.net>, 
	"open list:SPARC + UltraSPARC (sparc/sparc64)" <sparclinux@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Andreas Larsson <andreas@gaisler.com> =E4=BA=8E2026=E5=B9=B41=E6=9C=8827=E6=
=97=A5=E5=91=A8=E4=BA=8C 00:44=E5=86=99=E9=81=93=EF=BC=9A
>
> On 2026-01-07 11:41, alexs@kernel.org wrote:
> > From: Alex Shi <alexs@kernel.org>
> >
> >    arch/sparc/mm/init_64.c: In function 'arch_hugetlb_valid_size':
> >    arch/sparc/mm/init_64.c:361:24: warning: variable 'hv_pgsz_idx' set =
but not used [-Wunused-but-set-variable]
> >      361 |         unsigned short hv_pgsz_idx;
> >          |                        ^~~~~~~~~~~
> >
> > Reported-by: kernel test robot <lkp@intel.com>
>
> Did the kernel test robot also suggest a "Closes:" line as well? If so,
> please also add that.

No, I found this issue in a lkp report for my testing code on sparc.
In that report, lkp just focus on my another issue.

>
> > Signed-off-by: Alex Shi <alexs@kernel.org>
> > Cc: sparclinux@vger.kernel.org
> > Cc: Matthew Wilcox  <willy@infradead.org>
> > Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > Cc: Qi Zheng <zhengqi.arch@bytedance.com>
> > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > Cc: Zi Yan <ziy@nvidia.com>
> > Cc: Kevin Brodsky <kevin.brodsky@arm.com>
> > Cc: Mike Rapoport  <rppt@kernel.org>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Andreas Larsson <andreas@gaisler.com>
> > Cc: David S. Miller <davem@davemloft.net>
> > ---
>
> It's helpful if you put changes between versions in between --- lines
> here.

Thanks for suggestion, will do it in next version.

Thanks
Alex
