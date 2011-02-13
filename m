From: David Miller <davem@davemloft.net>
Date: Sun, 13 Feb 2011 22:00:26 +0000
Subject: Re: [PATCH 4/4] sparc32: genirq conversion (buggy)
Message-Id: <20110213.140026.214237414.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20110213192952.GD25069@merkur.ravnborg.org>
In-Reply-To: <20110213192952.GD25069@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 13 Feb 2011 22:48:44 +0100

> In the original implmentation we did the same via __enable_irq().

And we did so Via a function that's invoked by every cpu as it is booted.

Right?
