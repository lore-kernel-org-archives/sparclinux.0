From: William Lee Irwin III <wli@holomorphy.com>
Date: Wed, 12 Jan 2005 05:38:49 +0000
Subject: Re: Current BK kernel error
Message-Id: <20050112053849.GE14443@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20050111143605.GC4514@artsapartment.org>
In-Reply-To: <20050111143605.GC4514@artsapartment.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

William Lee Irwin III wrote:
>> According to Bob Breuer, returning 1 always seems to work for ordinary
>> userspace (as opposed to "unusual" programs). I've got documentation,
>> so I'll brew up something more accurate for it over the weekend.

On Tue, Jan 11, 2005 at 10:02:58PM -0600, Bob Breuer wrote:
> Yes, the easy way out is to return 1 from pte_read.  To do it right we will 
> need a combined solution for sun4c and sun4m.  I think that sun4 can use 
> the sun4c version and sun4d will share with sun4m.
> For sun4c, we can use the software managed read bit:
> 	return pte_val(pte) & _SUN4C_PAGE_READ;
> I can't test this myself, but it mirrors the pte_write functionality.
> For sun4m, there is no software bit for read, so we peek at the hardware 
> ACC field from the pte:
> 	return !(pte_val(pte) & 0x10);
> We need a #define to go with the new usage of this bit, maybe SRMMU_NOREAD?
> I have tested the sun4m solution on my SS20 and it works for me.
> Now, how can these be combined using the btfixup magic?

Ship me what you've got and I'll test it on sun4c and BTFIXUP-ize it.


-- wli
