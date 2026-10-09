Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608824BE45A;
	Fri,  9 Oct 2026 12:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791547788; cv=none; b=Zs0WW0CQhG/0nuusBeLpqy54kYncbPRnGE7hl2FXrxGFg124BU6utFz5iL2qX8LvF8yofEETThNV0BRvyM1gizi0Li6/So/7Tok+xcI1cnltvBVxn7uRtbUXIVs0bpSYxtiyAQVMvbveGylpT8vlM3Hrfj5i3XWqg23zDWr/aeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791547788; c=relaxed/simple;
	bh=Dq20ADAqDf405H8K7WW4rLyLm7w2FrSG0HL5gZBWnmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OIXxNMsFRaXE4RimgNO5MGlz3/yNlJQDFz/5cVjIS4E3HuPUp7OIzDstssaazsa8iklGac2KgHKcJ3mLwUHEFZUpE2tHjq76T0j8sLwYyxXFd4as5rD1oVZm0zVuGEakaBU8WMGCdR1pXKZwfN/i8WUX815KvtkROfgkSfca4cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=TxYgJENI; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="TxYgJENI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=O9rA9Mwgk88aDRZr9jh+2l7+6yLxai29L8EHtEPPmBE=; b=TxYgJENIpCy2zZ+Gm/jz7q6JNU
	y27zQXW0nYjcAiIR+j1hs3zlFGdmb0yBTb61WWh+Gdrczqe7j9jz2xA+me0rqHXRDPzn57CuPgQRt
	M1wGFJLtrUZUA4avMOfEGmSXS6Tc/zzdj1/78q7fUxGVNJwcJdhvsFJVu7kr0tZxuoUo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xF9Pr-009mUc-6n; Fri, 09 Oct 2026 14:09:35 +0200
Date: Fri, 9 Oct 2026 14:09:35 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Magnus Lindholm <linmag7@gmail.com>
Cc: pavan.chebbi@broadcom.com, andrew+netdev@lunn.ch, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] tg3: normalize inherited M3000 register byte
 order
Message-ID: <becc8f95-4650-477b-b1c7-cc4952e5e980@lunn.ch>
References: <20261008220433.965791-1-linmag7@gmail.com>
 <038bffb2-e40d-44bb-b7ce-53e9de32e50d@lunn.ch>
 <CA+=Fv5QvhYd7EqVBYKWVgvf92SLE=FjE8EYcZvUQ7HKdx2kc3Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+=Fv5QvhYd7EqVBYKWVgvf92SLE=FjE8EYcZvUQ7HKdx2kc3Q@mail.gmail.com>

> > Is there a legitimate reason you would want the bytes are swapped?

You missed answering this. I'm guessing, but does the hardware offer
this to make big endian machines more efficient?

Please could you look at the driver and think about what would happen
on a big endian machine. Is the change still correct?

	Andrew
