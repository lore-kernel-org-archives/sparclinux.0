From: "David S. Miller" <davem@davemloft.net>
Date: Thu, 18 Nov 2004 22:36:53 +0000
Subject: Re: circular console list in 2.6.9-bk3+
Message-Id: <20041118143653.5e2e7d9f.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20041118144142.GG2268@holomorphy.com>
In-Reply-To: <20041118144142.GG2268@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, 18 Nov 2004 06:41:42 -0800
William Lee Irwin III <wli@holomorphy.com> wrote:

> Some changes that added serial console retry logic aren't interacting
> well with PROM console setup and teardown and whatever sunzilog.c does,
> and appear to result in a circular console list (hence indefinitely
> repeated output). The trick is, of course, that I'm not sure which of
> the three is wrong.

Please elaborate.

sunzilog_console_init() will be called at most one time and
therefore it will register itself one time via register_console().

I don't see how anything in register_console() can wind us up with
a circular list, and thus the problem you seem to be describing.
