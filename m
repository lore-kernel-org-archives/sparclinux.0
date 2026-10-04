Received: from mail-ed2-f32.google.com (mail-ed2-f32.google.com [74.125.228.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A40E3B52F8
	for <sparclinux@vger.kernel.org>; Sun,  4 Oct 2026 15:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791128390; cv=pass; b=qT4ykQvJJuQDbgI4csw7VWSPvOBgJR6swsJvq5vaH4byIbwDb38m6lh3vKRE9MRuVxbYb1gUTjupBCX9xJjbBFG7HhqXyeNvBp3syNSC8+aZ1Apmv9gTEdpoBQrVz8XkKgvqMfuXt4IFisWlnJPC92AQhnDWqonkC0fDj/6kzAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791128390; c=relaxed/simple;
	bh=DKZ3QH3gyxBydoFYe8FH8qEcg50uqpETpsBdwFtBqJQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jA7eVx+QoRio+gZbw/4rjo1tGx2dCiv32HIxmXmghyADCwBD1Q2iPjhPcLpgIIa9ZNwgdF+iskNflCWtSFTWC07Wi61y+B1sJj5UKuyCYCIhdsjpe5MQPhiclCGWLdynb+ls7uDtBZm0230jMFA1qnJCBUK34dmRpg76HCXFlVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A1uuDc2S; arc=pass smtp.client-ip=74.125.228.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A1uuDc2S"
Received: by mail-ed2-f32.google.com with SMTP id 4fb4d7f45d1cf-6acb8b78d6cso1351304a12.2
        for <sparclinux@vger.kernel.org>; Sun, 04 Oct 2026 08:39:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791128387; cv=none;
        d=google.com; s=arc-20260327;
        b=Aj2acp2aj3eZq9jzIjyIOmFB8a60+RRMQJL+VzDyHSOQ+fmLkAbSiT2zxviFcpUOlu
         87ZvDNB/+EiZ4hVRfUtPtk6BxTbSuX/gG1OkdAXmVzCTTMtMsUt3HMscbnd2zsDsWT3u
         I6m2gIFzHYtxawgjAxJlnKGam6GxM/r7G/WMOBh28c9vGcO+fSFrKXwux0zZt+BLsZ7K
         5wE4jqf5yaTihOBNcunh7rqdfjspx4EJy1SG7cZBVdDRfs/TsiZYum6+hILjH4Q8SRdc
         9CdW2ebcHnQ7PbwjuGZgMzrRorKQv16k358nrlCGVfdyCLmY0Y2uZTxKuvqqjqB/IYx/
         yfcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=w3NslzmXPjfbixIKCMPYflTAUvKrQJ2PvjNFCDCiyds=;
        fh=sou2anKFbkHxDyp1gKUGdUcahQdjSQXsbjZSTYPUiv8=;
        b=C7F+1muR8uj1qoiP6B3Z1Y9z9Mb0/aDNJlB0I/aA5AjnwjIVX8FIZF3vDpDX1oRPWf
         wqkGNOWDvRMWEyJkI+IXps/tFtLl0s2DBIa4o+bAniVKtdwQiV2kSvREv958Lki9FkYS
         WLDmH1afQcckcggiRbt5G6mlC/lqjZ3VU4r8c0FqcYo00LfC5b4CaDqdhIXOv3j8GCVP
         ah61HFjy1xRRjK3bWMNLoMl3HfTHGsbdJFVxYjudb8InEU4CErp5u+OQ1pplzc6eWwkD
         xTzMpQuXXVPXD6bZqRfYg8/IMLJf7IwhZvMCcwWWj0/UANMnTurpwCIviYVqgbAk91gj
         l62A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791128387; x=1791733187; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=w3NslzmXPjfbixIKCMPYflTAUvKrQJ2PvjNFCDCiyds=;
        b=A1uuDc2SOB/6Lpe8raNJaG2KRSkYLk2OseIsiiTlRy8QiaRZGPBMn+6cRy0gtpLvfN
         BlInRRcp3Kuw/Jd78/rvJw8vmuhgFxamff1fNmWby2YLP30m+6ADDa4cVDXeZ60LtywU
         1xAEQjXBWWOPE+z0bLzahF0BGJEqsLrpMu+1X0Hpa72pS+Zgg/PC1M/TUIsPfzKOzRhE
         VRvnF0Re8hGzg7Dq7dAObTbtgUT/k2rWIFzd55r+W27LtSCixLdjaJskMO71Bn3eWive
         8wfJZbEqlNoyaBWBhsQWxuJnpTFEuTqqhkwrKn6ktAY0dTe3cO5bO/gW5pmhs3tygAQ8
         53iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791128387; x=1791733187;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w3NslzmXPjfbixIKCMPYflTAUvKrQJ2PvjNFCDCiyds=;
        b=j+Pi1EXnTXyk3FJPlP3jFf3fSYcTq14U4KUHZQ8bK87gytAJYzNkCTqeN/GOtPEYte
         rQ6x3FajuCmJG+V/tyVXek6W0ySNIkct8kA5gDsSRtJERe2/7GBFgn0ro29gwJJZioUg
         Nh9hVhaQ0HfEOLsMHLTSDwd2mvaT8nJF6IuqFWDVrKnOcgnrwRkW5gbejm2FgjQuTVca
         SWAYRE43KqB327IcLs6j4AXh0tfElu2GDQK7BTL5s6X22ftFnQJQwvsdkPr++qIf/x7v
         XR4IXmTTu7yn2uza1UWh5ySbzZu6XFn5cF4dShpi7ZwRjVoQIp5PKmByclb+rJ04EPpA
         qn3Q==
X-Gm-Message-State: AFuF++lU9BQ3P8KAXQt344iauq3jRuEFvYUiJGEN51VEZzEYgRe7b0ZS
	8EDl0Lm7tOzUDqb+WkAHfvcwViZTOGm/F1mjOYEEAtD1D5R2GAYZMVsYGQWsR5gjWx7936/LVjx
	M0b7HgcwuvgU6ZKQG09gBrgkAbDCZw28=
X-Gm-Gg: AYBFou3VnE5C2YHsfmYql/V9cpQlQSRPWFNtmteHnymJFFHoQaVw9UNMaYn3eEsEJZh
	uEJ0zkUa5qPV0xNUyfS6+8Ez4m99HOS8Az042HwhzSDjIU8COVnAo8ynkf3Dg5mF98SF/hOnQVt
	0yuEANlGGyDLT3p/arIb1D4oiUyHenr7hnRHaeoEv+B/1dLDuB5TjQ4JzKcpRZrdiW5/ghh06DJ
	J9LMNTw2Mixg+Z9irQCdQ7VsS4TJZlYVvV7Qu/qxMMKqAbijuR+uU65Pum9gfys0W701Dse26wm
	uriWVa9n8MwxE1r63mW9Magj+2Qf5O3ojYfRhU+z2He+Wf4fklauBn4MRvSSR9IbvTMloKSH9st
	P8itqcEQSNJCtuPPq40n8OmitkhdvE/yh4rVovWkVVA4=
X-Received: by 2002:a05:6402:4019:b0:6aa:f260:b851 with SMTP id
 4fb4d7f45d1cf-6af9e30ec5dmr6817737a12.33.1791128386479; Sun, 04 Oct 2026
 08:39:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261002161515.932316-1-linmag7@gmail.com> <20261002161515.932316-5-linmag7@gmail.com>
 <24db4eb5-19ac-404c-9dd8-c3af42bcf4cf@kernel.org>
In-Reply-To: <24db4eb5-19ac-404c-9dd8-c3af42bcf4cf@kernel.org>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Sun, 4 Oct 2026 17:39:34 +0200
X-Gm-Features: AclHuK8RSMN5OQSVW7fKvKmMGHupwE_st8Qcavj33tip96j2ukzukPLnhWfvabs
Message-ID: <CA+=Fv5QzqSQ8+=OpLbchKZ=t6An1HoyOH_OyR1+AiY1dF6Nzxg@mail.gmail.com>
Subject: Re: [PATCH 4/7] sparc64: add SPARC64 VII CPU, MMU and SMP support
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: sparclinux@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, linux-kernel@vger.kernel.org, 
	Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

On Sun, Oct 4, 2026 at 4:59=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.org=
> wrote:
>
> On 02/10/2026 18:14, Magnus Lindholm wrote:
> > diff --git a/arch/sparc/kernel/prom_64.c b/arch/sparc/kernel/prom_64.c
> > index aa4799cbb9c1..11437bbfc73b 100644
> > --- a/arch/sparc/kernel/prom_64.c
> > +++ b/arch/sparc/kernel/prom_64.c
> > @@ -564,6 +564,12 @@ static void *fill_in_one_cpu(struct device_node *d=
p, int cpuid, int arg)
> >
> >               cpu_data(cpuid).core_id =3D portid + 1;
> >               cpu_data(cpuid).proc_id =3D portid;
> > +             if (tlb_type =3D=3D sparc64_vii &&
> > +                 of_property_match_string(of_root, "model", "IKKAKU") =
>=3D 0) {
>
> Are the values documented as ABI anywhere? Usually the compatible is the
> ABI, not the model.
>
Thanks alot for taking the time to review this.

I haven't found documentation guaranteeing "IKKAKU" as an ABI;
the match came from this machine's firmware properties. Its root
node has no compatible property, although the core nodes advertise
"FJSV,SPARC64-VII+".

The firmware also describes the cmp/core/cpu hierarchy. I'll look
at deriving the topology from that instead of relying on the model
string and hard-coded CPU-ID layout.

> > +                     /* IKKAKU: two adjacent ITIDs per physical core. =
*/
> > +                     cpu_data(cpuid).core_id =3D (cpuid >> 1) + 1;
> > +                     cpu_data(cpuid).proc_id =3D 0;
> > +             }

Regards,

Magnus
