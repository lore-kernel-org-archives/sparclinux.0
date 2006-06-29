From: "David S. Miller" <davem@davemloft.net>
Date: Thu, 29 Jun 2006 20:45:00 +0000
Subject: Re: booting the T1000
Message-Id: <20060629.134500.78731918.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200606290937.49481.rene@exactcode.de>
In-Reply-To: <200606290937.49481.rene@exactcode.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Tom 'spot' Callaway" <tcallawa@redhat.com>
Date: Thu, 29 Jun 2006 15:27:58 -0500

> Try this:

As you can see from my response and his acknowledgment, this
wasn't the problem he was running into.

The default inetd package in Ubuntu, from iputils, is simply buggy,
because it sets it's sockets to non-blocking and leaves that setting
on the socket when it passes the connection on to the real application
from inetd.  Applications expect the socket to be in blocking mode.
As a result, tftpd craps out because it unexpectedly gets -EAGAIN on a
read().

To be honest this is a horrible selection of a default inetd
implementation, netkit-inetd is probably what should be used instead.

Changing over to netkit-inetd fixes the problem.
