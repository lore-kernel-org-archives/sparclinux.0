From: "David S. Miller" <davem@davemloft.net>
Date: Mon, 26 Dec 2005 23:47:15 +0000
Subject: Re: 2.6.15-rc7+git: sparc64 compile failure in cdc_subset
Message-Id: <20051226.154715.20089171.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.61.0512261156590.10687@math.ut.ee>
In-Reply-To: <Pine.SOC.4.61.0512261156590.10687@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Mon, 26 Dec 2005 12:00:54 +0200 (EET)

> CONFIG_SPARC=y
> CONFIG_SPARC64=y

I'm looking at this bug, but is this a full .config file?
When I use it and go "make oldconfig" it prompts me for a
lot of questions, which means this .config file is incomplete.

There isn't even a CONFIG_SPARC64_PAGE_SIZE_* selection nor a
CONFIG_HZ_* choice made in that kernel config file.  You must use it
in some way that all the defaults not specified explicitly are
selected.

You specify such things when you provide a kernel config file for
people to use in order to debug your problems.  The assumption is that
a given kernel config file is complete and fully specified.

Thanks.
