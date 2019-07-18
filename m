From: David Miller <davem@davemloft.net>
Date: Thu, 18 Jul 2019 01:21:21 +0000
Subject: Re: [PATCH 09/16] sparc64: use the generic get_user_pages_fast code
Message-Id: <20190717.182121.54176691060371062.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <CAHk-=whj_+tYSRcDsw7mDGrkmyU9tAk-a53XK271wYtDqYRzig@mail.gmail.com>
	<20190717233031.GB30369@altlinux.org>
	<CAHk-=wgjmt2i37nn9v+nGC0m8-DdLBMEs=NC=TV-u+9XAzA61g@mail.gmail.com>
In-Reply-To: <CAHk-=wgjmt2i37nn9v+nGC0m8-DdLBMEs=NC=TV-u+9XAzA61g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: ldv@altlinux.org, hch@lst.de, khalid.aziz@oracle.com, akpm@linux-foundation.org, matorola@gmail.com, sparclinux@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 17 Jul 2019 17:17:16 -0700

> Anyway, I suspect some sparc64 person needs to delve into it.

I'll take a look at it soon if someone doesn't figure it out before
me.
