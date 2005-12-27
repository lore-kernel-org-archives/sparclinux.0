From: "David S. Miller" <davem@davemloft.net>
Date: Tue, 27 Dec 2005 00:05:37 +0000
Subject: Re: 2.6.15-rc7+git: sparc64 compile failure in cdc_subset
Message-Id: <20051226.160537.115689365.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.61.0512261156590.10687@math.ut.ee>
In-Reply-To: <Pine.SOC.4.61.0512261156590.10687@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "David S. Miller" <davem@davemloft.net>
Date: Mon, 26 Dec 2005 15:47:15 -0800 (PST)

> From: Meelis Roos <mroos@linux.ee>
> Date: Mon, 26 Dec 2005 12:00:54 +0200 (EET)
> 
> > CONFIG_SPARC=y
> > CONFIG_SPARC64=y
> 
> I'm looking at this bug, but is this a full .config file?
> When I use it and go "make oldconfig" it prompts me for a
> lot of questions, which means this .config file is incomplete.

Also, even using it with the defaults, I cannot reproduce your
build failure.

How reproducable is this and what build options are you using?
If you type make again, does it complete successfully on the
second try?  That can mean some kind of corruption.
