Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1107344A3ED;
	Sun, 11 Oct 2026 13:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791725625; cv=none; b=VRk1s6+eEN7aTo2okjh6f9ZtkARHBGrIOlUU6/IquPIt49/EwRj6wnwKGf7xG5nwGr1LJp2dKE+QW6kAtO2cVzrvwIYNZkCVqXekz1McNVBCNzKgvG0Blkw1O6uaCbQT8G4QqERHt4dGK9CDm3Vk/Slf1TJmExeU04NlV3GJNu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791725625; c=relaxed/simple;
	bh=HOnRafXWuKE72C/S23cH6++NT6CqQhr4UAAHfdBw9Zo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vf02H13zbNGwvM8fQR2O+Ukxv1RBcAZy1opTrKqdIglhgTbe37kCIzX4WBcpA6Wbv5UXZklhfy9wmZM05EtPsdi0bhTz/1aRX/E4W6Jaq4e4e1q2u3Y1aDVv/AWO/othMUQdm+Qxi7Ef8OGRul1ZtS93TwwlsssULxGrFq+BSIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=XD5lEmY3; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="XD5lEmY3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=5p6ZdRwQER1NYntwkVUYNtDCW+pWTolFozIqkDncQWw=; b=XD
	5lEmY34PTVRKve2sYa6osmERrvO2YtHUqHk2NcJsTlo6V6/ywRFY5s/Vm+88pICnwY6idRKl1Xvqu
	pE2kXaXoTQbilR6qLToDWUZKPWHYchBuuPlMC36jVBNBWr+gRl7kgktPzHLuxBX4Ti7BaobMJWdp1
	2xlmh22o4tspqSY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xFtgH-00A6Mw-Hs; Sun, 11 Oct 2026 15:33:37 +0200
Date: Sun, 11 Oct 2026 15:33:37 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Magnus Lindholm <linmag7@gmail.com>
Cc: pavan.chebbi@broadcom.com, andrew+netdev@lunn.ch, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] tg3: normalize inherited M3000 register byte
 order
Message-ID: <c8bc138e-2d62-4ee8-9020-5f1091efe015@lunn.ch>
References: <20261008220433.965791-1-linmag7@gmail.com>
 <038bffb2-e40d-44bb-b7ce-53e9de32e50d@lunn.ch>
 <CA+=Fv5QvhYd7EqVBYKWVgvf92SLE=FjE8EYcZvUQ7HKdx2kc3Q@mail.gmail.com>
 <becc8f95-4650-477b-b1c7-cc4952e5e980@lunn.ch>
 <CA+=Fv5TU1rOUimi8f+e0R4_48ki+X3qzD_+1QPyviTnJz-irvA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+=Fv5TU1rOUimi8f+e0R4_48ki+X3qzD_+1QPyviTnJz-irvA@mail.gmail.com>

On Fri, Oct 09, 2026 at 02:52:57PM +0200, Magnus Lindholm wrote:
> Hi Andrew,
> 
> On Fri, Oct 9, 2026 at 2:09 PM Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > > > Is there a legitimate reason you would want the bytes are swapped?
> >
> > You missed answering this. I'm guessing, but does the hardware offer
> > this to make big endian machines more efficient?
> >
> > Please could you look at the driver and think about what would happen
> > on a big endian machine. Is the change still correct?
> >
> >         Andrew
> 
> You're right, my earlier reply missed the underlying question.
> 
> That is a plausible reason for providing the hardware swap mode:
> it can accommodate big-endian accesses without software byte
> swapping. I haven't verified Broadcom's design rationale.
> 
> However, Linux tg3 already initializes misc_host_ctrl with WORD_SWAP set
> and BYTE_SWAP clear on both little- and big-endian builds, before
> this helper runs.
> 
> The helper restores that existing setting. Its swab32() compensates
> for the device's inherited register state, not CPU endianness.
> Subsequent accesses use the normal driver path, and the separate
> __BIG_ENDIAN handling for DMA remains unchanged.
> 
> That is why I believe the correction is appropriate on either
> endianness. The runtime tests were on the M3000 running big-endian
> SPARC64.

Please expand the commit message to show you have thought about this.

       Andrew
