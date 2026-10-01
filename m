Received: from mail-pz2-f37.google.com (mail-pz2-f37.google.com [74.125.228.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1E14AE115
	for <sparclinux@vger.kernel.org>; Thu,  1 Oct 2026 21:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790888770; cv=pass; b=D9sxu9e8aL1eqBMmCFc44sqA8Jqmd1ooiLLs/aVDPgLWIwodM25Tr5fBWCNH/VX6DFi9qR1jSmQGUom5ELCm0Z2EWg0o43jO2nnpYbfoUuGaIf2ObvRyk/h3nMEb4TV+2gI5sjZX5aLwVnvDzKySL67YsHpnWN5xmailU8bynps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790888770; c=relaxed/simple;
	bh=xN21QYy0yGgz2sHT1nXnC/21nVEwjhkQB04Hg4E+rW8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gS1vU7pgRkPlQNV8/g8Hmv+5eixlw8nyt6qDEmTV5ldFfn0yYKOT05YGnCzKE9IzeUMTjuHDMo4yDTMPztYzHtdX/eIl663LxKVW2F9vw+xxtqZEyFZNjBEtMt842/uyeW3n4J9t/yZURdnlfZ0LMj4i8HHq83Za9SQnbaNucW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=CAwV36pr; arc=pass smtp.client-ip=74.125.228.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CAwV36pr"
Received: by mail-pz2-f37.google.com with SMTP id d2e1a72fcca58-885f0eca6c4so1421112b3a.1
        for <sparclinux@vger.kernel.org>; Thu, 01 Oct 2026 14:06:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790888767; cv=none;
        d=google.com; s=arc-20260327;
        b=SAnhtOfCuR6GLMEUp7BrcDDX1rCumXqqWiSDJdos7jd47MC3URstlUCpNaXvIA7TTc
         x4rwoWI3y2Hn0AxqKeC8HvImSgQFWKWdfqlBWYyx75k62fiQZTIaw1/cyCFJDBLxPn9q
         Qd6zWpL4nLCMWdb7/0FejjAPm/Io5vBir40ZJN7evH0R1L5RaNppWPn+TDIGymy/BMQy
         okfZnqyXD3uKjuoziVQc77PTx5cO8+jHadBYVj6pVYNoHJDtsSlb0A7t0ZvEQRpqYGsA
         4L53XhJp7SjTQ3TYAGSAOBQiwR6wkYo0Kd4WcmPs6OhoIiL6kCDHa6SfMxMBKNmQkuDG
         /Blw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zQjpYhlPNUCc8b2PKOBh4ENa5gh7HULkWsy4SYnLXSM=;
        fh=NYUwNf0LHwFzYWOHMsJQNCV5vNkIJiPEKOgnUZBSSvc=;
        b=ThWPWazmLlfhX7c+hUGUcUdPLtJ3pAbR1wlmcAGqz9h//zbe3zOya+vPBWIaVvL5dk
         aTafmsx9v9MIxfQ123XTBAEZbCiRwMe2hN4zPkNtHn1mTvpzdC4f9p1E5OpaD7+ilwVh
         AtwEJJY9+jSsvr8C4hQR/CzQ/QYpXvXGmCjCF6HJFMQdLf1SAWc3unQigbqVHcKU4F4Z
         h545vxLsevzArUzAdZcN24zGE/NSzAl1w/Q8/nKOgWR8TW3RmkcxT58ycw/3JYl7OWKV
         IypMDoK63oi4iqqqMYR4jzhIcEDKQpsSzTkncwP8zG7KnYJ36nA9zM1/8vdsevSrGYTz
         2gwg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1790888767; x=1791493567; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zQjpYhlPNUCc8b2PKOBh4ENa5gh7HULkWsy4SYnLXSM=;
        b=CAwV36prXHOZw2NRE+aSACbPdDsBf2SHqbBYA6oNTHRxcIGcOyC/CJqkRH7LJRevOZ
         ClcJMU2t93f7XmqqwruK0c5ZXJiXQfI/+n+w9nHyb4EcEh0EZTu11pUBC9xzrVuOqKBT
         YsV75j7RrnJU55Z+JqH44vXWfdCbI4I+NCB8980IdTgu7vzPMxHvgU+uCw/+FxPpgY0h
         63X1M3w+g/hILuWVI8qWSFmlSwv2NKZwGdJ2DwWfYsxtFTA/lG+C3YADiA4myoIGj7HP
         Z1Ev8yhuTUNqN+BrgGDh8F6GLVD0gbmqkkcnf9FOFy5sLyuxAa1XjcNkIrhbHMfk8YG5
         z0BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790888767; x=1791493567;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zQjpYhlPNUCc8b2PKOBh4ENa5gh7HULkWsy4SYnLXSM=;
        b=Mf0075DSsMar/OPXnoDbqlhbh/zs8yMjcPiLjmGbC73GNQj7QkxW9OxbBHmUZusbHV
         Mti5nG0UzgOoyeYkN6IqsYO46aSLYLdsspaCTw3kNnmpjgnwZco7kd+uMoFtLSlUrrX4
         ev9WQV0jYKcOEQzFJD5RU0yFcbwtOTEY5/dir2Z0odODDWhBh17958gemeBnaeUVw36j
         F6uWY9ri8kqedNjf12AqGWi94HDRfmcmQgTxxaDOK1ov9bUz+am+fpbHRBK4HemHvRAT
         MhX+HaXluDlFgMYwDHYe56nwpEi0GuXDRZG3+Wdp0y0eAlWlcaKTesSgG6pdVTWP5aaO
         YY/A==
X-Forwarded-Encrypted: i=1; AKwUvBwAbciEzUBY6sS+v9eOhkmX6n1ZabADqmRa0YqtVNrMMi0ujq8tTc4ZsXMmIpbED0Gvvo68VvWY7mS5@vger.kernel.org
X-Gm-Message-State: AFuF++l12mFCIKUVNc1z5bsS/+Usm7ydStzWn86mFLE4YE8rtEvs7Obn
	OlkSFeXIa0P1qGyfsS4AGTcQaRa3HGkLfKhEHLORDbRdh93qxB3rX9o+8CM+URs8t40l8qhlM7A
	yFKnXHKG3NHz7XOB1TIxHDBO6PnazyUa/tPyk4fQB
X-Gm-Gg: AYBFou1IJWzhCGolx0LoJuqMJeVUK/ULwOmmBy1SrsSurBsWKzR67Nfi7nDWOmLtxf/
	2Dcf+3DZibf12QExNotnxjRaGpYz8apmGUfebQFlMwK77spAw7ZPExwm4LdzZSEdMGtAuHGYsgx
	Eq/r5LZICfIu9uKlRMTVQTUiMR0f0Cx5pbZ8FIUzMPQUPPZ4MfIVVukiLipNwzH0kswymtyuH2B
	buFZBS/QMYKSCApYdv+HJPS/UW0aqrPcoZp/4h++kJx3TMAeRnUY417vSB5Lc2hZmNHzOIIbcIK
	NVxzevaP/76+qTGa+Ikd6RAPnMQ6KtRupVB7xAnbYUn63NzaKDILn3quMU7y4ACoK1r887pFjbX
	MqFJUYL+1esdR
X-Received: by 2002:a05:6a00:1254:b0:881:5dcb:400e with SMTP id
 d2e1a72fcca58-88af6d24f34mr727169b3a.56.1790888767004; Thu, 01 Oct 2026
 14:06:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1790088067.git.rrobaina@redhat.com>
In-Reply-To: <cover.1790088067.git.rrobaina@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 1 Oct 2026 17:05:54 -0400
X-Gm-Features: AclHuK923qNeclwyxHc-N96rTW9f--kU_8IWc_3FVDcJfFTXqnWMr4asd_Mjppw
Message-ID: <CAHC9VhQ=FFYVNmQdiMsqg+5KDDrSC3SZS+H2=r_GkhfwQox8tg@mail.gmail.com>
Subject: Re: [PATCH v3 00/14] audit: log all six syscall arguments in the
 SYSCALL record
To: Ricardo Robaina <rrobaina@redhat.com>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, bpf@vger.kernel.org, eparis@redhat.com, 
	sgrubb@redhat.com, oleg@redhat.com, richard.henderson@linaro.org, 
	mattst88@gmail.com, linmag7@gmail.com, linux@armlinux.org.uk, 
	catalin.marinas@arm.com, will@kernel.org, guoren@kernel.org, monstr@monstr.eu, 
	tsbogend@alpha.franken.de, jonas@southpole.se, 
	stefan.kristiansson@saunalahti.fi, shorne@gmail.com, 
	James.Bottomley@hansenpartnership.com, deller@gmx.de, 
	ysato@users.sourceforge.jp, dalias@libc.org, glaubitz@physik.fu-berlin.de, 
	davem@davemloft.net, andreas@gaisler.com, richard@nod.at, 
	anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net, chris@zankel.net, 
	jcmvbkbc@gmail.com, tglx@kernel.org, peterz@infradead.org, luto@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 3:21=E2=80=AFPM Ricardo Robaina <rrobaina@redhat.co=
m> wrote:
>
> The SYSCALL record currently logs only four of the six syscall
> arguments (a0-a3), silently discarding the remaining two. This
> leads to the need for auxiliary records when audit-relevant
> data lands in the 5th or 6th argument of a syscall.
>
> This series extends the SYSCALL record to log all six arguments,
> by adding arguments a4 and a5 inline within the existing record.

Thanks Ricardo, this looks great!

There are a few things in some of the individual patches which I reply
to in a minute, but there are a couple of "global" things that I
wanted to mention:

* As pointed out by Sashiko, when you were converting all of the
arches, it looks like you missed alpha.  I took a quick look and it
appears that it should be a pretty straightforward conversion like
most of the others.

* We need to get ACKs from all the various arch maintainers.  Aside
from the parisc changes all of your arch specific patches are trivial
(and cleaner than the existing code IMO) so I don't expect anyone to
complain, but getting ACKs will likely take some time.  Even the
parisc patches aren't that bad, and arguably they fix a problem for
seccomp so that should make asking for ACKs easier :)

Since I expect chasing down all the various maintainers for ACKs will
take a little while, and I'd like to start getting this patchset some
basic testing, I'm going to merge it into dev-staging now.  While the
dev-staging branch doesn't feed into linux-next (this isn't likely to
land in the next merge window) it is one of the branches that gets
tested automatically and included in my kernel-secnext RPM builds.
This also means you won't need to worry about keeping this patchset
up-to-date with rebasing, as I rebase dev-staging as needed (it
intentionally isn't a stable branch).  Going forward, if there are any
minor changes to this patchset, e.g. a few line change in one of two
patches, please just send a fixup patchset based against
audit/dev-staging and I'll squash it into the relevant patch in the
series.  However, in the unlikely event that a major rewrite is
needed, just send a new patchset ... but I'll be very surprised if
that happens here :)

--=20
paul-moore.com
