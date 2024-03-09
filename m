Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6EF37142;
	Sat,  9 Mar 2024 09:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709975212; cv=none; b=UBVNbF7THMiPj7hdX4qco19BHV+2Goh68uFsaUdxyXj61AH6OixAUYjMRgE2Hr35NUZboxiLWT2noGLfn05AG27Xn/XFLGWVaLdZWObdKL5EoXCAdCOMETAacuxKFRHZuERTgs6xl6bY6XihEjSo98IE6h4zXw4m3wFP0kEWaX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709975212; c=relaxed/simple;
	bh=iFRdAp9jM3cl8aHzi7jFe79tLZ+9tKqQtxSZAuGYclY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=WC23aRP7cwlIWI/ij0VUlJn1F6yP+Oa/mo3mG+Xzlxx/sgyMcCvVpXIvfAxYm6owrKWMiPXEiBXW+Gii6Pjct0ZCFLUeHmOADrrUN/krHLMYWhhVX5c0l76qaljaUDXUyqBRfsmEIOm+uLjvahiFzbt560wRZUcNJJyKSDSFhK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 96CDD92009C; Sat,  9 Mar 2024 10:06:47 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 9393992009B;
	Sat,  9 Mar 2024 09:06:47 +0000 (GMT)
Date: Sat, 9 Mar 2024 09:06:47 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Andreas Larsson <andreas@gaisler.com>
cc: sam@ravnborg.org, sparclinux@vger.kernel.org, 
    Randy Dunlap <rdunlap@infradead.org>, 
    Miquel Raynal <miquel.raynal@bootlin.com>, 
    linux-parport@lists.infradead.org, "David S. Miller" <davem@davemloft.net>, 
    Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, 
    stable@vger.kernel.org
Subject: Re: [PATCH v2 6/7] sparc32: Fix parport build with sparc32
In-Reply-To: <8123d73f-1e65-4e3b-870d-044df0d38c76@gaisler.com>
Message-ID: <alpine.DEB.2.21.2403090906240.16468@angie.orcam.me.uk>
References: <20240224-sam-fix-sparc32-all-builds-v2-0-1f186603c5c4@ravnborg.org> <20240224-sam-fix-sparc32-all-builds-v2-6-1f186603c5c4@ravnborg.org> <8123d73f-1e65-4e3b-870d-044df0d38c76@gaisler.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 8 Mar 2024, Andreas Larsson wrote:

> > include/asm/parport.h is sparc64 specific.
> > Rename it to parport_64.h and use the generic version for sparc32.
> > 
> > This fixed all{mod,yes}config build errors like:
> > 
> > parport_pc.c:(.text):undefined-reference-to-ebus_dma_enable
> > parport_pc.c:(.text):undefined-reference-to-ebus_dma_irq_enable
> > parport_pc.c:(.text):undefined-reference-to-ebus_dma_register
> > 
> > The errors occur as the sparc32 build references sparc64 symbols.
> > 
> > Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: Andreas Larsson <andreas@gaisler.com>
> > Cc: Randy Dunlap <rdunlap@infradead.org>
> > Cc: Maciej W. Rozycki <macro@orcam.me.uk>
> > Closes: https://lore.kernel.org/r/20230406160548.25721-1-rdunlap@infradead.org/
> > Fixes: 66bcd06099bb ("parport_pc: Also enable driver for PCI systems")
> > Cc: stable@vger.kernel.org # v5.18+
> > ---
> >  arch/sparc/include/asm/parport.h    | 259 +-----------------------------------
> >  arch/sparc/include/asm/parport_64.h | 256 +++++++++++++++++++++++++++++++++++
> >  2 files changed, 263 insertions(+), 252 deletions(-)
> 
> Reviewed-by: Andreas Larsson <andreas@gaisler.com>

Reviewed-by: Maciej W. Rozycki <macro@orcam.me.uk>
Tested-by: Maciej W. Rozycki <macro@orcam.me.uk> # build-tested

  Maciej
