From: David Miller <davem@davemloft.net>
Date: Thu, 01 Aug 2013 02:11:26 +0000
Subject: Re: [PATCH v2] sparc64: Fix not SRA'ed %o5 in 32-bit traced syscall
Message-Id: <20130731.191126.1761360791963639020.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Kirill Tkhai <tkhai@yandex.ru>
Date: Fri, 26 Jul 2013 17:21:12 +0400

> (From v1 to v2: changed comment)
> 
> On the way linux_sparc_syscall32->linux_syscall_trace32->goto 2f,
> register %o5 doesn't clear its second 32-bit.
> 
> Fix that.
> 
> Signed-off-by: Kirill Tkhai <tkhai@yandex.ru>

Applied, thanks for all of your bug fixes :-)
