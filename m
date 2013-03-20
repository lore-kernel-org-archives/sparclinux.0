From: David Miller <davem@davemloft.net>
Date: Wed, 20 Mar 2013 18:42:02 +0000
Subject: Re: [PATCH v2 0/1]sparc64: Hibernation support
Message-Id: <20130320.144202.1530409174695382904.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <757071363741867@web15e.yandex.ru>
In-Reply-To: <757071363741867@web15e.yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Kirill Tkhai <tkhai@yandex.ru>
Date: Wed, 20 Mar 2013 05:11:07 +0400

> This patch adds CONFIG_HIBERNATION support for sparc64
> architecture. The suspend function is the same as on another
> platforms. The restore function uses Bypass feature of MMU
> which allows to make the process more comfortable and plesant.
> 
> Signed-off-by: Kirill Tkhai <tkhai@yandex.ru>

Applied.
