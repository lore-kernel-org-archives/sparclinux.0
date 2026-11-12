Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794448639;
	b=Q022gjR/Rt/lm8mJmdTpzrTMDaq35+OEgZ5ilE0OWj0eXLa8D3RYXOdgBqs7UVS2coOh
	 ECN6wxiyMoYZdYkwTbfQGCH0HDbRbu+zSEWrfPptGd07/xRckHjtnETYhyZnFkjUpIpr0
	 n776YDCnQ0xYqmpQ8v5zcXpQXURB+S5O0kfuF36a1WZnPSNpMBSJBvTnhJ1VOO9tRhBV1
	 koUWuqkL1QYP6wJ36jQ3mJXrhx7ipw25rK7wEunKdYRZ7+VwsgNZOrpFA8vFILseYSa85
	 HwpSHGQC7EenygIrMI3BHEYeQb16bQWGYi0gLEBmxW15El0CylWviHlqe8QpdMeVFpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794448639;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=i9rfrReLPN4eoCuhLh++xCTWs2P8s66MnyJOkAlyAg0=;
	b=w1f3V4LQlvdHMpQDQmXq16WQRZavJ/IZF3OpdAh+/e8MzbupMHEyh1OrIf/F6ZIwxbTm
	 9Fi0wLbtZrkbD47cmFg5e49Cce6Lh1KwV/lIgCrdvnTwaoRRtWfZtKxpsnuIIq33bpePN
	 cgykELfaHMG0fnSvgMVhwmDgZw5gDeUxJs2pppivQsgOjGTPQuiBgVvHHzohCu4S8pfW5
	 gbZs6AbgXNPwSTQI1E8cgeppDF7JWCOWxVZg9480inzOuUXv6W5klsUIo3OrHLW8MDKcr
	 kPgi6uPneGjBkkGqCC03+hB2zY5amgnPEXsDv7z2nOYrXCQIw1BlwidPcUiTG4837YQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mdrF9o6F;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A966606A31C;
	Thu, 12 Nov 2026 01:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mdrF9o6F
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9C9A1F00A05;
	Thu, 12 Nov 2026 01:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794448639;
	bh=i9rfrReLPN4eoCuhLh++xCTWs2P8s66MnyJOkAlyAg0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=mdrF9o6FROv/mgAPvMpl+QiF3JupPX1P1uoWPHATrVXMSEfMTZIxv02J5UNbbBQTG
	 XmQWi3bBr5iOKInVlrxNI0cmROqz5hG/x6pdA/JVjAyaLyN/Oxx7f9iJ1p+cJbm+0b
	 cKXKvfh3JwO/MctQmCOLRsvViLS7PQvOrP2zCYGgz4lvuU8pKiJx8fUiS4eFsqynCH
	 RE7ynLHMY7nIDSFsOUBS58APApbq5qziRG/kZceg9CWSw8IzT5bYj5aOnzwZ2htzD+
	 6yfXQtpK5UufU+FSKrT780J0u1qtKGOcXg9nJFMmujbYBvKlCwCp/6NH7CnUMZb3/J
	 Roc0rnupeYE6A==
Date: Wed, 11 Nov 2026 17:57:14 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Vitaly Zuevsky <vitaly.zuevsky@gcore.com>
Cc: netdev@vger.kernel.org, David Miller <davem@davemloft.net>, Eric Dumazet
 <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, Richard
 Henderson <richard.henderson@linaro.org>, Matt Turner <mattst88@gmail.com>,
 Magnus Lindholm <linmag7@gmail.com>, Thomas Bogendoerfer
 <tsbogend@alpha.franken.de>, "James E.J. Bottomley"
 <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>,
 Andreas Larsson <andreas@gaisler.com>, Kuniyuki Iwashima
 <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, Arnd Bergmann
 <arnd@arndb.de>, Christian Brauner <brauner@kernel.org>, Andrew Halaney
 <andrew@amutable.com>, Jori Koolstra <jkoolstra@xs4all.nl>, Alexander
 Mikhalitsyn <alexander@mihalicyn.com>, Tariq Toukan <tariqt@nvidia.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Chuang Wang <nashuiliang@gmail.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-arch@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: add SO_BYPASS_RFS to exclude a socket
 from RFS and aRFS
Message-ID: <20261111175714.1bea2584@kernel.org>
In-Reply-To: <20261109014547.81555-1-vitaly.zuevsky@gcore.com>
References: <20261109014547.81555-1-vitaly.zuevsky@gcore.com>
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Post: <mailto:sparclinux@vger.kernel.org>
List-Help: <mailto:sparclinux+help@vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:sparclinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  8 Nov 2026 20:45:47 -0500 Vitaly Zuevsky wrote:
> RFS and accelerated RFS are enabled per host and per rx queue, but
> whether steering helps is a property of the flow. A host that carries
> a few long-lived flows which benefit from steering alongside a large
> churn of short-lived flows which arrive on the right CPU already has
> no way to express that today.

1) Please respond to netdev-bot+sashiko@kernel.org, we don't use 
the global bot (you only got a reply from it because you CCed half 
of the universe for no real reason).

2) Some data showing the win from this on real production workloads
would be nice.

3) The API looks backwards? I'd think that most users would want an opt
in for sockets they care about rather than having to chase down every
other socket on the system to exclude?

4) Please trim the slop in the documentation.
-- 
pw-bot: cr
