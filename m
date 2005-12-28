From: "David S. Miller" <davem@davemloft.net>
Date: Wed, 28 Dec 2005 21:18:32 +0000
Subject: 5-byte MSC Sun mice
Message-Id: <20051228.131832.65303657.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Well, I went and did some research after noticing that the
mouse on my Ultra60 speaks 5-byte too.

The 2.4.x and previous Sun mouse drivers always assumed the
5-byte protocols, and I have no idea where the 3-byte protocol
stuff comes from in the 2.6.x driver so I'll just make it always
use the 5-byte protocol for SUN mice.

Thanks for bringing this up Christopher.
