From: David Miller <davem@davemloft.net>
Date: Fri, 10 Sep 2010 03:36:51 +0000
Subject: Re: bugs compiling 2.6.35.4
Message-Id: <20100909.203651.245401449.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <201009092029.52510.dennis@ausil.us>
In-Reply-To: <201009092029.52510.dennis@ausil.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Turn off CONFIG_DEBUG_STRICT_USER_COPY_CHECKS in your config, it
is a debugging facility for kernel developers not something you
should enable yourself.

In fact because so many people turned this on and report the build
failures, I've simply just removed it from the tree as I got tired
of explaining this every single time :-/
