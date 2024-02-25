Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4BEE10E4;
	Sun, 25 Feb 2024 00:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708822668; cv=none; b=SxfBUTFNd9u9teRd2r9oIUPNiBvK8FFpJFmmsMuuxuW1PEvEIZmSFVF/IqD73nuGjDw32jXnuXwo4lCwuo/u3bdN99fbk4em1GXJhDT7DToZlTiNqrhkVP2Y6evD0cM28VkHHhh1I9EvEhfoCbeso9LNwYKMd2ysEEkiesKSJzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708822668; c=relaxed/simple;
	bh=ioMTznDwM8Bf83NeluICXPdCkl4fF07yGYnYlYsOynU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=jDAlyiH1+lZsCfVeX5BFkUb5RRs3JHnA4gnwHCSig8opPn/CqT7KYepkfJibT+gvmYoJIwoEb969+AjRUzj2t2Zzz/xSt7fSrTwq6xkMr/fF1cBBeKU/ii15vKAJGwRFizZS2hXFp9u37q4qeaWspRVjxUC6ZJhI5b9JQKqp3nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 9A11892009C; Sun, 25 Feb 2024 01:57:42 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 92FD092009B;
	Sun, 25 Feb 2024 00:57:42 +0000 (GMT)
Date: Sun, 25 Feb 2024 00:57:42 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Sam Ravnborg <sam@ravnborg.org>
cc: sparclinux@vger.kernel.org, Andreas Larsson <andreas@gaisler.com>, 
    Randy Dunlap <rdunlap@infradead.org>, 
    Miquel Raynal <miquel.raynal@bootlin.com>, 
    linux-parport@lists.infradead.org, "David S. Miller" <davem@davemloft.net>, 
    Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/7] sparc32: Do not select ZONE_DMA
In-Reply-To: <20240224-sam-fix-sparc32-all-builds-v2-4-1f186603c5c4@ravnborg.org>
Message-ID: <alpine.DEB.2.21.2402250054030.36563@angie.orcam.me.uk>
References: <20240224-sam-fix-sparc32-all-builds-v2-0-1f186603c5c4@ravnborg.org> <20240224-sam-fix-sparc32-all-builds-v2-4-1f186603c5c4@ravnborg.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sat, 24 Feb 2024, Sam Ravnborg via B4 Relay wrote:

> sparc32 has no limited DMA zone so there is no need to select ZONE_DMA.
> 
> Based on analysis from Marciej:

 Can you please use the correct spelling of my name in change descriptions 
(and preferably everywhere)?  Thank you.

  Maciej
