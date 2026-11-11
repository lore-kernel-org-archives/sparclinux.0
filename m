Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794382999;
	b=ftZdD4o/6zQ7/NRyo/yb6jlMoX4okXbGc1UeSMrT9faOwFihpV/v0DmDhEvpvu+JUQec
	 rHIxNDrQEnOLXG1Z3V1xi1SRZ/jnzewRO9Ql7gRT9iBFepymIsHnvIYSEagzwbdATbjEw
	 RAeiPcAq2GdFVeyd7F8qpav4bIm/4WmqRkg7+/bf3QJF1CKQ/IVxOQ9cTZetFtjuDrCPS
	 z3U1gV7OjHx3omb7ZdpMEBuHbre2W/foGxg68Y6MLUHlrE3ULoq+pcbVa4QZ3OuLqDyfy
	 1v+AT+XQS2sb/Ceapc5dU0nnBgbDj1N4ruxwuIVjQBDZ5fq2koIARxuLEeXq4mJdhxg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794382999;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=27U7oUdIa14bzFyO20wq2H7dyWDMznLD1QtfCXJzapQ=;
	b=mKxo1lV7d+Pvg9KZ70N5+iPGEv0AssBSnGoR5icEou/GTbnIK8nXsvql/EoElPKtidMO
	 vlkNqRCL1ojsFDlZECUxR15buq8lNG4ZNtPWEVz1iUoqClryITuIljmd6SWLe+t0zsS+G
	 gPjB3uUc4HYqH7F7DDPU5wJ87sTHhOld/33wyimYFqYnwEeXSz64IrnC0K1yBmopSTIgW
	 yUMJJ8As7zDui6tPdDptqu4rQFgHMIXnFJKzyBydGa8BfEVkfUnIGYal+9fG+i87Xvf+c
	 5WEfyyDShASoMA2yrbft6FyNO2jnHpboC45Hl45GG+Gf1ib7ijOd/0eqD/vW3hHXd/g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=h5NQKG5D;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.41
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0AC606A33C
	for <sparclinux@vger.kernel.org>; Wed, 11 Nov 2026 07:43:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A0AC606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=h5NQKG5D
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6b7221c0f2cso2278656a12.3
        for <sparclinux@vger.kernel.org>; Tue, 10 Nov 2026 23:43:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794382997; cv=none;
        d=google.com; s=arc-20260327;
        b=V7cntYGTCO9ZW3gRsRgrUkjKXv63oTOPTM5T7es+pyKXKF3bnvSFzwnch1XUJLetDw
         XvlI8g6/yYTtZ4EF35obX9fPElz+lAZLYziLn0iEvSEaneneMxhb7rw0gRN128pFIudw
         y5gmMQHNdRtiDPzd+FWdepIFJlufHE5Yasa2fxyWFE7qil1pFR5qSkh+ACmneHAWymlm
         jxV8q5xfp6VC4Jv/+CBy221+Hkg9CpomohtLHi311F8KILrNCukK5gyBz3Ex5VSe4x8j
         4lO/fHymXj1xRXrga3o+oQG9lso56h5r71DdYOHGDINg1yR1bgLMWe1W4BcFia4i4nRh
         uD0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=27U7oUdIa14bzFyO20wq2H7dyWDMznLD1QtfCXJzapQ=;
        fh=c3nuorN+rG6uR7FJw9+ydt5kqNaGxA+t1Znm43Nzkdk=;
        b=JRRnWHd+ba4IYrNcn8VeHceXU3suOocZU+60f62eTfQwQwgpKy24cRhCdj1nyk0Pir
         Ovxe+OS1DBnbmAP1rRW4sd1WcYt5fihT8MqP/Z++y8QvrKFnMkL8kZq9gSFSI5HmJsw5
         ekY5DaibVhapzY6L4xK1VlGHvjS5/C7LKn0nq9mO+Ic2tGjcKjEoC4dcGMxjV6YDGm74
         O3VXRj9H+RgUE4b5AQDbBSkhyDvyHvTJ0e1Q86ovBDohnpTg0t/8TTm+B21U4HfVz8K4
         vB32qWbUzq/8iLUeYmfNAsXAhH6993s3tmK4iI72ObQ4EkZjyOul4nFiGgk5NsTtt0vC
         kwXA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794382997; x=1794987797; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=27U7oUdIa14bzFyO20wq2H7dyWDMznLD1QtfCXJzapQ=;
        b=h5NQKG5DsH5k0QdRiJVJ86KtbHIpBxOZtiNveHnZG/t4JAkAZl11gGqvbZh2gbx+CZ
         U7R2l09uEN9Mz6txyG/VHZJvSvlNiFdQj+V+bgbOtkQgjiNZU0CA5FMY6smQ/+4XBAH3
         TyiknHwqbS9a1ikRyqP2U11AjltnFdJ0aJiSYxxvbDIdddHQa9rv+KTy80xEhAMzl3C+
         bIpY5WP4LhG5OSEIpLn1ynS3EgjFFWznVldcdS2uIAoKSyrP0PX27WalhA9H67xC1xsv
         oVv9D9PpI4KM5wKfG/3AUYQbehBCy8YKKKaBfMQR6O76UfhYBDJ2qQ9F1ZaCwVdZpUw3
         DTXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794382997; x=1794987797;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=27U7oUdIa14bzFyO20wq2H7dyWDMznLD1QtfCXJzapQ=;
        b=ZXtzHcDPx1fKoBJNf3sKa0Hz/HcpBwGWjJRDb7K10yae0HmEBk05RDVH5GK0uYLbnH
         OnVPtAS4nWehDmBgkK1gxKdHMg2/5PNagFyWUt3LW5ZyZVyc9Ks5MhD4ewy3F1JI3e9p
         ahlRnIemOROGsvPiSVIwoiELfCu0BnXh6o+UTK/G3SNZ01JWQ+Dm2T2acrs7V6kDZqIJ
         4Wk1y5nqFCt3kKx1Ao4eH8YtWAVsrIyfu588dOSorGeN8l3kMyPedp9xbkykqpfAHDMO
         6lLY0lt7O4gp70+bK3OvWkBRM32AkfuUDCTda2qJToHEVMLo3REmFytiMSbsfznDPAtm
         VfaA==
X-Forwarded-Encrypted: i=1; AL+hErHDMAQ0v31PW9om5tqZ7v2IPraUV6ghZGezwVbXpFXCBNjc0RamzH8LRcBo2OEMOqQI/ttEn/Smuq7w@vger.kernel.org
X-Gm-Message-State: APuU4Z8SCtP12NJET5aZJU3UoyVcRGhYOU2RzE/3ZQzfmpJjJQwKoLJs
	Fw5BbdwdlrbF2FB381+2yZhVP1luYBgXJMbC9Ld/COGqkqkSnEevFmaLR5MgSR5UdJW3SstvBQu
	DubOenAxsRgI5I+PEc3XsrIq1RnWrKWM=
X-Gm-Gg: AYBFou3bci4ongeZG7dLnBhhCth1xf7OuwdSrkPaKgNPGd8iY39fIv9uYqsL2Jx1A+r
	A0N97ggUwL6Iroh59LxLu1o0EjBZU0hfG+zaqvaKt2gtn7U/suxWlVljcuoCx1EenT/URcGHvK+
	5ft0OxclFfKSI1RxWKcKr0JK2ck7k3GjihNNVTdL6zUvWACNJwgZXe8jjPl4tOva1bopGiw5zmO
	9aDY6AtkopNAs6pmLIHZjlux/lxg9dSvY2GzlTceKEPSyIwCYgQH/Qf867Ua+y9dXbKAGMFqo0s
	AdyTJs0F7n0NHa7S2gTibU7qqe8Z+3xGNLNKcvb0UE0Rqq1ZI2v0PEL3g7hqxgin9k4E4MMgUcc
	yiSx64SriXlengatgK22mL4fDmGeEU00UqsDA0U/J9WdCKh/GFxkRZhglhzUEsUhyv06tOw==
X-Received: by 2002:aa7:c1c4:0:b0:6b5:90b9:e1f4 with SMTP id
 4fb4d7f45d1cf-6b7773edf4bmr819135a12.15.1794382997169; Tue, 10 Nov 2026
 23:43:17 -0800 (PST)
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Post: <mailto:sparclinux@vger.kernel.org>
List-Help: <mailto:sparclinux+help@vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:sparclinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105-tonyk-syscall_table-v9-0-8d1275885d9c@igalia.com> <20261105-tonyk-syscall_table-v9-11-8d1275885d9c@igalia.com>
In-Reply-To: <20261105-tonyk-syscall_table-v9-11-8d1275885d9c@igalia.com>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Wed, 11 Nov 2026 08:43:04 +0100
X-Gm-Features: AclHuK-WWcZzAuRTugYoSHBXz8aDMS8vLzO87BtuVYEGxCZ10b0uUmgcqCUEPe8
Message-ID: <CA+=Fv5Tm4-DV9KEKxO11ta84EvqigB-KDemhOML1hx9zoxx0cA@mail.gmail.com>
Subject: Re: [PATCH v9 11/15] alpha: Remove alpha_ prefix from custom syscall entries
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Arnd Bergmanon <arnd@arndb.de>, 
	Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, kernel-dev@igalia.com, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-alpha@vger.kernel.org, 
	linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	soc@lists.linux.dev, linux-mips@vger.kernel.org, sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andr=C3=A9

On Thu, Nov 5, 2026 at 9:26=E2=80=AFPM Andr=C3=A9 Almeida <andrealmeid@igal=
ia.com> wrote:
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
> Changes from v7:
> - Fix __clone3 entry
> ---
>  arch/alpha/kernel/entry.S              | 8 ++++----
>  arch/alpha/kernel/syscalls/syscall.tbl | 8 ++++----
>  2 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/arch/alpha/kernel/entry.S b/arch/alpha/kernel/entry.S
> index 790389a15c3c..25d05f45512d 100644
> --- a/arch/alpha/kernel/entry.S
> +++ b/arch/alpha/kernel/entry.S
> @@ -729,9 +729,9 @@ ret_from_kernel_thread:
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
> @@ -746,7 +746,7 @@ alpha_\name:
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
> index 8fc4701a6328..59eb066a40bf 100644
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
> +545    common  clone3                          __sys__clone3
>  546    common  close_range                     sys_close_range
>  547    common  openat2                         sys_openat2
>  548    common  pidfd_getfd                     sys_pidfd_getfd
>
> --
> 2.56.0
>
>

This conflicts with my Alpha for-next:

  https://git.kernel.org/pub/scm/linux/kernel/git/lindholm/alpha.git
  branch: for-next

Commit d38895ba9330 ("alpha: dispatch system calls from C") removes
the fork_like assembly wrappers and changes the table entries to
sys_fork, sys_vfork, sys_clone and sys_clone3.

Consequently, this rename is no longer needed when integrating your
series on top of that branch. I skipped this patch for my integration
test and retained those existing entries.

My for-next is registered with linux-next, so this is an interaction
we should account for when the trees are combined.

Thanks,
Magnus
