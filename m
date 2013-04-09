From: David Miller <davem@davemloft.net>
Date: Tue, 09 Apr 2013 02:50:56 +0000
Subject: Re: [PATCH] sparc64: Do not save/restore interrupts in get_new_mmu_context()
Message-Id: <20130408.225056.2200378270968222666.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <523971365452986@web28h.yandex.ru>
In-Reply-To: <523971365452986@web28h.yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Kirill Tkhai <tkhai@yandex.ru>
Date: Tue, 09 Apr 2013 00:29:46 +0400

> get_new_mmu_context() is always called with interrupts disabled.
> So it's possible to do this micro optimization.
> 
> (Also fix the comment to switch_mm, which is called in both cases)
> 
> Signed-off-by: Kirill Tkhai <tkhai@yandex.ru>
> CC: David Miller <davem@davemloft.net>

Applied to sparc-next, thanks!
