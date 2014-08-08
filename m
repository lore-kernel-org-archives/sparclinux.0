From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Fri, 08 Aug 2014 20:47:55 +0000
Subject: Re: soft-lockups in sunvnet
Message-Id: <20140808204755.GB24555@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20140808.114601.1454008888717150216.davem@davemloft.net>
In-Reply-To: <20140808.114601.1454008888717150216.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On (08/08/14 12:59), David Miller wrote:
> 
> This only works because we free the packet in the ->ndo_start_xmit()
> method.  If we didn't do that, and we freed it up at ACK time, we'd
> need to force the ACKs in order to guarentee that we release the SKB
> in a finite amount of time.
> 

I see. I missed that subtlety. I'll make a note in the comments for
my proposed change, in case this piece of code changes in the future.

--Sowmini

