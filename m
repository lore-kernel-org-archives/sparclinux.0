Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9642125CC69;
	Fri, 25 Jul 2025 21:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753477776; cv=none; b=VgtiFvKfU3zaN6k0+8yRV379MAKkFHk2B9lYPPL64xZWPB5rinf2I+MaGPlJ+ILzINcsNYaL0EteFCUZsf5ywlSV9ra2djgxXGCQhj6JNYyZJFANyvyf0fx6F+C2qzyykgP695rRKskvFHkSppZOuvyvBy/2cBz0/Jq+t7UEjJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753477776; c=relaxed/simple;
	bh=NvFjPY+6qE7WXN4o6/vaxVoS+e8BCS0bRZ2yH3tsuQA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P2fXpBeFP3y6v1MCnhEuKLBEfSsEVD8wIEBYdCPKAS6h88qllmY2NRFyh0QPB0s6vq8TwOmQVYZqJ+obe2Naav/Wxs544d/A/QFCXeljXCnffBxD9OeRWftsMSaFcuXIrnVBlddce3Uiw16aaaLa0Hcqu99yshLC5PZmfTtH/68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=TP18Unn0; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="TP18Unn0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=qRZRKJLRedmW5W2XiHSbffMtWqVz/braCFaXALADPFo=; t=1753477773; x=1754082573; 
	b=TP18Unn0NsF1t5vynuPmKRDY4b/FGk5uIqMpaZ+8t5mu9sxWpNhrniRtSEgD8F6/d4VwZNP+tC0
	dk2oskewh8O/5rcywg6m/bakDG+XJSz/bfU2m946mC6aVurei/BPSEstvdXYnPayE46gi4e0fVsSf
	zTw3rIHHfk14Pz3XXdT/PInlDciz+zR85f/kHRUnMb+fXzzPor3RU7FzvLW8iK1obQYqmHc8RzHfA
	k2u+eYNZllP0unNEj01fNQoWj1EoPPhCKGSthTdYCxypwAUMUs3k7v7AZSdSJkKlTuosx1gPa/khE
	JBBXWpWTwrzyA+h/iuR37VHhg1WfrNGq/D4g==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1ufPfW-00000001hXQ-1Zqq; Fri, 25 Jul 2025 23:09:30 +0200
Received: from p57bd96d0.dip0.t-ipconnect.de ([87.189.150.208] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1ufPfW-00000003T1Z-0Uag; Fri, 25 Jul 2025 23:09:30 +0200
Message-ID: <9a1fcf10fef8490875a179d33dcf99e08b0d71ce.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sparc64: fix hugetlb for sun4u
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Anthony Yznaga <anthony.yznaga@oracle.com>, sparclinux@vger.kernel.org, 
	davem@davemloft.net, andreas@gaisler.com
Cc: linux-kernel@vger.kernel.org, agordeev@linux.ibm.com, will@kernel.org, 
	ryan.roberts@arm.com, david@redhat.com, osalvador@suse.de
Date: Fri, 25 Jul 2025 23:09:29 +0200
In-Reply-To: <75cd8cf5b1cddc0914d29df20d3f664efd173b3c.camel@physik.fu-berlin.de>
References: <20250716012446.10357-1-anthony.yznaga@oracle.com>
	 <75cd8cf5b1cddc0914d29df20d3f664efd173b3c.camel@physik.fu-berlin.de>
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

Hi again,

On Fri, 2025-07-25 at 22:46 +0200, John Paul Adrian Glaubitz wrote:
> slbpacaflush (8M: 64):  Bad configuration: Atleast online 2 cpus are requ=
ired
> straddle_4GB_static (8M: 64):   PASS
> huge_at_4GB_normal_below_static (8M: 64):       FAIL    Wrong address wit=
h MAP_FIXED normal
> huge_below_4GB_normal_above_static (8M: 64):    PASS
> map_high_truncate_2 (8M: 64):   PASS
> misaligned_offset (8M: 64):     PASS (inconclusive)
> truncate_above_4GB (8M: 64):    PASS
> brk_near_huge (8M: 64): Fatal glibc error: malloc.c:2601 (sysmalloc): ass=
ertion failed:=20
> (...)
> fallocate_stress.sh (8M: 64):   PASS
> ********** TEST SUMMARY
> *                      8M           =20
> *                      32-bit 64-bit=20
> *     Total testcases:     0    111  =20
> *             Skipped:     0      9  =20
> *                PASS:     0     57  =20
> *                FAIL:     0      1  =20
> *    Killed by signal:     0      1  =20
> *   Bad configuration:     0      4  =20
> *       Expected FAIL:     0      0  =20
> *     Unexpected PASS:     0      0  =20
> *    Test not present:     0     39  =20
> * Strange test result:     0      0  =20
> **********
> root@raverin:/home/glaubitz/libhugetlbfs#
>=20
> Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Ah, I noticed that huge_at_4GB_normal_below_static fails.

Does that test require at least 4 GB of RAM? If yes, it's not surprising
the test fails as this machine have only 2 GB of physical memory and just
1 GB of swap space:

root@raverin:/home/glaubitz/libhugetlbfs# free -h
               total        used        free      shared  buff/cache   avai=
lable
Mem:           2.0Gi       591Mi       896Mi       1.1Mi       792Mi       =
1.4Gi
Swap:          976Mi       3.0Mi       973Mi
root@raverin:/home/glaubitz/libhugetlbfs#

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
