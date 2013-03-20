From: David Miller <davem@davemloft.net>
Date: Wed, 20 Mar 2013 18:42:07 +0000
Subject: Re: [PATCH v2 1/1]sparc64: Do not change num_physpages during initmem freeing
Message-Id: <20130320.144207.932164219241109058.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <757251363741928@web15e.yandex.ru>
In-Reply-To: <757251363741928@web15e.yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Kirill Tkhai <tkhai@yandex.ru>
Date: Wed, 20 Mar 2013 05:12:08 +0400

> Common hibernation code looks at num_physpages during suspend and restore.
> Restore is able to be called from initcall, which is before initmem freeing.
> This case leads to restore fail.
> 
> Signed-off-by: Kirill Tkhai <tkhai@yandex.ru>

Applied.
