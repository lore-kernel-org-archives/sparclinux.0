Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606954DAF88
	for <sparclinux@vger.kernel.org>; Fri, 18 Sep 2026 10:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789728914; cv=pass; b=sv+VDznwrcOUjaF/YOKpLiybDQfDGJpyRJpdw29I74bY9154QWOvhoGe/0Cnv8hbhFXNGCGpVN9cQBkdNZg9HjcVobNC4ANVdRCuXx4xo2Ox8UrG/7RxxxNeRidIU50qwMpeDYeHtKs8WOOfHlEc8FtXKYrMAq+ODGLjb7Fo8fM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789728914; c=relaxed/simple;
	bh=0QFLY2cyWzIGxwHrQ7HwSGwbi9sjKL2DXLzkJTDdzU8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fu4GVaylh+tWjWBlt4YUESGFYbhhrmrhJCxTztTea0QtyVbXSLUD5sCFok3wcof9JIP31q36SGAA6OL8DW/i9NgVBu10fXF0JwdUIonIc2yyJpjEZqwiAM5D6mD4o8vMeVYD0GV3TQerHrprOsTevWbLmHoHUT0yhO4VqTmjzfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Azd5WHFc; arc=pass smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Azd5WHFc"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f6c7a58so73468066b.2
        for <sparclinux@vger.kernel.org>; Fri, 18 Sep 2026 03:55:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789728907; cv=none;
        d=google.com; s=arc-20260327;
        b=oZspS5ZAuHsqrvSnv1RjHtjfsMrdqMF9gxGyIvm+D7rZTKADxFScbm/OLLb/UDnqpt
         tqP41Wrg6Et0NpyWUBRZFKSOPaE0DbGvhEXpvLkqumzr5YWJ5N1SPpudzjJlkj1G8zK5
         Nt2BVlABr2lwZDjdoXO3T6ctcK2xE0pvoVk9ghaWe7tfN43geZcb7+Cx/TCR9ia2a3Th
         6IoIE6szQnepWcmYUcVwELEohiLczozaZd9G2zBcVthaEjtt6rVn7svnp1ZuhzghK8iw
         t+0dWROsORxNDqqu0UbGpCRaJSWHZ5dMNmwkriQxJnOHc5s+UzW6xCLWnTATTZerokVQ
         ebVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=c9KFaw0r3zy7as/jjFJHUlbx8sYj2YFXt4OlbArB54Y=;
        fh=QnyAI3qg3XxBwMEb4qhCvJJPNnkXsuRI08keJjP1gsM=;
        b=FLUWdaCfiUuM0EKJhZtPrhtaOQyP6mke6z/Ea+jmeO2IvVu7N/CNe07nzxKLcrhCk5
         yx06UGSf5j1NMfBNxbcpX3J8lK37HZXNyOxb2zS19pD7wec8phHfTtTEgW2lOA/y1lOY
         y4A2TS/Aqd28p6PrQxO+LT/e3Rq5txxo78W1oGBrwllaJ5xf4ZANV3w4nIytyGk+dPCn
         lXKWmRX1mGPEfOe/FkTgXX6dgy7ci3xknAoqGxmTrb0V0Ceh3t4o+a/UALXyMXCm5K+u
         fDaZYSkiw/a9MEe/PfI667zB+sXgrIcjL8iJad50qheTgfDM9CQhsLkLOXQ56IsA5XvP
         6Fig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789728907; x=1790333707; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=c9KFaw0r3zy7as/jjFJHUlbx8sYj2YFXt4OlbArB54Y=;
        b=Azd5WHFc1CvGiYQ9NCg17h0QdQDsKZ1Ic+0GnZXnWRlhTXCHeOt/YKAE0IjeF3RFdo
         mNUlVWWMNvpDH01goCjbtTfi0Wb0g8nlX2FBJGkeqtrHbz9vnW4fm/VQ+kdwbqCSZ1kS
         Oi45Tx85x94cXarLimXLqXpPwrB4/rntqcR3q5+hBllZwHtqJMygkg6UgyHurXqBPemO
         /iVmKyn8SWOHzkRG5ESZV9hfeq3LpxINZGbxIPaCg8OJ0I78rpaQ5l15M18yL2So4NA5
         NCr6l6shtfaJr+Hss/3rPX5iLi+JKMylFgMwfsDg7JxXyd3atCS1RasPfbddZyg9hr7T
         G/Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789728907; x=1790333707;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c9KFaw0r3zy7as/jjFJHUlbx8sYj2YFXt4OlbArB54Y=;
        b=v6OgjAYp2PQWl1FdmNzaWOnuN42ZtN8YeNt0+YiER6LGYJ6qIecE7BEjtdyZGS/lJk
         HuJEDkHi0R8hI2Y82WMyzW4VTPXP4T05LHt4wBNNcTZWB7aEsWnIxNiOYpU3g+e8K+Lh
         oLVfwa36RA2OlsoQ/yGBpMvquaXV1OesjavrVrIEdQjysxb6+ldMEgB9/6zs63fosJad
         Co4Efz/tkpvZrO8gXLh8mi9iyqcq4kcFMTaBRjfFWL7v78tKJRjSC2rX4DA9jHbG+6Ku
         yFhFiPQ5f7OaOaDSSyOzJvUuf3v0JIbT83sutdA2nWi/aK8FQw9w5iODAjgFakvtN8Gc
         M6Jw==
X-Forwarded-Encrypted: i=1; AKwUvByR/wecNO3S1c0F8OfwE9U38PgWk5KEBbtK5KapCKxS+OyUa7OQUx4aoai7wuX/4FI6txTLStPcOASa@vger.kernel.org
X-Gm-Message-State: AFuF++lbIko7TWQQFxikcuJHLTFkUMafZ6THH2af8v67h5Fqwvn79jEM
	AumyyGPHk6DjAtJ+ORrXC/NMmpsFb1oV11mms5bFWvkYVQtUgBMycpi8TonzvVcPwrwfHU2gh2h
	wcud99AFWCxdg/Pu5TA8OjnT3Y9cPVN4=
X-Gm-Gg: AYBFou3000RorviRg+hk0IuL1maMVp6hXIs/1lJGQccPsiOdK/1JLN4Mi0VTYfYTxfI
	9h7tB4Ukph03TjD9dSWBlMOTYmZOyNV8fTkuZ2isGrc7LMjWJwB0L0OAFaM10J8MwyxC2BPjGKn
	uSuaTmZ0C9dv6VLm1gUI4iLpJFNvCTrhfhwjCrX/uNslKKFIHX1CdLxGY7IFsTHUYcO1jK1qHX2
	u/jPAgAMEV1YeM0szgPLYUwQvYRsfDTc4exB919y7EAUSIdnDafVud4YsPaLO2Zroim+hLMuHlj
	ovex8/E9avHsWGqQTHDIbofKexVJdDu5Bk9rSxTa3K+P+My9pI9CMKiuNQV5esc/UNtSkXeP0Dz
	99wzVTkzO9XrA58yLd6vqtJ/iORke1BOAta3gZkXqplvWwhLcEwfx
X-Received: by 2002:a17:907:d0a:b0:c28:ec7c:27ae with SMTP id
 a640c23a62f3a-c2a15aecddfmr221737866b.25.1789728906928; Fri, 18 Sep 2026
 03:55:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260917-tonyk-syscall_table-v7-0-f4cd8f8e3265@igalia.com> <20260917-tonyk-syscall_table-v7-12-f4cd8f8e3265@igalia.com>
In-Reply-To: <20260917-tonyk-syscall_table-v7-12-f4cd8f8e3265@igalia.com>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Fri, 18 Sep 2026 12:54:55 +0200
X-Gm-Features: AcwNN1XYBCc8XytQv7lpPsMdlPdL7ChQXyccU8FUv6otEOv13o1h6_2iRPXOShM
Message-ID: <CA+=Fv5Q+sOLmT0Wf3OGdKw=mBt_EoS8ZQDF3wwGrm2-2vnOYgg@mail.gmail.com>
Subject: Re: [PATCH v7 12/13] alpha: Remove alpha_ prefix from custom syscall entries
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Arnd Bergmanon <arnd@arndb.de>, 
	Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, kernel-dev@igalia.com, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-alpha@vger.kernel.org, 
	linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	soc@lists.linux.dev, linux-mips@vger.kernel.org, sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andr=C3=A9,

On Fri, Sep 18, 2026 at 1:48=E2=80=AFAM Andr=C3=A9 Almeida <andrealmeid@iga=
lia.com> wrote:
>
> Some architectures need special entry points for some syscalls (like
> clone3). The current approach is, instead of having a special name like
> arch_syscall, to name if as __syscall. This is enough to different the
> common entry point to the architecture specific entry point.
>
> Change alpha special syscall entries to do the same. This makes easier to
> join the syscall tables. Leave alpha_syscall_zero because this syscall on=
ly
> exists in alpha anyway.
>
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> ---
>  arch/alpha/kernel/entry.S              | 8 ++++----
>  arch/alpha/kernel/syscalls/syscall.tbl | 8 ++++----
>  2 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/arch/alpha/kernel/entry.S b/arch/alpha/kernel/entry.S
> index 9f2608de2544..8a85fcf117cb 100644
> --- a/arch/alpha/kernel/entry.S
> +++ b/arch/alpha/kernel/entry.S
> @@ -879,9 +879,9 @@ ret_from_kernel_thread:
>
>  .macro fork_like name
>         .align  4
> -       .globl  alpha_\name
> -       .ent    alpha_\name
> -alpha_\name:
> +       .globl  __sys_\name
> +       .ent    __sys_\name
> +__sys_\name:
>         .prologue 0
>         bsr     $1, do_switch_stack
>         // NB: if anyone adds preemption, this block will need to be prot=
ected
> @@ -896,7 +896,7 @@ alpha_\name:
>         ldq     $26, 56($sp)
>         lda     $sp, SWITCH_STACK_SIZE($sp)
>         ret
> -.end   alpha_\name
> +.end   __sys_\name
>  .endm
>
>  fork_like fork
> diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/s=
yscalls/syscall.tbl
> index 8fc4701a6328..a41276634923 100644
> --- a/arch/alpha/kernel/syscalls/syscall.tbl
> +++ b/arch/alpha/kernel/syscalls/syscall.tbl
> @@ -9,7 +9,7 @@
>  #
>  0      common  osf_syscall                     alpha_syscall_zero
>  1      common  exit                            sys_exit
> -2      common  fork                            alpha_fork
> +2      common  fork                            __sys_fork
>  3      common  read                            sys_read
>  4      common  write                           sys_write
>  5      common  osf_old_open                    sys_ni_syscall
> @@ -72,7 +72,7 @@
>  63     common  getpgrp                         sys_getpgrp
>  64     common  getpagesize                     sys_getpagesize
>  65     common  osf_mremap                      sys_ni_syscall
> -66     common  vfork                           alpha_vfork
> +66     common  vfork                           __sys_vfork
>  67     common  stat                            sys_newstat
>  68     common  lstat                           sys_newlstat
>  69     common  osf_sbrk                        sys_ni_syscall
> @@ -242,7 +242,7 @@
>  309    common  get_kernel_syms                 sys_ni_syscall
>  310    common  syslog                          sys_syslog
>  311    common  reboot                          sys_reboot
> -312    common  clone                           alpha_clone
> +312    common  clone                           __sys_clone
>  313    common  uselib                          sys_uselib
>  314    common  mlock                           sys_mlock
>  315    common  munlock                         sys_munlock
> @@ -474,7 +474,7 @@
>  542    common  fsmount                         sys_fsmount
>  543    common  fspick                          sys_fspick
>  544    common  pidfd_open                      sys_pidfd_open
> -545    common  clone3                          alpha_clone3
> +545    common  clone3                          __clone3
>  546    common  close_range                     sys_close_range
>  547    common  openat2                         sys_openat2
>  548    common  pidfd_getfd                     sys_pidfd_getfd
>
> --
> 2.55.0
>
>

The fork_like macro now defines __sys_clone3, but the syscall table
entry is changed from alpha_clone3 to __clone3.

This should be __sys_clone3, like the other custom entry points.

I also confirmed this by building the tree at this patch, before applying
patch 13:

LD      .tmp_vmlinux1
alpha-unknown-linux-gnu-ld: arch/alpha/kernel/systbls.o:
in function `sys_call_table':
(.data+0x1108): undefined reference to `__clone3'

Patch 13 hides the issue because the common table uses __clone3 as the
ABI tag but correctly selects __sys_clone3 as the syscall entry point.

Magnus
