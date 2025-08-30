Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794D822DFB8;
	Sat, 30 Aug 2025 08:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756542966; cv=none; b=inpagyuseZUxYBZh9Q/NRLgfdaP/HZuCwgwU+c5E+OQkCk82wOblkCLzSszvht4Epb/DLspKFeeRjLPIntwB+7GbvFdRJfVbp+jzzpk80hDTzQtRJC0VloCTTCWkRtBVATSUxGwhxJUvXrAIic5ZWglR+0g0D/BMLsHogijNZkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756542966; c=relaxed/simple;
	bh=8CEPE5SZ81umhkmrXioGPbAjSUW1mPfziUAF+t4NFTo=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Fwxf4CLgqK7DM8GYFMAAmQWPpoankQBX1Fd3q8KF7G1cxslHSs9ysDHBx3m4Ah3HCb9XhWkWEjpiqs34w4sWEIxzIEbaa92AIWzcmekeo7n+9LC+VMi9c/zMzmlIDKhl5hAiq5u1pcgGR60UQ4e8ekPAdOQueFS/J9XAhpAZzG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mkarcher.dialup.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=ZHfD8bBt; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mkarcher.dialup.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="ZHfD8bBt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=UuZowZvYIfVFLIrdPbzq1seTVyiyk/J01AmgZPL60EI=; t=1756542961;
	x=1757147761; b=ZHfD8bBt9bDxj/9F8bKV8e1Xoq2fSvPCpHXo+IBAlbxFJ589+uBc/qNn6IFO0
	YksCpIxV59rE0XgKbGBTLdql+PyKdrKeXO8L118XOfJPo8XkYNLVljJ5ykJhvm8M19fIpHJnPk+Bl
	NxvKVzwco7oD5jKipAbMG1G4izfhXiMMzfLYRoJ4HMKSWJAxoBmdNBpEwwvlgrADZdM1uUo2NxRV6
	pDCODWBR2+DrFvvXWa/DnoIA5xnNixNtpd5PFWGN6e6lvLq9M/xIESJOcCve21reDLjAFMYTm03Bc
	XHA9JMIPRgV7SMGhd+Qh88PkCWruVeYe43Nf9lEb7gz2b2I+/g==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <mkarcher@zedat.fu-berlin.de>)
          id 1usH43-00000001SkH-0P3x; Sat, 30 Aug 2025 10:35:59 +0200
Received: from tmo-125-174.customers.d1-online.com ([80.187.125.174] helo=ehlo.thunderbird.net)
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_128_GCM_SHA256
          (envelope-from <kernel@mkarcher.dialup.fu-berlin.de>)
          id 1usH42-00000000QbH-3ReF; Sat, 30 Aug 2025 10:35:59 +0200
Date: Sat, 30 Aug 2025 10:35:57 +0200
From: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>
To: Anthony Yznaga <anthony.yznaga@oracle.com>, linux-kernel@vger.kernel.org
CC: sparclinux@vger.kernel.org, Andreas Larsson <andreas@gaisler.com>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_2/4=5D_sparc=3A_fix_accurate_exception_re?=
 =?US-ASCII?Q?porting_in_copy=5F=7Bfrom=5Fto=7D=5Fuser_for_UltraSPARC_III?=
User-Agent: K-9 Mail for Android
In-Reply-To: <528a5d4b-1e07-4379-afd6-7e58d423e713@oracle.com>
References: <20250826160312.2070-1-kernel@mkarcher.dialup.fu-berlin.de> <20250826160312.2070-3-kernel@mkarcher.dialup.fu-berlin.de> <528a5d4b-1e07-4379-afd6-7e58d423e713@oracle.com>
Message-ID: <C90C7694-C913-499B-8426-8DEC42137066@mkarcher.dialup.fu-berlin.de>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Original-Sender: kernel@mkarcher.dialup.fu-berlin.de
X-ZEDAT-Hint: PO


>I think there should be a little more text about the nature of the failur=
e=2E Maybe:

I will add something like that in v2 of the series=2E
Do you think it is useful to add the message ID
b14f55642207e63e907965e209f6323a0df6dcee=2Ecamel@physik=2Efu-berlin=2Ede
as well, or an abbreviated backtrace from that message?
I suppose, that is the BUG_ON you are referring to=2E

>Otherwise, the fix looks good=2E
>
>Reviewed-by: Anthony Yznaga <anthony=2Eyznaga@oracle=2Ecom>
Thanks=2E

Kind regards,
  Michael Karcher

