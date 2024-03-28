Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377BA137907
	for <sparclinux@vger.kernel.org>; Thu, 28 Mar 2024 20:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711656570; cv=none; b=sMOJVsdvHS28/Ktmt0gNdN0bwu/sFvixNrPPtK1Snn/hOkmuZeLXsG/XgEwQlbxnJFFm3p2V0k/pjg7jiZbqaIzxDQ9ZpXrBQBQC6bRme9qW/hjd4ynlnatR56kLMJrxRA3BmYlwzdCotjq7nxT6KpwE9N7NWUsnfCIOOlUw28k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711656570; c=relaxed/simple;
	bh=OrfH9kHPnKygy3hofZhQXKxDKdHWeNXPs7Z+BPCJInw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aZ6kvlXkYiqbOIDOcodMRtZ7660dl1mPhCnLsgTa6jie9FbrRTS1yzxpRjT9S40fasAXU4tBZVJ+fF6hTAnwp1WK7uCMLvsYPq+6S2yL7Q3tZCla7nFTmp2LX9No9RCAkARLYP5QTYq7mV9XZzGHNRylmJ8XAsHdUcxOns5JEWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=b/LxhMJ5; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="b/LxhMJ5"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-56890b533aaso1536512a12.3
        for <sparclinux@vger.kernel.org>; Thu, 28 Mar 2024 13:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1711656566; x=1712261366; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XTxbVAahUUqo8qIWTib74cjwQuWnxXYmY/UOpSlb0dE=;
        b=b/LxhMJ57ZDdtRC1jnmbGYmHuyi7ZeUNhv+WO4VtE6p2IjBs4Sh6EDg2vfrOHpTRRE
         ySp5gYKo/2TisecQtLdTEAeGRTEEax8c2YO7gNfnkT60JNQb+iwq5XPDvaMDyONlorTe
         R/DuoDJ5Qp+aFmQcJWLaTSY+ZmEvQjCGPxAlU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711656566; x=1712261366;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XTxbVAahUUqo8qIWTib74cjwQuWnxXYmY/UOpSlb0dE=;
        b=lmXnIDhGHX1WUeM9NUYpF3duMRHi1Q9YR/661iV/7SETg47QaaU62kB3WABEm20Fj+
         d2Z3tIM75/JM6YATFcMfaalf8T45Ltd6FYUEPnqV6OfKeCALiG0Kj7z7W1BrrO3VHOiQ
         JDDZZgVhTfgysmWewieCdIulA6Ktbsahf+i9yPY1foPDtgN4YB0RQ1GD+2lyVoQuLNRQ
         WWRZ6M6DvrF5DiGEz+sInGxxaYmk6jB6VdLcJSC+5b0b0gZLV0PLET9R5zPTcOO/x/bB
         3CGjcAUk0mTw1MeDRh7dFf+8lCukQo/A6qfg7cVuxuTIwsYmtGan6n+HYF9lT7mQMN5V
         rpZw==
X-Forwarded-Encrypted: i=1; AJvYcCUY8Bw6YnpnpgivrVZXyOuhM0NGAEEvo6Wb94jTjjV/L1ySCSCz6iyE1ZofyVBxoMdZ3RyWVrcVNfNDA0jaKHUHDn0AOTE80WjOaw==
X-Gm-Message-State: AOJu0Yz9SCg82lx/jBv0+CcrOzOSy8hngr+nTXRBnVVNcMawJUaPD/oe
	7LKZC0X9MbgZ0HXJusvRMCZtVmr9fxg4ZqZSqjUDUvrMsQU3Fln5Pp3EEr8xPRrSeoHZj1um9jM
	iwPBZFw==
X-Google-Smtp-Source: AGHT+IH0YpKd8ttLiED/8o4oe8v09O8AvrjAeZO01Kw1oy3YdbTk+q/PLsjchSYmR4SgmwLjCNcSqg==
X-Received: by 2002:a17:906:7245:b0:a4e:2269:bc21 with SMTP id n5-20020a170906724500b00a4e2269bc21mr222432ejk.1.1711656566334;
        Thu, 28 Mar 2024 13:09:26 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id c3-20020a170906340300b00a4739efd7cesm1118159ejb.60.2024.03.28.13.09.24
        for <sparclinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 13:09:26 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a466a27d30aso171802966b.1
        for <sparclinux@vger.kernel.org>; Thu, 28 Mar 2024 13:09:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVW4ui/vCgsRgpuE2XmbKaQJmvZHNuCCICwL3sZq3DyedW6lF9MAr60mmxlgDEZtxs8hqfjntXbo8KLewdCK3HXS8WTZ4cOEj79GA==
X-Received: by 2002:a17:906:2698:b0:a47:4d61:de44 with SMTP id
 t24-20020a170906269800b00a474d61de44mr190688ejc.55.1711656564444; Thu, 28 Mar
 2024 13:09:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADyTPEwt=ZNams+1bpMB1F9w_vUdPsGCt92DBQxxq_VtaLoTdw@mail.gmail.com>
 <CADyTPEyAidGgBT3f1VJLHb3ouO-r1UyvFp1PcwXxy0NRG94sbw@mail.gmail.com>
 <1df92fec-7f57-5080-94ed-b149ed384280@leemhuis.info> <14dcd743-144a-9f7b-849c-0843d50e4c04@draconx.ca>
 <4dce7447-678d-4e60-b76e-b01988bd6515@leemhuis.info>
In-Reply-To: <4dce7447-678d-4e60-b76e-b01988bd6515@leemhuis.info>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 28 Mar 2024 13:09:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgFuoHpMk_Z_R3qMXVDgq0N1592+bABkyGjwwSL4zBtHA@mail.gmail.com>
Message-ID: <CAHk-=wgFuoHpMk_Z_R3qMXVDgq0N1592+bABkyGjwwSL4zBtHA@mail.gmail.com>
Subject: Re: PROBLEM: Only one CPU active on Ultra 60 since ~4.8 (regression)
To: Linux regressions mailing list <regressions@lists.linux.dev>, Andreas Larsson <andreas@gaisler.com>
Cc: Nick Bowler <nbowler@draconx.ca>, linux-kernel@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 28 Mar 2024 at 12:36, Linux regression tracking (Thorsten
Leemhuis) <regressions@leemhuis.info> wrote:
>
> [CCing Linus, in case I say something to his disliking]
>
> On 22.03.24 05:57, Nick Bowler wrote:
> >
> > Just a friendly reminder that this issue still happens on Linux 6.8 and
> > reverting commit 9b2f753ec237 as indicated below is still sufficient to
> > resolve the problem.
>
> FWIW, that commit 9b2f753ec23710 ("sparc64: Fix cpu_possible_mask if
> nr_cpus is set") is from v4.8. Reverting it after all that time might
> easily lead to even bigger trouble.

I'm definitely not reverting a patch from almost a decade ago as a regression.

If it took that long to find, it can't be that critical of a regression.

So yes, let's treat it as a regular bug. And let's bring in Andreas to
the discussion too (although presumably he has seen it on the
sparclinux mailing list).

Andreas, if not, here's the link to lore for the beginning of the thread:

  https://lore.kernel.org/all/CADyTPEwt=ZNams+1bpMB1F9w_vUdPsGCt92DBQxxq_VtaLoTdw@mail.gmail.com/

And from a quick look I do think that commit is buggy, and yes, the
fix probably is just be to revert it.

As the original report makes clear, that commit 9b2f753ec23710 is
clearly confused about the difference between "number of CPU's", and
"index of CPU numbers".

When that smp_fill_in_cpu_possible_map() does

        int possible_cpus = num_possible_cpus();

and then uses that to fill in &__cpu_possible_mask, that's completely
nonsensical. Because we literally have

  #define cpu_possible_mask ((const struct cpumask *)&__cpu_possible_mask)
  #define num_possible_cpus()     cpumask_weight(cpu_possible_mask)

so it's reading cpu_possible_mask to figure out how many cpus it might
have, and then using that number to set possibly *different* bits in
the same bitmap that is just used to judge what the max number is.

So I do think a revert is called for, but I'm not going to treat this
as a regression, I'm going to just treat it as "sparc bug" and hope
that the sparc people try to figure out why that crazy code was
written.

And maybe it made more sense back a decade ago than it does now.

Andreas?

                Linus
