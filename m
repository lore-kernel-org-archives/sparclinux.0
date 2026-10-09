Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F77D2E738B;
	Fri,  9 Oct 2026 01:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791508403; cv=none; b=W2LfpjzrRu3aEZriKRSd85oMRSOp0kOP6K5ArCb/oKEALfNayh2Phi+IiCGrXJIHNyauXlxvp8gLbeagoClg5o3/0L1tlqQCeuXNpzMYLL5JWuPqsJv3TF6IagLipgeIkfPrXBLthP158Wz5HoHr8CFPqUnr0hcFNgAZGH46IxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791508403; c=relaxed/simple;
	bh=r9anZZ9RVSXqBbTuq+fpzVX2SmzUPjuecPmKS9s7dWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uygEDQOjuMZUVJ2hdYxe1FRqUObOTvsUiOmg537z4AP3ObS4wILdSRv9Lhu/22+JXSraItrW30BnYw7uVFXim1CYTEt/4bIHCBhAhwndoHHUILbYWzhtc3+/pcieVQ6EXAr74nUB1LfKXOwOhfAyUNq9zLX4fWmW9uTK0I7wrqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=oChc2+sH; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="oChc2+sH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=/FGRBMXMbhN2koUceaUJ7F1sDiwsDaXu8C6c3BEK1xk=; b=oChc2+sHr4SjEX6L+QNaUyi/sB
	exrUl3UdyvAIDx0wvrn7SUqVwFfe/R1X6dMdFbDrvrRP+zvgpgobLIzwIpjcH/rvkvjDdU2T3kr2N
	gTFXSTMyo7qSiCmcm7ao8l2J5n7aPvIV8VpTLQkmh+EupQx9TEfOZ8C71xBBcSJL4W78=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xEzAe-009i9m-BC; Fri, 09 Oct 2026 03:13:12 +0200
Date: Fri, 9 Oct 2026 03:13:12 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Magnus Lindholm <linmag7@gmail.com>
Cc: pavan.chebbi@broadcom.com, mchan@broadcom.com, andrew+netdev@lunn.ch,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] tg3: normalize inherited M3000 register byte
 order
Message-ID: <038bffb2-e40d-44bb-b7ce-53e9de32e50d@lunn.ch>
References: <20261008220433.965791-1-linmag7@gmail.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261008220433.965791-1-linmag7@gmail.com>

On Fri, Oct 09, 2026 at 12:04:03AM +0200, Magnus Lindholm wrote:
> M3000 firmware can leave BCM5718 vendor registers byte-swapped while
> standard PCI fields retain normal byte order. Match the Fujitsu 10cf:165a
> subsystem, IKKAKU model and swapped revision/product signature before
> restoring host control; reject failed PCI accesses or register readbacks.
> 
> Keep this in probe so failures can abort initialization; SPARC firmware
> enumeration skips PCI_FIXUP_EARLY. Normal rebinds and other platforms
> retain their existing path.
> 
> Use tg3.h's MISC_HOST_CTRL_BYTE_SWAP and TG3PCI_GEN2_PRODID_ASICREV;
> the inherited state was observed on M3000 hardware.
> 
> Signed-off-by: Magnus Lindholm <linmag7@gmail.com>

> +/* M3000 firmware can leave the on-board BCM5718 registers byte-swapped. */
> +static bool tg3_is_m3000(struct pci_dev *pdev)
> +{
> +	struct device_node *root;
> +	const char *model;
> +	bool match;
> +
> +	if (pdev->vendor != PCI_VENDOR_ID_BROADCOM ||
> +	    pdev->device != TG3PCI_DEVICE_TIGON3_5718 ||
> +	    pdev->subsystem_vendor != 0x10cf ||
> +	    pdev->subsystem_device != 0x165a)
> +		return false;
> +
> +	root = of_find_node_by_path("/");
> +	match = !of_property_read_string(root, "model", &model) &&
> +		!strcmp(model, "IKKAKU");

The DT Maintainers generally don't like this.

Is there a legitimate reason you would want the bytes are swapped?

Can you not just probe the registers, and if they are swapped undo it?
Does it really need to be conditional on the machine?

	Andrew
