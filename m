Received: from mailrelay5-1.pub.mailoutpod3-cph3.one.com (mailrelay5-1.pub.mailoutpod3-cph3.one.com [46.30.211.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0FA14B973
	for <sparclinux@vger.kernel.org>; Tue, 11 Jun 2024 20:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.211.244
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718139306; cv=none; b=HiZzsTkYZjcUzA3ooD5OhL4IvL+1PXP99FLc9ylqdgakjxHKN9mN00D9p4Eln8eJy311QPc3kyOF+VmtV67S1SJiTPqtKo0OJwhf2gWpbEIAA9nOYRs2EUCO1mO74GlIEuzDr6BjX79irVcxl8lkPO351IzA/lGW8fmi7GcEXRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718139306; c=relaxed/simple;
	bh=tTiQIOR5fXfoTAL0Ccw5hIwFJl0c8eM1AKdXxiCxyRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nA0DFuztRazEcHKz0fgQEKoZD43eijZL12rdP0PCgh8E+thyIPcEY4ppuuN1HDkERUNSZzmfi+0wpjyD1vn8h914NwYjYAtd8sjgkGU7Zs2bg1fuBcDSlVtkPX78LbuR+9+C7Vlgu8pxO1MnjI8tvDWpa7zUddUxCHegttkQJ5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org; spf=none smtp.mailfrom=ravnborg.org; dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=AiulmEbX; dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=y8bJqY1F; arc=none smtp.client-ip=46.30.211.244
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="AiulmEbX";
	dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="y8bJqY1F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=rsa1;
	h=in-reply-to:content-transfer-encoding:content-type:mime-version:references:
	 message-id:subject:cc:to:from:date:from;
	bh=k3ERBR7pPMabLon7+j+2K3RUQpylljUKVmTxI1gsd+4=;
	b=AiulmEbX+BwDK4kBlV7SqhmTnhf1udadW8kzRtO+NusdCn3B0+7bNSxasJVkji5utbjqdOuaGK4wE
	 xVmFjT8tIIykEzVzI2VxaS1dkb8sE3AvuDuIq+eVNCQDkz2L0K6WNxxxeTUAc4JQkytjycnPAZhebB
	 Tj51a9nw2JPv7eBCcyQ/v2eiwye7uWCnB4BdcCR0Y/IHMEPI1+uTu4N2XFQeBIf6W9XB5In1aS5WBc
	 0RCMzDvHuXcG1Kq7cDikgZ2Hw6tD0LNI+Ovx839KkLq1jA8GgoKwbc3I4iWwCdfHlCKZY0vmMqETKw
	 xtQRkfJUYZOi1DufeOO8L2ae7HAipKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=ed1;
	h=in-reply-to:content-transfer-encoding:content-type:mime-version:references:
	 message-id:subject:cc:to:from:date:from;
	bh=k3ERBR7pPMabLon7+j+2K3RUQpylljUKVmTxI1gsd+4=;
	b=y8bJqY1FxZO9r/gLtSUOuwA9y9IhgmjIkq1Sqkv/6i/IFYmftufvg+5MUsKotboMU6JDflf/WJ0Wz
	 B8ZnwiiBQ==
X-HalOne-ID: b4f7f42f-2834-11ef-97e2-e973630cf47d
Received: from ravnborg.org (2-105-16-150-cable.dk.customer.tdc.net [2.105.16.150])
	by mailrelay5.pub.mailoutpod3-cph3.one.com (Halon) with ESMTPSA
	id b4f7f42f-2834-11ef-97e2-e973630cf47d;
	Tue, 11 Jun 2024 20:53:54 +0000 (UTC)
Date: Tue, 11 Jun 2024 22:53:52 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andreas Larsson <andreas@gaisler.com>, linux-kernel@vger.kernel.org,
	sparclinux@vger.kernel.org
Subject: Re: Build regressions/improvements in v6.10-rc3
Message-ID: <20240611205352.GA557485@ravnborg.org>
References: <CAHk-=wiK75SY+r3W5hx+Tt_bjhcSKPLdji-Zf_8HjikRPbn9wg@mail.gmail.com>
 <20240610071049.933142-1-geert@linux-m68k.org>
 <46c5a25-ea8c-4a1-5241-df88a9848a9@linux-m68k.org>
 <20240611173739.GB545417@ravnborg.org>
 <CAMuHMdW__Uak2qkUAJc1b1eK1nOzGy=+cneRrtmj_QgBTanK-Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdW__Uak2qkUAJc1b1eK1nOzGy=+cneRrtmj_QgBTanK-Q@mail.gmail.com>

On Tue, Jun 11, 2024 at 09:50:41PM +0200, Geert Uytterhoeven wrote:
> Hi Sam,
> 
> On Tue, Jun 11, 2024 at 7:37 PM Sam Ravnborg <sam@ravnborg.org> wrote:
> > On Mon, Jun 10, 2024 at 09:28:25AM +0200, Geert Uytterhoeven wrote:
> > > On Mon, 10 Jun 2024, Geert Uytterhoeven wrote:
> > >   + {standard input}: Error: pcrel too far: 1095, 1074, 1022, 1020, 1021, 1096, 1126 => 1074, 1021, 1255, 1096, 1095, 1020, 1022, 1126, 1254
> > >   + {standard input}: Error: unknown pseudo-op: `.al':  => 1270
> > Hmm, strange..
> 
> Just in case you missed that: these are not SPARC build issues,
> but SH build issues (gcc ICE).

Thanks, I saw that as sparc64 issues. Then I will ignore them :-)

	Sam
