Received: from mailrelay-egress4.pub.mailoutpod2-cph3.one.com (mailrelay-egress4.pub.mailoutpod2-cph3.one.com [46.30.211.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38373815DD
	for <sparclinux@vger.kernel.org>; Sun, 30 Aug 2026 17:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.211.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788110575; cv=none; b=qeDwu7tajQaMAW9pCXBUkm8w2tRCEDpbBqRNVFjegh0u9sVVjjUv/f7xRjnR8widw31toCx5yBKiouX9F8h7eQCNur7MEHBcFh4fXvic+1OgJJwZK0359ODdbHQtfSGT3H3CvEpGtodY2KY3QeTDkYEV/iBRY39LaV7CIAYAjgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788110575; c=relaxed/simple;
	bh=tyWZoQAQblOmCVI+PbxPrKMuMatAbXJUuZAqwdCG7xk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i+B/x6UdVAQBCFGYLs+L/SjnPb/wusmSPzrTiBBHA8BFz+gdhiorZAaErirthw18PJfcny7cioGaw9zVSygpT6GVftW+o26+kLBBKe/rUuOI82SRuAxesayLpn3vgu15vPOmohehg1mtNPqZ8/veP1CCltwxKpbf5h7As8bQxAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org; spf=none smtp.mailfrom=ravnborg.org; dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=IDCWZFK1; dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=hjAMNVy/; arc=none smtp.client-ip=46.30.211.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="IDCWZFK1";
	dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="hjAMNVy/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1788110558; x=1788715358;
	d=ravnborg.org; s=rsa1;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=S6AnUn2esV66ylB6zaKCehVlp7CaVncyvopYVMYp8yM=;
	b=IDCWZFK1J68IevBYTNWD/js+nn/SdlycHJ3rTWeQEpzfrNY0G9pJ3mPmVe3wFzaRM/BCNhUZDp2BO
	 EspXP9tIwbgXCGjBoC7pDPVMbOnJqOAvbQE7YG+YwDQUNkxYzVf5yyGx9vBSnYkw/UuL4S3PuR9A7h
	 Wuh7/HkYVTgBy4hKWGMmglcXusbyQyfhhkFEkAnjjm4zK93GOlBOknNBlcOg2xcQ6mPwu0Qj/pp2fx
	 uuAbM+saG6cbZZ0czCtsgDO0vOHMIP6QtpoJjSKgJIgwi50ISkaqy1sJ67bHdcJsz7vZ+Z5b0Srr5b
	 kaX/ioxnfDO6XLlhfrqdxA3Q8zzwsvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1788110558; x=1788715358;
	d=ravnborg.org; s=ed1;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=S6AnUn2esV66ylB6zaKCehVlp7CaVncyvopYVMYp8yM=;
	b=hjAMNVy/s01mFFL0UqLy33R0xjLElrq5L5Pxk+wMEpU6/aGpRVMXix8ABnQSkpsU6Z8dCMIGXqkx2
	 kARZUsLDg==
X-HalOne-ID: 6534019c-a497-11f1-98ec-579199b74f77
Received: from ravnborg.org (unknown [2a00:fd01:81e9:6100:f5ac:d3d2:8b9f:e425])
	by mailrelay5.pub.mailoutpod3-cph3.one.com (Halon) with ESMTPSA
	id 6534019c-a497-11f1-98ec-579199b74f77;
	Sun, 30 Aug 2026 17:22:38 +0000 (UTC)
Date: Sun, 30 Aug 2026 19:22:37 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Magnus Lindholm <linmag7@gmail.com>
Cc: sparclinux@vger.kernel.org, davem@davemloft.net, andreas@gaisler.com,
	linux-kernel@vger.kernel.org, glaubitz@physik.fu-berlin.de
Subject: Re: [PATCH v2 4/6] sparc32: drop unused valid address bitmap
Message-ID: <20260830172237.GA173328@ravnborg.org>
References: <20260830120742.20950-1-linmag7@gmail.com>
 <20260830120742.20950-5-linmag7@gmail.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260830120742.20950-5-linmag7@gmail.com>

On Sun, Aug 30, 2026 at 02:06:43PM +0200, Magnus Lindholm wrote:
> sparc_valid_addr_bitmap is populated during early memory setup but never
> read. Remove the bitmap, its allocation and the population helper.
> 
> Suggested-by: Sam Ravnborg <sam@ravnborg.org>
> Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

Good to have this dead code gone.

	Sam
