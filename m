Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBE7267B01;
	Fri, 31 Oct 2025 07:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761896797; cv=none; b=R1XBRr9+e6yppquF6KCTQWBFj7vTgq/5evaAUVbYFcbZtEL6Y4mvmaOpe75bDATQMArLMsHQXToH5gzHDa2B201OJ+PzbTxmHJ/zqt7MVHCfFINXhOwN614QnDZbhPl6oUScGnOCwnC9QbKMz4IoA7C4FhBQYAqIOaE/yrx43no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761896797; c=relaxed/simple;
	bh=lfq0dr1WBATG6evXfV0jmBhx7PA6JUYfS/CR4ff8HTA=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=schNXqnJlJW8Sbv6/Bxqk6XExyEhN1qEzTtVRWQ8KKrrIeqnP1JfqVqI1G1GqlTnzH273r11pZKyxwMxt7+IzpbuNU/tfrUqTXl+TrzJwwDaPZkTgCJhnhFKxFZXOrNHo+ssDwAvqlamvsXDASbWYxR3GyqpYzcjWxBa3aaZVlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=t1lFqMz+; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="t1lFqMz+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1761896791; x=1762501591; i=markus.elfring@web.de;
	bh=5iyaCMe1EWH4JiA+syvzdW5hxQJGUTzYJOA439YhVhw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=t1lFqMz+K/W4MT0oHk0sTtSJ/rB7PE39+GXQFNkBQDNbyGmopBr+E6DpzkvqqnXQ
	 SLIdubD6DfiLszUJoKceEyun/44PpaOLkvlFsaNEneoW6h/oN9/prielbyqCiJHcO
	 OuSqY75QD8Ttws+A/niU0XIRtz2IU0hRwZoFK+XxrVNt7nNJ0Qhox+cnmIGltPZNm
	 HOQSzwKEHUVo8J/vcGvoiz8VN/jJf7lSr1gxtPFVhmu1LPXJnkCxtPv3YLTw/wqN2
	 t7ffK02mECJ/EewE25ly+nj3AorFzNgs18Tg9NTdu2vLYQASlnJ9LwLwGpD/JsLUo
	 O3YBE8U3/lydD3ZX2g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.206]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MBjMM-1vObDH3QBo-0017NA; Fri, 31
 Oct 2025 08:46:31 +0100
Message-ID: <2fa899eb-60b6-4637-9035-aeff78e261fa@web.de>
Date: Fri, 31 Oct 2025 08:46:28 +0100
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: sparclinux@vger.kernel.org,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Andreas Larsson <andreas@gaisler.com>, Christoph Lameter <cl@linux.com>,
 "David S. Miller" <davem@davemloft.net>, Finn Thain <fthain@linux-m68k.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Tejun Heo <tj@kernel.org>
Content-Language: en-GB, de-DE
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Miaoqian Lin <linmq006@gmail.com>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] sparc: time: Use pointer from memcpy() call for assignment in
 setup_sparc64_timer()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xxvCEfJNW2iftFGhPsZz/mDUEwxNOxsz1QczOVe/lAWFyqY6NdD
 HZaOj3z1olWHU60B4V7mMdp0H5zhhLgQZRVqC2qTGecOQ69/JO3gn6K+IBM4D/UOHiYBQEd
 Vtv6iRlg0uUsz0kXr/BFKetPMjDr7o9glZajmN7SFIPa69yP20QiJ16vhRicqywrNBTwrTN
 /Fd8IelIEd6+YtReRdokA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:jgJaWNtHi14=;vSSu5axq/lkud8xL0Cz12rJMNBN
 m7vfis/wqT4nugsalFWezAXA4aZS6A1ObzT1yypN9XicgA099q4ZC3gpv2K/z2rUyW0oRcOYP
 RakrRTlsttRxPs0YrZmRK3Yoln2qTPzCaU9ETg9j9z6+2lpVoOXdbH51RPHlRZvH5EKZjjgKY
 GI9OWB3ycWiGJpitaHlLsxiLXx3A1lvtnyaAe3/zX8v0IUWjLTgiJQNirhuJy/WzI7qcJDwIi
 jhF0etDjTtS72E/0o5xz9CIebp4P+JqwRr0ZbraQzrkj0A/iTMMy5vd8qviFamANbTlvvq9XV
 KgN4wo2O503h1Ne9ODlu0zriPKMoged730Rnk3xEg8+JAN3qBj6AWpzj2SdI51BmsEa1jXocC
 O8nKocw+ns1FU9xQNmWLCKHXPyoG+MueGF7dTYD4V6Xnm2W6NQINlaECtI/112y2zNzFEn/EY
 6hcaC90p5Wm2IGUNdJklPjiukw2fQyze96OqfVQruzj2UV45I0WS9WWSH/9M/S1Jl6vN00t2j
 5hofeW8tsC8G57hm/CaCtudYUwH0gNMTgRhd2ymH5S0uevyCmxxqF42K07ytM4gqaeVzqSvow
 hlPAh2OxYF7QrKeOf9vzfM/jpUA0ccSjih9AQnAH6KXpYbWxzQy4XbQyEX5chp6d5KDK0Qf0R
 ZYZPhz0lsnSwWw8C1gBsrC0betCaXyuiAHUOwOnCZmBiWJxSLhBz0JW+Og85xzhLnMTfStLBP
 f0pHxen3Szvs3oLQF4HcL9eCE1Q0Xf2X7nvd6ZMyLwq4IAABWW/xQfjZsMQbK77kG03+BDz85
 15F94R3ybyuWyQPTEfJVxkCvAIhJh8CDT+zr5v4B+69EdFsgvyST4VPEnIrUhIuEeMH6wMoZw
 I72I949p1aOdk0orGncVGOPr0UiwCBYfs4Br/+vaM7C95Y8BOLYWf32+1u4MbwBFY8cIo7wmG
 OHjWrXXjcBUEqqIVixr0cXNxrV6YJMpxVKzWJmKnznZl1DRHRULHSu52pcCoBO+lagDEifRhw
 /Q4g9tipaj0gsGG2RG9c9midgK9SUgcGdG9C48ZD5svlvaJBIYHX8CnDtEyJhLD42w4qB1aQT
 WjKGmZVl9s0rpN0734COWcxQTFaErMbMr03H13aoscXtMfQCILeP0qlxBiq49aY8H0w3fOUY9
 sCCg8fhCreHVDeukRWgI6sV7XsBfWNuQz5AcuIkODjWEfNyf/O+8saoW9BFiCzETYUMJ9MRvA
 M60wWennWPLphgAmn6NclBXBebwBh2wqzBMl+4ghiQlpM23TyXAqPNKP5Lt9si40vTR6ks9qd
 mqWaP+GYi2DO2bnkAJ46G0cog3d8db35BvaIwMlxs5pnV/Oi2QYKygXXd0xfSobfQRJj5MI6t
 VCB3nNpNEFTYYD44UFxwHo+Iq9vJmuVU/TG8kiZYENb0ZFgmegT3BhFumikdkriyk1IHOgbTR
 2/NJIXxhnA0tUcHkdlR/PjusWd7dwhjddcTq/IJ++NV8iazzEUGQGFERlWmqDOb3z/CLUAlJW
 8ZPdstNUK7zgpQppW1hmkKO0H5hq3p6mTWCszLrThZ9Xywga3gmyR5ifik/B1fad+erTHjKLY
 fqanLNkLKJCiSLM7q2z1Gqgr4RdqU+J2PAIYRt6FwXJ+Nb3SljQGfEcZanKr1qix1TZVRr59a
 RhkSOqVFJLk+N1GRI6SKZtT1JGhC8E/xZP5KSiE5AATxdCXFY8WW9oDdCZI4A0WKghimOjnBq
 b8U0JX9e930a1XLWgZAeQpJZJ3awCo6G/w3Sei+vqbxFl8NpeM3CGfA4Tf57i2fKHBCYH5U1I
 Z56Dr0RrIlPCfXw2YLyeAMzqNaZJ6y7BGiDXB7tfk19qG2mHhsBAtUh/QnBzcBx++m5ukUNRa
 JbYct3Mu1xXW37H0hTImt4IKWaRcSQ9lUD6yseoTZVdSkB0hWFvp8IFucSed2y/JIID5DkGJK
 rFYuaHpIJPJ81yyi3SzBZ5Wj5BJuN1fooB0K438E5grsgSTrmTVQt5iKgMZf463qtspTLedKi
 fbeWDGg1K+UPyI2zg3zSN/lO8PNVs9NJhhxMKi5UmsXVMfxUHpe/aaaqgV6FN5EWo6Wr3MeJC
 rMMt9N5ARbQU79vxwb4bOJzXVlE3VxHqkHa5tMegufSVjncdmXg7G7bT9dk2nwb8xWTsSj/NL
 MyTzp8B8iQ0EjmIYiJ+QooRPL7i1E3plxmDJcS1JC+G5VuclbsLHKuwsx3gnyJNWjjIwApeTf
 6UVdNqneaVFWB8UrxEECWl2I0eXnKuL4WzbkToRrQFvqwO7YqYLPEdKn9XpFk8IgXvDHuf5k0
 XMW+1cYanKijp/z+j8RXcN8QnUPbh2F4zFMPwpTBeO/+X+Nv3fpPATt4sCC3nG9wHpbqxxiVK
 JUvJYfRgd5Oc7kxeI6vAlZ9Awe4km5u137QjHWAQ0UKEBFWnjQrK8+4jjgNZPYieE8oEjx1bL
 so6x2Z49XxIKmOQyLTldJXEqwDpb2oDvFp74RxXWp+6pfxL/ol4wLXcZk66EqbrMG9qVZDy5u
 Q3wIuK1sxX3TeN43dFWEYq//qlMhztspSR8Z8+qMpXtrcx/k7JYI2PtT36ycLic/H+2LgILbS
 yC6RFnsox2PbEnCJo5GUDLxf91LCdKHbkfrPBx3pXoDNLpndKf/dm4JDAiMDjk7p+Hs8in/wg
 UGnqc0D03WxLkfPy++x8spAZ+Tq8og/h5rHmTB1zBfSB88vhcbeJPiQV/oLPLK06x2Q/zTdP7
 I6+6uRgAkofnEIwywnv6SiaMyuDsnF+/k5PIUO8PB8MlTiZ3D0AYCODxo1JZlw86q5GDFfhWq
 +2Edi/T/BbfPohSAsKFtdQW5dLPRkRVzQy2+DNOzmqUE/f5uEgnW3l4XD6PLoe/t6lOdqZ0Y3
 W29Yiy1Fscl8yy/AR6ijbr7KCltogsHfaZcw/iC1qzw/S3Xmhca8SZ/aagqjmMk+958WvHGLx
 ZQcsjCvtvYVw8X2rDf1ussst3LScZwYRblxtzhPK7rZBrKy1veaIHWeC4vFVagybaJHd4Ih8x
 WFs6iETWYb0PQBHIBnHg19KXgWd27Oeg6YNAqnbhYXeuOVhpeun4TlN2Ns5rQoBwsqGUJys7o
 Fq4mCe+uonWUtZQDDtieEeK+tN5hvPj+DgO8DIsVALV6xzZ07hVlmF3Ddn+lIEXDG5KOM62cw
 vIqR8qpEgp28ZmQy7/JkxJOjM1cWHKHzo6PWGtTfYUyzcQwtu+Iuo6RvcUtN2OHIYYqd1h4Ug
 7oVUaj1aNGTPQit3Eldg9eFpe64dCsaS2m+P6aQOuQ3Zs/hc0zXU8tmTwBzaQBclV9pAIuUCC
 PSn417wI7cRduIrZmontnQTKb8Wgi7mW9SXdQ61ztWjuxbt2GiWLxZ2khVxIHZpdl0kMu34K7
 69H3PIDTa147w3yKg6K/qmtxfOlDIAP3ODVPgo1Xzos4AH5fd6ZGE/qCdQMQh/B7eOO3h4bft
 2aL9aNG4xXjdkJK16p22wNwH8KbH/arYzoaxXQu+GKxYZXLbMbKjPvjRJnrlaV6S2ENsqTcet
 H4uv6XIEzKAhL1JVOuLFsy3Eohr+Oj7b6zfhUr0dxggmsQP6GzXasfwiz+gFNSgesVUrktePO
 MYQ6dZY+wT9Ozx4QyH4Xwoyp8eCGU3lPc3AZBBos5z0mxohVvdBIOoXRgeUiRQebwXkMULBy0
 ZlWCSHwcpIqOWyRkAe0YaW4GUbd6ocfJMqlgHJhVpMuWdU4iR77ym58YVKhXfmlSqfh6ebvAC
 AGauimDCIkIrCL/sUyR9IMZaia5TAOM4spl0swHBW1W3p6DifbIFpZ84YETyZW4WB29QtJABw
 gqad3IV9OUbDry/BRgtc0O4CtIqML16w5haCCFod9/XrCoL3kfeniNDD8TkPinw7xT1zQaIQU
 l1P65w254ug6MJdLqOWl1JLQdPdjpww5k/XBIaxdESWwGwhn1EB49UEnSLq/digDKzAFp1FWR
 GrnktX/ppUsMWWIG8fDRxPcxewEE2uu0tING8Kcon/oV3ugL34WDnD/T+To98RHQvcToDGe7E
 d+9ET13/unVNMQYaIH3tGoAzQZPi+bPpc3X6dQlm+U8gLErBd3Czz2Yb6SG+D0/z4DBp8UPId
 jZgtgLYBgaqzT2wNDZcejrk7UxK+iMOUpvjwI4bD1tY1dkfZ0H6f0j7V79/3m68zu2bDJZ4iV
 T7ELMEFovMNBjBISDFMaSIuSa2BNEEjUYUcajVOgUeFyHqehTE5t/vxwN9pDhOKcwW1YVSFuu
 h0hVZVNlzLV6GCICcZlVAttFotPXh+CvBWkQrwgnaBg3GMezM0qqf4ZYuuucDuHl7pimeFzmf
 8mAIKcpN71DhFEhtBN1fn9K4ZJgLzXIGZMZxogF/ay9G0GtCg7hKFA5HKp7NqP1TrBCGWy7Tt
 idt6r/1jGyHHZ9zngAGF6chPkteFM1BgnRIRjnF1aRd50PWp78G3SqVrspNg7dH5wzOCJCdr3
 qNXqEuxiofq8HnWJ/btiupfYlMWRG023091AubNi3hZ+NNnAXDLTiliiEgzaJTYYbxJV6kb5B
 Q7Vy9PSovGI7ak7OmMkP5+lgcQ7RKGoYrTVPSqlQ3cfNJQSCKJE2IJPjQZMcGRIsaCs4dZg08
 Vtq1spZ6g1IkGQGwXUeC8dJDxFE4vDLwNmQYWHZScXV0f/jm19JQdI0kxEYptQ4cMGnsBKMsy
 Oz+iqQhT/3xPbPThVzAvETKbSa1nmYrrNHOULCxF5z2J6o/Oj84dGPXBPEDRUF/mkWeX/dsD1
 rQXbEBJWouu4rgF1/bOn1LWdNafe84fSl01OZjRWFQf8tK0BxM6K1FfPyW+fbvRafX7Icsuml
 oI98v4mI1bldSUk4cbAXl8Rywc47IRqYAjXNG9EeS/DOIDbpFQd69A24F9WrzKfiXFb9o8mLo
 2r9s6E/h6r0iuDWldW4G+d0p9ouU1B+ZD0rMJRFvIaCSLcoUk7d5Tj4CZaMuysaVo6S6zKb43
 Dt0Sjb95gs8ssAjiZmZ/u1olsFh4xnuMqwzSlt90A1E4IM9aGy4q76EgQNxbpaEwkl35rWpz/
 eJagFv+Gkrsq/t3e0sRy2XOIoPZRZ7epN7bObmc1ewz6zOX

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 31 Oct 2025 08:36:13 +0100

A pointer was assigned to a variable. The same pointer was used for
the destination parameter of a memcpy() call.
This function is documented in the way that the same value is returned.
Thus convert two separate statements into a direct variable assignment for
the return value from a memory copy action.

The source code was transformed by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 arch/sparc/kernel/time_64.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/sparc/kernel/time_64.c b/arch/sparc/kernel/time_64.c
index b32f27f929d1..e9c29574cd59 100644
=2D-- a/arch/sparc/kernel/time_64.c
+++ b/arch/sparc/kernel/time_64.c
@@ -760,9 +760,7 @@ void setup_sparc64_timer(void)
 			     : /* no outputs */
 			     : "r" (pstate));
=20
-	sevt =3D this_cpu_ptr(&sparc64_events);
-
-	memcpy(sevt, &sparc64_clockevent, sizeof(*sevt));
+	sevt =3D memcpy(this_cpu_ptr(&sparc64_events), &sparc64_clockevent, size=
of(*sevt));
 	sevt->cpumask =3D cpumask_of(smp_processor_id());
=20
 	clockevents_register_device(sevt);
=2D-=20
2.51.1

