From: David Miller <davem@davemloft.net>
Date: Tue, 10 Jun 2008 18:59:01 +0000
Subject: Re: [panic] "Cheetah error trap taken" with Debian 2.6.24 kernel
Message-Id: <20080610.115901.134409459.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200806100003.54269.elendil@planet.nl>
In-Reply-To: <200806100003.54269.elendil@planet.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Alexander Vlasov" <alexander.vlasov@gmail.com>
Date: Tue, 10 Jun 2008 14:02:50 +0200

> I have to confirm that problem is somehow related to radeonfb.
> This problem happens only with TWO Sun XVR-300 videocards installed; when
> I'm pulling one card out, kernel boots fine.

Now that's a good clue.

I wonder if the firmware mis-sizes one of the ROM resource
properties in cases like this.
