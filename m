From: David Miller <davem@davemloft.net>
Date: Tue, 30 Oct 2007 03:51:50 +0000
Subject: Re: PATCH: tcp rfc 2385 security/bugfix for sparc64
Message-Id: <20071029.205150.04488278.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200710161848.18443.2500@gmx.de>
In-Reply-To: <200710161848.18443.2500@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 2500@gmx.de
Cc: pl@dlh.net, sparclinux@vger.kernel.org, alan@lxorguk.ukuu.org.uk, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org

From: Matthias Dellweg <2500@gmx.de>
Date: Tue, 16 Oct 2007 18:47:56 +0200

> while reviewing the tcp_md5-related code further i came across with another
> two of these casts which you probably have missed. I don't actually think
> that they impose a problem by now, but as you said we should remove them.

I'll apply this patch, thanks Matthias.
