Received: from smtp.CeBiTec.Uni-Bielefeld.DE (smtp.CeBiTec.Uni-Bielefeld.DE [129.70.160.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84C117A2EB;
	Mon,  1 Sep 2025 07:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.70.160.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756710564; cv=none; b=jYLqiCULfkWv2vYMwtMCRlerRi71/S+VRKLelufFrkCrfPAyKPMiyXPedwQbATRwzqqVnGMd3cNXTpIdriFsxoZvl/eTlXI+zA4z1JVYdEn544SmXDXm0cO8//uXpgAiHeH9mDwAgFP5aWomOxxARVXBVK+lAG1dQtS7kThIumQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756710564; c=relaxed/simple;
	bh=MpMRn0jmorqks8fMq6ldSU/X2aqwsi6PRn2Ixb3HtBM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Sh9qRk4t+YTBoSaXE5Tt5ZlSjeCpZps+kuAJRotZ0DKYNHulWbxGQj+rZoDb35NpHzIGneQgeQ5qT2VJkDbGBrDbAl/j/zGmgssxwrIkfbNEnHAcwRf49wFZgnHT3neZSD44XG1EnhTie3BSGJBn+V7nXBUePYBS3yEVkFesGTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=CeBiTec.Uni-Bielefeld.DE; spf=pass smtp.mailfrom=cebitec.uni-bielefeld.de; dkim=pass (2048-bit key) header.d=cebitec.uni-bielefeld.de header.i=@cebitec.uni-bielefeld.de header.b=kJqwZrxD; arc=none smtp.client-ip=129.70.160.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=CeBiTec.Uni-Bielefeld.DE
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cebitec.uni-bielefeld.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cebitec.uni-bielefeld.de header.i=@cebitec.uni-bielefeld.de header.b="kJqwZrxD"
Received: from localhost (localhost.CeBiTec.Uni-Bielefeld.DE [127.0.0.1])
	by smtp.CeBiTec.Uni-Bielefeld.DE (Postfix) with ESMTP id EF863B8D3E;
	Mon,  1 Sep 2025 09:00:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	cebitec.uni-bielefeld.de; h=content-type:content-type
	:mime-version:user-agent:message-id:date:date:references
	:in-reply-to:subject:subject:from:from:received:received; s=
	20200306; t=1756710027; bh=MpMRn0jmorqks8fMq6ldSU/X2aqwsi6PRn2Ix
	b3HtBM=; b=kJqwZrxD2sH35QeC55lSl9RJwG/BvbJQBfb9PNScwTPGunOV/QIkV
	Y77OaZVmC3udnAXEW9dog8T5lY0GmsXMPti1Lcjj2gFTNpGRT/tIGBPufYPrUIYd
	6hfP6s6NYjflZUMFQxVRPkh9NBvh/DvJvt3w6hF5fTeNSqGFkFpGCmrsVaC/thuI
	DG9GUD+sfJOvCIJMWX4wssNzPo7hF1hL6oR+4F69T3l1Ww+7yhBYIZLgth92jnEq
	MepXt8mlgZN76CDrAmmlo2u98Bx286CMKJhTLA9GObWA8oIPwVPP5KaI2h5X5qGM
	Rj+MOypqiV1qUy98diroJJA9hi0yC9FVg==
X-Virus-Scanned: amavisd-new at cebitec.uni-bielefeld.de
Received: from smtp.CeBiTec.Uni-Bielefeld.DE ([127.0.0.1])
	by localhost (smtp.cebitec.uni-bielefeld.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id FdUk0RIJygLE; Mon,  1 Sep 2025 09:00:27 +0200 (CEST)
Received: from manam.CeBiTec.Uni-Bielefeld.DE (p50854244.dip0.t-ipconnect.de [80.133.66.68])
	(Authenticated sender: ro)
	by smtp.CeBiTec.Uni-Bielefeld.DE (Postfix) with ESMTPSA id 16F56B85F8;
	Mon,  1 Sep 2025 09:00:27 +0200 (CEST)
From: Rainer Orth <ro@CeBiTec.Uni-Bielefeld.DE>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>,
  linux-kernel@vger.kernel.org,  sparclinux@vger.kernel.org,  Andreas
 Larsson <andreas@gaisler.com>,  Anthony Yznaga <anthony.yznaga@oracle.com>
Subject: Re: [PATCH v2 1/1] sparc: fix accurate exception reporting in
 copy_{from,to}_user for M7
In-Reply-To: <240f0f51687dcb146656a47932ec075b0821b605.camel@physik.fu-berlin.de>
	(John Paul Adrian Glaubitz's message of "Mon, 01 Sep 2025 01:43:33
	+0200")
References: <aecb14d84b1af658a87a2b1ba3a49ac13d39560e.camel@physik.fu-berlin.de>
	<20250828130456.2335-1-kernel@mkarcher.dialup.fu-berlin.de>
	<240f0f51687dcb146656a47932ec075b0821b605.camel@physik.fu-berlin.de>
Date: Mon, 01 Sep 2025 09:00:26 +0200
Message-ID: <yddjz2i64j9.fsf@CeBiTec.Uni-Bielefeld.DE>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Adrian,

> in the past, you reported stability issues with the Linux kernel when running
> inside an LDOM on SPARC M7/M8. Could you verify whether the patch above fixes
> these problems or whether at least they don't introduce regressions?

thanks for the heads-up.  Indeed the hangs persist even when the system
is idle.  However, I've never built a Linux kernel before and have way
too much on the plate to try now.  Besides, I don't have a reproducer
for the issue, so even with a patch I'd have to wait for an extended
period of time to see if the issue is gone, so I'll just wait until the
patch lands in the Debian/sparc64 repo and see if it helps.

	Rainer

-- 
-----------------------------------------------------------------------------
Rainer Orth, Center for Biotechnology, Bielefeld University
