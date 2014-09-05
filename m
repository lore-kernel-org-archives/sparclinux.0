From: David Miller <davem@davemloft.net>
Date: Fri, 05 Sep 2014 17:53:58 +0000
Subject: Re: commit 8c86e70acead629aacb4afcd818add66bf6844d9 hangs SPARC64 LDOMs
Message-Id: <20140905.105358.1299889092381748568.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <5409D2C3.6010806@oracle.com>
In-Reply-To: <5409D2C3.6010806@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David L Stevens <david.stevens@oracle.com>
Date: Fri, 05 Sep 2014 12:46:24 -0400

> No, there's nothing on the console.

This might be obvious, but booting with "-p" can help diagnose in
these situations.

There is a quiet period during boot where no console messages actually
get printed.
