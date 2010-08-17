From: David Miller <davem@davemloft.net>
Date: Tue, 17 Aug 2010 21:48:43 +0000
Subject: Re: XVR-600 console not working with e3d
Message-Id: <20100817.144843.104046744.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Josip Rodin <joy@entuzijast.net>
Date: Tue, 17 Aug 2010 16:33:22 +0200

> OK, good. So our kernel still has something missing... I'm attaching the
> config in case anyone can spot anything obvious.

Config looks fine, the XVR500 driver will driver those chips.

Probably missing a patch to the driver or similar.
