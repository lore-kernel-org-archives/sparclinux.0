From: David Miller <davem@davemloft.net>
Date: Mon, 29 Jan 2007 20:07:47 +0000
Subject: Re: Linux on Sun e10k
Message-Id: <20070129.120747.116356127.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1169241607.30406.19.camel@duo.jes.ee>
In-Reply-To: <1169241607.30406.19.camel@duo.jes.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Tom 'spot' Callaway" <tcallawa@redhat.com>
Date: Mon, 29 Jan 2007 13:45:52 -0600

> On Mon, 2007-01-29 at 09:34 -0800, David Miller wrote:
> > Ignore values 3, 4, and 5 for now, there is a way to redirect console
> > output over the network with the SSP but we'll not support that yet. 
> 
> Maybe I'm confused here, but the only way I've been able to get to the
> OpenBoot console has been via netcon_server and netcon through the SSP.
> 
> Is there some other way I should be accessing the starfire domains?

I'm talking about a network console that bypasses the normal
SSP communications.

Just code up the SRAM bits, it should work.
