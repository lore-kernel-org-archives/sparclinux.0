From: "David S. Miller" <davem@davemloft.net>
Date: Mon, 25 Apr 2005 03:45:26 +0000
Subject: Re: [PATCH 2.6] More sparc32 ksyms cleanups
Message-Id: <20050424204526.058da3b1.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, 03 Mar 2005 23:44:39 -0600
"Tom 'spot' Callaway" <tcallawa@redhat.com> wrote:

> The sparc32 ksyms is missing a few more symbols, these are primarily
> related to SMP, and will be needed as SMP gets beaten back into
> functionality.
> 
> Specifically, add __cpu_data (PER_CPU), cpu_online_map, and
> phys_cpu_present_map.
> 
> This patch assumes that the earlier "linux-2.6.11-sparc-fixksyms.patch"
> is applied, otherwise, it will apply with fuzz.
> 
> Signed-off-by: Tom 'spot' Callaway <tcallawa@redhat.com>

Applied, thanks Tom.
