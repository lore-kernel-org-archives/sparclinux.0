From: David Miller <davem@davemloft.net>
Date: Tue, 05 Jan 2016 04:25:17 +0000
Subject: Re: [BISECTED] "sparc64: Fix numa distance values" breakage
Message-Id: <20160104.232517.1519082428316546515.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <22148.1009.8278.45539@gargle.gargle.HOWL>
In-Reply-To: <22148.1009.8278.45539@gargle.gargle.HOWL>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Nitin Gupta <nitin.m.gupta@oracle.com>
Date: Mon, 4 Jan 2016 11:27:26 +0530

> Dave: would you have a script to dump MD which you can share?

I take raw dumps from /dev/mdesc and feed them into the opensolaris
mdlint program whose source I slightly modified so that it would
compile under Linux.

It's entirely trivial to do so yourself.
