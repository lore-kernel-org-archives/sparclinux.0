From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Tue, 13 Jan 2015 15:45:30 +0000
Subject: Re: [linux-nics] Solved: Re: ixgbe/linux/sparc perf issues
Message-Id: <20150113154530.GA31036@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20150109152118.GA6560@oracle.com>
In-Reply-To: <20150109152118.GA6560@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On (01/13/15 01:08), Tantilov, Emil S wrote:
> Relaxed ordering was disabled due to an issue with some chipsets. There
> is a comment to that effect when enabling relaxed ordering for reads in
> ixgbe_update_tx_dca(). This was done back in 2011, so I'm still trying
> to dig through the details.

It would be helpful to know exactly which chipsets, so that in
those cases, we can set the ->enable_relaxed_ordering in my patch
to null (or make this setting specific to CONFIG_SPARC?)

> ... In your patch below you enable
> relaxed ordering for writes - have you tested if there is any effect if
> you enable it only for reads or both?

The critical loop is the one for Rx, namely, to re-enable this:

        for (i = 0; i < hw->mac.max_rx_queues; i++) {
                regval = IXGBE_READ_REG(hw, IXGBE_DCA_RXCTRL(i));
                regval |= (IXGBE_DCA_RXCTRL_DATA_WRO_EN |
                            IXGBE_DCA_RXCTRL_HEAD_WRO_EN);
                IXGBE_WRITE_REG(hw, IXGBE_DCA_RXCTRL(i), regval);
	}

fwiw, I tested/verified the patch on sparc/X540 and (more light testing) 
on x86/82598.

So knowing the history here on the 2011 specifics (that you mention
above) would be useful, then we can discuss how to tailor the fix and
which other drivers also need something similar.

--Sowmini

