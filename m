From: David Miller <davem@davemloft.net>
Date: Sun, 02 Nov 2008 04:42:54 +0000
Subject: Re: 2.6.28-rc2: Unable to handle kernel paging request at
Message-Id: <20081101.214254.178222451.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <a4423d670811010723u3b271fcaxa7d3bdb251a8b246@mail.gmail.com>
	<Pine.LNX.4.64.0811011837110.20211@blonde.site>
	<a4423d670811012102m3fdd245apbe0a310b4890f958@mail.gmail.com>
In-Reply-To: <a4423d670811012102m3fdd245apbe0a310b4890f958@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: a.beregalov@gmail.com
Cc: hugh@veritas.com, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, linux-mm@kvack.org

From: "Alexander Beregalov" <a.beregalov@gmail.com>
Date: Sun, 2 Nov 2008 07:02:40 +0300

> Should we fix also sparc32?

Sparc32 uses a different scheme for all of this stuff.
I don't think your patch will even compile.
