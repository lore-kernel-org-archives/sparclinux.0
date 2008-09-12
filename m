From: David Miller <davem@davemloft.net>
Date: Fri, 12 Sep 2008 21:47:48 +0000
Subject: [PATCH 0/16]: Sparse warning fixups...
Message-Id: <20080912.144748.109568932.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


I saw Andrew Morton mention sparse yesterday, and since I hadn't done
a sparse run in arch/sparc64 in a while a neuron in my brain fired and
I just went bananas trying to clear up as much as I could.

Some warnings from sparse still remain under arch/sparc64, but those
are larger problems than I am able to cure with this quick run.

