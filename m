From: David Miller <davem@davemloft.net>
Date: Sat, 21 Apr 2007 22:41:37 +0000
Subject: Re: [TESTERS NEEDED]: Rewritten ESP driver
Message-Id: <20070421.154137.48532684.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20070412.233350.41640545.davem@davemloft.net>
In-Reply-To: <20070412.233350.41640545.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Georg Chini <georg.chini@triaton-webhosting.com>
Date: Sun, 22 Apr 2007 00:38:58 +0200

> I'm seeing the same problem on my ultra2 with 2.6.21-rc7 and
> your patch. Even the message is the same. Maybe it is connected
> to the use of md-devices, as far as I could see from the logs
> Bertrand is also using md-devices. If I can provide any debugging
> output, please advise.

Can you provide the full dmesg logs?  I need to see what
kind of ESP chip is in your machine in order to see
if there is some pattern of ESP chip type involved here.

Bertrand, could you give me the full bootup probing logs
from your system too?  Please indicate clearly which ESP
the device which triggers the problem is hung off of.

Thanks.
