From: David Miller <davem@davemloft.net>
Date: Mon, 18 Sep 2006 07:43:42 +0000
Subject: Re: [Bugme-new] [Bug 7115] New: openpromfs on 2.6.18-rc stop
Message-Id: <20060918.004342.55726632.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20060906202247.6e609ed7.akpm@osdl.org>
In-Reply-To: <20060906202247.6e609ed7.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Eric Brower" <ebrower@gmail.com>
Date: Wed, 6 Sep 2006 20:48:28 -0700

> This seems to be a known issue, as per DaveM's last changelog for
> fs/openpromfs/inode.c:

Right, convert such uses to /dev/openprom which still supports
property writes.

This won't get fixed until 2.6.19 at the earliest.
