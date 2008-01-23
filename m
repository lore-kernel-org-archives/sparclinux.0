From: Grant Grundler <grundler@parisc-linux.org>
Date: Wed, 23 Jan 2008 06:19:50 +0000
Subject: Re: [Bug 9106] Sun Fire v100 dmfe driver bug
Message-Id: <20080123061950.GA20348@colo.lackof.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20080121.232756.107909847.davem@davemloft.net>
In-Reply-To: <20080121.232756.107909847.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, Jan 21, 2008 at 11:27:56PM -0800, David Miller wrote:
> This driver did work on sparc64 to some extent at some point in the
> past.  So something did change over time to subtly break this thing.

Good - that gives me some hope it can be made to work again.

> The users log with the TX timeouts probably indicates that the chip
> cannot DMA properly or send to the network for whatever reason.

Yes - or the interrupts aren't getting generated/delivered.

> Maybe the media type is wrong.
> 
> BTW, I noticed this while reading the DMFE code:
> 
> 	db->buf_pool_ptr = pci_alloc_consistent(pdev, TX_BUF_ALLOC *
> 			TX_DESC_CNT + 4, &db->buf_pool_dma_ptr);
> 
> That size looks strange, is this supposed to be:
> 
> 	(TX_BUF_ALLOC * TX_DESC_CNT) + 4
> 
> or:
> 
> 	TX_BUF_ALLOC * (TX_DESC_CNT + 4)
> 
> I think the latter is the intention, but the former is what
> is actually happening.

Note the same thing is happening in the pci_free_consistent call.

After looking the code a bit, my guess would be the former was intended.
I suspect this driver once suffered from alignment issues:
        /* pointer for memory physical address */
        dma_addr_t buf_pool_dma_ptr;    /* Tx buffer pool memory */
        dma_addr_t buf_pool_dma_start;  /* Tx buffer pool align dword */
...

and I'm going a bit out on a limb here by guessing this line:
	db->buf_pool_dma_start = db->buf_pool_dma_ptr;

might used to read something like:
	db->buf_pool_dma_start = db->buf_pool_dma_ptr & ~3ULL;

or two lines:
        db->buf_pool_dma_start = db->buf_pool_dma_ptr;
        db->buf_pool_dma_ptr &= ~3ULL;

to guarantee the DMA pool had a 4-byte alignment. So I think the +4 can
just be dropped.


> Looking through the driver history I definitely see some bugs
> introduced into the SROM code, for example:
...
> But it is totally wrong in the cases where the offsets were not
> a multiple or 2 or 4, respectively.  (hint: (34 % 4) = 2)

Ouch. Good catch.

> It would have been better to use expressions like:
> 
> 	(__le16 *) (srom + 34)
> 	(__le32 *) (srom + 34)
> 	(__le32 *) (srom + 36)

Yes. This is in fact what the dmfe.c v1.43 driver from Davicom does:
#define DRV_NAME        "dmfe"
#define DRV_VERSION     "1.43"
#define DRV_RELDATE     "2005-07-14"
...
                /* Get NIC support media mode */
                db->NIC_capability = le16_to_cpup((u16 *)(srom + 34));
...
                /* Media Mode Force or not check */
                dmfe_mode = le32_to_cpup((u32 *)(srom + 34)) & le32_to_cpup((u32 *)(srom + 36));

Driver is available from:
http://www.davicom.com.tw/eng/download/Driver/driver_9102a.htm
http://www.davicom.com.tw/big5/download/Driver/dm9102a/dmfe_1.43.tar.gz

> Thinking about this some more, these accesses are extremely queer.
> Why would it use 32-bit accesses here to two 32-bit datums which
> overlap, and "and" them together to figure out the 'dmfe_mode'?

Yeah, this looks wierd. But probably happens to work IFF only one bit
is set of the 16 bits at offset 0x36 and NONE of the same bits are
set at the 16 bits starting at offset 0x38. Given we only care about
bits 1-3 (see "switch(dmfe_mode)"), this should be safe to convert
to 16 bit accesses.

> This driver is in a bit of a state of disrepair.  Who is Tobias
> Ringstrom (from MAINTAINERS) and when was the last time he did any
> maintainence on dmfe?  He definitely hasn't done anything in
> the GIT era as I look through the changelog.

http://ringstrom.mine.nu/

and seems to have started a family since 2003 or so :)
	http://ringstrom.mine.nu/photo/ 

Google hasn't seen any contributions since about 2003.
Mostly active in 2001 on the kernel.
Maybe time to orphan the driver or find a new maintainer?

> Anyways, here is a fix for the above regression, if that DMA
> sizing error above is a real one that will need a fix too:
> 
> [TULIP] DMFE: Fix SROM parsing regression.
> 
> Changeset 16b110c3fd760620b4a787db6ed512fe531ab1b5 (dmfe warning fix)
> bothed up the offsets read from the SROM so that it doesn't read the
> same datums it used to.

In case it matters, looks good to me.

thanks,
grant
