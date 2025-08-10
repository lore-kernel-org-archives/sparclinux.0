Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB371188A0C;
	Sun, 10 Aug 2025 09:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754819571; cv=none; b=lf67ubcheLETW4zpFgujPoh18cTnMTbpeb5I800ltKf2lY9wWbR8PxYyVeiGj73pMyYO4kVY9/b8UYCJu0Zyexs0SJ4JPCVMMUtBoRO/v9rbM2TKAUfiMnQGILZ0kM9a1dKJe9KBLEg/1ZsFfn8ObbKZfVnmg/kFDckqgNMkBMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754819571; c=relaxed/simple;
	bh=0zbKbrfwdAGAGat6xjBXj/g3hVQvEW3XlbIDjn69heM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cVWk/9+j5LrXfyWa3ROSyj5GwNpk/JNYAwR23BisRtw7+nFaoBT7pBjdphh1LWGDdUB5tDTD/WQVz1KbYSvtCOvAp8QEkzp4uqYYw0/vhXuENSutlbV4qj41q5xzU0rJ9IizW2/bWgxirt13PgaVb7jbusvjhGqC/9nEVFIcp+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=pGQ4emiw; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="pGQ4emiw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=oV8Gds9hWjugNfFQS5K+yU4Rf58QVDw1DCSo4yGQ5/4=; t=1754819566;
	x=1755424366; b=pGQ4emiw29doT69zZZrlr5b4buh3yJzl/O9kPqXS4Gn574XnQjv+l8G+JuyRr
	sC2KFaesbc0loe0FyGCDpnU7EFhxQUfjopT6nLEvAe1LCd5ZA7eioPt6+OJKhChfdga+nBDIdK+S/
	61QC87mS8/o98UFK3emv5EDFaB+qIRLDGXKtBdOKRYFMAhbtsPIk7Df2HY07L66R0+VVjEEwc+GZA
	AcxJSQ09zFKiGOftbOP+AzECDaghugW1zbn0oxRduZglkqGhDGYAa64pxeWqXHcprtZu6inzP/OaU
	xj2kzQYqpglSTUFqVkAm9CARPUk+KkV4/wjyGSawSOd7k0gqaw==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1ul2jF-00000001gT9-0PqX; Sun, 10 Aug 2025 11:52:37 +0200
Received: from p57bd96d0.dip0.t-ipconnect.de ([87.189.150.208] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1ul2jE-00000002jI4-3Z8d; Sun, 10 Aug 2025 11:52:37 +0200
Message-ID: <b5b75976c94b7b46f86a5af4675a1a570aaf20cc.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sparc64: fix hugetlb for sun4u
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Anthony Yznaga <anthony.yznaga@oracle.com>, sparclinux@vger.kernel.org, 
	davem@davemloft.net, andreas@gaisler.com
Cc: linux-kernel@vger.kernel.org, agordeev@linux.ibm.com, will@kernel.org, 
	ryan.roberts@arm.com, david@redhat.com, osalvador@suse.de
Date: Sun, 10 Aug 2025 11:52:36 +0200
In-Reply-To: <ff3d87634aedec28e7103f16a35031bfe86ca501.camel@physik.fu-berlin.de>
References: <20250716012446.10357-1-anthony.yznaga@oracle.com>
					 <35f5ec4eda8a7dbeeb7df9ec0be5c0b062c509f7.camel@physik.fu-berlin.de>
					 <7e1e9aa5-0529-4fb5-84fb-557b5cc1cd50@oracle.com>
				 <38f4469f48e6d36fa92b445c8ecef7a440be43e6.camel@physik.fu-berlin.de>
			 <b14f55642207e63e907965e209f6323a0df6dcee.camel@physik.fu-berlin.de>
		 <fc1555550f7a9b3c9aa5fb651769cf41ed859c77.camel@physik.fu-berlin.de>
	 <ff3d87634aedec28e7103f16a35031bfe86ca501.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Anthony,

On Sat, 2025-08-09 at 08:42 +0200, John Paul Adrian Glaubitz wrote:
> Let me know if you have more suggestions to test. I can also provide you =
with full
> access to this Netra 240 if you send me your public SSH key in a private =
mail.

I have narrowed it down to a regression between v6.3 and v6.4 now.

The bug can be reproduced with the sparc64_defconfig on a Sun Netra 240 by =
setting
CONFIG_TRANSPARENT_HUGEPAGE=3Dy and CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=3Dy.=
 When testing
on a modern systemd-based distribution, it's also necessary to enable CGrou=
p support
as well as enable support for Sun partition tables with CONFIG_SUN_PARTITIO=
N=3Dy.

Then it should be a matter of bisecting the commits between v6.3 and v6.4.

I will do that within the next days as I'm currently a bit busy with other =
stuff.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
