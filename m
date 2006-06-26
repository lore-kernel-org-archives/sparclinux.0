From: David Miller <davem@davemloft.net>
Date: Mon, 26 Jun 2006 20:39:04 +0000
Subject: Re: 2.6.17 + sym53c876 causes many i/o errors
Message-Id: <20060626.133904.26279654.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20060620175656.GA12525@ele.uri.edu>
In-Reply-To: <20060620175656.GA12525@ele.uri.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Will Simoneau <simoneau@ele.uri.edu>
Date: Mon, 26 Jun 2006 15:46:11 -0400

> Just an update: 2.6.17.1 had the same problem until I changed both the
> max # and default # of tagged queue commands to 64 instead of 256 like I
> had them. The doc file for the driver seems to indicate that at most 255
> tagged queue commands are supported, but the help text in 'make
> menuconfig' indicates that up to 256 are supported. Maybe setting it to
> 256 causes badness in the driver?
> 
> Anyway, 2.6.17.1 is fine on this machine now.

If that's the theory, try setting it to 255 and see if that works.

If it does, then the configuration system should not let you set
256 or higher if that value is illegal.
