From: Paul Bolle <pebolle@tiscali.nl>
Date: Tue, 19 Mar 2013 17:06:47 +0000
Subject: Re: [PATCH] sparc: remove unused "config BITS"
Message-Id: <1363712807.1390.26.camel@x61.thuisdomein>
List-Id: <sparclinux.vger.kernel.org>
References: <1363708727.1390.16.camel@x61.thuisdomein>
	 <20130319.123306.1709006318806942163.davem@davemloft.net>
In-Reply-To: <20130319.123306.1709006318806942163.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 2013-03-19 at 12:33 -0400, David Miller wrote:
> We use this in the Makefile fragments, you cannot remove it.

From arch/sparc/Makefile:
    ifeq ($(CONFIG_SPARC32),y)
    [...]

    [...]
    export BITS    := 32
    [...]

    else
    [...]

    [...]
    export BITS   := 64
    [...]

So $(BITS) is set depending on whether CONFIG_SPARC32 is set or not.
Using $(BITS) in sparc's Makefiles is not using CONFIG_BITS. That
doesn't count as usage of "config BITS". 


Paul Bolle

