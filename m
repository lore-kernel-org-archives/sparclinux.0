From: Mikael Pettersson <mikpe@it.uu.se>
Date: Sat, 25 Sep 2010 17:34:49 +0000
Subject: Re: [2.6.36-rc regression] occasional complete system hangs on
Message-Id: <19614.12985.649827.886053@pilspetsen.it.uu.se>
List-Id: <sparclinux.vger.kernel.org>
References: <19611.34846.813757.309183@pilspetsen.it.uu.se>
	<20100923.120935.173861259.davem@davemloft.net>
In-Reply-To: <20100923.120935.173861259.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: mikpe@it.uu.se, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

David Miller writes:
 > From: Mikael Pettersson <mikpe@it.uu.se>
 > Date: Thu, 23 Sep 2010 19:02:22 +0200
 > 
 > > The 2.6.36-rc kernels do appear to be solid on a UP Ultra5, but that
 > > one no longer does any gcc builds or tests, only kernel builds.
 > > 
 > > Any ideas, or do I have to try to bisect this?
 > 
 > I've seen this too, it's some kind of deadlock obviously.
 > 
 > Unfortunately I haven't gotten any further than you have in the
 > analysis.

Update: I got another hang with 2.6.36-rc5, then went back to
2.6.36-rc1 which hung twice.  SYSRQ would print help text and
the name of the command but not print anything useful on the
console.  Now trying some of the 2.6.35-git snapshots before -rc1.
