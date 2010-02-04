From: David Miller <davem@davemloft.net>
Date: Thu, 04 Feb 2010 17:28:17 +0000
Subject: Re: [PATCH 0/8] niu parameters and RX flow separation
Message-Id: <20100204.092817.236890531.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1265282762-13954-1-git-send-email-chris.torek@windriver.com>
In-Reply-To: <1265282762-13954-1-git-send-email-chris.torek@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Please these patches CC:'d to netdev@vger.kernel.org

There is nothing Sparc specific about the NIU driver and
even if it were netdev@vger.kernel.org is where even platform
specific network device patches are posted.

Also, your patches which use module parameters to set
things in the NIU chip will need to be deleted.  Instead
you should create run-time configuration methods, such
as new ethtool commands and/or flag bits, to modify these
settings.

Next, it's even more incredulious that you posted this only
to the sparc list given that you make changes to the generic
networking code.

Finally, there are lots of other work, particularly from the google
folks, to do software flow seperation, which frankly I see no need for
on a chip like NIU which %100 already does this for you in hardware.

This is a really bad patch submission, sorry.

Thanks.
