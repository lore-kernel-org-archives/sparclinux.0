From: Greg Onufer <gonufer@jazzhaiku.com>
Date: Fri, 18 Aug 2017 22:41:13 +0000
Subject: Re: [PATCH] sparc64: speed up etrap/rtrap on NG2 and later processors
Message-Id: <CAE8irLgcC7+E1Ua68r3u_gSPG=6KUei7sUBZdrFYLvjPEg-DRw@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1503017943-23575-1-git-send-email-anthony.yznaga@oracle.com>
In-Reply-To: <1503017943-23575-1-git-send-email-anthony.yznaga@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, Aug 18, 2017 at 3:15 PM, David Miller <davem@davemloft.net> wrote:
>> It was pointed out off-list that this is not future-proof.  The only
>> sun4v chip that does not support allclean, normalw, and otherw is
>> Niagara1, and any future sun4v-compliant chip must support the
>> instructions.  Rather than require a code change for new processors,
>> just skip hot patching for Niagara1.  I'll send out a v2 patch shortly.
>
> I was going to say something about this as well.
>
> You could test HWCAP_SPARC_BLKINIT or HWCAP_SPARC_N2.

Neither of those hwcaps are for these instructions.  hwcaps are
specific and are not intended to imply other features.  Please do not
use them that way.

-greg
