From: David Miller <davem@davemloft.net>
Date: Tue, 02 Sep 2008 08:05:31 +0000
Subject: [PATCH 0/3]: Small PCI OF property cleanups.
Message-Id: <20080902.010531.193694046.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


The sparc64 PCI controler drivers have cases of using
of_find_property() then derefernecing the property
container to get at the data.

It's more concise and efficient to use of_get_property()
and the of_getintprop_default() helpers.
