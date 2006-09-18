From: David Miller <davem@davemloft.net>
Date: Mon, 18 Sep 2006 14:11:57 +0000
Subject: Re: Possible bug in sys_getdomainname() on sparc64
Message-Id: <20060918.071157.94073383.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <43513.192.168.1.10.1157439907.squirrel@otter.puszczka.com>
In-Reply-To: <43513.192.168.1.10.1157439907.squirrel@otter.puszczka.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Andy Walker <andy@otter.broadpark.no>
Date: Mon, 18 Sep 2006 10:52:26 +0200

> On Mon, Sep 18, 2006 at 12:38:23AM -0700, David Miller wrote:
> > 
> > Also, arch/sparc/kernel/sys_sparc.c has the same error and thus
> > needs the exact same fix.  It would be appreciated if you would
> > fix both cases in your updated patch.
> > 
> > Thanks.
> 
> Hi Dave,
> 
> Here's a new unmangled patch, including arch/sparc/....

Applied, thanks Andy.
