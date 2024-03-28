Received: from mailrelay5-1.pub.mailoutpod3-cph3.one.com (mailrelay5-1.pub.mailoutpod3-cph3.one.com [46.30.211.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8425623765
	for <sparclinux@vger.kernel.org>; Thu, 28 Mar 2024 07:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.211.244
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711610719; cv=none; b=VOufxGuno77FnggwwWvqanilranyNeiVlgUup/jy54YXjHqtggTVCwnq2t+kuOb2zIMGSvrdf+jDyyNBZXFN0VLGC48YWSoIoEkbSmW5O7ftQTLOKPFL13wLp/XptfMYaqwHvE9+J8yF+q8Nfqt/Z3nyZsMG6l6q8tRKt8yx0lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711610719; c=relaxed/simple;
	bh=5ouWhom1WgEvr+UIkAhFMpNB+A6ib/M6M2/Q60VF/0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YDfitdWRGE+fPXOgxsueQGlQLey8MV16hzowo3DQrN250gBEqhboMmJ8tFkr0hsKUjPdOZ211zuJEBKZhkTtgOV8A12ywOVhL9yCTAuH1Fc8rUEG++aMnabovbRPIR1sbjXtjvHFcNpouLm1+eWcFI1boU1Y4SYjgdIOkVIadK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org; spf=none smtp.mailfrom=ravnborg.org; dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=FO3avDbt; dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=tWmWJ3ND; arc=none smtp.client-ip=46.30.211.244
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="FO3avDbt";
	dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="tWmWJ3ND"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=rsa2;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=dyKv5n7Yl7LRdH+1tEzFGNQHD1DRdGd99PJrS6/p+zs=;
	b=FO3avDbtCVJhZmbtPb25Z7M92okwL42Lwzwk0Xt1eFKNFfW85ebYPD1a4Iz7nbfQa1BVxuB2fck3t
	 dV01QiC6wivs5sf4FR4Dwcj/7zxIoo8LiqS5TizyDmf/zwISEz8XHoo+q0YBAqS+W/jFG4FUQ44kvh
	 t0uaYwTBtz7fuc9aKHnSrFR3GY32xONVYLJIM0g3hDiXwbLR9BD/o3eEuUuj3l3UwYm6F6muVvvj3L
	 eaFcKcGJK55ShMf9yqSyFAGh9is77eUJyw3RtIOaPW++JhkBvC7HK4Ge1s3CMNfQOfP48o4EmSO883
	 mKHiYwbBSpWF7oBq3uTpz9wEoyMQoiA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=ed2;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=dyKv5n7Yl7LRdH+1tEzFGNQHD1DRdGd99PJrS6/p+zs=;
	b=tWmWJ3NDZTn8BTwQyoXUT6BJQOWPfdg24c2VPAtEdn8oRObE4JrU9XMtFz3jWr/w4xs53mowsZ7/3
	 oWNGr4OCg==
X-HalOne-ID: 4ddcab29-ecd4-11ee-9a1b-9fce02cdf4bb
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
	by mailrelay5.pub.mailoutpod3-cph3.one.com (Halon) with ESMTPSA
	id 4ddcab29-ecd4-11ee-9a1b-9fce02cdf4bb;
	Thu, 28 Mar 2024 07:25:09 +0000 (UTC)
Date: Thu, 28 Mar 2024 08:25:07 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: arnd@arndb.de, javierm@redhat.com, deller@gmx.de,
	sui.jingfeng@linux.dev, linux-arch@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-sh@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-parisc@vger.kernel.org,
	linux-mips@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	loongarch@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 2/3] arch: Remove struct fb_info from video helpers
Message-ID: <20240328072507.GC1573630@ravnborg.org>
References: <20240327204450.14914-1-tzimmermann@suse.de>
 <20240327204450.14914-3-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327204450.14914-3-tzimmermann@suse.de>

Hi Thomas,
On Wed, Mar 27, 2024 at 09:41:30PM +0100, Thomas Zimmermann wrote:
> The per-architecture video helpers do not depend on struct fb_info
> or anything else from fbdev. Remove it from the interface and replace
> fb_is_primary_device() with video_is_primary_device(). The new helper
> is similar in functionality, but can operate on non-fbdev devices.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
> Cc: Helge Deller <deller@gmx.de>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Andreas Larsson <andreas@gaisler.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: x86@kernel.org
> Cc: "H. Peter Anvin" <hpa@zytor.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
