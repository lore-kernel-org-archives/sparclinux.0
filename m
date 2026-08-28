Received: from mailrelay-egress4.pub.mailoutpod2-cph3.one.com (mailrelay-egress4.pub.mailoutpod2-cph3.one.com [46.30.211.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050163537FF
	for <sparclinux@vger.kernel.org>; Fri, 28 Aug 2026 15:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.211.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787930902; cv=none; b=p9lzdeqSPXJV4OqtQY/sdaqmGjjwC/xzYqItHUST8KzRilrS3Fm2J3ZNJrzPUiR0LXUhsYj+P51oA0nZ0V1ZTXGba5OEJAK14YUN7SCccyndLtUvxtoop4Kf5gb8eqvCzqj9LKDOLsMTxH65vu7dBPSpR4Ex+SpyWn3QB0rSSyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787930902; c=relaxed/simple;
	bh=+5C4CVgISa9gWma3JdrNz8NifWM11Ifw6Zp7Wgkj8aI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kxCyTD6FDNIX2zfpbepVcPwMNnUl7vFhxtSxgL2Arly1yWcfVwGHputb4fevEM7jd2uuwpAyv7p35lDLktlXXRl7VPa9OdGemo4J4s1/PT6cIOvUX1g0/hfU/EoFKQqI3v86T1Wi3qMsKVvmu/18bfInDd6Mu6vInzgh3i1lUPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org; spf=none smtp.mailfrom=ravnborg.org; dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=MVKuV5gP; dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=6iEHJA+a; arc=none smtp.client-ip=46.30.211.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="MVKuV5gP";
	dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="6iEHJA+a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1787930825; x=1788535625;
	d=ravnborg.org; s=rsa1;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=EUDhUnpBdYWqAMhmUcpR/993DfcrYtWsPh2N7qFv/e0=;
	b=MVKuV5gP3rPziIiiZ0v3SFuDhm7hcrugoFBDV6Olyn3/Gpq/GFRVGtY+AwGVZFHRzDUh/Sms3FkBR
	 ZqmCOhyMvq5GwH0a/76QAgyd2HECIDT/sX6F3eKqpF8GzCId6ZMfM8d2RN00gYqH/2VCBH4b/Aj+kI
	 kEfvX6qWhWiTUNXzzPeiJsedFf9ptBg+8Ey444BhSTwAsvphUL8Y9xiJnCLLvAjdvT8T8Xo73PT8DL
	 3asR6dh3tyjDpC8LH+Kd1N8kSl9ptSSvxNjbQkkby8hoVmHwhLWq82Y50nlignMHVOoDWWDbkb27n2
	 MafdY/MBetmZvbgJuUhd45M18ZCUMjA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1787930825; x=1788535625;
	d=ravnborg.org; s=ed1;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=EUDhUnpBdYWqAMhmUcpR/993DfcrYtWsPh2N7qFv/e0=;
	b=6iEHJA+a97fkiDYH1kS/63q/Cw1nzrUXLVAtIl0BIagCfqUfeXMJjJrg03hV6KsH7qWl7a0Z/u0yy
	 8daE0J4AQ==
X-HalOne-ID: eb759449-a2f4-11f1-b81c-55bb5426428c
Received: from ravnborg.org (unknown [2a00:fd01:81e9:6100:77b9:f16e:d6e:1f4f])
	by mailrelay2.pub.mailoutpod2-cph3.one.com (Halon) with ESMTPSA
	id eb759449-a2f4-11f1-b81c-55bb5426428c;
	Fri, 28 Aug 2026 15:27:04 +0000 (UTC)
Date: Fri, 28 Aug 2026 17:27:03 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Magnus Lindholm <linmag7@gmail.com>
Cc: sparclinux@vger.kernel.org, andreas@gaisler.com, arnd@kernel.org,
	davem@davemloft.net, glaubitz@physik.fu-berlin.de
Subject: Re: [PATCH v2 00/28] sparc32: sunset sun4m and sun4d
Message-ID: <20260828152703.GA9209@ravnborg.org>
References: <20240309-sunset-v2-0-f09912574d2c@ravnborg.org>
 <20260828074446.9768-1-linmag7@gmail.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828074446.9768-1-linmag7@gmail.com>

Hi Magnus.

On Fri, Aug 28, 2026 at 09:44:46AM +0200, Magnus Lindholm wrote:
> Hi everyone,
> 
> On Sat, Mar 09, 2024 at 07:15:21PM +0100, Sam Ravnborg wrote:
> > This is the second attempt to sunset sun4m and sun4d.
> > See [1] for the inital attempt.
> >
> > The sun4m and sun4d parts of the kernel have seen no real interest
> > for several years now. Last time a few people surfaced, but it was
> > either due to a personal project or for nostalgic reasons.
> > It is time to let go and drop the parts of sparc32 that in reality
> > are not in use.
> 
> I'd like to revisit this discussion. I recently got SILO and modern
> kernels working on legacy sun4m systems. I missed this discussion the
> last time around, but I am glad the series has not been merged.
> 
> The kernel patches are available here:
> 
> https://lore.kernel.org/sparclinux/20260816075141.3489194-1-linmag7@gmail.com/T/#t
> 
> The SILO patches are available here:
> 
> https://github.com/linmag7/silo/tree/release
> 
> Code that is not tested or maintained will inevitably deteriorate over
> time. I hope we can keep sun4m/sun4d support in the mainline kernel. If
> the lack of testing and general maintenance was the main reason for
> proposing its removal, I would be happy to help with both.
> 
> I have plenty of old SPARC32 hardware with various CPU configurations
> available for testing, and I am willing to assist with maintaining the
> support in any way I can.

If there is a community that is interested in keeping sun 4m/4d alive
then having it upstream is the right call.
But if this falls down to a single person doing this only for the sake
of being able to boot Linux on HW that is not used in reality the
right call is to cut it out.

I was in the "Keep sun 4m/4d" camp for a while, but felt we could
do the sparc32 architecture a favour cutting out the support for the old
HW. When I was active here, I had the ambition to move sparc32/LEON over
to use DT files, and skip all prom features and I had something remotely
booting, but then priorities changed and I stopped playing with this.

Note: I have not talked with anyone about moving sparc32/LEON to use DT
files, so that idea could easily be rejected.

An open question is if we have more than one person interested to
invest time in keeping sun 4m/4d alive?

	Sam
