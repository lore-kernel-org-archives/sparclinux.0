From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Sun, 04 Jun 2006 14:32:15 +0000
Subject: Re: Checksum problem on sparc64
Message-Id: <20060604143215.GC5295@bouh.residence.ens-lyon.fr>
List-Id: <sparclinux.vger.kernel.org>
References: <20060323223510.GA7683@sceen.net>
In-Reply-To: <20060323223510.GA7683@sceen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

Syn wrote:
> The value returned by csum_block_sub() may have the 16 MSB bits set.
> th->check = tcp_v4_check(th, len, inet->saddr, inet->daddr,
>                         csum_partial((char *)th,
>                                      th->doff << 2,
>                                      skb->csum));

There indeed seems to be an issue in csum_partial: quoting beginning and
end of csum_partial in checksum.S:

        .align          32
        .globl          csum_partial
csum_partial:           /* %o0=buff, %o1=len, %o2=sum */
	/* skb->csum is in %o2 */

 	 ... a lot of computing that doesn't involve %o2 ...

1:      add             %o2, %o4, %o2

csum_partial_finish:
        retl
         mov            %o2, %o0

The last add doesn't take care of the potential carry into the 33th
bit. I guess something like

1:      add             %o2, %o4, %o2
	srlx		%o2, 32, %o4
	srl		%o2, 0, %o2
	add		%o2, %o4, %o2

csum_partial_finish:
        retl
         mov            %o2, %o0

should be correct.

Samuel
