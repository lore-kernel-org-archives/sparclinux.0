Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6712594;
	Sat,  1 Jun 2024 23:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717284222; cv=none; b=KpMeJGqWzmsMr6FecnaMM7Bo5sjAYwx8vK7HwqIdCFT+3Rwv0D/byg+wIVcskAEDAJYgjEua6qZbkRYYsY1s3QG3wLXZNdgJclfNdT/LCJh0xtoOU13gimbRvjqMe5TiRhCistMxZNv7TvUno3vV4JjF7QF37jcpHqWe3i0Tf9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717284222; c=relaxed/simple;
	bh=F09WkOb4zjlbyJIQOG9CR9Mt37qnZbdjCOZPPd+57PE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HktE69l4zCQ+Kurcs8ZbKGxl6pWrase1JvagflAqELezz1Zs6iMAhFJpMZ/pxLvmI4OPB+CRG/PdhZcm6nhgkzFdbU+RcXFIPXD46TkfUutyqqvq9D0LOnhaqpTwxRp1bPg3ov98jvYjnF/gqvBdT5AzdQWN2QVOOVKJHSY7Wyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CvjxNygJ; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CvjxNygJ"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-60585faa69fso2123677a12.1;
        Sat, 01 Jun 2024 16:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717284220; x=1717889020; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4PSTY5+233QjLpOpIMQneadANCFD05kjPw3PWERQR6E=;
        b=CvjxNygJ3awyl/VdDJFBwQ/E7WlM1s/+Z+Y7tSnw0dt1Mc56GX+xLBzrdNhazZs12f
         xNrhKMILuNFFuAf5icPFwuVFVIO0Axehsb5oy75mDMkVvLjfmNO8780q/3W8uPXBInT7
         gel11qg21gEYFLllnNy5+wBqP5DBCMmpbp1yMcKr81v0i5mzEfroNtVOXMuT3IP6jqLT
         BFvFlELJjS4VgHmMUK9JtLijmsYMXcKSfWFjZY0UXQKkurfK1Gy6FkpfsZhMRvQWFzPm
         mhbDFlmFufusj1r7v1avsczOg+KDmlPY9/Dwa7zmMHuKOxDQzuB4D0YNzqKL1oHRgG5j
         X+fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717284220; x=1717889020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4PSTY5+233QjLpOpIMQneadANCFD05kjPw3PWERQR6E=;
        b=miVkUTnnirIH9UY6Wu2XfmvlcmcT/pw0SgkRQ1vE+dbcPHtnh33o9zrUstF8KemLzL
         kkhgGPmR6DcX6ivSGaV+jtWEXBlTLww35bHaG374hDWQdAUP+qGINtVVw1XXqycaobpR
         R30yJdcbQFY036SNrPklDSZ82lYznsTBTnrGYchKXshmjROlCtHNDZIrZ/0OiB5Ko3Za
         wDs823vPlWyDBZr/oqBhWT1z+JyFCw7L1t07Wzuht9Zw5ZUgKAByxj15m2BqsfbjL+tJ
         5dyO6o6EEvSKW9DHy1nk3FZTwHK0fqfnPuG2JFaiDRNSkxdDCNaFvNFPVzuHRNdKCacX
         +7Fw==
X-Forwarded-Encrypted: i=1; AJvYcCVd+IZEUrB2EUpzt/NPGnknES47eChnIblMUZc79Xc8HfmFZRNgcemoSt2GEAikua0y+KXMAx9Ts++cQng/SDucipLATb8l72Ne4fensA+kXnaAebtGINbhssY7MCNGMfpFTySA3CqBwBv1
X-Gm-Message-State: AOJu0YxECokaLf+CNdI+ihzirwyI8AKl1N+EAtiGVR8Il3qr4GIV2kgw
	1Asnn79kZvmC8LIToox7QmzNw+X0zZoFz9KwjxYU4k6xnoqQMLuj4WEIguC9CLPTm8Z4XU/mrCI
	WN07ik927XHfu/xAwbh2wPWd7ujqiYg==
X-Google-Smtp-Source: AGHT+IEm6OKLBJwf3PvplL5rwytM1rg5viWRXXh1JCjlse+po6akaQxyzBOT0LfVC1PCl1ISz55J/N9+px9/vmTNq2c=
X-Received: by 2002:a17:90a:bf87:b0:2bd:d67b:6bf3 with SMTP id
 98e67ed59e1d1-2c1acd998ffmr11271494a91.20.1717284220399; Sat, 01 Jun 2024
 16:23:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240518114051.18125-3-shresthprasad7@gmail.com>
In-Reply-To: <20240518114051.18125-3-shresthprasad7@gmail.com>
From: Shresth Prasad <shresthprasad7@gmail.com>
Date: Sun, 2 Jun 2024 04:53:28 +0530
Message-ID: <CAE8VWiLT-bdRfs0DExVOxjG-tNRSBnkZ7KbDX+5bT_d9bkr9hg@mail.gmail.com>
Subject: Re: [PATCH v3][next] tty: sunsu: Simplify device_node cleanup by
 using __free
To: davem@davemloft.net, gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, Julia Lawall <julia.lawall@inria.fr>, 
	Javier Carrasco <javier.carrasco.cruz@gmail.com>, Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 18, 2024 at 5:11=E2=80=AFPM Shresth Prasad <shresthprasad7@gmai=
l.com> wrote:
>
> Add `__free` function attribute to `ap` and `match` pointer
> initialisations which ensure that the pointers are freed as soon as they
> go out of scope, thus removing the need to manually free them using
> `of_node_put`.
>
> This also removes the need for the `goto` statement and the `rc`
> variable.
>
> Suggested-by: Julia Lawall <julia.lawall@inria.fr>
> Signed-off-by: Shresth Prasad <shresthprasad7@gmail.com>
> ---
> Changes in v3:
>     - Remove incorrect testing statement
>
> I've tested the patch by cross compiling it for sparc systems and
> booting the produced `image` file in `qemu-system-sparc`.
>
> ---
>  drivers/tty/serial/sunsu.c | 37 +++++++++++--------------------------
>  1 file changed, 11 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/tty/serial/sunsu.c b/drivers/tty/serial/sunsu.c
> index 67a5fc70bb4b..0f463da5e7ce 100644
> --- a/drivers/tty/serial/sunsu.c
> +++ b/drivers/tty/serial/sunsu.c
> @@ -1382,44 +1382,29 @@ static inline struct console *SUNSU_CONSOLE(void)
>
>  static enum su_type su_get_type(struct device_node *dp)
>  {
> -       struct device_node *ap =3D of_find_node_by_path("/aliases");
> -       enum su_type rc =3D SU_PORT_PORT;
> +       struct device_node *ap __free(device_node) =3D
> +                           of_find_node_by_path("/aliases");
>
>         if (ap) {
>                 const char *keyb =3D of_get_property(ap, "keyboard", NULL=
);
>                 const char *ms =3D of_get_property(ap, "mouse", NULL);
> -               struct device_node *match;
>
>                 if (keyb) {
> -                       match =3D of_find_node_by_path(keyb);
> +                       struct device_node *match __free(device_node) =3D
> +                                           of_find_node_by_path(keyb);
>
> -                       /*
> -                        * The pointer is used as an identifier not
> -                        * as a pointer, we can drop the refcount on
> -                        * the of__node immediately after getting it.
> -                        */
> -                       of_node_put(match);
> -
> -                       if (dp =3D=3D match) {
> -                               rc =3D SU_PORT_KBD;
> -                               goto out;
> -                       }
> +                       if (dp =3D=3D match)
> +                               return SU_PORT_KBD;
>                 }
>                 if (ms) {
> -                       match =3D of_find_node_by_path(ms);
> +                       struct device_node *match __free(device_node) =3D
> +                                           of_find_node_by_path(ms);
>
> -                       of_node_put(match);
> -
> -                       if (dp =3D=3D match) {
> -                               rc =3D SU_PORT_MS;
> -                               goto out;
> -                       }
> +                       if (dp =3D=3D match)
> +                               return SU_PORT_MS;
>                 }
>         }
> -
> -out:
> -       of_node_put(ap);
> -       return rc;
> +       return SU_PORT_PORT;
>  }
>
>  static int su_probe(struct platform_device *op)
> --
> 2.44.0
>

Hi,

Any updates on this patch?

Regards,
Shresth
