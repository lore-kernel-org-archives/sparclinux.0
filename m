Received: from smtp.CeBiTec.Uni-Bielefeld.DE (smtp.CeBiTec.Uni-Bielefeld.DE [129.70.160.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59BB13A244;
	Mon,  1 Sep 2025 14:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.70.160.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756736305; cv=none; b=PPdCHPxC5FAmSTaT7S+l/lrqTQtzdSqjSwIW07WbE7+n8iN2WijZ0tjtdgz0C+XRPUA5HZB+UQc17lMi7Ydf48emgRWovHlvQ361Sriplcx36uFSXTktmjHwNJzHxq/mpGGuEMIKSz4lo9pkTXH4lOOrzjdsahJ+8iwq71N2rP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756736305; c=relaxed/simple;
	bh=HX0WaoTrp/btXeyLMGnRU3Iygy+Fmu4W+bVNct25BOw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AWoXDdtxQbvkP7EWxwiURQrwvxx6yvPJwPZzVHJcoCUtqqgKlb0/I4WqHHU/vJTlT+uMl3vuwbC1/M0W17vn+ml8laG1uQ/UATHLTLmz+waPUnDDQ6eabKeI4nkmNOOX+9iL6VVf6SoFExinhz7RCqtfRa3Uc8zwOi3kvmBngQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=CeBiTec.Uni-Bielefeld.DE; spf=pass smtp.mailfrom=cebitec.uni-bielefeld.de; dkim=pass (2048-bit key) header.d=cebitec.uni-bielefeld.de header.i=@cebitec.uni-bielefeld.de header.b=BciIhNQn; arc=none smtp.client-ip=129.70.160.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=CeBiTec.Uni-Bielefeld.DE
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cebitec.uni-bielefeld.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cebitec.uni-bielefeld.de header.i=@cebitec.uni-bielefeld.de header.b="BciIhNQn"
Received: from localhost (localhost.CeBiTec.Uni-Bielefeld.DE [127.0.0.1])
	by smtp.CeBiTec.Uni-Bielefeld.DE (Postfix) with ESMTP id 18B7AB9F5A;
	Mon,  1 Sep 2025 16:18:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	cebitec.uni-bielefeld.de; h=content-type:content-type
	:mime-version:user-agent:message-id:date:date:references
	:in-reply-to:subject:subject:from:from:received:received; s=
	20200306; t=1756736295; bh=HX0WaoTrp/btXeyLMGnRU3Iygy+Fmu4W+bVNc
	t25BOw=; b=BciIhNQnsGZQDzRfm2d0hPML6v/WYZf4DZH9v9bm02hicCUfD5Nv4
	0yvZtymdEDxgkeSmhZvHVMlIgFgb1Qb5tdlUFfyu59qWbVkPdtWvzayA8p5EZ3/l
	CEgPWO4VfszOyKDn+d/i+4By7CtSwGlZPAj7y/z47kvoBCgWgPhvK62RQ+YBjTh4
	Rna7o8EK5QyJkjTt1bYEjOBpBVRhst9mKS3XgdIu9xjtw1gY5BD/orMt2tiNHzeL
	zGDbW8vs7fQ+NVXvu6GYKg/s4YVbpeqaKX2nv/ASPF++cdMWjwxlGp2r/oqxoWSL
	vlC9v6ACiTSrT2vWNKvZjl2UYbRmPrwuQ==
X-Virus-Scanned: amavisd-new at cebitec.uni-bielefeld.de
Received: from smtp.CeBiTec.Uni-Bielefeld.DE ([127.0.0.1])
	by localhost (smtp.cebitec.uni-bielefeld.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id SY2vdEiCoxuz; Mon,  1 Sep 2025 16:18:15 +0200 (CEST)
Received: from manam.CeBiTec.Uni-Bielefeld.DE (p50854244.dip0.t-ipconnect.de [80.133.66.68])
	(Authenticated sender: ro)
	by smtp.CeBiTec.Uni-Bielefeld.DE (Postfix) with ESMTPSA id 3A00DB9F59;
	Mon,  1 Sep 2025 16:18:15 +0200 (CEST)
From: Rainer Orth <ro@CeBiTec.Uni-Bielefeld.DE>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>,
  linux-kernel@vger.kernel.org,  sparclinux@vger.kernel.org,  Andreas
 Larsson <andreas@gaisler.com>,  Anthony Yznaga <anthony.yznaga@oracle.com>
Subject: Re: [PATCH v2 1/1] sparc: fix accurate exception reporting in
 copy_{from,to}_user for M7
In-Reply-To: <4c92d08cff24c04023bff8555ecf3bbd2eb0e944.camel@physik.fu-berlin.de>
	(John Paul Adrian Glaubitz's message of "Mon, 01 Sep 2025 09:05:58
	+0200")
References: <aecb14d84b1af658a87a2b1ba3a49ac13d39560e.camel@physik.fu-berlin.de>
	<20250828130456.2335-1-kernel@mkarcher.dialup.fu-berlin.de>
	<240f0f51687dcb146656a47932ec075b0821b605.camel@physik.fu-berlin.de>
	<yddjz2i64j9.fsf@CeBiTec.Uni-Bielefeld.DE>
	<4c92d08cff24c04023bff8555ecf3bbd2eb0e944.camel@physik.fu-berlin.de>
Date: Mon, 01 Sep 2025 16:18:14 +0200
Message-ID: <ydd4itm45p5.fsf@CeBiTec.Uni-Bielefeld.DE>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Adrian,

> On Mon, 2025-09-01 at 09:00 +0200, Rainer Orth wrote:
>> > in the past, you reported stability issues with the Linux kernel when running
>> > inside an LDOM on SPARC M7/M8. Could you verify whether the patch above fixes
>> > these problems or whether at least they don't introduce regressions?
>> 
>> thanks for the heads-up.  Indeed the hangs persist even when the system
>> is idle.  However, I've never built a Linux kernel before and have way
>> too much on the plate to try now.  Besides, I don't have a reproducer
>> for the issue, so even with a patch I'd have to wait for an extended
>> period of time to see if the issue is gone, so I'll just wait until the
>> patch lands in the Debian/sparc64 repo and see if it helps.
>
> Would it work if I built a kernel for you plus installation instructions
> and a quick explanation how to test it?

I wouldn't mind trying, but as I said it's difficult to say when I can
claim success given the lack of a reproducer.  All I can report reliably
is failure ;-)

> FWIW, we consider the patch already acceptable when it doesn't introduce
> any regressions.
>
> I did some testing on a SPARC S7 yesterday, but the problem is that the
> support for SPARC S7 in the Linux kernel is incomplete at the moment and
> I had to add it quickly myself which did actually work but I really would
> like to verify it on M7 or M8 again to at least not cause regressions.

The only system that I can test on is S7 (a Netra S7-2 actually).  While
I also have a T8-1, that's reserved for cfarm work.

	Rainer

-- 
-----------------------------------------------------------------------------
Rainer Orth, Center for Biotechnology, Bielefeld University
