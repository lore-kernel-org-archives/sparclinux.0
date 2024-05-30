Received: from mailrelay6-1.pub.mailoutpod3-cph3.one.com (mailrelay6-1.pub.mailoutpod3-cph3.one.com [46.30.211.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D274D8DA
	for <sparclinux@vger.kernel.org>; Thu, 30 May 2024 20:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.211.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717100914; cv=none; b=tibd+iOzCtF18tvrWxKVDUw13rjOEfc05EYM4Ad24kq+MVE5jc9yhmAFycwmV9rXPsBjbM7cgkG80+lHzK0u1yIvGIcvYucsipfpGcbNBlcs3ziTgAVCVe300roY+mOrxQjeQOED9AQXfQIezqkwmDhsydWZtnnYLVo+RYEbLAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717100914; c=relaxed/simple;
	bh=J4KBa91vTwvjKyQ32cxhENIxuhAvRMoEF4xMj9S4DD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F3CGedBKtSaDEnFRaDXs58Bz+30Bs5/NhmnMK4GupqTUXL552wTUQh5nEJ6jNN5ywIbyH9zsp87jQlXW2j2+dEtNaH29BRB7CaDkXlR9DZZb2ZGyS5EBSKrLb7X9xMNSgTS3BwTxbo9YfIyunCb1Ii42insEESBaO8k8Bf9G0N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org; spf=none smtp.mailfrom=ravnborg.org; dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=iISsR6bi; dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=npM9s9pq; arc=none smtp.client-ip=46.30.211.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="iISsR6bi";
	dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="npM9s9pq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=rsa1;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=A9v8zIG2nO6qcSOd8DMaTxsgywGvI2zqZhB8aRF0VXo=;
	b=iISsR6biyfqy471hHRm4DcrNBvLRjGn6Rrlbq3LLjWeWegmckdRQ7ry1JBB7Vj7a6C608YKq/4gzV
	 GhnTDBMWdJX3H7ZbtPcaCyYrLeKyvl4dj9vcUVowseqybeN4TSAnIKs//2e79NYPYpRroXOO5oRcwC
	 Km9d9jNyeLezx+BYjNQ+OUhWvuG4imtAS7XUnu/P1cAo9lAzSk7R26jbq6aFBW71lXThwYMBA+tnxE
	 FQJH2zDbVfopF8YvDr5wVZWjShv0YNUQK82VrCOtJSKQtHcIAmweEydYnJqZAPnJyekswHejAN5FWd
	 t5Vi+dSBIiahJZHVGGbgur6q+eZnfPg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=ed1;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=A9v8zIG2nO6qcSOd8DMaTxsgywGvI2zqZhB8aRF0VXo=;
	b=npM9s9pqoihScimHGnN8anoeoASHuow7Z4UzFsgkJiRkYLCiikfF/CQiv3D5PdqbVNi9OYlVZjlHX
	 Kj6jhpyDQ==
X-HalOne-ID: 03b25ac3-1ec3-11ef-bda0-83bcbd00a978
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
	by mailrelay6.pub.mailoutpod3-cph3.one.com (Halon) with ESMTPSA
	id 03b25ac3-1ec3-11ef-bda0-83bcbd00a978;
	Thu, 30 May 2024 20:27:21 +0000 (UTC)
Date: Thu, 30 May 2024 22:27:20 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Saravana Kannan <saravanak@google.com>,
	Andreas Larsson <andreas@gaisler.com>, sparclinux@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] of: WARN on using default root node
 #address-cells/#size-cells
Message-ID: <20240530202720.GA1656150@ravnborg.org>
References: <20240530185049.2851617-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530185049.2851617-1-robh@kernel.org>

Hi Rob.

On Thu, May 30, 2024 at 01:50:48PM -0500, Rob Herring (Arm) wrote:
> While OpenFirmware originally allowed default values of #address-cells
> and #size-cells, FDT has long required explicit values. It's been a
> warning in dtc for the root node since the beginning (2005) and for
> any parent node since 2007. Of course, not all FDT uses dtc, but that
> should be the majority by far. The various extracted OF devicetrees I
> have dating back to the 1990s (various PowerMac, OLPC, PASemi Nemo)
> all have explicit root node properties.
> 
> I have no idea what exists for Sparc, so disabling the warning for it.
> If any other platforms hit the warning, then the warning can be
> disabled for them.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
> Sparc folks, If anyone can dump DTs from some Sparc systems it would be
> helpful.

For sparc the format looks much different - see:
git://git.kernel.org/pub/scm/linux/kernel/git/davem/prtconfs.git

This is dumps from the prtconf tool found in Solaris.

Looking at for example t1000 it looks like #size-cells, #address-cells
are used properly.

Looking at the older ss20 I see no use of these.
Looking at sb100 (old sparc64 machine) I see inconsistent use.

My best guess is that sparc32 machines see little to no use of them.
sparc64 use them, but on older machines the usage is inconsistent.

	Sam
