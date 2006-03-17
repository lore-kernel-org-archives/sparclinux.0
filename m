From: "David S. Miller" <davem@davemloft.net>
Date: Fri, 17 Mar 2006 08:56:11 +0000
Subject: Re: bbc, envctrl and sun blade 2000
Message-Id: <20060317.005611.120739363.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <87k6auqm68.fsf@thorr.asgardr.info>
In-Reply-To: <87k6auqm68.fsf@thorr.asgardr.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: NOSPAM4coyote@cojot.name
Date: Fri, 17 Mar 2006 09:53:49 +0100 (CET)

> The sb1k is identical to the sb2k except for the faster Procs (I event 
> hink the mobos are identical). 'uname -a' on an sb2k even reports it as a 
> sb1k so I'm surprised that something would work on an sb1k and not on an 
> sb2k...

It checks for cheetah processors.  If he has cheetah+ or later
chips in there, the driver will not load.
