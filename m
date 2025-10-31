Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AC934D3A4;
	Fri, 31 Oct 2025 08:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761900414; cv=none; b=n0lWsk18t23cr213LouFR7Gtv4m9YRkDOvu4iCleo+9AJe/xS4MieZt62IztUxTvPE2SZYVVqnm0TPS2JLyKyezDJffA2WWvF1Y2wKGwsv4dYndmjMrdMFAeBd3Ljm8IpyG0U+CcoH8DIe2E69LiMVqrQ9v+A3RwrZ8Mi+79PBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761900414; c=relaxed/simple;
	bh=jd3+S526GEg4heAvpz7XTNqPzy5SAR7KnlKOiYa0Tvk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N+DibhsQ6RjfkTGHxAzRiLLqENAs8wJZosZAMhJJpdmXurFCTnXyhGCpD/RrmH6x/l6Av+J7ys/bMtb4cKwPHN8huezjPU72S1+rhwbI8PiEvtAqkLPpc+CWI7THfHZelx67d6cvu/HWcuD4yCPNM//5GX1Tu+6t1J/b/OexPww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=VQ6OZlUQ; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="VQ6OZlUQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1761900387; x=1762505187; i=markus.elfring@web.de;
	bh=X9eLvk8AlK5UF948hKNDOCkMRnlBmk87p3xiZxScGDA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=VQ6OZlUQoGKdWfeFdj5759Ks9mBwnpfixo6FNLBF3vz10nMjKX1Bu5+2+tfr8Dqn
	 0hffj3FKtOzXbVjo4f7QrZrCutYX+2CdGQvOQtCaP5WJ7sHd28NpTVD4B6TzUnxz/
	 a9HIbm3J5gbabo3Mza96kl+GtJE67CC+wi0WJOYeLvipwwqR4qkWPxfM45SgwDTrG
	 d0maZOxVz+AHOausRPLeFa9ZDvNUChGfTqdQicXCjWBR8kC1XC5OzkZjXELTlF8CG
	 D8AzJ+jyFBNwhG8X1TskvIEVUDE+SCufJvo/9O4DBp5BNu3bXQR/pe0/jQ0M8J+RW
	 5BOY8bGXOpMcZc/96g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.206]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N7xeb-1wJaXQ2KmJ-00xEGI; Fri, 31
 Oct 2025 09:46:27 +0100
Message-ID: <33199802-d83d-48e8-9032-f1c4c61cfee7@web.de>
Date: Fri, 31 Oct 2025 09:46:25 +0100
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sparc: time: Use pointer from memcpy() call for
 assignment in setup_sparc64_timer()
To: Geert Uytterhoeven <geert@linux-m68k.org>, sparclinux@vger.kernel.org
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Andreas Larsson <andreas@gaisler.com>, Christoph Lameter <cl@linux.com>,
 "David S. Miller" <davem@davemloft.net>, Finn Thain <fthain@linux-m68k.org>,
 Tejun Heo <tj@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 kernel-janitors@vger.kernel.org, Miaoqian Lin <linmq006@gmail.com>
References: <2fa899eb-60b6-4637-9035-aeff78e261fa@web.de>
 <CAMuHMdX-uKt3-Lb2NaxmONEqWdtFgTOqXEo1nOfGq-R8ysHfcQ@mail.gmail.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CAMuHMdX-uKt3-Lb2NaxmONEqWdtFgTOqXEo1nOfGq-R8ysHfcQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NQfi16aBSQF04/h5UAmlXLovIPccw+cP+hrd/IRduH3QV9dVz5Z
 y/umYe4yA+WPPKBlULRumxv1/qKmavySGr5HfPGaQNED9Scb/fgOXD4b0UUS2K22ITDGzVA
 eunhWOXfbrt+pZkogpDlkEYaFRNWcQ8hFDRF5wrXy01/sYsJUoHBDFmU/UQa4kkiSde/TAV
 /Sn+JEj0tBUitpSx3rdMg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:DsmkQIGgFPQ=;fL80Fq4eueEw1r3UJKjT19gZ602
 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

=E2=80=A6>> +++ b/arch/sparc/kernel/time_64.c
>> @@ -760,9 +760,7 @@ void setup_sparc64_timer(void)
>>                              : /* no outputs */
>>                              : "r" (pstate));
>>
>> -       sevt =3D this_cpu_ptr(&sparc64_events);
>> -
>> -       memcpy(sevt, &sparc64_clockevent, sizeof(*sevt));
>> +       sevt =3D memcpy(this_cpu_ptr(&sparc64_events), &sparc64_clockev=
ent, sizeof(*sevt));
>=20
> IMHO this makes the code harder to read:
>   - Only 0.15% of the memcpy() calls in the kernel use the
>     memcpy() chaining feature,

I obviously propose to refactor this implementation detail.


>   - The line is now longer than the 80-character limit, which is still
>     customary for this file.

Would you like to get a subsequent patch variant?

Regards,
Markus

