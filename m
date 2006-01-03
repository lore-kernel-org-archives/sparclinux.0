From: "David S. Miller" <davem@davemloft.net>
Date: Tue, 03 Jan 2006 20:50:36 +0000
Subject: Re: SILO 1.4.10
Message-Id: <20060103.125036.05541695.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1136175018.27583.50.camel@grayson>
In-Reply-To: <1136175018.27583.50.camel@grayson>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jim Gifford <maillist@jg555.com>
Date: Tue, 03 Jan 2006 09:39:19 -0800

> So we have 2 potential issues
> 
> 1 - elftoaout is not creating proper files when it's compiled as 64bit
> 2 - second.b is not being created properly

It's probably just some 64-bit arithmatic coding error
in elftoaout that only gets triggered by the second.b
image and not by most other uses of the utility.

Someone with the time and inclination can probably look
at the final image differences, and use that to pinpoint
the elftoaout problem when built 64-bit.
