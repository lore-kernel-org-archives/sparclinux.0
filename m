From: "David S. Miller" <davem@davemloft.net>
Date: Mon, 06 Jun 2005 22:05:48 +0000
Subject: Re: No keyboard on E450
Message-Id: <20050606.150548.08325240.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200506062239.13244.dj@david-web.co.uk>
In-Reply-To: <200506062239.13244.dj@david-web.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David Johnson <dj@david-web.co.uk>
Date: Mon, 6 Jun 2005 22:39:13 +0100

> As far as I can tell this isn't a generic sparc64 issue (keyboard
> worked with the same kernel on an Ultra 5) and may be specific to
> the E450. Is this a known bug? Is anyone else seeing the same issue?

Could you please double check that both of the following
config options are enabled in your config:

CONFIG_SERIAL_SUNSU=y
CONFIG_SERIAL_SUNSAB=y

Also, make sure no keyboard maps are being loaded during
bootup on the E450.
