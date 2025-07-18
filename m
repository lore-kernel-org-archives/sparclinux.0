Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476AD146588;
	Fri, 18 Jul 2025 13:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752846217; cv=none; b=Nh8FAuUe7tNtD/vKk1jeGYMLqX3vGFoVVvRH+qpUTt19u1vRgCPLAIweTuMNu/Hp8Q/4V0boFwXXUv5OopzbaGAeyLhirkT28S8rtojmwRGWOeYMIDgbr+iKkrPat8u4glkIdREX/lf5ThsRspVNfb0qgddHgYU/zps6vAImvGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752846217; c=relaxed/simple;
	bh=3p7vube/9jlo+GVzHtG0DrjdvWu3LcoLwhT0YUtMywE=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=J/rxEFlJggpsNiB/KYiCCfYtM3VZ1YJO0+BCsTGiiHX8qHk7zKWOoazXZll+lCRsU2VQ7plUz2C5YnMiw33eGwyWIlFhEM30VhTzvVSi9oHVFc4g2foG9NBZcJaAX+sQ9xD8InMWj7Yb3syTYZJ+RqjOkc97nWW2S4g/1Wonaoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=MPu5ju2n; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="MPu5ju2n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1752846209; x=1753451009; i=markus.elfring@web.de;
	bh=+iXPjTfm6/97MQgZMt4xsWs/7fRwYeuvfsd89d6RUmg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=MPu5ju2ne6PvP+TEK6E9Pkms6DsbsHnn+oO9eOa7+uIUMURpwhycfJVlribW1ycr
	 zThhHBnrGhWXnJtJCN3o/8QAo7YTINFrSBzt6HRDW9oLQvILBEo+QCmic3qU8KEg3
	 Co1wUGSfVhiB54E4gfPV4z9RHoAHLO0K56yIhugX2Kx/Qxx0+KlmLHirxx41dd8H2
	 GHWLwvEvd80aYYNYiircPLQ0VdZ6h1YyPrgp6o/+Fuhxokhe21ZJHKUcFlNTdTAjy
	 D99Iyxjxr112GvFMQIo54S1z4qddON4UIS+tWk3rebBjSo1zW9WFrKxvilC9Je9hB
	 pSc1lx1lbgXeqUkKcA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.219]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MlsKH-1v33Rq0vul-00aVb2; Fri, 18
 Jul 2025 15:43:29 +0200
Message-ID: <cc7db82b-0337-4342-aeaf-ec6376cbcc74@web.de>
Date: Fri, 18 Jul 2025 15:43:27 +0200
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Siyang Liu <1972843537@qq.com>, sparclinux@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Andreas Larsson
 <andreas@gaisler.com>, "David S. Miller" <davem@davemloft.net>
References: <tencent_C3DEC6F98F25C1BF6F35F3A1B0A629E0EA0A@qq.com>
Subject: Re: [PATCH] arch: fix resource leak in chmc.c
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <tencent_C3DEC6F98F25C1BF6F35F3A1B0A629E0EA0A@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/uFRKr29Edn0BtGUR9iV/XLoI6p8qbpPgbrDVn2owdGqJ4B9VMK
 2xkNrUyqKP0hN2r48W/IpZEyucMr1dB2/et2fxKXpT/whnuD34xHzSSaKoDtCj3kwuIGSRY
 S8tMAjCEw8aojvX+W61YWEykESUa8xNNK1swxYkXaokj1oag7v65RFG8ALZk+wG1s4DXeh9
 FzDlaWsPAU2KpAYVbW9UA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:fzfFCtaBqY4=;VSfOiOnn1+ICqxBab4AWCv2pRVi
 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

> In the jbusmc_probe function, the device node mem_node fetched=20
> via of_find_node_by_path("/memory") is not properly freed=20
> on all code paths.=20
=E2=80=A6

You may occasionally put more than 62 characters into text lines
of such a change description.

See also:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.16-rc6#n94


* How do you think about to add any tags (like =E2=80=9CFixes=E2=80=9D and=
 =E2=80=9CCc=E2=80=9D) accordingly?

* Will an other subsystem specification be more appropriate?

* Would it be more helpful to refer to =E2=80=9Cjbusmc_probe()=E2=80=9D in=
stead of =E2=80=9Cchmc.c=E2=80=9D
  in the summary phrase?


Regards,
Markus
