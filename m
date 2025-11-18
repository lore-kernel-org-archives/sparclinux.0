Received: from exactco.de (exactco.de [176.9.10.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC063659E6
	for <sparclinux@vger.kernel.org>; Tue, 18 Nov 2025 15:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.10.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763479522; cv=none; b=Yr7lrTcTFSg7cbi3gYwokMwYa3ipWUeo1P576rvthwT5D1pJLwpJR5n/NKmWYtOJmvau4cJWjO5rRe5gh1h5RnitWV3bogQsfIg3xp3P85E5DqbNrF9/5JoGATYtQ8/qmYbDNwuVgmg0tJPDhG44tbUfxLuO3GvA8D2g99YNUws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763479522; c=relaxed/simple;
	bh=YBGHMl1kOtXCCtldS7WVgn0Y5V0FHkHPE/4GYONKEA0=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=DmY57Hzku6tsram3eI6vM6bfvsa+0KIR1GmIV+nURFslDbp1Upf+F6JT8mbfzGlpe9tglzgwDg+Zi6CqQM3LQzBy6Oq0FstXphCN7FhA1gzzllQSzN8/lsvxn8nfhAYEoyy2HRLFFlQXdH9QxvJMUyQ526RWOAZke+i4u7QlNS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactco.de; spf=pass smtp.mailfrom=exactco.de; dkim=pass (2048-bit key) header.d=exactco.de header.i=@exactco.de header.b=w7RTFdid; arc=none smtp.client-ip=176.9.10.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactco.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=exactco.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=exactco.de header.i=@exactco.de header.b="w7RTFdid"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=exactco.de;
	s=x; h=Content-Transfer-Encoding:Content-Type:Mime-Version:References:
	In-Reply-To:From:Subject:Cc:To:Message-Id:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=ySqOKpeKfulcUmtqazA975aDUynfPt9n1Uipxl0c3mA=; b=w7RTFdidNPFcihX18UREKAapZI
	4hsHG/JgeQ8hjLXPEoFDwfcLrLNKE0coPWN/oLuYZX8siDWXVZy6taFJAaZqSa2XSipbatd8Kk9yT
	eEsAmp9LP4T4+r4skgeVzo74WwDwk+swAtUxClt6zRQTnDTsfWoPphQfpHbezb0szHFFH2qe4qrO4
	AFciPzQlHr0XxG7VRy15leCwp4BjoryLrOpIg2Gv6d9cU77BIz5ahp+wG3ariVNONkpJh31KodaB/
	fOgw9DHTB+AVdMNYzbAwe8v9UFsgLb7WXe4q3QD0ZRepn0wiW62312kipKv+Kwpxg2C8DhFyz+fV3
	Gspm8ECw==;
Date: Tue, 18 Nov 2025 16:25:29 +0100 (CET)
Message-Id: <20251118.162529.193664192018749438.rene@exactco.de>
To: glaubitz@physik.fu-berlin.de
Cc: sparclinux@vger.kernel.org, joe.moriarty@oracle.com,
 david.j.aldridge@oracle.com, allen.pais@oracle.com, davem@davemloft.net,
 andreas@gaisler.com
Subject: Re: [PATCH] sparc: Correctly recognize Sonoma S7/S8 cpus and perf
From: =?iso-8859-1?Q?Ren=E9?= Rebe <rene@exactco.de>
In-Reply-To: <baf12ef8dcf7ec72423bc2795d4824c06ed32adf.camel@physik.fu-berlin.de>
References: <20251118.142521.973960159957848254.rene@exactco.de>
	<baf12ef8dcf7ec72423bc2795d4824c06ed32adf.camel@physik.fu-berlin.de>
X-Mailer: Mew version 6.10 on Emacs 30.2
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hi Adrian,

On Tue, 18 Nov 2025 16:10:30 +0100, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de> wrote:

> Hello,
> 
> On Tue, 2025-11-18 at 14:25 +0100, René Rebe wrote:
> > Fix SPARC Sonoma S7 incorrectly identify as M7. Orabug: 23041
> > 
> > Add support for Sonoma S7 into perf to ensure that perf will
> > recognise that it is running on a Sonoma device and initialize
> > correctly. Orabug: 24931042
> > 
> > Rename SN to correctly identifying Sonoma 2 systems. Orabug: 22960812
> > 
> > While at it, fix S8 to use M7 optimizations instead of Niagra4, too.
> > 
> > Signed-off-by: René Rebe <rene@exactco.de>
> > Originally-by: Joe Moriarty <joe.moriarty@oracle.com>
> > Originally-by: Dave Aldridge <david.j.aldridge@oracle.com>
> > Originally-by: Allen Pais <allen.pais@oracle.com>
> 
> This should be approved by someone from Oracle so that we don't run into
> any risks of copyright litigation.
> 
> Furthermore, it would be nice to get an approval for the other patches
> that are part of Oracle's UEK kernel which have not been upstreamed yet.

Thank you for taking a look and bringing this up. IMHO they modified
the GPL licensed Linux kernel and thereby agreed the GPL license
terms, shipped and Signed-off-by it. I don't really see any legal
issue here and as Guenter Roeck lectured me the other day, there is no
real Copyright for few lines changes[1], anyway ...

I also significantly re-based and fixed this S7 patch and if it was
for me we could remove the SN/S8 bits as this appears to be unreleased
hardware that nobody probably ever had? I or a friend could also
retype the SN to S7 rename perf and asm wire-up, it really is just one
hex number and sed, ...

      René

[1] https://lore.kernel.org/linux-watchdog/20251116.145908.308086523429052446.rene@exactcode.com/T/#mc50846bb4a7df87068e2bfa51d76cd09ef024929

-- 
René Rebe, ExactCODE GmbH, Berlin, Germany
https://exactco.de • https://t2linux.com • https://patreon.com/renerebe
