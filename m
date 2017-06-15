From: David Miller <davem@davemloft.net>
Date: Thu, 15 Jun 2017 18:06:42 +0000
Subject: Re: [v1 0/2] Early boot timestamp fixes
Message-Id: <20170615.140642.33323833400445332.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1497537659-419752-1-git-send-email-pasha.tatashin@oracle.com>
In-Reply-To: <1497537659-419752-1-git-send-email-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Thu, 15 Jun 2017 18:57:30 +0100

> Currently I'm booting one of John Paul Adrian Glaubitz's Debian 9 images
> and the timestamps stay at 0 until the clock is initialised so I'd hope
> that these patches would fix that. Do they require any PROM support at all?

They don't require anything special.
