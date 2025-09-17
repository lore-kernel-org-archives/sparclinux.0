Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603442F069F;
	Wed, 17 Sep 2025 15:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758124240; cv=none; b=PmNi1j4I0x9lHur6er5YMBGGykehlgjHE86tLQEqfFMgmFEIhOl6pLh7qNYPpFmtye04GzgxUiFVMUmJVturjiJyS0v5xC0ORx0474TfTY4qOz5TDD6/cGnhTwkqHoUsL2mzAv+dL4q4Y/l7ldbpKl5Wot9+bu94uIUFtZLIOWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758124240; c=relaxed/simple;
	bh=p0cL9e+1CI1l0mivxGy3X/fL5f/YaaMWCMYYpGS9RQA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=TYQi6VxIfdkdx0GCIqRWEG3WXbZttORD0ib5KVBmwwDnCjUVwfmRASgVNyAgTcvxIzWwycX2NYohMbbDFiu50pxzFYoAA1RxTQDA361hFA19VVaTnnq1lbi996lodIt6OtVZvMtzaM5NIqAWBaYgrLQrFqKmvQD+CBp5c21FtFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nQdcFHoL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nQdcFHoL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DF64C4CEE7;
	Wed, 17 Sep 2025 15:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758124240;
	bh=p0cL9e+1CI1l0mivxGy3X/fL5f/YaaMWCMYYpGS9RQA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=nQdcFHoLRmrUmJeqTIw9u71kfyLBLDTV88iiwbJIejAW/3C+AXRXYfoXuKfcEpWvg
	 RCBaiINhdDeEOt9UZ3DT2tvhN2zkFjdeaWFJEA1cBpX7em1q1DW4YKSf2tlC1i5UYr
	 8wd0hFN0asAluYAmbcx9jw534P8l/5RCXpApyU1qTE/nA4BkKOhibjlDWg5+Mngt5n
	 QGZGgjY3MUmUP1ClDZgHpoAqmETMpfFmHZwnm1Jx/cgmATVsimNYSp8pEswczaSO2E
	 v4qzOzxkwuNTZJEllijXWZzAVZGHHDj++4xU8cCFkmX8iZ97dejGhgfq1qgtIC08b9
	 G5Unw66MdVZRQ==
Date: Wed, 17 Sep 2025 10:50:38 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-hardening@vger.kernel.org, sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] sparc: PCI: Replace deprecated strcpy() with
 strscpy()
Message-ID: <20250917155038.GA1852582@bhelgaas>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917144733.118553-1-thorsten.blum@linux.dev>

On Wed, Sep 17, 2025 at 04:47:30PM +0200, Thorsten Blum wrote:
> strcpy() is deprecated; use strscpy() instead.
> 
> No functional changes intended.
> 
> Link: https://github.com/KSPP/linux/issues/88
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

No objection from me, but no particular PCI core issue and I don't
maintain this file, so up to the sparc folks if they want it.

I would consider making a single patch to address this issue
everywhere in arch/sparc so it can all be reviewed together.

> ---
>  arch/sparc/kernel/pcic.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/sparc/kernel/pcic.c b/arch/sparc/kernel/pcic.c
> index 25fe0a061732..f894ae79e78a 100644
> --- a/arch/sparc/kernel/pcic.c
> +++ b/arch/sparc/kernel/pcic.c
> @@ -16,6 +16,7 @@
>  #include <linux/init.h>
>  #include <linux/mm.h>
>  #include <linux/slab.h>
> +#include <linux/string.h>
>  #include <linux/jiffies.h>
>  
>  #include <asm/swift.h> /* for cache flushing. */
> @@ -352,7 +353,7 @@ int __init pcic_probe(void)
>  	pbm = &pcic->pbm;
>  	pbm->prom_node = node;
>  	prom_getstring(node, "name", namebuf, 63);  namebuf[63] = 0;
> -	strcpy(pbm->prom_name, namebuf);
> +	strscpy(pbm->prom_name, namebuf);
>  
>  	{
>  		extern int pcic_nmi_trap_patch[4];
> @@ -477,7 +478,7 @@ static void pcic_map_pci_device(struct linux_pcic *pcic,
>  	int j;
>  
>  	if (node == 0 || node == -1) {
> -		strcpy(namebuf, "???");
> +		strscpy(namebuf, "???");
>  	} else {
>  		prom_getstring(node, "name", namebuf, 63); namebuf[63] = 0;
>  	}
> @@ -536,7 +537,7 @@ pcic_fill_irq(struct linux_pcic *pcic, struct pci_dev *dev, int node)
>  	char namebuf[64];
>  
>  	if (node == 0 || node == -1) {
> -		strcpy(namebuf, "???");
> +		strscpy(namebuf, "???");
>  	} else {
>  		prom_getstring(node, "name", namebuf, sizeof(namebuf));
>  	}
> -- 
> 2.51.0
> 
