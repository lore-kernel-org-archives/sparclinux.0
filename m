Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.166
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792684154;
	b=itTD3u7nr0fy1fV46ViIIdmUPykxUVsTn2yp47JghHtu+RPzu8sHScGz7NBFGELTCu8y
	 acVPm9Mf6OoIRYJuEqgyFClq5vQGv6FnE0US3j13vP/nJQKmaBvoOciNUCbqU0Mm4su+p
	 2QGkW7NVkHBGwqexoSho0yEEDcUV/LdjWVYDL/T4VsAoVudM5B/x9J08NHwy+DOpAg14l
	 rCu62HU29Nhtfs9dU+fh6XvhpSxog3RK8OrxidBoFgAihQn5yad5X7IZA1hI6Dn22HVEN
	 SiOxkC+92SzQ/Up5fbXoAWV01UkVCHGgvOMv3g2Qdngy+XGZTdA4133YpDdyby/UX5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792684154;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:In-Reply-To:
	 References:User-Agent:Date:Message-ID:MIME-Version:Content-Type;
	bh=fT8Ya1Op87GUrpK4YMhzZpBMHsNUcdW4n48pCvXCzHQ=;
	b=wDJIRJh7HQ4K7JSzMZ2LsHVz4MPrQL+195Powr3olHcwv3Pi3zkkYBO9g24VmdYxc2pv
	 hyuRXHbHgx3PXmG6dCqLRx6UK7vATWm5Eu672D/U/5MKaPA3rEHPekDuIEa1ASKiW7vMs
	 6IbHk4IN3HcjTSAVd5bqNIc5vpG+2bzVil2URt/CLh7lfydQZ7tHfft+sGha5nmll+/Ih
	 LbVYegLBQ9VPth9u/5jHDUN9nR6pjeAxy2odwCJXWqFNYib7dACHrQmK8eJLysO7/C0ms
	 DXVKtNADRx9hzpT5y3LGNeCwmlZD0WsswT9n1S960+vvx5Alpord1X4nNlsN/rdEY2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=gm0QHVFv;
	arc=none smtp.remote-ip=91.218.175.166
Received: from mta0.migadu.com (out-166.mta0.migadu.com [91.218.175.166])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2C6606A31B
	for <sparclinux@vger.kernel.org>; Thu, 22 Oct 2026 15:49:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D2C6606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=gm0QHVFv
X-Envelope-To: sparclinux@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=fT8Ya1Op87GUrpK4YMhzZpBMHsNUcdW4n48pCvXCzHQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792684151; v=1; x=1793288951;
 b=gm0QHVFv6pqEbyGAJYdWYBPG/owToPsM3u5iAS5nrm6+JOYVEjaF2YlaZvcfj9y0lwWPNOdU
 a5zrlbI8YCVvJDli6aln7A09ACXf0LKNGpVVBtFoShCu8NB5Z0isTxIPhcdrn+xiyemyVga/PE/
 UgkzVuRn5V8fsjks+8vtEN5k=
X-Envelope-To: sparclinux@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 7cc6c7ca1ef52428;
	Thu, 22 Oct 2026 15:49:11 +0000
X-Mizu-Trace-ID: 7cc6c7ca1ef52428
X-Migadu-Flow: FLOW_OUT
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Andreas Larsson <andreas@gaisler.com>
Cc: sashiko@lists.linux.dev,  sparclinux@vger.kernel.org
Subject: Re: Enabling Sashiko reviews for sparclinux mailing list
In-Reply-To: <a08430ed-9e39-456d-8863-3fa478368134@gaisler.com> (Andreas
	Larsson's message of "Thu, 22 Oct 2026 16:54:16 +0200")
References: <a08430ed-9e39-456d-8863-3fa478368134@gaisler.com>
User-Agent: mu4e 1.12.15; emacs 30.2
Date: Thu, 22 Oct 2026 15:49:08 +0000
Message-ID: <7ia433txrb0r.fsf@castle.c.googlers.com>
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Post: <mailto:sparclinux@vger.kernel.org>
List-Help: <mailto:sparclinux+help@vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:sparclinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Andreas Larsson <andreas@gaisler.com> writes:

> Hi Roman,
>
> Could you enable Sashiko reviews for sparclinux@vger.kernel.org?
> Preferred configuration:
>
> reply_to = ["author", "list"]

Hi Andreas,

Added:
https://github.com/sashiko-dev/sashiko/commit/bbb84c8e441f9000de69f5a93ccf460cbd5b233d

I'll roll it out later today/tomorrow.

Thanks
