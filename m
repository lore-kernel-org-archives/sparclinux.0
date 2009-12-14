From: David Miller <davem@davemloft.net>
Date: Mon, 14 Dec 2009 04:36:41 +0000
Subject: Re: [PATCH 2/2] Added leon3_dma_ops and LEON specific
Message-Id: <20091213.203641.242143030.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1257172092-25026-2-git-send-email-kristoffer@gaisler.com>
In-Reply-To: <1257172092-25026-2-git-send-email-kristoffer@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Kristoffer Glembo <kristoffer@gaisler.com>
Date: Mon, 23 Nov 2009 13:31:32 +0100

> David Miller wrote:
>> If it's not adding in phys_base, then it's not returning a legal
>> physical address.  Any idea why we don't add phys_base here?  I feel
>> like we've discussed this exactly recently, like in the past few
>> months.
>
> We did yes. You said that mem_map is not offset at phys_base and
> then of course we don't need to add it in page_to_phys. Is mem_map
> not offset because typically sp_banks[].base_addr = 0? In our case
> we pass in one sp_banks entry which has base_addr = 0x40000000.

I'm still trying to find time to address this, just FYI.
