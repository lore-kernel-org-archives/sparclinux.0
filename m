Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1349021CA1E;
	Mon, 21 Jul 2025 07:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753082307; cv=none; b=HSOl9AOs1oXOhKG5/NAIEai9XbU/X6WlCt+FW2iX9VqcJXT8We3q5bClzDh97kpXhbwhhJW9TYNU9VZGZSIv5MltaFP4cZy89y12janR0/WxJF+VW6NqJ+xJu4K6aCZsYnCKK1tg7VB0UCdFzr4xc/YrArz0AAo5WzkuYyZMRjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753082307; c=relaxed/simple;
	bh=3qrevPcicxgETY1294+5rHRFXsitnT5UsxJa4w+t/jo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i08PM/XMfjul2v+gzrPAYXFGQ4mq427nQ9Rf37t+s8NodvTwST7Cx1hHPWK5UoUmt81asNXW+62eOrqRb2QJbxp1Y/6ffvfxKFAIB2HW5U22dzs4mUMooeKoKGrLY0aCrFP4ce3ew/wXHK3tA2Jwq92zqE7NmappeNIXUGb37jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=O+qg6ChK; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="O+qg6ChK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1753082296; x=1753687096; i=markus.elfring@web.de;
	bh=3b63yCSRxFfdpBP67zrx3rmro5uAXRHNaFmThsOJBMg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=O+qg6ChKrpJcIpGtGSH5T9hwR0ami5ZmSTF8GO0F9n5/NRv7Lgx8Fmv0J1xBx3Zz
	 GfgYRf4mW1reLZKNjbsc1vICFq8BB2uP3bq00q2NIyHFM98aPq+c2LzHni9AVlxaW
	 1IqHNbONs0lgB8r/+Fk6MO9kFO8kzK1DwAxI74qGWEaAHNasFHDBfWdrjCcZpIvP3
	 9KhBexXwNwahTaJQg1tmAXTlbCPQ4e2aJjb5Q+R4mJgcx9nzB4rRzDS2C9uffo64g
	 kdPHgjK5yMQOUuzAjsXN62Ghx2iFAkt3bbUNE52zcvKGOUKlddPzMSJz/RSV/pdWe
	 PBNddPc4SW46pelGFg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.235]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MtPvg-1usOUY18mM-012FdT; Mon, 21
 Jul 2025 09:18:16 +0200
Message-ID: <45b8941a-b6bf-4b48-ad1b-cc6ba46b8642@web.de>
Date: Mon, 21 Jul 2025 09:18:14 +0200
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arch: fix resource leak in jbusmc_probe()
To: Siyang Liu <1972843537@qq.com>, sparclinux@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Andreas Larsson
 <andreas@gaisler.com>, "David S. Miller" <davem@davemloft.net>
References: <cc7db82b-0337-4342-aeaf-ec6376cbcc74@web.de>
 <tencent_60B856B729FE434916EF57CDF5286D69A008@qq.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <tencent_60B856B729FE434916EF57CDF5286D69A008@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Sx62xdx/hkM/LHNDHWh+0OOkVE2MklN8TDbtqT7mVFO/btoc0wr
 gI3P1cUI+j/arcOvtXDRMSBrjCya8aZbXpjbT958S4KqVhW3wonGTkTsBAEH7XidL/vkFP2
 RyEZEd3khQI5Z2pZASa8KVCr8O5vcBpDTUPTHj9p1DqBaagxXP3NgII8kdWyJcFt5btQlSG
 Ddf2dmcIoxS4pauSm/gQA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ZJ9QKpSfQGU=;xc0DNeNXcxa+osVlhMHOMEW8j6q
 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

=E2=80=A6> This can lead to leakage of device node reference counts,
> which may result in kernel resources not being released.
=E2=80=A6

See also one more:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.16-rc6#n94


* Will you become more interested in additional tags (like =E2=80=9CFixes=
=E2=80=9D and =E2=80=9CCc=E2=80=9D)?

* Would the subsystem specification =E2=80=9Csparc=E2=80=9D be more approp=
riate
  in the summary phrase?


=E2=80=A6> ---
>  arch/sparc/kernel/chmc.c | 10 +++++++---
=E2=80=A6

How do you think about to improve your version management?
https://lore.kernel.org/all/?q=3D%22This+looks+like+a+new+version+of+a+pre=
viously+submitted+patch%22
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.16-rc6#n784

Regards,
Markus
