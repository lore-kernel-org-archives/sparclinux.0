Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400502F261F
	for <sparclinux@vger.kernel.org>; Fri, 31 Oct 2025 08:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761897678; cv=none; b=KChwtni54JgAuwefr+ZiGZO5YfBpeQTfjgkF7pnUIT7Rm6Tr1OQLxRxMh41E9AFTcrHRgoqyoKD6SB4qtqrqX5Az5snbeNo7mWkv6y6E9Z/1YLrSOwHzdVffkW7TXHHVA7TWKdszolyY7N9kg7zV4AIbOfOvbSvabaGgiUo4Mo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761897678; c=relaxed/simple;
	bh=6RExzYFt2jFngKeLwZZhIXhryDhrEYofiRI4ar8KsXw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VwS0YxapKZWgraP6wRtkN8nj6SwckgIckisfA8q8E1Q3K8nRwNkKaPBU+vGh53amHW+6rji/nEErlmq3w0axFlZTkKAuaRQHkhzpsfadEhnDn2K39HCNCYHChordQ2Y/XJ7ZXJ8xoZJYIaPVtROOBBldCagO9hUZ4C/DyA69NQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-5dbaf2b0bf4so512952137.2
        for <sparclinux@vger.kernel.org>; Fri, 31 Oct 2025 01:01:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761897674; x=1762502474;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h9bvdnPD20ODXbm88Rkbvmv8aTDyzXTmQyD55LvW55s=;
        b=qrgwH39b8DsMQXtFkR+e+dDh4Qy4YlsGetOXlbI46EyuazaF+sy+kWzFdZzuexZKCT
         aJybg/bqD63tYwEAB2yeNGBBQTG7VM5YoZYg2YJsuWmxyAIwMPN2zKvKgPYP+n20XDjU
         rY5wNj/ONkgPV3xl1gBcIU7YmY3IuE1U2hyu5q77ObGDzgc6/4HCu0mHUCe5riZt5La0
         Zt2Uk+E+GW8tCy1Bcam41WlkqlKUy55fHjKe0uWSPXaz6VTPVbYPT2NNAchNJCr9WR8U
         UvOFRvaAxnFzn07X4S+SEaMXnF63eSFxTwE3NO0ikJ3A3O1GxG1z/Ys1I63NNjTtIrZz
         GY8Q==
X-Gm-Message-State: AOJu0YwsPuig2EDd684eU8dejVwObX7ln9/Q+gCPwuILezez3UwJ0p7V
	AAPH70m5bofyccsvzp8L3tvARUYUmE4B4gyK1wsRJ60y+oMRqxuG8ECyA4hQcHg+
X-Gm-Gg: ASbGncs7dSu8bYtDVQMNGE7wSq/gotRLA49YUQ3t8Fs7lbe5jDuz1Zx0+BYQjSalTt7
	9ow/sclauoVLVLTW4z7qJtOhr2cZ24nAtOi9WC4pf7Ncre75ouR4qty+rGMJ+O6FORaOSj83Yr8
	t5aP/fzlIUQyV0uLcauMH5fQMR8DhM+s1pq0i1etjssnPYcn7MmfmD0tF14L0PrCTDrklacOgzh
	011MqrX5joEPEi9+rPwCJ5dFp90IforsspjhQTjpRB3MFKp1BcKbKINPSwDNSxBIdVNrRsMz918
	tWc6gAO0HTc54mfc9Dekcsgl0KDIAqHD9MuUJuM0VJHeQjopATYxCAf7I4RYnsqiE7eEKiJz+Ng
	hMxC71OWo413nFvyHtDv8zQWNWpUVPCONUtGxJGB/OsRikviiAepTN7tj873J9CmlpP+gG8Fsvo
	ck08bQyBZ6uWceNgsIF/debnoW/ey5f5Q0GB5N3YiDrbkKFkv87Wd8
X-Google-Smtp-Source: AGHT+IFUjZEdFmZTowbsOnZP73FI44FiJN79tjfaC9iQrKjSzfENsb0TiQJUkYPGXWfU2uRpDfUZtA==
X-Received: by 2002:a05:6102:2926:b0:5d5:f6ae:38d3 with SMTP id ada2fe7eead31-5dbb1379111mr710534137.40.1761897673861;
        Fri, 31 Oct 2025 01:01:13 -0700 (PDT)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com. [209.85.217.51])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-93512a5789csm415052241.4.2025.10.31.01.01.13
        for <sparclinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Oct 2025 01:01:13 -0700 (PDT)
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-5db385e07a6so903466137.3
        for <sparclinux@vger.kernel.org>; Fri, 31 Oct 2025 01:01:13 -0700 (PDT)
X-Received: by 2002:a05:6102:4186:b0:538:9b66:7655 with SMTP id
 ada2fe7eead31-5dbb12466ecmr618067137.18.1761897673256; Fri, 31 Oct 2025
 01:01:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2fa899eb-60b6-4637-9035-aeff78e261fa@web.de>
In-Reply-To: <2fa899eb-60b6-4637-9035-aeff78e261fa@web.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 31 Oct 2025 09:01:01 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX-uKt3-Lb2NaxmONEqWdtFgTOqXEo1nOfGq-R8ysHfcQ@mail.gmail.com>
X-Gm-Features: AWmQ_blCO1e8lSBOgkh0TQ3Lynfwp2Y7X0NnvV--2NjFJHk-coEQ7bju69mPh3U
Message-ID: <CAMuHMdX-uKt3-Lb2NaxmONEqWdtFgTOqXEo1nOfGq-R8ysHfcQ@mail.gmail.com>
Subject: Re: [PATCH] sparc: time: Use pointer from memcpy() call for
 assignment in setup_sparc64_timer()
To: Markus Elfring <Markus.Elfring@web.de>
Cc: sparclinux@vger.kernel.org, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Andreas Larsson <andreas@gaisler.com>, 
	Christoph Lameter <cl@linux.com>, "David S. Miller" <davem@davemloft.net>, Finn Thain <fthain@linux-m68k.org>, 
	Tejun Heo <tj@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	kernel-janitors@vger.kernel.org, Miaoqian Lin <linmq006@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi Markus,

On Fri, 31 Oct 2025 at 08:46, Markus Elfring <Markus.Elfring@web.de> wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Fri, 31 Oct 2025 08:36:13 +0100
>
> A pointer was assigned to a variable. The same pointer was used for
> the destination parameter of a memcpy() call.
> This function is documented in the way that the same value is returned.
> Thus convert two separate statements into a direct variable assignment for
> the return value from a memory copy action.
>
> The source code was transformed by using the Coccinelle software.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Thanks for your patch!

> --- a/arch/sparc/kernel/time_64.c
> +++ b/arch/sparc/kernel/time_64.c
> @@ -760,9 +760,7 @@ void setup_sparc64_timer(void)
>                              : /* no outputs */
>                              : "r" (pstate));
>
> -       sevt = this_cpu_ptr(&sparc64_events);
> -
> -       memcpy(sevt, &sparc64_clockevent, sizeof(*sevt));
> +       sevt = memcpy(this_cpu_ptr(&sparc64_events), &sparc64_clockevent, sizeof(*sevt));

IMHO this makes the code harder to read:
  - Only 0.15% of the memcpy() calls in the kernel use the
    memcpy() chaining feature,
  - The line is now longer than the 80-character limit, which is still
    customary for this file.

>         sevt->cpumask = cpumask_of(smp_processor_id());
>
>         clockevents_register_device(sevt);

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
