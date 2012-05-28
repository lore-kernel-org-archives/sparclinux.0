From: David Miller <davem@davemloft.net>
Date: Mon, 28 May 2012 07:07:42 +0000
Subject: Re: [PATCH 0/4] remove additional LEON dependencies
Message-Id: <20120528.030742.1105884700737489875.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20120526144047.GA6819@merkur.ravnborg.org>
In-Reply-To: <20120526144047.GA6819@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 26 May 2012 16:40:47 +0200

> Took a closer look at the remaining references in
> arch/kernel/sparc to CONFIG_SPARC_LEON.
> 
> It turned out to be easier than anticipated to allow multi
> platfrom support in the remaining bits.
> 
> This is on top of the previous batch sent earlier today.
> 
> With this patch I can build a kernel with LEON selected
> and it boots on my ss5 :-)

All applied, thanks a lot!
