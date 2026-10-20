Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792514342;
	b=4LxRjN65oEG+97VDW9PPJ9ILhi2JExc1qvj9OLRIQrPqZ8rkiBQL+ZnSepXC9Oz8g4Dq
	 SFahLvwNuQyzr40crpefu2D/FCxVHy7spRx9Z/f+0HclCkzZrlrojh35gUC6X6NyxgZsj
	 7KRRGfpD6Nj4iQ20hmKiTitcCaWkM2oSYZcsJyHbXD8YqeUCqz01IpmVB7fAl8cJk8lov
	 fnALup98zin+qyWOMMYRd2kfNNeYosZ3ZMC/Nz4k/LSZoWX6KJ9FK18HdCv7ydcT6ZGWm
	 ckRdDlWrOYkpIWhvFlrhgrBUWEKQFR676DSycaKVt9PXbr+DZMUSSkbAY1nTbESkVRw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792514342;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=5h6v8PMV52XAIibb0bLKm7PVGjK4muo/m4wCC4Oc5nw=;
	b=Fq3xLNiHDwgFKp2P+0DP2dEvEG45P29f6hwc+D8bYhR/S7hgDdGaUsIc6NmQ+MuhGxzA
	 I1oTB5s7/8+V/lItvhCV5kDKgQ2SOHE+oLKIYrFsyySTAcxlu+ZKPIvpEeeKMievEy8Sk
	 p+H39SiwXOAYkz5OEZcfskZuhzQlHfM7uyiSzwmONVw99aGVSL2oxQgg8EnaNzAe6JYog
	 /jKsZQXDSfW4AU5VuNTPUbPf2NWYe0tVRhLm/7Dd1qNjqqbR7Af2e1guwbnd7IWiLfcd6
	 CO3dslI4/e+lj3adsCItuuz7j4qCx4g5Q81EGQF6rLHhqejk6a6PaEVaKxU5DhlZ6wA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=GwYGVURA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F291360A2608
	for <sparclinux@vger.kernel.org>; Tue, 20 Oct 2026 16:38:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F291360A2608
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=GwYGVURA
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2e901e114fdso17356255ad.2
        for <sparclinux@vger.kernel.org>; Tue, 20 Oct 2026 09:38:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792514336; cv=none;
        d=google.com; s=arc-20260327;
        b=fCR5e9iHB2qQiW1amRl4w54xdsGI++svY+VbtB2Dxmiej14ABIgWAF12vjKu4ZYoYt
         uvTl4F044j6+7Qfd75vVyP3Icb0HzCKD57KHrgdUxGVVcUAYCr9apjQ+neWpcktnuui/
         1INniDZgLruTRApzSpyZx2Zjuq435Rpzmpiub5Jk7bksjzBy9Xs2xfwBZ23XdHaZz3GD
         swzi8nZ9IB6OrJoH+c2IdSFPctqk1zKEV8ZXG0L8hjJUAOO/zRdG7sS8wx5c7oMtEydQ
         1r0Rf8j/tGJB8EeRyJQHsfJQEiIhHJzJeBK+Q+12RdNRpqrHHDOvxjmll1Gvi8cqwyFU
         rx1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5h6v8PMV52XAIibb0bLKm7PVGjK4muo/m4wCC4Oc5nw=;
        fh=MMBqcJamUGBABkUkjSV4i4uVYcsZagLQjRLJUMChSXo=;
        b=OCOu7QG/L4Fzq6XgNkhtcWY5sd9PSsy/fCl1l5fC9PwdnXP787zlICRiYLdeih0s+x
         my6PNjBzyTQ9bhbO9XhsFy+2KlXO+tdyqs4WoeoWr7d5hLuExMeciv82Ao+Ybpv1NR8b
         azCGArEvIkMKtX5aSDeDFmo48b/smyU+ujYBiFYiRFsvqmJSwVNnH/Ae9oNTdwXkb3gc
         +e74wx32FJMOztId6MpTdS1nrGvnXyZ981yhcf0CANMBxD7qyNsVk96ZQEf0g6mbjox6
         F1rVzfF21QJmPOj3rFf0myYMg7p0nLE8aWxUqWVIToZxyKqllv/uplGcU+fFrvR2KH+g
         h+WQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1792514336; x=1793119136; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5h6v8PMV52XAIibb0bLKm7PVGjK4muo/m4wCC4Oc5nw=;
        b=GwYGVURAL7E3Gqp1mE6IbppA5fK/M6QVj3T4+Mu1VqNJAQWSHTCgIBs7lXAHx7VP4b
         X7Ol6JtjEVwHUVW/UUWijctAKk0S3FIF6sAkL2D0z4+yun1CiPIG05jQakKiuYArY+di
         qKUZ2JssWHS9PY4Rrbam2j+K8HSVipMYAjJhVwlz0qlw5vC30c9m2oPlM5nOac4bwKsb
         0iIOeo41vgbotndmbkqO3IW2nEL8EcaGXBwYuALkuaiWKHExqpmpd78k/kVF659++rVb
         16kcHMvBo17gh+L06xflahlYQXJ+NMSTGDwKIeHcy9Z1IKqewLhKEpxT50Ywi1EBHbtT
         Ya6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792514336; x=1793119136;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5h6v8PMV52XAIibb0bLKm7PVGjK4muo/m4wCC4Oc5nw=;
        b=TheAJRsDki8J+0AqHJLy1I/A2bDjwL+sD2fpXs6rHvY7B833V6PWqZDT14GKR2FGo3
         R5HakAjLF8EkLgJIq2RTqDL+qchqv1mVUguasvpv0OO3LIl4gH7un6thocTFC1HhECVW
         T9vndv8UE91SwUjZwo8WaGGqrkebe6KJPtX/duJAgW1nqEfemixC+J4QjhucfuEImSxs
         32HicCoup1/MZItPQA3DbHYMMGfMWztdbCHJoRnsSCrj4BKy3p3Q3xM2guBoQSqfQSms
         5mdBWcrUOzedPuZMxU62L1/Zwj4UU9eo222volS95t8xz4hwPIw+MocyhCr1CHZwAzyU
         W5DQ==
X-Forwarded-Encrypted: i=1; AKwUvByZLkoV9h6P49Sg+h29PqAma9FL4zg+m4wFhx75ZAoJQxRRs0mDivO0VaIfW69NXFfaw+O9+KowVC+z@vger.kernel.org
X-Gm-Message-State: AFq9FYLzTDwGDuDduuFIglOYJPf5+Qkjl0P95hoTUJbbkN7wp0QOHKam
	KFztF7VDrQCT6panMFX5qD4DeuUfiHrLBZkBqhuCWpNB0dGbHfwivGnWSCBtSCqLv05PND9ABv7
	bXliJKCsuc7CQAq6VfUGkFRj5b1jexKXH8Mcsj9K/
X-Gm-Gg: AYBFou3+8gbb7MeTE0yFm4WZ/wllfXunh9oIzdVYCJjSy0qNxs48Pg1IJJbgsTMTiH5
	wOqkQWitKDRcz22R0md9wR/3Xw1ydUeueagSKRettw5nbLk3+iEaG1q4+UNl91tRzhA/i6EtkDD
	HL6sgEK4CedEh0Q+bNOlZs6+cs2rB9hQg/T9PgkCS7gMDSEKh6CTS/LQvcwc+2fOZAXQedHX/Rd
	JHdBqM3CE+VNbOYWZ0+ZiyEkmqIQoJLxOzowSrs3omPaE9rQxSQkAa4Ik5L2wN/RcIaiX/M4z4F
	rYvWJGrLG4Pjy7pJNnJxpkGJ5AutP3iGaUjeodjysgT9SnN9+NeiLyuR5d+hIYSbA6aw76inLd7
	xt5ukuVSpLw8=
X-Received: by 2002:a17:903:1111:b0:2e6:dcce:8227 with SMTP id
 d9443c01a7336-2e9a6c1a30dmr99034965ad.37.1792514336247; Tue, 20 Oct 2026
 09:38:56 -0700 (PDT)
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Post: <mailto:sparclinux@vger.kernel.org>
List-Help: <mailto:sparclinux+help@vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:sparclinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1790088067.git.rrobaina@redhat.com> <CAHC9VhQ=FFYVNmQdiMsqg+5KDDrSC3SZS+H2=r_GkhfwQox8tg@mail.gmail.com>
 <CAABTaaBL=TScs8Qqu3b8F6KZPGMyvwy6cBC3teDaBL6MGMucNg@mail.gmail.com>
In-Reply-To: <CAABTaaBL=TScs8Qqu3b8F6KZPGMyvwy6cBC3teDaBL6MGMucNg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 20 Oct 2026 12:38:41 -0400
X-Gm-Features: AclHuK9ZakV6IFm9eD67kaqUic0iU1MgVPLS7VN6RgjPgTRZmZP6_X_XOYOX9ZU
Message-ID: <CAHC9VhROsmzbm+AP63Sm7mqCokgEy6Zu0AVMY0gxp8qY75Pqiw@mail.gmail.com>
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

On Tue, Oct 13, 2026 at 8:36=E2=80=AFAM Ricardo Robaina <rrobaina@redhat.co=
m> wrote:
> On Thu, Oct 1, 2026 at 6:06=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
> > On Tue, Sep 22, 2026 at 3:21=E2=80=AFPM Ricardo Robaina <rrobaina@redha=
t.com> wrote:

...

> > * As pointed out by Sashiko, when you were converting all of the
> > arches, it looks like you missed alpha.  I took a quick look and it
> > appears that it should be a pretty straightforward conversion like
> > most of the others.
>
> I've actually dropped the alpha patch as per Magnus's request [1].
>
> [1] https://lore.kernel.org/audit/CA+=3DFv5T4826T2sd0Gbh-nfZsqcWK_phdBKy4=
BLWOvDTt92t5Eg@mail.gmail.com/

The problem is that as things stand, this patchset breaks the build on
Alpha.  Perhaps this gets resolved during the current merge window,
but as you know we can't break the kernel build ...

https://lore.kernel.org/oe-kbuild-all/202610041836.6TatRQSm-lkp@intel.com

--=20
paul-moore.com
