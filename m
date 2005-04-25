From: "David S. Miller" <davem@davemloft.net>
Date: Mon, 25 Apr 2005 03:39:35 +0000
Subject: Re: [PATCH 2.6] TCX Framebuffer fixes
Message-Id: <20050424203935.17ff56c7.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, 03 Mar 2005 22:41:17 -0600
"Tom 'spot' Callaway" <tcallawa@redhat.com> wrote:

> Using the same logic as the other framebuffer fixes committed in 2.6.11,
> this is a set of fixes to make TCX functional on the console again. Adds
> the tcx_pan_display function, sets the
> all->info.var.{red,green,blue}.length values to 8, and runs fb_set_cmap.
> Also looks for the correct SUNW,tcx prom value.
> 
> This patch just slipped through the cracks.
> 
> Originally by: Georg Chini <georg.chini@triaton-webhosting.com>

Applied, thanks Tom.
