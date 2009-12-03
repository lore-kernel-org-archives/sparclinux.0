From: David Miller <davem@davemloft.net>
Date: Thu, 03 Dec 2009 06:56:45 +0000
Subject: Re: Boot problems on a V880
Message-Id: <20091202.225645.257509718.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200911262202.45791.pat@computer-refuge.org>
In-Reply-To: <200911262202.45791.pat@computer-refuge.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Patrick Finnegan <pat@computer-refuge.org>
Date: Thu, 3 Dec 2009 01:48:12 -0500

> Ok. this looks like it fixes the problem with the fiber-port gem, but 
> the 10/100 TP gem just bounces back and forth between these messages, 
> and never gets link:
> 
> [  174.260495] eth0: switching to forced 10bt             
> [  194.660290] eth0: switching to forced 100bt            
> 
> Ideas?  It does this even with the interface not configured (down 
> according to ifconfig), which is kinda annoying on the console... I have 
> to do an "ethtool -s eth0 autoneg off" to make it stop.

This is a feature.  It tries different possibilities trying to
get a link going.

I'm not to thrilled about it and it is different from how other
network drivers behave.

I'll try to find some time to take a look at this, thanks for the
report Patrick.
