From: "David S. Miller" <davem@davemloft.net>
Date: Fri, 01 Apr 2005 06:08:24 +0000
Subject: Re: [PATCH 2.6] pte_read confusion resolved (was Re: [PATCH] A
Message-Id: <20050331220824.0fb61895.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, 04 Mar 2005 00:08:40 -0600
"Tom 'spot' Callaway" <tcallawa@redhat.com> wrote:

> On Thu, 2005-02-03 at 01:13 -0800, William Lee Irwin III wrote:
> >On Wed, 2005-02-02 at 15:32 -0800, David S. Miller wrote:
> >>> I disagree with Tom's patch in that it puts this huge switch()
> >>> statement inline.  The whole point of BTFIXUP_HIGH() is that it
> >>> resolves the call to a single instruction which can be easily
> >>> patched at runtime.
> >>> If it's going to expand to multiple BTFIXUP_HIGH() calls and a
> >>> switch statement, just make it a normal BTFIXUP() to a function
> >>> and place the implementation in sun4c.c and sun4m.c
> >
> >On Wed, Feb 02, 2005 at 10:22:24PM -0600, Tom 'spot' Callaway wrote:
> >> How about this instead?
> >> Signed-off-by: Tom 'spot' Callaway <tcallawa@redhat.com>
> >
> >I'll make sure this gets into 2.6.11-final.
> 
> The second pte_read patch did not really make it into 2.6.11 final (but
> my original patch, which DaveM pointed out as faulty, did). I've made a
> new patch which reverts the huge switch inline statement logic, and uses
> the normal BTFIXUP instead.
> 
> With this patch applied, we should have the preferred pte_read mechanism
> in place for sparc32.
> 
> Signed-off-by: Tom 'spot' Callaway <tcallawa@redhat.com>

Looks great, patch applied.  Thanks Tom.
