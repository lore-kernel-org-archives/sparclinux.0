From: Krzysztof Helt <krzysztof.h1@wp.pl>
Date: Mon, 20 Aug 2007 18:19:13 +0000
Subject: Re: possible endless loop in PROM initialization
Message-Id: <20070820201913.7a3e9009.krzysztof.h1@wp.pl>
List-Id: <sparclinux.vger.kernel.org>
References: <20070820075949.GA5927@vimes.madsworld.lan>
	<20070820.010622.41634915.davem@davemloft.net>
	<20070820105320.GB4911@vimes.madsworld.lan>
In-Reply-To: <20070820105320.GB4911@vimes.madsworld.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Markus Dahms <mad@automagically.de>
Cc: David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 20 Aug 2007 12:53:20 +0200
Markus Dahms <mad@automagically.de> wrote:

> Hello again,

> As I'm not sure anymore whether the device tree (show-devs) or the aliases
> (devalias) are broken on the Classic X (I "upgraded" mine to a Classic by
> changing some NVRAM bytes) this may be a non-issue. But it is still an
> endless loop where it don't has to be.
> 

I understand your problem now. The only rational solution is
to stop building the list in the build_one_prop() if the property 
with already found name is defined.

Changing way the *_nextprop() works seems not a good 
idea to me.

My two cents,
Krzysztof
