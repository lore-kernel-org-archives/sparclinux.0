From: David Miller <davem@davemloft.net>
Date: Wed, 15 Nov 2017 05:42:26 +0000
Subject: Re: [PATCH] sparc64: Convert timers to user timer_setup()
Message-Id: <20171115.144226.335209383872903559.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Allen Pais <allen.pais@oracle.com>
Date: Tue, 24 Oct 2017 15:08:13 +0530

> Switch to using the new timer_setup() and from_timer()
> in LDOM Virtual I/O handshake.
> 
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Allen Pais <allen.pais@oracle.com>

Applied.
