From: David Miller <davem@davemloft.net>
Date: Fri, 24 Apr 2009 15:06:20 +0000
Subject: Re: [patch] Niagara1 Perfcounter Accesses
Message-Id: <20090424.080620.214511924.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.0904221537190.12401@pianoman.cluster.toy>
In-Reply-To: <Pine.LNX.4.64.0904221537190.12401@pianoman.cluster.toy>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Vince Weaver <vince@deater.net>
Date: Fri, 24 Apr 2009 11:08:11 -0400 (EDT)

> sorry, it was a false alarm.  It turned out to be the prom console
> issue.
> It apparently triggered the NMI code and locked the system hard.
> I made the mistake of using the .config from debian as a starting
> point for my own kerne config.
> 
> Current git of your tree with prom console disabled works fine on my
> t1000 system.

Thanks for the info.
