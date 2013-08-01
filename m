From: David Miller <davem@davemloft.net>
Date: Thu, 01 Aug 2013 02:11:06 +0000
Subject: Re: [PATCH]sparc32: Fix exit flag passed from traced sys_sigreturn
Message-Id: <20130731.191106.1250324802616162198.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Kirill Tkhai <tkhai@yandex.ru>
Date: Fri, 26 Jul 2013 01:17:15 +0400

> Pass 1 in %o1 to indicate that syscall_trace accounts exit.
> 
> Signed-off-by: Kirill Tkhai <tkhai@yandex.ru>

Applied.
