From: David Miller <davem@davemloft.net>
Date: Mon, 16 Apr 2007 22:21:07 +0000
Subject: Re: [PATCH]: Fix for SB100/SB150 bootup hangs
Message-Id: <20070416.152107.115929351.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20070305.011139.78710584.davem@davemloft.net>
In-Reply-To: <20070305.011139.78710584.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Tom \"spot\" Callaway" <tcallawa@redhat.com>
Date: Mon, 16 Apr 2007 15:56:25 -0500

> Yep. Absolutely. Aurora's got this patch in it, to have the old behavior
> on FB ordering, since people expect it.

Yes that would maintain the status-quo from ages ago, but
it still doesn't actually fix the core problem :-)

What we should probably do is parse the output-device prom environment
variable, and using that set the console framebuffer device.

One way to do that would be to cons up a dummy console= kernel
command line entry if the user hasn't explicitly specified one.

Otherwise it's going to be a bit messy.

Actually, I'll take a look at the console<-->fb hookup internals
a little bit more, perhaps there is an easier solution.

But the bottom line is that we must use the output-device to
determine the console output framebuffer device in the absense
of a console= command line specification.

Oh btw, Tom, does my scsi bus reset patch help your SS4 at all? :-)
