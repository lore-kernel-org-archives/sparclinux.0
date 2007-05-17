From: David Miller <davem@davemloft.net>
Date: Thu, 17 May 2007 08:25:27 +0000
Subject: Re: [PATCH]: Fix for SB100/SB150 bootup hangs
Message-Id: <20070517.012527.41193346.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20070305.011139.78710584.davem@davemloft.net>
In-Reply-To: <20070305.011139.78710584.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Mon, 16 Apr 2007 15:21:07 -0700 (PDT)

> But the bottom line is that we must use the output-device to
> determine the console output framebuffer device in the absense
> of a console= command line specification.

The status of this is that I just had an email exchange
with one of the framebuffer layer developers and he's
come up with a scheme by which we can set the framebuffer
device correctly based upon the setting of 'output-device'
and whatever that aliases too.

I'll forward some test stuff here, if I remember, once the
infrastructure is done.
