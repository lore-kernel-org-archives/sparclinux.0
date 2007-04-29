From: David Miller <davem@davemloft.net>
Date: Sun, 29 Apr 2007 04:01:47 +0000
Subject: Re: [TESTING NEEDED] drivers/serial/sunzilog: Interrupt enable
Message-Id: <20070428.210147.111207684.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0704281529090.8157@mtfhpc.demon.co.uk>
In-Reply-To: <Pine.LNX.4.61.0704281529090.8157@mtfhpc.demon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mark@mtfhpc.demon.co.uk
Cc: wli@holomorphy.com, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, linux-serial@vger.kernel.org, jengelh@linux01.gwdg.de


Your patch is extremely mangled, please try to email it to yourself
and apply it if in doubt.

Furthermore, the comment your patch adds is unnecessary.  That kind of
text belongs in the changelog comment, not the code.  The changelog is
also where you'll get credit for your change.

There is no reason to play Napoleon in the source files any more now
that we have proper source control and history all these years. :-)

Please fix all of this up and resubmit, thank you.
