From: David Miller <davem@davemloft.net>
Date: Mon, 29 Jan 2007 16:39:15 +0000
Subject: Re: Linux on Sun e10k
Message-Id: <20070129.083915.38709352.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1169241607.30406.19.camel@duo.jes.ee>
In-Reply-To: <1169241607.30406.19.camel@duo.jes.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@ut.ee>
Date: Mon, 29 Jan 2007 17:08:06 +0200 (EET)

> > Don't bother with netconsole support.
> 
> Orthogonally from real console, this would be a nice-to-have. I have't 
> looked what netpoll actually needs - some drivers get away with very 
> simple patches. Would it be easy for sunhme too?

Drivers which use NAPI already are the ones that are supported
by easy patches, sunhme does not use NAPI.  That's why netconsole
support would be a bit of work, you'd have to convert it to NAPI
and then you could easily add netconsole.
