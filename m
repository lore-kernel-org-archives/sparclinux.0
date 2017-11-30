From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 30 Nov 2017 03:46:53 +0000
Subject: linux-next: build failure after merge of the akpm-current tree
Message-Id: <20171130144653.1e2e7fab@canb.auug.org.au>
List-Id: <sparclinux.vger.kernel.org>
References: <BANLkTim5dYNmTMJo-Wa3LYCTi4vxPGMNeQ@mail.gmail.com>
In-Reply-To: <BANLkTim5dYNmTMJo-Wa3LYCTi4vxPGMNeQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Waiman Long <longman@redhat.com>, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org

Hi Andrew,

After merging the akpm-current tree, today's linux-next build (sparc
defconfig) failed like this:

mm/list_lru.c: In function 'list_lru_del':
mm/list_lru.c:141:2: error: implicit declaration of function 'prefetchw' [-Werror=implicit-function-declaration]
  prefetchw(item->prev);
  ^

Caused by commit

  9b4516980e87 ("mm/list_lru.c: prefetch neighboring list entries before acquiring lock")

Missing include of linux/prefetch.h?

I have reverted that commit for today.

-- 
Cheers,
Stephen Rothwell
