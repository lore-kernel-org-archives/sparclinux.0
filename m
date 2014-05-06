From: David Miller <davem@davemloft.net>
Date: Tue, 06 May 2014 15:24:18 +0000
Subject: Re: [PATCH V2 0/11] sparc64 MM fixes
Message-Id: <20140506.112418.392202927937738903.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20140506.000802.1283819541274253321.davem@davemloft.net>
In-Reply-To: <20140506.000802.1283819541274253321.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@ut.ee>
Date: Tue, 6 May 2014 18:13:58 +0300 (EEST)

> How should I continue debugging it - find the conf differences with 
> Debian kernel?
> 
> Or do you want my .config for U2, X1, V100?

I think the pattern is that the UltraSPARC-III based machines have
no problems, whereas the UltraSPARC-I and UltraSPARC-II based ones
tend to crash and hang.

You said they have the same problem with THP disabled too, right?

I'll try to see if I can find a potential reason, but what's more
likely to happen is that I'll have to fire up some of my older
systems when I am physically near them again which is at the end
of this month. :-)
