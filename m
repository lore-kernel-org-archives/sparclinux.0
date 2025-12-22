Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD63244692;
	Mon, 22 Dec 2025 07:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766388984; cv=none; b=CNrDwIRrOny3d2Ct6dQ9zxE1YBgllhpmSKuBGwsggJ5CtsEYLzo2Ky5WfuGBOBgXujutEXUNwWXg4g5T270SVnr1bdnH3XeEt5V1gr2+X7sfy+ptmqMpXZrwsNZzHRnaTDiAA5naflQcpCr+RDvKeuUpW6GauxWusFKxIYN/9pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766388984; c=relaxed/simple;
	bh=GVYB53SRj+Yh6/WHbilonRbNAH4T3bD5gXKgIKHZQCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MpgHO2iyeUKThwumSUSkNxafgdhhCxhbRN4SwpwFHv9Y55/1lYW4FL1LHvxMmLRSxOZEan18HMZ6CIGblar670ZHRtubeifgfCm+rONoRGjTiM3smmaya2TZLPfAtJybt3phztdHgiJclZvodW6Hd9Tjm1A4GOA/w3/qOh9L2Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TbpNcQuP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tUAdzH1o; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TbpNcQuP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tUAdzH1o"
Date: Mon, 22 Dec 2025 08:36:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1766388973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2uZTM70BkzNxiOTuai075PcNDDD8Kpj/7sBTwUT6PA4=;
	b=TbpNcQuPcNWmXc2j3XGdvueFW+3Sn7300J9VwSPY3h6KSZJrd8imK2eUSziZISJQ8SfQoD
	pdtzdEj1WFP+e+Zq2fDSh3JNVQoTvAasvqmxzF2rIXlsCwSwvV6PyC/U3Od85MrnonoNQs
	6KF0aAiK0RnGwC+AWs2mv6EJsS7gD/Ezd75BYcysB0pwI9zYYY4of1xfUpPLQKlJ1Bybpm
	gOvOlTxrMT1IFhYwtE4b7DK+/zUDQiC8Bnfd0UiXMzUulg/+bTKk7wUJgKhQOhNvpgfeVx
	zOpcLPNaPUR8uY94vIQ7Qepk/YsRe0+JrrZYMRp3aUYY3+GRWqataiV+M1wTXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1766388973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2uZTM70BkzNxiOTuai075PcNDDD8Kpj/7sBTwUT6PA4=;
	b=tUAdzH1oWSrSmesEKTXfkrbA4kMUFbORNwFDFJh0ssyyVz44Ja1Q1ycOxUzs56qVkXiN+e
	mZVWLXYARVwN4pCw==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, sparclinux@vger.kernel.org
Subject: Re: [PATCH] sparc/vdso: add missing prototypes
Message-ID: <20251222083340-159edb10-2209-40af-9d7d-8959ac485a07@linutronix.de>
References: <20251209050332.881348-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251209050332.881348-1-rdunlap@infradead.org>

Hi Randy,

On Mon, Dec 08, 2025 at 09:03:32PM -0800, Randy Dunlap wrote:
> On sparc64, when CONFIG_WERROR=y, there are a few missing-prototype
> build errors. Fix them.
> 
> Add the 4 missing prototypes to <asm/vdso.h> and include that header
> file in vclock_gettime.c.
> 
> Fixes these build errors:
> In file included from ../arch/sparc/vdso/vdso32/vclock_gettime.c:22:
> ../arch/sparc/vdso/vdso32/../vclock_gettime.c:274:1: error: no previous
>  prototype for '__vdso_clock_gettime' [-Werror=missing-prototypes]
> ../arch/sparc/vdso/vdso32/../vclock_gettime.c:302:1: error: no previous
>  prototype for '__vdso_clock_gettime_stick' [-Werror=missing-prototypes]
> ../arch/sparc/vdso/vdso32/../vclock_gettime.c:327:1: error: no previous
>  prototype for '__vdso_gettimeofday' [-Werror=missing-prototypes]
> ../arch/sparc/vdso/vdso32/../vclock_gettime.c:363:1: error: no previous
>  prototype for '__vdso_gettimeofday_stick' [-Werror=missing-prototypes]

This issue would also be fixed by my patch series adopting the generic
vDSO library on SPARC [0].
Picking up your patch would introduce conflicts.

[0] https://lore.kernel.org/lkml/20251106-vdso-sparc64-generic-2-v5-0-97ff2b6542f7@linutronix.de/


Thomas
