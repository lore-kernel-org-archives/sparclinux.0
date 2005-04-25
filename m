From: "David S. Miller" <davem@davemloft.net>
Date: Mon, 25 Apr 2005 03:42:12 +0000
Subject: Re: [PATCH 2.6] Missing sparc32 ksyms
Message-Id: <20050424204212.26122bd2.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, 03 Mar 2005 22:54:40 -0600
"Tom 'spot' Callaway" <tcallawa@redhat.com> wrote:

> This patch adds some missing sparc32 ksyms that are needed.
> Specifically, ___rw_read_enter, ___rw_read_exit, ___rw_write_enter, and
> sys_close.
> 
> Signed-off-by: Tom 'spot' Callaway <tcallawa@redhat.com>

Applied, thanks Tom.
