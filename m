Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84AC511208
	for <sparclinux@vger.kernel.org>; Thu, 15 Oct 2026 10:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792061343; cv=pass; b=a3rkWfLI53WDfbRoz7kQxt5D2z8PWHOrEeqTaiq+BKIOWS+8LgqION5FCHyBwTo8+YB+O7WxXYVCy8tR0v7NnyF79oWKRrIVHkHHjGgj4I79emb5CchMe6QUVCLdyxITqSEF05tfr2+VSfLFCnI+Zaaw6bzqJf646f+Le+1nI48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792061343; c=relaxed/simple;
	bh=IJgvpO6/GZ5vutrzR5YipI9vHkWFgMsz/X+gwRbcJUE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f4MoUjYPMqb7EZKJqgmKxRkFYCP1ilrpgL684vfTC7gcCk4ACGox2vu4M96SrP8TF5/6ndkSsyHhOuf/3LA1TWXkpPfM34rs1/BoOqjXVgZDJxFZfgvsWdxLgxOeXDNe9bPdXyR83GIT1nDT0UCOQ55cQ7rvooduHJtS0m2uevY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VRxnRAPn; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VRxnRAPn"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6a0794669a6so455118a12.2
        for <sparclinux@vger.kernel.org>; Thu, 15 Oct 2026 03:48:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792061338; cv=none;
        d=google.com; s=arc-20260327;
        b=qKJ7nqdXmn/8h5ZbbeFgQFOrO7z9hD5la8PV3buTBj1g8WT3lpbgO2obEazYX2sy4N
         ZBs68REBgqMO6ZzGsfSo/ynTFwovKx7xgOOe5eJya0KJmb52Zp5h3+OM2BaZTn5zwDlD
         nm8LwKJfI04vNfBVYpBs/R08bvEbfAy1gg5ad+0XLBpD1elp2NBUWRKf0EjerTjxe3mM
         BHIAZ6MRMznmokorfmjXq7mAGM/FZVUP9rKB84G2C6FP3V3JOKALPfNhpkWpZ1Ig2KqU
         VtNV7xjHAAWj2pSF1WQJLTtSxIUNoQudBlicm7R+0gOKldA4GIvzyIOm8fzIHMgdJdVZ
         uMww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iC2PDsG9ehdnra7rI62aO4hbslW1ebWnxZmL1ySRB9c=;
        fh=G/G5LDYVtkBLufgFhCm4dyOak33UcytEfFT0hLDmvfU=;
        b=aCV32LV6KI+TfTWE2mkYzRrx7Zg614L84L9OtTEcDqKx6Cm7G5QeQtVqNMy2/xvkfO
         yZKl4PVazdBSOdb0lcbDXw1bOG1oBhaRwzDC7kOiGTo43oDD7xKWUxw7IWVNeG9k4ljm
         ZhlHdv1LHmA+ZLoLZoUnyDcSm2jfSxqnzC/vwIgYQhkBNgHOGJ+xRAKuQj8VnzLKWdti
         h4nl/7lVH2HmpA5N4eJ7//KEXhJcBPqEjRXL1zI8HI7immC+azOdCvGHPTFJ80TnqwiT
         yHM5IHVtqYNift+iiSYhXqOPGITF7jOmM48z+D/30ge0aFGxQMlnOwbTXo0ouuwMHe2S
         6Kdg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792061338; x=1792666138; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iC2PDsG9ehdnra7rI62aO4hbslW1ebWnxZmL1ySRB9c=;
        b=VRxnRAPnCeROMEtG4agrc9XDF/BIke08DNRMVr8whzFg8C3DqNMCmj8lAExc5tfUGP
         JGAxVp2CpJSTay55YBRyeA4cP4QCW9WTmYdkwWbOwpJp2mfoXPmKuGTEAs/Teemd342G
         jYFXA6menohXmGCuxkD0mdtQLfWB4r6c9HPG6H3aRlp04xKGqjZ0E20/7/ieWo1YJqEy
         GgPAVtlXDxdWZHdlGlaebwabmYO8GBKhXPyJH+dOhW/H1meubVHFkYBRiSqgDjIV2hg5
         z5c+A+M2wXJbpNY6doU4WkYclRIAF+eDeOd3KBttui6MYN/LOASXQ31vl7awKiYUEkKh
         2EBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792061338; x=1792666138;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iC2PDsG9ehdnra7rI62aO4hbslW1ebWnxZmL1ySRB9c=;
        b=c382srSQaaV/tsIEwHCbT3ibLM1di6H9KuZzvzcEmZqa47l9N8z3MrjYDyanzXIZqV
         fhCj5QsDSYvnKhplFSSS6hWrn1pG0E/LpmHdA/FyeD/v+Fbn1yHpILFktAYCDEdVYnan
         7dWXsqLrnclADvL+/89eyFxv4uIo865OTWN/Kb9rwZcx76cLFptnLB0KOQX8DeDzCxJM
         LRcxDeqQB5mCQt3dEIleDlrYMgutEHkxZoP/llN2aX45XZMVQJe+dmkq6qN+zYTEhnWj
         BYeX4tn9BZDsD83WDv0DZEYsjRdA+1ON/GcwbIFV+DVVhyccps52wwOkIlfEqQKpRvPy
         4osA==
X-Forwarded-Encrypted: i=1; AKwUvBwFpyHNZkkOEGMcOGbDaPM9rwkNNa/RlJvsn+sbgyyNbXYGNkjkxLG4NJrckmGe+kC+Kbeojb0z7fzm@vger.kernel.org
X-Gm-Message-State: AFq9FYLmeC4mDorp3V4MF/TCWaDAxWnEy98shVMgpCUR2Pn8TDRJrz8X
	0kKRC8fF8mQo25jUen6CoeGUFgGSYn9Gn5nOVUcC1zxgixIMJYRzzQKaU2V5tD7ONBId7Tt5+MV
	m4Tuq0SPj5yfjzYZW00CNtBmLhAtbrmk=
X-Gm-Gg: AYBFou1vurew2C2RiqPbaOOZSlZKeXF+qe/bxNoQfOL91IzDD25NmBN40ca6jsS8qmD
	79ms3UXnQY1FlC//nLzYwZ/uAVY3KQTRvhk7aXjpoY9Go8hMIzHEpcJCLiOj8gDcB5v+NcpRg0k
	hZm0cDDadZIVK9ESaFN9tohb83c85m3XYKTc1xWOzJjbxrIVoLoXPKI0VXJrKFq7YuAGE+CA3b8
	b6ss/8pANwZQzUWfBGNBJrXjZLk5FuyVJGUh+JyAKZWAB7XUd7T/ym/UpDJ4oOnGAWYFtL03AGV
	QyswNNteRc01SesY0ekK7jN8Jr+aB+NFwkKwFh29QzRkePodDTHQz4pJf0HEH/QHXHY+L+9Gc8x
	9eRpRCXqHoChpcXGpCQGNptaXhy/JmEaOnC2XwqqVSw==
X-Received: by 2002:a05:6402:324f:b0:6b1:e8e1:a3aa with SMTP id
 4fb4d7f45d1cf-6b1e8e1a84cmr4973615a12.7.1792061338000; Thu, 15 Oct 2026
 03:48:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261015085545.3246951-1-ramin.moussavi@yacoub.de> <20261015085545.3246951-2-ramin.moussavi@yacoub.de>
In-Reply-To: <20261015085545.3246951-2-ramin.moussavi@yacoub.de>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Thu, 15 Oct 2026 12:48:46 +0200
X-Gm-Features: AclHuK8mCm9Ee0LkjgfrS5QZWWzZqnEL_WpPmAkC66KzWm8nuPPfV5rDKDnh3Q4
Message-ID: <CA+=Fv5Stzr=3QZRvRcUeTRj6dqp+rVzZAUwgBK29z3CoqsqLVg@mail.gmail.com>
Subject: Re: [PATCH 1/4] sparc32: keep PIL raised until the IRQ frame is gone
To: Ramin Moussavi <ramin.moussavi@yacoub.de>
Cc: Andreas Larsson <andreas@gaisler.com>, "David S. Miller" <davem@davemloft.net>, 
	Thomas Gleixner <tglx@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, 
	Guenter Roeck <linux@roeck-us.net>, sparclinux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ramin,

On Thu, Oct 15, 2026 at 10:57=E2=80=AFAM Ramin Moussavi
<ramin.moussavi@yacoub.de> wrote:
>
> The per-cpu timer interrupts on sun4m and sun4d SMP, and the LEON SMP
> IPI, leave their handler with
>
>         wr      %l0, PSR_ET, %psr
>         WRITE_PAUSE
>         RESTORE_ALL
>
> %l0 is the PSR at trap time, so this turns traps back on at the PIL of
> the interrupted code, usually 0, while the trap frame is still on the
> stack. Any interrupt that is pending at that point is taken on top of
> the frame, and if it leaves through the same path it opens the same
> window one level deeper. A source that keeps firing makes the nesting
> unbounded: the kernel stack runs into its thread_info, w_saved and the
> task pointer get overwritten, and the next window trap stores through
> them with traps disabled. The CPU goes to error state.
>
> The generic path does not have this problem. real_irq_continue keeps
> PIL at 15 after handler_irq and lets ret_trap_entry restore the old PIL
> together with the rett. It was fixed that way in Linux 2.1.129
> (entry.S 1.153, November 1998):
>
>         -       wr      %l0, PSR_ET, %psr
>         +       or      %l0, PSR_PIL, %g2       ! restore PIL after handl=
er_irq
>         +       wr      %g2, PSR_ET, %psr       ! keep ET up
>
> smp_ticker had been added in 2.1.36 with a copy of the old exit, and
> kept it through the rename to smp4m_ticker and the addition of
> smp4d_ticker in 2.1.97. smpleon_ipi copied the pattern in 2011. Do the
> same as real_irq_continue in all three.
>
> On hardware the window is a few instructions long and no interrupt
> source refills it that fast. qemu does: its ESCC finishes a transmit
> instantly, and since 8.2 it takes a pending interrupt right after rett
> (930f1865cc65 "target/sparc: Clear may_lookup for npc =3D=3D DYNAMIC_PC")=
.
> A burst of console output on an SS-20 with -smp 4 is enough. A trap
> ring buffer in trap_setup showed the level 12 serial interrupt taken
> over and over at smp4m_ticker+0x34, timer ticks nesting further down,
> and the frames sinking below the thread_info.
>
> Tested on qemu 11.1.0, SS-20, -smp 4, with a test that writes a few
> hundred lines to the serial console from a multithreaded process: the
> kernel went to error state in 4 of 4 boots before, and booted cleanly
> 8 of 8 times after. Two full runs of the uClibc-ng test suite on top
> then completed without a crash. LEON SMP was tested on qemu's
> leon3_generic with -smp 4, where a full run of the suite completed
> without a crash as well. sun4d gets the same one line change but was
> not run; qemu has no sun4d machine.
>
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Ramin Moussavi <ramin.moussavi@yacoub.de>
> ---
>  arch/sparc/kernel/entry.S | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/arch/sparc/kernel/entry.S b/arch/sparc/kernel/entry.S
> index ea51ef52c952..87d03a58446e 100644
> --- a/arch/sparc/kernel/entry.S
> +++ b/arch/sparc/kernel/entry.S
> @@ -252,7 +252,8 @@ smp4m_ticker:
>         WRITE_PAUSE
>         call    smp4m_percpu_timer_interrupt
>          add    %sp, STACKFRAME_SZ, %o0
> -       wr      %l0, PSR_ET, %psr
> +       or      %l0, PSR_PIL, %g2       ! keep PIL up until the frame is =
gone
> +       wr      %g2, PSR_ET, %psr
>         WRITE_PAUSE
>         RESTORE_ALL
>
> @@ -353,7 +354,8 @@ smp4d_ticker:
>         WRITE_PAUSE
>         call    smp4d_percpu_timer_interrupt
>          add    %sp, STACKFRAME_SZ, %o0
> -       wr      %l0, PSR_ET, %psr
> +       or      %l0, PSR_PIL, %g2       ! keep PIL up until the frame is =
gone
> +       wr      %g2, PSR_ET, %psr
>         WRITE_PAUSE
>         RESTORE_ALL
>
> @@ -407,7 +409,8 @@ smpleon_ipi:
>         WRITE_PAUSE
>         call    leonsmp_ipi_interrupt
>          add    %sp, STACKFRAME_SZ, %o1 ! pt_regs
> -       wr      %l0, PSR_ET, %psr
> +       or      %l0, PSR_PIL, %g2       ! keep PIL up until the frame is =
gone
> +       wr      %g2, PSR_ET, %psr
>         WRITE_PAUSE
>         RESTORE_ALL
>
>
> base-commit: d419d682257d813f6cb7a28e42b35d0edf4ad038
> --
> 2.53.0
>
>

I plan to test this on my SMP SS-20 with HyperSPARC CPUs. I have seen
intermittent stalls and register-window-related failures, so this looks wor=
th
investigating, although I cannot yet say whether they share this cause.

Regards,
Magnus
