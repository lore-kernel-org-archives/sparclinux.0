From: David Miller <davem@davemloft.net>
Date: Mon, 26 Jul 2010 22:48:54 +0000
Subject: Re: [PATCH v3] of: Create asm-generic/of.h and provide default
Message-Id: <20100726.154854.35052662.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100726220405.1550.63442.stgit@angua>
	<20100726222627.GA23501@merkur.ravnborg.org>
	<AANLkTikcV3jJUm_My-oK-drudSDz3M2iH1cWhxdt+W1s@mail.gmail.com>
In-Reply-To: <AANLkTikcV3jJUm_My-oK-drudSDz3M2iH1cWhxdt+W1s-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org
Cc: sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org, microblaze-uclinux-rVRm/Wmeqae7NGdpmJTKYQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org

From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 26 Jul 2010 16:42:20 -0600

> It protects against some later include file doing a #define
> of_node_to_nid and thus resulting in an inconsistent definition.  If
> some code tries to do this then the preprocessor will complain.  This
> is the pattern that Stephen suggested.

Also, it would be nice to unravel the "0" vs. "-1" default
inconsistency.
