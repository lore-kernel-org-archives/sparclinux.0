Received: from mailrelay-egress4.pub.mailoutpod2-cph3.one.com (mailrelay-egress4.pub.mailoutpod2-cph3.one.com [46.30.211.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3B319D074
	for <sparclinux@vger.kernel.org>; Fri, 14 Aug 2026 20:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.211.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786740489; cv=none; b=VerL8F/kE0qrtW4r/kFHg2SJXHWXqf+ZQjDzauLz5e3mT8qY87l4pOrKDh38Uc8+ekz4mys48HN698CNTsQyGF1514QzdmzSvJ1kRzPRMZEWeSr3UfiIYhy2gjoIpCsr8VAyBJuChjP7SlqPnGD+yYeZZfDCGo3B/aBStAndrew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786740489; c=relaxed/simple;
	bh=rXUjojw6DuTAaZkLogk0OKNghVjXW8HksCjhQno0W2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rVMYlTyecGqDQVQBpGnQo8do1osDxvR5ijL3Ly9syDrONdDT7CF3F+VjjztF7x2c/PwM1FZoaZv6MgGz7zIR8oJvx9+k3PKP6ns8GJUhjhVILTxlSafd9ZFFgivExuDmXNQmoKZ/LB1T7YD2UvLetL5TJlNX+mWOIYSpZVABRfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org; spf=none smtp.mailfrom=ravnborg.org; dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=lO2+z10A; dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=wiO1A9kB; arc=none smtp.client-ip=46.30.211.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="lO2+z10A";
	dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="wiO1A9kB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1786740484; x=1787345284;
	d=ravnborg.org; s=rsa1;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=UGvAx5G47f5RtS/sbl2quiAHyksJObDdApFu8i+KZZ0=;
	b=lO2+z10AG8JV7iD0ppWVPvnb5XflndRii5XZfAn40/IkBkm3a7QHsmtqhururwuVHR9/8DPkwYNAw
	 V3dftIXUKkUWbM6sf08tkTue1+2/agzX3lo5OS2vzw0pkfRETg7RyIxWsUrVqPyIl+gWMlUxfNBmdw
	 hDSH2ntcJky2fXJ/CqpZ0HFLuQesCt69zWBUw/35nGLhJZQ+0RGRHMdmb3q+S+xmlAQKXhiqzvBunj
	 pSj6rDY4HADXj2L++ZYV8BuiOyZMDKSubkRaCKU/5gxifQPSA8eI/jsA8VSOUN34/JJ/xn8x4JpcEE
	 iU2C276mRH0M/lQXGEMkjNNEA7XxzYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1786740484; x=1787345284;
	d=ravnborg.org; s=ed1;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=UGvAx5G47f5RtS/sbl2quiAHyksJObDdApFu8i+KZZ0=;
	b=wiO1A9kBcJPU9PEEsKGejytiIujAgMBdaaqoODEAX8djzcRs0FkSKt6kR2JRA1ZKcV2TXm81QwiIZ
	 w9EP8YfDg==
X-HalOne-ID: 70e35150-9821-11f1-8fa3-6b8d581b3111
Received: from ravnborg.org (unknown [2a00:fd01:81e9:6100:173:77b0:ce00:a307])
	by mailrelay3.pub.mailoutpod2-cph3.one.com (Halon) with ESMTPSA
	id 70e35150-9821-11f1-8fa3-6b8d581b3111;
	Fri, 14 Aug 2026 20:48:04 +0000 (UTC)
Date: Fri, 14 Aug 2026 22:48:02 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Magnus Lindholm <linmag7@gmail.com>
Cc: davem@davemloft.net, andreas@gaisler.com, sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] sparc32: advertise relocatable kernel with HdrS
 0x0300
Message-ID: <20260814204802.GC534878@ravnborg.org>
References: <20260814105723.3454511-1-linmag7@gmail.com>
 <20260814105723.3454511-4-linmag7@gmail.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814105723.3454511-4-linmag7@gmail.com>

Hi Magnus.

On Fri, Aug 14, 2026 at 12:52:34PM +0200, Magnus Lindholm wrote:
> HdrS version 0x0300 tells the boot loader that the kernel supports being
> located somewhere other than physical 0x4000, which is where SILO places
> the image on the traditional path. Anything older is copied back down
> there, and refused outright when it no longer fits.
OK, if I knew this it was paged out a long time ago.

> 
> sparc32 could not make that claim before, because setup_arch() took
> phys_base from the lowest memory bank rather than from what PAGE_OFFSET
> maps to. It can now, so say so.
> 
> Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
