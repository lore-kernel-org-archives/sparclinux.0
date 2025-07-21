Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90924280A20;
	Mon, 21 Jul 2025 08:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753085872; cv=none; b=m7w6SZVdtkqDkPcoV9qhIkutIfaFlQUrSgeToFFeD7aIW0FX+OHW8XbqtdE7xqJqwvylDt8f9co+gDOW2L4VMTJhRM9/dlPTq83t6CF7ykjFVbJcbEx0lglr4OnKohi2tLzkemYQ1sYGmQ8q5qn4LIJNg9ILDeoDkFqnrIRlQKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753085872; c=relaxed/simple;
	bh=nBY3egso3wyBHb7G0mZCOwzZktaLtKxIiVx7NMVbz5c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dkVGHK47LH36tXQxze+WDPojmoc9e50/LgIm6nnMDYsmDpxAbrQMI90l4qgWl3TnmBdY2CYKQldOLnToIQHE5+YObj+Ff7cA50/EDVD4cXxZdW72Dqgqpnc/vnTsJcG3FwRHrZ4ZLY7gxdAmla5bhYEFPEVoqVsC5JNwzIqLeuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=idGy9dVd; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="idGy9dVd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1753085861; x=1753690661; i=markus.elfring@web.de;
	bh=tYRgRzV3RcH0tkCVqG+N8NqmPThlBnU78OJZ8xWqWUk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=idGy9dVdsm22DxXMgXGX/Ek5K0gxsg/5dj2BU3KTvj6zhOzdS4u63117O2e7YT00
	 MgqxuB7p7qxBne07r1+BrA6UWatu7WdsjjOKaswiem7AN5B9gye2EIT7NL740NW2M
	 9UB2kzNJiuRvnFEvOcOQgWdY+DTipR88c4kaPwmhhxlB0nh5qyxhSlIhya+UuLeWW
	 X9FU0dnKnsbQ3QpLc4WxRt/pmuXxkKUbiTce9E/mx1f80NeSJZNX+J6S4r2rmGvQ2
	 xO7CddKp2h3nIZ5as5DHEeZf+NojWlM+iI8HrD3Y3+SNi2HkDMkyCZfT3e5hxI0sz
	 pxPw78bEXQwY6U0smg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.235]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MVaYw-1uCAAj2EPk-00IvsH; Mon, 21
 Jul 2025 10:17:41 +0200
Message-ID: <57b3f1cb-ce37-4026-8689-7bef61583b10@web.de>
Date: Mon, 21 Jul 2025 10:17:39 +0200
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] sparc: fix resource leak in jbusmc_probe()
To: Siyang Liu <1972843537@qq.com>, sparclinux@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Andreas Larsson
 <andreas@gaisler.com>, "David S. Miller" <davem@davemloft.net>
References: <45b8941a-b6bf-4b48-ad1b-cc6ba46b8642@web.de>
 <tencent_46DA24BE77C8E62514B3346C5CDBDB327F07@qq.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <tencent_46DA24BE77C8E62514B3346C5CDBDB327F07@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cd6849LtWxFBqAHJwAIJVDKNubR0oduILMPj5f9CeOWb54q1Oki
 nklMVyjr1dD/W+fl9aMWzqCDj5DDiI5kdjBR3jpVMcC10DlSZdGTY4ERX6p7NaU3sWyXIcB
 d7GFpDCwMQnjQggxEonG74/aMXccISka/zjoNsS2jSj+2puuMnERQuQJafhKI7BrcmomdB8
 86kMF1C/XvJpwMcZ8yDKg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:tmpagtcfOis=;n2UFRFqOcdifgyk+JqnG7pI5i6K
 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
 Ow7LY=

=E2=80=A6> ---
>  arch/sparc/kernel/chmc.c | 10 +++++++---
=E2=80=A6


Why did you overlook mentioned patch requirements once more?

https://lore.kernel.org/all/?q=3D%22This+looks+like+a+new+version+of+a+pre=
viously+submitted+patch%22
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.16-rc6#n784

Regards,
Markus
