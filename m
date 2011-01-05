From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed, 05 Jan 2011 19:48:01 +0000
Subject: Re: sb-100 bootup hangs...
Message-Id: <20110105194801.GA25578@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20110105.112012.183041683.davem@davemloft.net>
In-Reply-To: <20110105.112012.183041683.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, Jan 05, 2011 at 11:20:12AM -0800, David Miller wrote:
> 
> Sam, just FYI, I think I know what this bug is, I've been helping
> Fabio hunt down a similar bug on his machine, and he generated enough
> debug info for me to work on a fix.
> 
> The issue is that the atyfb_setup_sparc() code in the ATY driver is
> doing direct PROM calls to fetch information from the device tree, and
> it's doing it in such a way that we will violate the PROM restrictions
> that we can only pass <4GB virtual addresses down into prom calls.
> 
> That code should be using the in-kernel copy of the device tree,
> via the of_*() interfaces, to do it's probing.  And I'm going to
> write such a patch to fix this bug.
> 
> So sit tight :-)

Great - I was anyway postponing debugging this until the weekend.
I will test whatever you come up with.

	Sam
