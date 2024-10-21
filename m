Received: from mail-43167.protonmail.ch (mail-43167.protonmail.ch [185.70.43.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA88C1EEE0
	for <sparclinux@vger.kernel.org>; Mon, 21 Oct 2024 06:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729493690; cv=none; b=A9rxILAX6aFiJ5EOgnjbpbyCGmvTiOeR9WlF1g+0RdDukm7FKX5ylt4qn8T+L8JvA1zkKYcpLmG+T88Lbs3Q9j4X8Ve62XDi1Yhu7mem3fKOIGeCPyaV8IOv+L+l4VGevvgSnl9bLsKYHTnc7QMBKo7NqbWutY8/eAv443BnBT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729493690; c=relaxed/simple;
	bh=mKszSO2uodhB/SVawf/fZzSNYzvQqPz+HdN5wa27pkY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GS2ykvcOABxHpxTmZrePLMEbk8/7JSWYp5FNIcUuPnsbldTVNoyKH2tsIJ53C/MuARbp8S7/ufpPSjli8NkKvLcFURtK0PJQgFM+Inydm8mwdGOztjE5bWyPPcpfgZ57gpX8+h6l/BSeXYi2DcdnCdXrU9PNcWEMJGNsovJHvBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=svGzb9j9; arc=none smtp.client-ip=185.70.43.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="svGzb9j9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1729493686; x=1729752886;
	bh=mKszSO2uodhB/SVawf/fZzSNYzvQqPz+HdN5wa27pkY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=svGzb9j9yZ6ZgssC/fXMy4RKdUYPQffidIAYoe/ApFaTyB8MkhZOhmcEfUX0hPBYk
	 3uYrjo4iu3EqDsETxwGX+t8K1/ulpiq1Hroq76Y6ss0EkspVhadprAzHn3FvEodqiX
	 t8ohW57R+bBpRDOg3aBNFApODJqyi3kw9Yauc0gV6sHtelEn/y8DzJcDhbxkW9pLrz
	 Woya34sWO4648EQuTjwJ6erBTTmc5GXt2mCvuIg6xJZCRxv+souHirafYcw1dcCym1
	 /vV2avSDVGoV3j4SExIkSdZb1ZXbPkr+1YNdsulgAU7tvwiKGhMCkaLzwwRW+djg7X
	 s6huH1Adf+n6A==
Date: Mon, 21 Oct 2024 06:54:39 +0000
To: koachan@protonmail.com
From: Koakuma <koachan@protonmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v2] sparc/vdso: Add helper function for 64-bit right shift on 32-bit target
Message-ID: <-I-Ljs420E94P091A2LOUkq7SOKMg2yY3jCj8aTjDtN4r3hH3NvnoNfuGQbrJTEMAKKZP-BV2Qsmu9ARUjpngc7-71R26iB4q0bpZgxBgzk=@protonmail.com>
In-Reply-To: <20240808-sparc-shr64-v2-1-fd18f1b2cea9@protonmail.com>
References: <20240808-sparc-shr64-v2-1-fd18f1b2cea9@protonmail.com>
Feedback-ID: 6608610:user:proton
X-Pm-Message-ID: 1fda092beb2bf4a3b6ea843d0280416627e36948
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Koakuma via B4 Relay <devnull+koachan.protonmail.com@kernel.org> wrote:

> From: Koakuma koachan@protonmail.com
>
>
> Add helper function for 64-bit right shift on 32-bit target so that
> clang does not emit a runtime library call.
>
> Signed-off-by: Koakuma koachan@protonmail.com
>
> ---
> Hi~
>
> This adds a small function to do 64-bit right shifts for use in vDSO
> code, needed so that clang does not emit a call to runtime library.
> ---
> Changes in v2:
> - Move __shr64 to sparc code since there are no other users of it.
> - Now that __shr64 is not in portable code, redo it in inline asm for sim=
pler implementation & better performance.
> - Link to v1: https://lore.kernel.org/r/20240804-sparc-shr64-v1-1-2505096=
8339a@protonmail.com
> ---
> arch/sparc/vdso/vclock_gettime.c | 28 ++++++++++++++++++++++++----
> 1 file changed, 24 insertions(+), 4 deletions(-)
>
> diff --git a/arch/sparc/vdso/vclock_gettime.c b/arch/sparc/vdso/vclock_ge=
ttime.c
> index e794edde6755..79607804ea1b 100644
> --- a/arch/sparc/vdso/vclock_gettime.c
> +++ b/arch/sparc/vdso/vclock_gettime.c
> @@ -86,6 +86,11 @@ notrace static long vdso_fallback_gettimeofday(struct =
__kernel_old_timeval *tv,
> }
>
> #ifdef CONFIG_SPARC64
> +notrace static __always_inline u64 __shr64(u64 val, int amt)
> +{
> + return val >> amt;
>
> +}
> +
> notrace static __always_inline u64 vread_tick(void)
> {
> u64 ret;
> @@ -102,6 +107,21 @@ notrace static __always_inline u64 vread_tick_stick(=
void)
> return ret;
> }
> #else
> +notrace static __always_inline u64 __shr64(u64 val, int amt)
> +{
> + u64 ret;
> +
> + asm volatile("sllx %H1, 32, %%g1\n\t"
> + "srl %L1, 0, %L1\n\t"
> + "or %%g1, %L1, %%g1\n\t"
> + "srlx %%g1, %2, %L0\n\t"
> + "srlx %L0, 32, %H0"
> + : "=3Dr" (ret)
> + : "r" (val), "r" (amt)
> + : "g1");
> + return ret;
> +}
> +
> notrace static __always_inline u64 vread_tick(void)
> {
> register unsigned long long ret asm("o4");
> @@ -154,7 +174,7 @@ notrace static __always_inline int do_realtime(struct=
 vvar_data *vvar,
> ts->tv_sec =3D vvar->wall_time_sec;
>
> ns =3D vvar->wall_time_snsec;
>
> ns +=3D vgetsns(vvar);
> - ns >>=3D vvar->clock.shift;
>
> + ns =3D __shr64(ns, vvar->clock.shift);
>
> } while (unlikely(vvar_read_retry(vvar, seq)));
>
> ts->tv_sec +=3D __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
>
> @@ -174,7 +194,7 @@ notrace static __always_inline int do_realtime_stick(=
struct vvar_data *vvar,
> ts->tv_sec =3D vvar->wall_time_sec;
>
> ns =3D vvar->wall_time_snsec;
>
> ns +=3D vgetsns_stick(vvar);
> - ns >>=3D vvar->clock.shift;
>
> + ns =3D __shr64(ns, vvar->clock.shift);
>
> } while (unlikely(vvar_read_retry(vvar, seq)));
>
> ts->tv_sec +=3D __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
>
> @@ -194,7 +214,7 @@ notrace static __always_inline int do_monotonic(struc=
t vvar_data *vvar,
> ts->tv_sec =3D vvar->monotonic_time_sec;
>
> ns =3D vvar->monotonic_time_snsec;
>
> ns +=3D vgetsns(vvar);
> - ns >>=3D vvar->clock.shift;
>
> + ns =3D __shr64(ns, vvar->clock.shift);
>
> } while (unlikely(vvar_read_retry(vvar, seq)));
>
> ts->tv_sec +=3D __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
>
> @@ -214,7 +234,7 @@ notrace static __always_inline int do_monotonic_stick=
(struct vvar_data *vvar,
> ts->tv_sec =3D vvar->monotonic_time_sec;
>
> ns =3D vvar->monotonic_time_snsec;
>
> ns +=3D vgetsns_stick(vvar);
> - ns >>=3D vvar->clock.shift;
>
> + ns =3D __shr64(ns, vvar->clock.shift);
>
> } while (unlikely(vvar_read_retry(vvar, seq)));
>
> ts->tv_sec +=3D __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
>
>
> ---
> base-commit: defaf1a2113a22b00dfa1abc0fd2014820eaf065
> change-id: 20240717-sparc-shr64-2f00a7884770
>
> Best regards,
> --
> Koakuma koachan@protonmail.com
>
>

Hi, is there anything else I need to do for this patch?
