From: "David S. Miller" <davem@davemloft.net>
Date: Mon, 25 Apr 2005 03:46:19 +0000
Subject: Re: [PATCH 2.6] Fix mxcc warning
Message-Id: <20050424204619.16064e9e.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1109917519.17038.87.camel@localhost.localdomain>
In-Reply-To: <1109917519.17038.87.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, 04 Mar 2005 00:25:19 -0600
"Tom 'spot' Callaway" <tcallawa@redhat.com> wrote:

> Peter Jones uncovered this one while we were debugging the framebuffer
> issues. There are some references to -1 in the mxcc asm code, which
> should be 0xffffffff.
> 
> This patch gets rid of the -1s.
> 
> Signed-off-by: Tom 'spot' Callaway <tcallawa@redhat.com>

Applied, thanks.
