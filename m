Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879683DC4CC
	for <sparclinux@vger.kernel.org>; Wed, 23 Sep 2026 21:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790198228; cv=pass; b=fN/N4yZo7CoNedfSfWmH444xttZ+sY43DjIpa0P1sNipOn9ofxrWYqqwVZ+h5XhMKep1HrAfRP0he6JXdgscNssygOKOIOfiVZkH2qOu3lCH5gK5sOOD3+x6D/nm06wzmPvqtD7ps9QqD4pdJhxu/ecjykn+RN3oowHcAxTIVt8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790198228; c=relaxed/simple;
	bh=C5HdZMd3V/zpNuhFOrkwdljn7AwYQiF19c8FeGsvyvw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=grLImTgXqjctfOTFscXF1oSbTFn34UTcS153AnHEUFWPxdu/zO7LBQVsTO5uzQE7kWJZ5AGw8e79hAAIkBlvJcwQ9UCGXyxNeOTO69qYrGOIXMt5FkWV4zsgkeR3tMc1r8x9erJElJfxLjc90vdYmdi5WeF3lTNHA4cDrp9EL6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Lwg3Xy5l; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lwg3Xy5l"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-52faa58bff5so30231cf.0
        for <sparclinux@vger.kernel.org>; Wed, 23 Sep 2026 14:17:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790198223; cv=none;
        d=google.com; s=arc-20260327;
        b=fAglusUsGcD83OwUzhzgiA7/qAeBYgTbf6HP040hDrzNr5yhy6fgahUWfMvoUB9V46
         /b4Wrs851uK0baUVQGL/QRLZqi4MHb9Ly8Pdid0/81Wq2zHCkm835hZrZLTzckf9BEK2
         2tN4Lu4GnQtxE86cym6C4KdWrpapGoow2GDodXgThv4mRhJjRS7giqhJ9O9diRnn+0w8
         2/J1SWDs5U7xEDRuZLuSjcWlIDzprZdgTdO71ghrxTFF/0xWlROpREz03vR06P64SjqL
         pGvza6vM1IPn8vr8hUZyRRIgXyexZ9/Oj4kK3+buLxTlvJhCojMs1Frv7rQs+wV24Hee
         peoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=C5HdZMd3V/zpNuhFOrkwdljn7AwYQiF19c8FeGsvyvw=;
        fh=yP2FuIMwsjNA8lWz+dqSa0louGj9EcfmppvNR1vqFnc=;
        b=GjzADa5xgIWuBCXNEji73TKMvRFcOGEFf5T7hRYzmjmMZBCzOd73rvUDsmJtWSzxc/
         UdtOCr8+Fdfyg0jO0IkX3NaE0DUvaFdMcjxaPjfI8AZ4tXM2hHDzIVtbz13Bp11PBddh
         qzbH30Ldt+AOzLr0EGEY4wdO+jEKGVn6coYqui3JaWcFsNAbJ21KC0ywOL7PrEZTTDDj
         0d5+Hk/dWahKMTzhGQuUBU6gDhmyx3vf+/JjuIHK1F5/xJ9Jwoigae9lV9tb4iK5v7yd
         5JRgeJyTzUJHgQxmOXCR/5ymnCvgN9I17k4gSF9VRWu9SfBlAlevcMVeAa49leSCFiAf
         t4PA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790198223; x=1790803023; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=C5HdZMd3V/zpNuhFOrkwdljn7AwYQiF19c8FeGsvyvw=;
        b=Lwg3Xy5lYMDf90jqn3ho9Cam0aqsJDBQACJYsyoKflvSObThj1DoiY/uZgx9SNYj+4
         YIODlNKf9WQJFgL0PAjRd8AswuDTSD6xxP96FIJzfSN4Rtbx7b3uFYsF4mtwI2NC62eV
         LatlIWM3bxugwqGH2aUgkqvIcxHyVj8ylNeBb/EAZV5PzLOJLkPQAjO55OyRRpJYBg0C
         FlpEfNZaZQwfP4uzyUPqKQlFvsue5GRrjYPqneT73mooODy+NgbE1+Wf3UF/ult/Bvfs
         066QfO/a40z0pz5D4KFkmPrumHvyacTwi7YqKW1K1VYT2Dz0es47IBXazjVacuUAdbur
         IfQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790198223; x=1790803023;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C5HdZMd3V/zpNuhFOrkwdljn7AwYQiF19c8FeGsvyvw=;
        b=cJ4AVhho9XRk9TnoFOGtpWs4viHwhtzg0hRbrD5SxOxzIzZeNnrmAdda/dz5f20feM
         ntr83O98p1QPZxJOhVJqjimsfp4nsZ1s5BCFZ9x4gKI7K19Lvf7MHPNze/LSJeJQF8Nt
         qFSZ3lG9jMKRumaApyZVi4xQF2/SowUCj6Mid0++ZdIVxOV67+rPs13nXqxlxguly9Ug
         Hz9TOfyqGKn0g1JyptFi2JU4q2JDuCB8rkJLpjaJU/Sbi5xBNJbPugyFho88xFFmTuY0
         VWmUQHjaQsumfEVifN/EHsDnLXK8aI9YHHEpKK1rBd/qrwhEqgCfhJTYpDjOYhRfW43I
         /5gQ==
X-Forwarded-Encrypted: i=1; AKwUvBxDsk0HiV50SQ1x3BVfCLWNVtMGIHEEGKrTGkhuV+iel6U8PJv5aEx48JWj0+UepfjY1Id8j/dRCbhb@vger.kernel.org
X-Gm-Message-State: AFuF++nGb5SixQiYmSXTt5jUKjljNHhHzVpkNRjyVwykBB7ss1n+ZoH1
	9YuhmKThxuSqcYDHmaLOVut6cphi1NyhvxugI/BLKVR5CwfkEX6Lvz5U97LbdO3oDuo9SMRdn1O
	+HiKEVNW9r5sOGO2Jt71d9Lc37IlSTkj+cuWasA6e
X-Gm-Gg: AYBFou0DpDRVgeXADCwxUZ8gGv0rpDSMbln6lEgZYo6eBDJGlR7LkXVu74HlUMDoOut
	bsHfSIIBQsUKD1nQfwWplKGVkKtgPW+3ok3eQeZQiH1xf2LslaFa8FIsyKDuWKEYIcRgXQVSAzY
	2QQC+oCxiFN7ADsxCTRgaLIAbCv3a8g9m1ID4XfbM9gOpM+4O8l5NBNbhn5sJLvn0Ow9Sj8VPNV
	+1km7oHpsXWoQDGYHTD1BJ5Hg5ePiDH2AQByWBkHJErZwvaHhVLUAVRUh6XZV5kxcwcVVd/JAS6
	rswzmSGI+AltF8IxkcXyCA2+tf3CW6gJ4ThfAwehAMggCnGQ6CeabPFbRVscLfimFfQH2pZrlTi
	/cHATzhoobg==
X-Received: by 2002:a05:622a:2ca:b0:52f:9ed4:8d76 with SMTP id
 d75a77b69052e-532f900c602mr5083471cf.14.1790198222132; Wed, 23 Sep 2026
 14:17:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923090429.2026529-1-stian@itx.no> <CAP-5=fW4bzmy5_6a-8YucOy7JGKg+izRbq+7TaOGKV5aG0oYcw@mail.gmail.com>
 <4927bb40f34ec6d3d5591dabba755452bd6b4a39.camel@itx.no>
In-Reply-To: <4927bb40f34ec6d3d5591dabba755452bd6b4a39.camel@itx.no>
From: Ian Rogers <irogers@google.com>
Date: Wed, 23 Sep 2026 14:16:49 -0700
X-Gm-Features: AclHuK9pZsA8iY-d7bWNHMtUz0MouzhE42jjiSTkxy86JSYE5mHT9HB5K2xVHh8
Message-ID: <CAP-5=fWhk8Z22+PhFKbatO6fYgiNBgLGwVgg_NxS8fg=uEdDUw@mail.gmail.com>
Subject: Re: [RFC PATCH v3 0/3] perf: sparc64 user regs and stack dump, with
 arch hooks
To: Stian Halseth <stian@itx.no>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Andreas Larsson <andreas@gaisler.com>, "David S. Miller" <davem@davemloft.net>, 
	Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Magnus Lindholm <linmag7@gmail.com>, 
	linux-perf-users@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 1:57=E2=80=AFPM Stian Halseth <stian@itx.no> wrote:
>
> Hi Ian,
>
> On Wed, 2026-09-23 at 13:38 -0700, Ian Rogers wrote:
> >
> >
> > For the series:
> >
> > Reviewed-by: Ian Rogers <irogers@google.com>
> >
>
> Since this series is still marked RFC, should I resend it as a regular
> PATCH v4 with your Reviewed-by, or wait for additional maintainer
> feedback?
>
> And thank you so much for the reviews!

I think we have everything we need but the kernel changes are really
up to Peter and Ingo, and the tool changes are up to Arnaldo and
Namhyung.

Thanks,
Ian

> Stian
