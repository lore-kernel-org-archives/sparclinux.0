From: Georg Chini <georg.chini@triaton-webhosting.com>
Date: Sat, 21 Apr 2007 22:38:58 +0000
Subject: Re: [TESTERS NEEDED]: Rewritten ESP driver
Message-Id: <462A9282.9060009@triaton-webhosting.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20070412.233350.41640545.davem@davemloft.net>
In-Reply-To: <20070412.233350.41640545.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org



David Miller wrote:

>
>I only need to resolve the bug that Bertrand is still seeing
>where the reconnect tag gets corrupted somehow.
>
>I'll try to work on that over the weekend, but for everyone
>else keep beating on it :-)
>-
>
>  
>
Hi Dave,

I'm seeing the same problem on my ultra2 with 2.6.21-rc7 and
your patch. Even the message is the same. Maybe it is connected
to the use of md-devices, as far as I could see from the logs
Bertrand is also using md-devices. If I can provide any debugging
output, please advise.

Regards
             Georg 
