From: David Miller <davem@davemloft.net>
Date: Thu, 05 Sep 2013 19:15:00 +0000
Subject: Re: [PATCH] sparc64: Remove RWSEM export leftovers
Message-Id: <20130905.151500.971491127341879054.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Kirill Tkhai <tkhai@yandex.ru>
Date: Mon, 12 Aug 2013 16:02:24 +0400

> The functions
> 
> 			__down_read
> 			__down_read_trylock
> 			__down_write
> 			__down_write_trylock
> 			__up_read
> 			__up_write
> 			__downgrade_write
> 
> are implemented inline, so remove corresponding EXPORT_SYMBOLs
> (They lead to compile errors on RT kernel).
> 
> Signed-off-by: Kirill Tkhai <tkhai@yandex.ru>

Applied.
