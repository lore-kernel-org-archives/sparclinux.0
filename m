Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC014734F7;
	Fri,  2 Oct 2026 10:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.121.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790936566; cv=none; b=b9mSidEmQPvD9mB2gpdCWlHEKz0aQm16epwDZbENt1UaFfMggtMVztvNFCFSgTDXzsx0D3jJsDgijajffOs2zNFXLHToBZVClA6v2Wd6PgVEz8u4F0d51MpduSxK6Co7w7n8mqXHtlfj3gWVM1QC1TDV0qB3ecnuwHCISrVp+LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790936566; c=relaxed/simple;
	bh=IDalTpX2GPRnxBFjUjzWmxvbVySxHHYQmxTHHq2csW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YiBTOXkpNTcXVrHvtQriPN0S6btX0ckDH7ODnq35T/ypP+ADEEmarub6Dzs9Gan+6ipB1a1JcCBtjFf96yFCjOI5TX8fic6gxbnRCUP/DudB/slUwxx93IW2mgnw39WkjVkTAPIrZCp//6WLBCQi4M8yRdsfPAX3iQTzf+iv7oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no; spf=pass smtp.mailfrom=itx.no; dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b=E9uY+epL; arc=none smtp.client-ip=91.189.121.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b="E9uY+epL"
From: Stian Halseth <stian@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1790936561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IDalTpX2GPRnxBFjUjzWmxvbVySxHHYQmxTHHq2csW8=;
	b=E9uY+epLrsp75dy4fcGZO0ESWEnzv9bdWgLSo7UOziJQdYzymlZ7QyFHyWnkNPiIDWQpkK
	9c7/Pi2kzicJ+js918GsmiSCNevn099dMEVU9zxj8uNl/PpPd18j157RnftOKLYIxK3Oo8
	w5CzubeLTWtkykTA4j0MXc7fMIYH+iU=
To: Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: Imre Kaloz <kaloz@kernel.org>,
	Andreas Larsson <andreas@gaisler.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sparclinux@vger.kernel.org,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mips@vger.kernel.org
Subject: Re: [PATCH] PCI/MSI: Clear msi_desc::irq in the legacy teardown path
Date: Fri,  2 Oct 2026 12:22:31 +0200
Message-ID: <20261002102231.1635173-1-stian@itx.no>
In-Reply-To: <20260929111003.3707239-1-stian@itx.no>
References: <20260929111003.3707239-1-stian@itx.no>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Please drop this patch. Imre posted a fix for the same leak two days
earlier, in the sparc teardown:

https://lore.kernel.org/all/20260927105515.8701-1-kaloz@kernel.org/

The Fixes: tag here is also wrong. Until 2f2940d16823 ("genirq/msi:
Remove filter from msi_free_descs_free_range()") msi_free_msi_descs()
freed every descriptor, associated or not, so the leak starts there,
as Imre's patch says.

Stian
