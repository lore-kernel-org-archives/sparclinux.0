Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C1B1D5170
	for <sparclinux@vger.kernel.org>; Mon,  2 Feb 2026 07:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770015671; cv=pass; b=s1alg5PsqLS9RpAWD1CRjeMn1RyX7SEq+q5lrBhB20EW3xhFWFa1hAmiYlKcNiEcit9SeioOdf/nsOT5tmNmDMf8gsaYPL13X1CKPZmPQ6dKrLrk/rccyssgj9Gn0j4lunJMusoV+PLfrPNsuz+zvTv2Zi1gQusm+4fSRDnzc/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770015671; c=relaxed/simple;
	bh=Bjo3UgAA2rRJumnw1IYXfxyLaqDd6w1R2Rb/N5yUH4w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gReaxfKi05Zrx4qhBtXFEpY7ddLxCXOkFsSBlPB2s7teXBZ+Sy4Xx40B5IFObUoOGi7XL8rlf7UxUQ9L9RVEHNFTPUn7asP0RmcxDFUe5KcN5so1JvK/oRxYUuZfIVzZH6tYkGiGw3F5VI2Nh8atPt3njw0T2NZvdoV5XFGuxa0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Il2ofX/9; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Il2ofX/9"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-658f1fde4bfso2725872a12.1
        for <sparclinux@vger.kernel.org>; Sun, 01 Feb 2026 23:01:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770015668; cv=none;
        d=google.com; s=arc-20240605;
        b=QtzOZIytGaQgw1/CzWoHqdOwkoTJssV3FdKeTT8U5oA3MBn2+PsTypBT3TeY8aAwNu
         uZQWqsWQPrblSKwY4oEB0WM7bLzaIt1OX5zSECfQ8QeqyE35dQQvZmXy9Mr3ay55ewuA
         EYUpro87BFKLFChVIDJziYrbiuY7iQFONifnWz6O6PLZl4CTcjsNlaSvBsxa7H8wdPzu
         hZNyiyRdrzbmslpeTZvrGUWKywhqto+YoGDos+OnYT+gm4VAXYGBPoF8HMRT0dE3yoWV
         DgYhQ4JIzMj+pUvnGymgRzetbe3uTzUleo72kz6GrQHSeZlQOOrrkx22UuSvkvXWs3Yo
         iipg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=30Y9+onGpNc2OUQcCoTT7fHVVHJMOyxoAwk1YIbwP+0=;
        fh=Y4JvQIOGqAdieE1twSIYoVokaynehTByb812yylBwfw=;
        b=USOj0DaiXJsob5nT+VoyO9N3H0DjMNN3z6zMQkYxivvxRcGDqf68turHTBtZymlVHa
         LSm0WtJU0Yc6bRAXdADGeTiou8JT7eet4+Z/jwnSmysfA6q9wBy8tcgsORqSWslr7iCk
         VnUjsxqP6cDfH0nUhqL04y4XOCX3UCZe7oyGPmkeNTv1o4W767LFEoqXHSoj7ZbWr1NK
         rrboJ86vhl7B/RGznH8B9TSpHFdGIQMGG9Xch4l1LBkdgp+8THmFnc+JQuAKdf+q0kUy
         ysZ7YqpEexDJVP99oaVIEC3b5fjJcezStn1djnQm2OfNcLSEWRx70vPKXLMsUpNp2Ci+
         +4yA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770015668; x=1770620468; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=30Y9+onGpNc2OUQcCoTT7fHVVHJMOyxoAwk1YIbwP+0=;
        b=Il2ofX/9BkB3IHHR/vmh4ZlHVKeKwLHBgkxobFS+wXjxd+tfWKgEC3xP6drGTeq1RY
         dbK426j57bPAHyDCCQYCXWMLsMgNZBT095B7YtSZSjlUHqE58As8DQs2YKjHzvIhyQ0R
         pRjsWJOiCFQ3Ob9sK0cksWvAQdHyDM8DEJCoecyMmDXjc+8Y3EGGWV6nXqldpAkEHppX
         CDm7hcuzz+FTo8b10D6R+w5x6FtlghTOgx4OHUQQCxynVUsDX6xH40QmItvZFCFtDNj9
         7sFhXDOAL2mS7kk5IhoC9hQE7LfUAVMt0jWuFJ7WR05thzZlgKOZbswrFBGQ6NUZfHLZ
         zO5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770015668; x=1770620468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=30Y9+onGpNc2OUQcCoTT7fHVVHJMOyxoAwk1YIbwP+0=;
        b=pc6yLAI8b3hZ5G8XjbiDePQSw3NLU0xKWKqHXqRlA/MujEv8EoWhBqqAAKED/P0CHu
         AcZRtgJB5BDDld3W+3nvk7tAnI72tGL5du1EdY5oQ/e/dCxZKDuNoyRmrCAZCDn6p6yD
         KbywTaOHpLL8wGVjsMn+aADhHkbJMOzEPaTSeW39JEDbcJYWq8Xr8WZyepOcSEUMESqI
         vfg3SHlQ4PAsFT7wyBfRSatWsDX7CX08cJlSIkyh2ii/xHigpc0cofAkpSasK2CGc5iM
         VKD8+gFsCu4Xi8IZcc22ho9oMs+DnX5gEoz1mVb+nPCHPUse/7YY8pbJ32KqqxjHvLnF
         7grw==
X-Forwarded-Encrypted: i=1; AJvYcCVAb9U6WIuZFeQlnDJubmidizmhVAWGwwC+PvOCLsH6KQxiiDi7xN8rizcLyypmgms7Hh71V40A49Bf@vger.kernel.org
X-Gm-Message-State: AOJu0YxJOnKxkieHlkyMiQE0sl4BLknVN4/WCAbY7C6vJXU3CkTjMdgp
	ufUb+NhDtjxkJQE/IsfG6YS30h6RgfZYda3Xg2XppYKdKkmV2UwKYfLH+HcEGEMMiVBoC3gsC7C
	TRs66ghe6txjeelHIBMdX6UyEiBfzNr4=
X-Gm-Gg: AZuq6aIWmWqJZmnVIkJVzOohqOjYZp1yaItYPJJ1dOw4LC1vqBrX05zE1DVHL5cRjBN
	wPY6XNusgPSeprK5NcrMfZWNGeLMs3TK6ji5PhfgQyRDqw3wVSAF1KRGTyYI20u9cSF/9Vz55Pg
	Prn8jquzv7/vEg7RM8o4QohHkj3ceEXSyvakAr4ekirRTydzMwVi0Tr+pFd0IlfuZj+Ea5pxMPz
	npZyJsoAVGhJCUiYprezDP8NtVD7c0RDW9lgYKBqTFr8iiU7Iu06cZgg4xnAenZhGdkFVQ=
X-Received: by 2002:a17:907:e113:b0:b8e:2fc5:c44f with SMTP id
 a640c23a62f3a-b8e2fc5c4a9mr274152866b.21.1770015668101; Sun, 01 Feb 2026
 23:01:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260112063715.179733-1-alexs@kernel.org> <163838aa-62fa-49a9-9948-e50ba3a5aba2@gaisler.com>
In-Reply-To: <163838aa-62fa-49a9-9948-e50ba3a5aba2@gaisler.com>
From: Alex Shi <seakeel@gmail.com>
Date: Mon, 2 Feb 2026 15:00:31 +0800
X-Gm-Features: AZwV_Qj9OA9Raz0JNoVsYkDifUSfLovqTUH8oC-5hn3fcT4ZHoqKXdNlvQmKk6c
Message-ID: <CAJy-AmkEEyC=6h=n4K7Ns4wC-jWP_ubNmC7_ZZww3WHKSus5Bw@mail.gmail.com>
Subject: Re: [PATCH] arch/sparc32: remove unused variable strtab
To: Andreas Larsson <andreas@gaisler.com>
Cc: alexs@kernel.org, kernel test robot <lkp@intel.com>, sparclinux@vger.kernel.org, 
	"David S . Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Andreas Larsson <andreas@gaisler.com> =E4=BA=8E2026=E5=B9=B41=E6=9C=8827=E6=
=97=A5=E5=91=A8=E4=BA=8C 00:54=E5=86=99=E9=81=93=EF=BC=9A
>
> > [PATCH] arch/sparc32: remove unused variable strtab
>
> Although the commit that made it unused did changes for sparc32, this
> cleanup is not only for sparc32. Also, no need for the "arch/". Please
> use "sparc:" instead of "arch/sparc32".

Got it. Thanks for point it out. I will fix it in next version.
>
>
> On 2026-01-12 07:37, alexs@kernel.org wrote:
> > From: Alex Shi <alexs@kernel.org>
> >
> > The commit 1b35a57b1c178 ("sparc32: Kill off software 32-bit multiply/d=
ivide
> >  routines") removed the last usage of strtab in funtion module_frob_arc=
h_sections
> > Therefore, it can be removed now.
> >
> > Reported-by: kernel test robot <lkp@intel.com>
>
> Did the kernel test robot also suggest a "Closes:" line as well? If so,
> please also add that.

This issue is also found in a lkp report for my testing code on sparc.
In that report, lkp just focus on my another issue.
But since it is just a simple change, is it fine without the 'Closes'?

Thanks
Alex
