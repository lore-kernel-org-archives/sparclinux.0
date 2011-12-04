From: David Miller <davem@davemloft.net>
Date: Sun, 04 Dec 2011 18:07:24 +0000
Subject: Re: [PATCH-RFC 10/10] sparc: switch to GENERIC_PCI_IOMAP
Message-Id: <20111204.130724.729202580136553783.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20111204104916.GL15464@redhat.com>
In-Reply-To: <20111204104916.GL15464@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Michael S. Tsirkin" <mst@redhat.com>
Date: Sun, 4 Dec 2011 12:49:17 +0200

> On Thu, Nov 24, 2011 at 10:21:27PM +0200, Michael S. Tsirkin wrote:
>> sparc copied pci_iomap from generic code, probably to avoid
>> pulling the rest of iomap.c in.  Since that's in
>> a separate file now, we can reuse the common implementation.
>> 
>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> Sorry to nag, any ACKs/NACKs on the sparc changes?
> I intend to send this to Linus if there are no
> objections. Thanks!

Acked-by: David S. Miller <davem@davemloft.net>
