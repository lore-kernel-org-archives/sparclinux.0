From: David Miller <davem@davemloft.net>
Date: Tue, 05 Aug 2014 03:22:34 +0000
Subject: Re: [PATCH sparc] ldc_connect() should not return EINVAL when handshake is in progress.
Message-Id: <20140804.202234.332087995854821874.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20140801135040.GE19031@oracle.com>
In-Reply-To: <20140801135040.GE19031@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Fri, 1 Aug 2014 09:50:40 -0400

> The LDC handshake could have been asynchronously triggered
> after ldc_bind() enables the ldc_rx() receive interrupt-handler
> (and thus intercepts incoming control packets)
> and before vio_port_up() calls ldc_connect(). If that is the case,
> ldc_connect() should return 0 and let the state-machine
> progress.
> 
> Signed-off-by: Sowmini Varadhan <sowmini.varadhan@oracle.com>
> Acked-by: Karl Volz <karl.volz@oracle.com>
> ---
> Resending to the correct list this time.

Applied and queued up for -stable, thanks.

Please, in the future, format your Subject line something like
the following:

[PATCH] $subsystem: $description

Everything after "[xxx] " goes into the commit log header line, and
putting a subsystem prefix allows people scanning the shortlog to
get a good idea what area a change touches.

In this case I added "sparc64: " for the subsystem prefix when
commiting your change.

BTW, you'll probably come to notice that not a lot of work has gone
into handling hard disconnect failures properly in LDC and the drivers
that use it.  It's the one area where the LDC framework is very weak.
Unfortunately a lot of cooperation is required by the drivers
themselves, because what to do when a LDC connection goes down is
different in different drivers (networking drivers can drop packets,
but block drivers have to redo the I/O when the LDC link comes back
up, for example)


