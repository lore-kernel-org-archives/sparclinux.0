From: "David S. Miller" <davem@davemloft.net>
Date: Tue, 01 Feb 2005 04:44:28 +0000
Subject: Re: fix cg14 with serial console
Message-Id: <20050131204428.5185e305.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <41FF079C.7070007@mc.net>
In-Reply-To: <41FF079C.7070007@mc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, 31 Jan 2005 22:37:48 -0600
Bob Breuer <breuerr@mc.net> wrote:

> When booting with a serial console and a vsimm installed, the cg14
> driver would crash because the driver failed to check the return
> value of prom_getproperty().
> 
> Here's a patch to fix that and move the SPARC32 conditional out of
> the source file and into Kconfig.

Please don't do that so I can test the build of the
driver even under sparc64.  I made all the sparc FB
SBUS drivers available on sparc64 for this reason.

