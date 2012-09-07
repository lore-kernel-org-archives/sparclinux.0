From: David Miller <davem@davemloft.net>
Date: Fri, 07 Sep 2012 05:34:06 +0000
Subject: [PATCH 0/3] sparc64: Improve large pages wrt. kernel linear mappings.
Message-Id: <20120907.013406.43842981064016368.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


The main impetus here is to support 2GB pages which SPARC-T4
supports.

But since I was here and I don't really feel like going through this
dance again when the next chip supports 16GB pages I decided to do it
right.

The page sizes supported by sun4v cpus can be obtained from the
machine description, the cpu nodes have a property with a bitmask
where bits are set for the page sizes the cpu supports.

So we make use of that and therefore we'll transparently take
advantage of whatever page sizes future sun4v cpus can handle.

Signed-off-by: David S. Miller <davem@davemloft.net>
