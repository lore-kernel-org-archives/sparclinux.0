Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEFF20B80A;
	Tue, 14 Jan 2025 20:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736886602; cv=none; b=G9VVGvSl/qHLYpBZ+Pr8VUmEi/6sn/kJlysTb0opm47PnO4g7zM7wnQAO+0nxOpSWk9Yc082hgzGqCXzw3DcXm2wDOKPiUFKiu9/2rlYeXn3fX8nQ+6Bq2UTEEC3GUyLTi8wD/yXnRt3BMbsK16PomWp0kO5KrC5YKVtjpSbPTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736886602; c=relaxed/simple;
	bh=5rdDF0CULigSzCeEbJyCr6WDrKX3Koie60UNUZPXJFs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F9tvVFhd4xlLWPxUkC7K1CVLWSsf8fKMgmckuBKXoABq+vg1Dru5kbi0Ig4F7uzacZybTrA/x2V6Sy9dTenOWiSXa/Ec8w/LmuVcrWGpUCAMw9BmTvHsZCSZ8vYSg+Cs56KNDASFvHOSDnUMmTC2oA2Rr59I9MdCMeWDhIpDS5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=AAwEQ1S+; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="AAwEQ1S+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=y+ImgVN5K0eevwoNX8bwkb8cRKjkpAPKYJzQg3Q2Ad8=; t=1736886598; x=1737491398; 
	b=AAwEQ1S+PL4oojBsupR5mNO1HXs6pjidCxCl8WGi8wEIkkt98CJZEgA/mzljU8s3XGbdH7E2TmY
	3taT3haYJrsoaz0kzS89+zi5VEAoFDEHnYkLR7qseCHDyTL5Gfg7CAgVbL7P0NNLKpaHnlaewMBQX
	pcHfNYWNxPgpg7wuLQVuaqIe+pn52BfO9QUOUJV9VDz3BTplwxVTlQvq0XzZf52+mhPDbxrwGomo2
	oUh7Qyr9j86qwS4SqX8x2nGg8NIFW78O5VmruSzME7EC62ogLBdkWtXRxE5kDL0yfXTVOrPVMEdmn
	derFFi5NgAa8ZgPLLM+5BFf5YonzyRGgeD2Q==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1tXnXm-000000041PC-14DJ; Tue, 14 Jan 2025 21:29:46 +0100
Received: from p57bd9274.dip0.t-ipconnect.de ([87.189.146.116] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1tXnXm-00000001Pyk-02hX; Tue, 14 Jan 2025 21:29:46 +0100
Message-ID: <2b249bb11b3c08b21929b46f14bee808c9bbefe6.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sparc/irq: Remove unneeded if check in
 sun4v_cookie_only_virqs()
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Thorsten Blum <thorsten.blum@linux.dev>, "David S. Miller"
	 <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, Randy Dunlap
	 <rdunlap@infradead.org>, Bjorn Helgaas <bhelgaas@google.com>, Sam Ravnborg
	 <sam@ravnborg.org>, Dawei Li <dawei.li@shingroup.cn>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 14 Jan 2025 21:29:45 +0100
In-Reply-To: <20250114202502.912690-1-thorsten.blum@linux.dev>
References: <20250114202502.912690-1-thorsten.blum@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Thorsten,

On Tue, 2025-01-14 at 21:25 +0100, Thorsten Blum wrote:
> Remove the unnecessary if check and return the result directly.
>=20
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  arch/sparc/kernel/irq_64.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/arch/sparc/kernel/irq_64.c b/arch/sparc/kernel/irq_64.c
> index aff0d24f8c6f..81fb49b089a8 100644
> --- a/arch/sparc/kernel/irq_64.c
> +++ b/arch/sparc/kernel/irq_64.c
> @@ -146,9 +146,7 @@ static int hv_irq_version;
>   */
>  static bool sun4v_cookie_only_virqs(void)
>  {
> -	if (hv_irq_version >=3D 3)
> -		return true;
> -	return false;
> +	return hv_irq_version >=3D 3;
>  }
> =20
>  static void __init irq_init_hv(void)

I'm not sure whether this change is really necessary nor will it improve
the readability of the code. I think the compiler will optimize the code
the same way, for both variants.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
