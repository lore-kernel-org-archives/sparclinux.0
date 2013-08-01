From: David Miller <davem@davemloft.net>
Date: Thu, 01 Aug 2013 02:11:00 +0000
Subject: Re: [PATCH]sparc64: Fix wrong syscall return value passed to trace_sys_exit()
Message-Id: <20130731.191100.204384173713857504.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Kirill Tkhai <tkhai@yandex.ru>
Date: Fri, 26 Jul 2013 01:00:53 +0400

> Syscall number is passed instead of return value. Fix that.
> 
> Signed-off-by: Kirill Tkhai <tkhai@yandex.ru>

Applied.
