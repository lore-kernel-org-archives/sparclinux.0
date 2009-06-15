From: David Miller <davem@davemloft.net>
Date: Mon, 15 Jun 2009 10:12:37 +0000
Subject: Re: 2.6.31-rc1: memory initialization warnings on sparc
Message-Id: <20090615.031237.16489152.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <a4423d670906150303o353f598dg4eb7b1f181344d8e@mail.gmail.com>
In-Reply-To: <a4423d670906150303o353f598dg4eb7b1f181344d8e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: a.beregalov@gmail.com
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, linux-mm@kvack.org


I know about them, I saw these messages too.

kmalloc() initialization got moved earlier so large swaths of sparc
early initialization need to move from bootmem to kmalloc or similar.

It's just a harmless warning as the bootmem code calls kmalloc()
if that's available already.
