Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2805123F397;
	Mon, 17 Mar 2025 13:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742219770; cv=none; b=VodFrlbllnmjUSSjpC+ntDac7UXpOtIkbsPy2PctetHdEOE+/TvGn3c+c5PWv/aXbNzx3xJ4wGPmegxbrhvNMs4lnZiHMKyd200OIaidOvsurrMwgrXm1ostvwj6Op9BjwcUz4vSgm6TId4XBClxuanQJPrHx4s7Ai/CKWmhEX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742219770; c=relaxed/simple;
	bh=4xaXh+lYmFcHptXjeAt8Y6AFPaYRLw5Pnu/1WSiP1A8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S8tEs3pRXZS50QndGBz0AhT3HE9ZKBzGPJBK5Foie3LrdQiASY1+BPoGFLCxVjnIxYsODto8C0PV7Ok4l1DoQQdZjnpkDAlXS9konbtlTYyWbbeFweIimrs4e7DzZscyofFCfq2lNNmwTawIA+UIbqiX1oOHJq4H2dbRhZM32/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VwZi/+rN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VwZi/+rN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA9FFC4CEE3;
	Mon, 17 Mar 2025 13:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742219769;
	bh=4xaXh+lYmFcHptXjeAt8Y6AFPaYRLw5Pnu/1WSiP1A8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VwZi/+rNVKtQMMOaTW0xup13mkSQRxz4n+ypWbnElNTBZj/A7JUNtHAUe4MVcppMI
	 KLPi1z/Q1RN+WQwqsAz+mwjdsWcvyTi6YZdYJFiuqhg9hb14sNqiSztVTH1bI1AxoH
	 Sv/MwGG2gdurE1cdS475TYlCcfgVwIKNKo/M1Dw8=
Date: Mon, 17 Mar 2025 14:54:45 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: xie.ludan@zte.com.cn
Cc: andreas@gaisler.com, davem@davemloft.net, ukleinek@kernel.org,
	jonathan.cameron@huawei.com, mathieu.poirier@linaro.org,
	quic_zijuhu@quicinc.com, sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org, xu.xin16@zte.com.cn,
	yang.yang29@zte.com.cn
Subject: Re: [PATCH linux-next] sparc/vio: use sysfs_emit() instead of
 scnprintf().
Message-ID: <2025031743-cheating-latch-ba8f@gregkh>
References: <20250317160456854fAJoK7WQI_J5R7rPeyfxh@zte.com.cn>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317160456854fAJoK7WQI_J5R7rPeyfxh@zte.com.cn>

On Mon, Mar 17, 2025 at 04:04:56PM +0800, xie.ludan@zte.com.cn wrote:
> From: XieLudan <xie.ludan@zte.com.cn>
> 
> Follow the advice in Documentation/filesystems/sysfs.rst:
> show() should only use sysfs_emit() or sysfs_emit_at() when formatting
> the value to be returned to user space.
> 
> Signed-off-by: XieLudan <xie.ludan@zte.com.cn>
> ---
>  arch/sparc/kernel/vio.c | 2 +-

Do you have this hardware and have tested it?  If not, I wouldn't mess
with existing code, just follow the documentation for new submissions,
leave old stuff alone as it's already working.

thanks,

greg k-h
