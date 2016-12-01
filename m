From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Thu, 01 Dec 2016 02:41:47 +0000
Subject: Re: sunvnet: Question on tx control in original code
Message-Id: <20161201024147.GW24944@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <161e538d-f353-2075-280b-50767e6ec8d8@oracle.com>
In-Reply-To: <161e538d-f353-2075-280b-50767e6ec8d8@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On (11/30/16 17:25), Shannon Nelson wrote:
> I've recently been studying up on the sparc LDom environment and
> sunvnet, the virtual network device.  In looking through the code I
> ran across an odd bit of tx control that I don't quite understand.
  :
> In order to get into the if-block there needs to be a 0 or negative
> return from vnet_tx_dring_avail(), yet then we're checking it again,
> with no discernible delay, for a positive value.  I don't see how we
> could get to the netif_tx_wake_queue() call - shouldn't there be
> some delay, or perhaps something that might bump the underlying
> channel before checking for more available space?
> 
> Perhaps I've missed something?

And fwiw, Shannon asked me this question, and I too did not have the
history here. Perhaps DaveM remembers where this came from?

--Sowmini
