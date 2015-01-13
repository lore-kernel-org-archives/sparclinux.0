From: David Miller <davem@davemloft.net>
Date: Tue, 13 Jan 2015 21:58:21 +0000
Subject: Re: [linux-nics] Solved: Re: ixgbe/linux/sparc perf issues
Message-Id: <20150113.165821.105280833265039921.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20150109152118.GA6560@oracle.com>
In-Reply-To: <20150109152118.GA6560@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Tue, 13 Jan 2015 10:45:30 -0500

> On (01/13/15 01:08), Tantilov, Emil S wrote:
>> Relaxed ordering was disabled due to an issue with some chipsets. There
>> is a comment to that effect when enabling relaxed ordering for reads in
>> ixgbe_update_tx_dca(). This was done back in 2011, so I'm still trying
>> to dig through the details.
> 
> It would be helpful to know exactly which chipsets, so that in
> those cases, we can set the ->enable_relaxed_ordering in my patch
> to null (or make this setting specific to CONFIG_SPARC?)

I think they are talking about "system chipsets", ie. relaxed ordering
doesn't work reliably on this or that AMD/Intel/whatever system
chipset.
