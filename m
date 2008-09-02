From: David Miller <davem@davemloft.net>
Date: Tue, 02 Sep 2008 23:40:42 +0000
Subject: Re: [next 0902] sparc64: oops at boot: n_tty_set_termios
Message-Id: <20080902.164042.147785415.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <a4423d670809020908t4f763557l306a1db791677f8d@mail.gmail.com>
In-Reply-To: <a4423d670809020908t4f763557l306a1db791677f8d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: a.beregalov@gmail.com
Cc: alan@redhat.com, sparclinux@vger.kernel.org, linux-next@vger.kernel.org, linux-kernel@vger.kernel.org

From: "Alexander Beregalov" <a.beregalov@gmail.com>
Date: Tue, 2 Sep 2008 20:08:09 +0400

> Hi
> 
> Host is Sun Ultra 10.
> 
> Here is what can I see on screen:
> 
> swapper(1): Oops
> 
> TPC: n_tty_set_termios
> i7: n_tty_open

Alan says he pushed a fix for this, see the thread titled:
"Re: broken tty-move-canon-specials patch"
