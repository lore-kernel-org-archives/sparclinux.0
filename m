Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D069683A14
	for <sparclinux@vger.kernel.org>; Mon, 22 Sep 2025 21:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758575488; cv=none; b=ZnqGu5s100cOT5uFpS3qmRZl2dytrpFWhZRet4vClCwHSBfCJA04p9R0hnnzw4DmBV6rVQe+7sJ+iCFeJgW5usvWHhqibnR3blAiLG2HHYwIghUVybHWZdKS9XClyWnHH1bEv0g4yRO2Z4eaINTDsMJB2GhohsCTppXX2NBuscY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758575488; c=relaxed/simple;
	bh=XzbjLdGwdorUgzFZNNHEJOdjHSCRBfkUY7BNS5tTsgU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=lMpCfLAoPt7pwOuzjdNA8beJZ5Dm+m0efYJdiIypLMlBKgBUFOgFdpAaLkSRzsCEPBgs15rV9VwL1GuhlhsOUzcscTERZ1/uQ/w7kJMa2Te9uednTHD6EpJux10moTQ7Yaqsd9EUNqtbYruC+LlQG4ljzDBleSddo+7omo78CA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tXLvEXO+; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tXLvEXO+"
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758575474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XzbjLdGwdorUgzFZNNHEJOdjHSCRBfkUY7BNS5tTsgU=;
	b=tXLvEXO+0G3oeMOAVCtE/toOx3oPlmimyv0uE412gaNkTB2AaVt2Cc3MGWaCvL6Vhfhz9H
	ZF00ApxeA8gwQWXuJUgDEbTfTAhwPiRWCJ2ncpwo6s6rVgBfhn/zuCByW/TyqTAe1yDIOA
	aBOxccPN0zk07+h6eKLoOQQnJrxRkKs=
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH RESEND] sparc: PCI: Replace deprecated strcpy() with
 strscpy()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <d676606e-f448-434b-be26-c839dea4f5d1@gaisler.com>
Date: Mon, 22 Sep 2025 23:11:01 +0200
Cc: Bjorn Helgaas <helgaas@kernel.org>,
 "David S. Miller" <davem@davemloft.net>,
 =?utf-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 linux-hardening@vger.kernel.org,
 sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <57FABB07-3C1B-4D33-A5BB-8D402A20487F@linux.dev>
References: <20250917155038.GA1852582@bhelgaas>
 <d676606e-f448-434b-be26-c839dea4f5d1@gaisler.com>
To: Andreas Larsson <andreas@gaisler.com>
X-Migadu-Flow: FLOW_OUT

Hi Andreas,

On 19. Sep 2025, Andreas Larsson wrote:
>=20
>=20
> On 2025-09-17 17:50, Bjorn Helgaas wrote:
>> On Wed, Sep 17, 2025 at 04:47:30PM +0200, Thorsten Blum wrote:
>>> strcpy() is deprecated; use strscpy() instead.
>>>=20
>>> No functional changes intended.
>>>=20
>>> Link: https://github.com/KSPP/linux/issues/88
>>> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
>>=20
>> No objection from me, but no particular PCI core issue and I don't
>> maintain this file, so up to the sparc folks if they want it.
>>=20
>> I would consider making a single patch to address this issue
>> everywhere in arch/sparc so it can all be reviewed together.
>=20
> Thank you and sorry for the late feedback. I agree with the above.
> Thorsten, could you fix this for all occurrences of strcpy() in
> arch/sparc?

I just submitted a small series [1] replacing all occurrences of strcpy
in arch/sparc.

Thanks,
Thorsten

[1] =
https://lore.kernel.org/lkml/20250922210408.1723452-1-thorsten.blum@linux.=
dev/

