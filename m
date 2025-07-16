Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654C3221FA4;
	Wed, 16 Jul 2025 08:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752655269; cv=none; b=kuNXuyoaurdUiiS3MOEGgI0FpBsmnF2pZxsceI0eXdEPqQ8q6pzXyi+JlR/oMHUemoG1i32LQgf9ZC5RE1/ZkKqWkdkN1Nq/UK3J8N68J3+kkrjmgLu7oJ3zYbtOpd4SGsPgZRqq7tKCZTBwMUUfWbCWZXwGyraLj0QXM1BoDx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752655269; c=relaxed/simple;
	bh=UBE4i18UG5TgC8Dr08fCzSgyRxxuzZUTw5teLieSK4o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qmA2WNlxKDHaz/fY+u7vLyWaiTwr+RZJCBdfOnCRVgnIk6+vSoJC0nlmXoHrNqC+LTyddnZcGZK05feyBK9jS+rKqK+wbjW1mn6Rk1YKiXgHPxyDdkD/rZzOFxdOrcZlLJ/CEeYJNZHkolNobJnj8G8RZd2qqxV30IU+9rjLCho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=jtlJVtHN; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="jtlJVtHN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=KDNHYOLOXC4cy2Zm95zWXOqNT8ZXuyhYPaz5r24B/f0=; t=1752655266; x=1753260066; 
	b=jtlJVtHNQAvBcVEGLi32yRSWV8C2cgHUd0lSfgGKNsEnJVEABhiRLcVqgEK/a8/FPqrWn8kOKTV
	xR2d2ZslqnesQlA7/6JKWylQL4BZxgkYyAoCSZsHYh7WCLoy0IwRwgiiVUU43IEuwfCfFSN5eFG6K
	2iLuo0v7EOtht30kTdg8C5JdMjpLnEBfTubRcGABffS2ClHOUd8Y5ZDMu4bgns5Ss9CNePrAXA9oa
	1renM2Rz6xiPsfUV4sxRUJdtcyyUKYVJwo/2PbXs21K6heiYWbC0k2rHZUY/uaIM5ybTsLk2wgWGV
	4F5pVGG3RIsbd4p3d90NdEhMlyzABM0/Go1Q==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1ubxhG-00000000Bmn-1v59; Wed, 16 Jul 2025 10:41:02 +0200
Received: from p57bd96d0.dip0.t-ipconnect.de ([87.189.150.208] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1ubxhG-000000025aC-0wwT; Wed, 16 Jul 2025 10:41:02 +0200
Message-ID: <1821f2fc2e339fbb4bc6a4af1748a3462f501392.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sparc64: fix hugetlb for sun4u
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Anthony Yznaga <anthony.yznaga@oracle.com>, sparclinux@vger.kernel.org, 
	davem@davemloft.net, andreas@gaisler.com
Cc: linux-kernel@vger.kernel.org, agordeev@linux.ibm.com, will@kernel.org, 
	ryan.roberts@arm.com, david@redhat.com, osalvador@suse.de
Date: Wed, 16 Jul 2025 10:41:01 +0200
In-Reply-To: <7531c897d8a4dc874bc226f5cb724eb66ee17974.camel@physik.fu-berlin.de>
References: <20250716012446.10357-1-anthony.yznaga@oracle.com>
	 <7531c897d8a4dc874bc226f5cb724eb66ee17974.camel@physik.fu-berlin.de>
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

On Wed, 2025-07-16 at 08:18 +0200, John Paul Adrian Glaubitz wrote:
> On Tue, 2025-07-15 at 18:24 -0700, Anthony Yznaga wrote:
> > An attempt to exercise sparc hugetlb code in a sun4u-based guest
> > running under qemu results in the guest hanging due to being stuck
> > in a trap loop. This is due to invalid hugetlb TTEs being installed
> > that do not have the expected _PAGE_PMD_HUGE and page size bits set.
> > Although the breakage has gone apparently unnoticed for several years,
> > fix it now so there is the option to exercise sparc hugetlb code under
> > qemu. This can be useful because sun4v support in qemu does not support
> > linux guests currently and sun4v-based hardware resources may not be
> > readily available.
>=20
> It has actually been observed for a long time that newer kernels are
> unstable on sun4u while there are no stability issues on sun4v.

Just as a heads-up: I'm currently building a Debian kernel with this patch
and see if this fixes the stability issues we're seeing on UltraSPARC machi=
nes.

> I'm not sure though whether the Debian kernel enables hugetlb by default.

We do.

I'll report back.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
