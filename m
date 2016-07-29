From: alexmcwhirter@triadic.us
Date: Fri, 29 Jul 2016 02:56:40 +0000
Subject: Re: [PATCH] sparc: Don't leak context bits into =?UTF-8?Q?thread-=3Efault=5Faddress?=
Message-Id: <55c5dc5700748feaae4c0077480d2bfa@triadic.us>
List-Id: <sparclinux.vger.kernel.org>
References: <20160727.175351.219584019615190125.davem@davemloft.net>
In-Reply-To: <20160727.175351.219584019615190125.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 2016-07-27 20:53, David Miller wrote:
> 
> Reported-by: Mikulas Patocka <mpatocka@redhat.com>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> ---
>  arch/sparc/kernel/dtlb_prot.S |  4 ++--
>  arch/sparc/kernel/ktlb.S      | 12 ++++++++++++
>  arch/sparc/kernel/tsb.S       | 12 ++++++++++--
>  3 files changed, 24 insertions(+), 4 deletions(-)

I am happy to report that this patch completely fixes the rsync / ssh / 
ssl issues i was having on sun4u.

Just curious, as i am not certain of how this normally works, would a 
patch such as this one be backported to all current stable kernels that 
this bug effects? Which at the moment would be 4.1, 4.4, 4.5, and 4.6?
